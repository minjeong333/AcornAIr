package acornAir.booking.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.booking.dto.BookingDTO;
import acornAir.booking.dto.PassengerDTO;
import acornAir.flight.dto.FlightDTO;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/booking/seatSelect")
public class SeatServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
		
		// 임시추가 - dhy
		if (goFlight == null) {
		    String goFlightId = (String) session.getAttribute("goFlightId");
		    String goPrice = (String) session.getAttribute("goPrice");

		    goFlight = new FlightDTO();

		    if (goFlightId != null) {
		        goFlight.setFlightId(Integer.parseInt(goFlightId));
		    } else {
		        goFlight.setFlightId(1); // 임시 테스트용, DB에 실제 있는 FLIGHT_ID
		    }

		    if (goPrice != null) {
		        goFlight.setPrice(Integer.parseInt(goPrice));
		        goFlight.setBizPrice(Integer.parseInt(goPrice));
		    } else {
		        goFlight.setPrice(190000);
		        goFlight.setBizPrice(450000);
		    }

		    session.setAttribute("goFlight", goFlight);
		}
		//
		
		FlightDTO backFlight = (FlightDTO) session.getAttribute("backFlight");
		String seatClass = (String) session.getAttribute("seatClass");

		@SuppressWarnings("unchecked")
		List<PassengerDTO> passengers = (List<PassengerDTO>) session.getAttribute("passengers");
		if (passengers == null || passengers.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
			return;
		}
		int passCnt = passengers.size();

		int unitPrice = 0;
		if (goFlight != null) {
			unitPrice += "C".equals(seatClass) ? goFlight.getBizPrice() : goFlight.getPrice();
		}
		if (backFlight != null) {
			unitPrice += "C".equals(seatClass) ? backFlight.getBizPrice() : backFlight.getPrice();
		}

		int basePrice = unitPrice * passCnt;
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

		if (goSeats != null && !goSeats.isEmpty()) {
		    bookingDTO.setGoSeats(java.util.Arrays.asList(goSeats.split(",")));
		}

		if (backSeats != null && !backSeats.isEmpty()) {
		    bookingDTO.setBackSeats(java.util.Arrays.asList(backSeats.split(",")));
		}

		bookingDTO.setBasePrice(basePrice);
		bookingDTO.setTotalPrice(basePrice);

		session.setAttribute("bookingDTO", bookingDTO);

		resp.sendRedirect(req.getContextPath() + "/air/booking/payment");
	}
}
