package acornAir.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.flight.dao.FlightDAO;
import acornAir.flight.dto.FlightDTO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/flights")
public class AdminFlightServlet extends HttpServlet {

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

		FlightDAO dao = new FlightDAO();
		ArrayList<FlightDTO> flightList = dao.getAllFlights();

		request.setAttribute("flightList", flightList);

		request.getRequestDispatcher("/WEB-INF/views/admin/adminFlightList.jsp").forward(request, response);
	}
}