package acornAir.admin.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
			String flightNo = request.getParameter("flightNo");
			String depAirport = request.getParameter("depAirport");
			String arrAirport = request.getParameter("arrAirport");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
			Date depTime = sdf.parse(request.getParameter("depTime"));
			Date arrTime = sdf.parse(request.getParameter("arrTime"));

			int price = Integer.parseInt(request.getParameter("price"));
			int fuelSurcharge =
			        Integer.parseInt(request.getParameter("fuelSurcharge"));

			int taxPrice =
			        Integer.parseInt(request.getParameter("taxPrice"));
//			int economySeat = Integer.parseInt(request.getParameter("economySeat"));
//			int businessSeat = Integer.parseInt(request.getParameter("businessSeat"));
			int economySeat = 198;
			int businessSeat = 20;

			FlightDAO dao = new FlightDAO();

			// 일반석 Y
			FlightDTO economy = new FlightDTO();
			economy.setFlightNo(flightNo);
			economy.setDepAirport(depAirport);
			economy.setArrAirport(arrAirport);
			economy.setDepTime(depTime);
			economy.setArrTime(arrTime);
			economy.setSeatClass("Y");
			economy.setPrice(price);
			economy.setFuelSurcharge(fuelSurcharge);
			economy.setTaxPrice(taxPrice);
			economy.setTotalSeat(economySeat);
			economy.setRemainSeat(economySeat);

			dao.insertFlight(economy);

			// 비즈니스석 C
			FlightDTO business = new FlightDTO();
			business.setFlightNo(flightNo);
			business.setDepAirport(depAirport);
			business.setArrAirport(arrAirport);
			business.setDepTime(depTime);
			business.setArrTime(arrTime);
			business.setSeatClass("C");
			business.setPrice(price);
			business.setFuelSurcharge(fuelSurcharge);
			business.setTaxPrice(taxPrice);
			business.setTotalSeat(businessSeat);
			business.setRemainSeat(businessSeat);

			dao.insertFlight(business);

			response.sendRedirect(request.getContextPath() + "/admin/flights");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/admin/flights/add");
		}
	}
}