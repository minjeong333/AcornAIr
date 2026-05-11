package acornAir.admin.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.flight.dao.FlightDAO;
import acornAir.flight.dto.FlightDTO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/flights/add")
public class AdminFlightAddServlet extends HttpServlet {

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

		request.getRequestDispatcher("/WEB-INF/views/admin/adminFlightAdd.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		try {

			FlightDTO dto = new FlightDTO();

			dto.setFlightNo(request.getParameter("flightNo"));
			dto.setDepAirport(request.getParameter("depAirport"));
			dto.setArrAirport(request.getParameter("arrAirport"));

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

			dto.setDepTime(sdf.parse(request.getParameter("depTime")));

			dto.setArrTime(sdf.parse(request.getParameter("arrTime")));

			dto.setSeatClass(request.getParameter("seatClass"));

			dto.setPrice(Integer.parseInt(request.getParameter("price")));

			dto.setTotalSeat(Integer.parseInt(request.getParameter("totalSeat")));

			dto.setRemainSeat(Integer.parseInt(request.getParameter("remainSeat")));

			FlightDAO dao = new FlightDAO();

			dao.insertFlight(dto);

			response.sendRedirect(request.getContextPath() + "/admin/flights");

		} catch (Exception e) {
			e.printStackTrace();

			response.sendRedirect(request.getContextPath() + "/admin/flights/add");
		}
	}
}