package acornAir.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.booking.dao.BookingDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/bookings/cancel")
public class AdminBookingCancelServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/air/login");
			return;
		}

		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

		if (!"ADMIN".equals(loginUser.getUserRole())) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		int bookingId = Integer.parseInt(request.getParameter("bookingId"));

		BookingDAO dao = new BookingDAO();
		dao.cancelBooking(bookingId);

		response.sendRedirect(request.getContextPath() + "/admin/bookings");
	}
}