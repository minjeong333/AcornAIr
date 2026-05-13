package acornAir.booking.controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.booking.dao.BookingDAO;
import acornAir.booking.dto.BookingDTO;
import acornAir.booking.dto.PassengerDTO;
import acornAir.flight.dto.FlightDTO;
import acornAir.login.dto.UserDTO;
import acornAir.util.DBUtil;

@WebServlet("/air/booking/seatSelect")
public class SeatServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		FlightDTO goFlight = (FlightDTO) session.getAttribute("goFlight");
		FlightDTO backFlight = (FlightDTO) session.getAttribute("backFlight");

		BookingDAO dao = new BookingDAO();

		try (Connection con = new DBUtil().dbcon()) {
			if (goFlight != null) {
				List<String> booked = dao.getBookedSeats(goFlight.getFlightId(), con);
				System.out.println("[SeatServlet] goFlightId=" + goFlight.getFlightId() + ", bookedSeats=" + booked);
				req.setAttribute("goBookedSeats", booked);
			} else {
				System.out.println("[SeatServlet] goFlight is null");
				req.setAttribute("goBookedSeats", new ArrayList<>());
			}
			if (backFlight != null) {
				List<String> booked = dao.getBookedSeats(backFlight.getFlightId(), con);
				System.out
						.println("[SeatServlet] backFlightId=" + backFlight.getFlightId() + ", bookedSeats=" + booked);
				req.setAttribute("backBookedSeats", booked);
			} else {
				req.setAttribute("backBookedSeats", new ArrayList<>());
			}
		} catch (Exception e) {
			System.out.println("[SeatServlet] 예외 발생: " + e.getMessage());
			e.printStackTrace();
			req.setAttribute("goBookedSeats", new ArrayList<>());
			req.setAttribute("backBookedSeats", new ArrayList<>());
		}

		req.getRequestDispatcher("/WEB-INF/views/booking/seatSelect.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();

		// 좌석 파라미터 수신 및 세션 저장
		String goSeats = req.getParameter("goSeats");
		String backSeats = req.getParameter("backSeats");

		session.setAttribute("goSeats", goSeats);
		if (backSeats != null && !backSeats.isEmpty()) {
			session.setAttribute("backSeats", backSeats);
		}

		// 항공편 가격 계산
		FlightDTO goFlight = (FlightDTO) session.getAttribute("goFlight");

		if (goFlight == null) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}

		FlightDTO backFlight = (FlightDTO) session.getAttribute("backFlight");
		String goSeatClass = (String) session.getAttribute("goSeatClass");
		String backSeatClass = (String) session.getAttribute("backSeatClass");

		@SuppressWarnings("unchecked")
		List<PassengerDTO> passengers = (List<PassengerDTO>) session.getAttribute("passengers");
		if (passengers == null || passengers.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
			return;
		}
		int passCnt = passengers.size();

		//
		List<String> goSeatList = parseSeatList(goSeats);
		List<String> backSeatList = parseSeatList(backSeats);

		if (goSeatList.size() != passCnt) {
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().write("<script>alert('가는편 좌석은 승객 수와 동일하게 " + passCnt + "개 선택해야 합니다.'); history.back();</script>");
			return;
		}

		if (backFlight != null && backSeatList.size() != passCnt) {
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().write("<script>alert('오는편 좌석은 승객 수와 동일하게 " + passCnt + "개 선택해야 합니다.'); history.back();</script>");
			return;
		}
		//
		
		int unitPrice = 0;
		int fuelSurcharge = 0;
		int taxPrice = 0;

		if (goFlight != null) {
		    unitPrice += "C".equals(goSeatClass) ? goFlight.getBizPrice() : goFlight.getPrice();
		    fuelSurcharge += goFlight.getFuelSurcharge();
		    taxPrice += goFlight.getTaxPrice();
		}

		if (backFlight != null) {
		    unitPrice += "C".equals(backSeatClass) ? backFlight.getBizPrice() : backFlight.getPrice();
		    fuelSurcharge += backFlight.getFuelSurcharge();
		    taxPrice += backFlight.getTaxPrice();
		}

		int basePrice = (unitPrice + fuelSurcharge + taxPrice) * passCnt;
		int bagPrice = 40000; // 초과 수하물 1개당 고정 요금

		req.setAttribute("totalPrice", basePrice);
		req.setAttribute("bagPrice", bagPrice);

		// to-do 결제 jsp말고 결제 서블릿으로 보내기
		// bookingDTO 생성
		BookingDTO bookingDTO = new BookingDTO();

//		bookingDTO.setUserId("test01"); // 임시 테스트용
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

		if (loginUser != null) {
			bookingDTO.setUserId(loginUser.getUserId());
		}
//		bookingDTO.setTripType((String) session.getAttribute("tripType"));
		// 임시추가 - dhy
		String tripType = (String) session.getAttribute("tripType");

		if (tripType == null || tripType.isEmpty()) {
			tripType = "RT"; // 임시 테스트 기본값
		}

		bookingDTO.setTripType(tripType);
		//

		bookingDTO.setGoFlight(goFlight);

		if (backFlight != null) {
			bookingDTO.setBackFlight(backFlight);
		}

		bookingDTO.setPassengers(passengers);

		bookingDTO.setGoSeats(goSeatList);

		if (backFlight != null) {
			bookingDTO.setBackSeats(backSeatList);
		}

		bookingDTO.setBasePrice(basePrice);
		bookingDTO.setTotalPrice(basePrice);
		bookingDTO.setFuelSurcharge(fuelSurcharge * passCnt);
		bookingDTO.setTaxPrice(taxPrice * passCnt);

		session.setAttribute("bookingDTO", bookingDTO);

//		resp.sendRedirect(req.getContextPath() + "/air/booking/payment");
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().write("<script>" + "window.parent.postMessage({type:'seatDone'}, '*');" + "</script>");
	}
	
	private List<String> parseSeatList(String seats) {
		List<String> list = new ArrayList<>();

		if (seats == null || seats.trim().isEmpty()) {
			return list;
		}

		for (String seat : seats.split(",")) {
			if (seat != null && !seat.trim().isEmpty()) {
				list.add(seat.trim());
			}
		}

		return list;
	}
}
