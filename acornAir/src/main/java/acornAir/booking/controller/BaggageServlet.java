package acornAir.booking.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.booking.dto.BookingDTO;

@WebServlet("/air/booking/baggage")
public class BaggageServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();

		int bags = Integer.parseInt(req.getParameter("bags"));

		session.setAttribute("bags", bags);

		BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");

		if (bookingDTO != null) {
			int baggagePrice = bags * 40000;
			int totalPrice = bookingDTO.getBasePrice() + baggagePrice;

			bookingDTO.setBaggagePrice(baggagePrice);
			bookingDTO.setTotalPrice(totalPrice);

			session.setAttribute("bookingDTO", bookingDTO);
			session.setAttribute("total", totalPrice);
		}

		resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
	}
}