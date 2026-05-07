package acornAir.booking.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.booking.dto.BaggageDTO;
import acornAir.booking.dto.BookingDTO;
import acornAir.booking.service.PaymentService;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/booking/payment")
public class PaymentServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private PaymentService paymentService = new PaymentService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");

		if (bookingDTO == null) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}

		req.setAttribute("totalPrice", bookingDTO.getBasePrice());
		req.setAttribute("bagPrice", 40000);

		req.getRequestDispatcher("/WEB-INF/views/booking/payment.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();

		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

		BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");

//		if (loginUser == null) {
//			resp.sendRedirect(req.getContextPath() + "/air/login");
//			return;
//		}
		if (loginUser == null) {
		    loginUser = new UserDTO();
		    loginUser.setUserId("test01");
		    loginUser.setUserPhone("01012345678");
		    loginUser.setPhoneCountry("+82");

		    session.setAttribute("loginUser", loginUser);
		}

		if (bookingDTO == null) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}

		try {
			String payMethod = req.getParameter("payMethod");

			int total = Integer.parseInt(req.getParameter("total"));
			int bags = Integer.parseInt(req.getParameter("bags"));

			int bagPrice = 40000;
			int baggagePrice = bags * bagPrice;

			bookingDTO.setPayMethod(payMethod);
			bookingDTO.setBaggagePrice(baggagePrice);
			bookingDTO.setTotalPrice(total);

			String contactPhone = (String) session.getAttribute("contactPhone");

			if (contactPhone == null || contactPhone.trim().isEmpty()) {
				contactPhone = loginUser.getUserPhone();
			}

			bookingDTO.setContactPhone(contactPhone);
			bookingDTO.setPhoneCountry(loginUser.getPhoneCountry());

			if (bags > 0) {
				List<BaggageDTO> baggages = new ArrayList<>();

				BaggageDTO goBag = new BaggageDTO();
				goBag.setFlightId(bookingDTO.getGoFlight().getFlightId());
				goBag.setExtraBaggage(bags);
				goBag.setBaggagePrice(baggagePrice);
				baggages.add(goBag);

				if (bookingDTO.getBackFlight() != null) {
					BaggageDTO backBag = new BaggageDTO();
					backBag.setFlightId(bookingDTO.getBackFlight().getFlightId());
					backBag.setExtraBaggage(bags);
					backBag.setBaggagePrice(baggagePrice);
					baggages.add(backBag);
				}

				bookingDTO.setBaggages(baggages);
			}

			paymentService.pay(bookingDTO);

			session.removeAttribute("bookingDTO");
			session.removeAttribute("passengers");
			session.removeAttribute("goSeats");
			session.removeAttribute("backSeats");
			session.removeAttribute("contactPhone");

			resp.sendRedirect(req.getContextPath() + "/air/mypage");
			System.out.println("=== DB INSERT 완료 ===");

//		} catch (Exception e) {
//			e.printStackTrace();
//
//			String msg = e.getMessage();
//
//			if (msg != null && msg.contains("이미 예약된 좌석입니다")) {
//				req.setAttribute("errorMsg", msg);
//				req.getRequestDispatcher("/WEB-INF/views/booking/seatSelect.jsp").forward(req, resp);
//				return;
//			}
//
//			req.setAttribute("errorMsg", "결제 처리 중 오류가 발생했습니다.");
//			req.setAttribute("totalPrice", bookingDTO.getBasePrice());
//			req.setAttribute("bagPrice", 40000);
//
//			req.getRequestDispatcher("/WEB-INF/views/booking/payment.jsp").forward(req, resp);
//		}
		} catch (Exception e) {
		    e.printStackTrace();

		    String error = e.toString();

		    req.setAttribute("errorMsg", error);
		    req.setAttribute("totalPrice", bookingDTO != null ? bookingDTO.getBasePrice() : 0);
		    req.setAttribute("bagPrice", 40000);

		    resp.setContentType("text/html; charset=UTF-8");

		    resp.getWriter().println("<script>");
		    resp.getWriter().println("alert('결제 오류: " + e.toString().replace("'", "") + "');");
		    resp.getWriter().println("location.href='" + req.getContextPath() + "/air/booking/passenger';");
		    resp.getWriter().println("</script>");
		}
	}
}