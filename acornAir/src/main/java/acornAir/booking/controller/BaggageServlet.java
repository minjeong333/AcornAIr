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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setAttribute("bagPrice", 40000);

		req.getRequestDispatcher("/WEB-INF/views/booking/baggage.jsp")
		   .forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();

		int bags = 0;
		String bagsParam = req.getParameter("bags");

		if (bagsParam != null && !bagsParam.isEmpty()) {
			bags = Integer.parseInt(bagsParam);
		}

		session.setAttribute("bags", bags);

		BookingDTO bookingDTO = (BookingDTO) session.getAttribute("bookingDTO");

		int baggagePrice = bags * 40000;
		int totalPrice = baggagePrice;

		if (bookingDTO != null) {
			totalPrice = bookingDTO.getBasePrice() + baggagePrice;

			bookingDTO.setBaggagePrice(baggagePrice);
			bookingDTO.setTotalPrice(totalPrice);

			session.setAttribute("bookingDTO", bookingDTO);
			session.setAttribute("total", totalPrice);
		}

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().write(
			"<script>" +
			"window.parent.postMessage({" +
			"type:'baggageDone'," +
			"bags:" + bags + "," +
			"bagFee:" + baggagePrice +
			"}, '*');" +
			"</script>"
		);
	}
}