package acornAir.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.booking.dao.BookingDAO;
import acornAir.booking.dto.BookingDTO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

		BookingDAO dao = new BookingDAO();
		ArrayList<BookingDTO> bookingList = dao.getAllBookings();

		request.setAttribute("bookingList", bookingList);

		request.getRequestDispatcher("/WEB-INF/views/admin/adminBookingList.jsp").forward(request, response);
	}
}