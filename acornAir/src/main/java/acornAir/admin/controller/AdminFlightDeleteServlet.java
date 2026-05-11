package acornAir.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.flight.dao.FlightDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/flights/delete")
public class AdminFlightDeleteServlet extends HttpServlet {

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

		String flightIdStr = request.getParameter("flightId");

		if (flightIdStr == null || flightIdStr.trim().equals("")) {
			response.sendRedirect(request.getContextPath() + "/admin/flights");
			return;
		}

		int flightId = Integer.parseInt(flightIdStr);

		FlightDAO dao = new FlightDAO();
		dao.deleteFlight(flightId);

		response.sendRedirect(request.getContextPath() + "/admin/flights");
	}
}