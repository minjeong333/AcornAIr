package acornAir.booking.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.booking.dto.PassengerDTO;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/booking/passenger")
public class PassengerServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession();

		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		if (loginUser != null) {
			req.setAttribute("loginUser", loginUser);
		}

		req.getRequestDispatcher("/WEB-INF/views/booking/passenger_info.jsp")
		   .forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		HttpSession session = req.getSession();

		int passCnt = session.getAttribute("passCnt") != null
				? (Integer) session.getAttribute("passCnt")
				: 1;

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<PassengerDTO> passengers = new ArrayList<>();

		for (int i = 0; i < passCnt; i++) {
			PassengerDTO p = new PassengerDTO();

			p.setEngLastName(req.getParameter("engLastName_" + i));
			p.setEngFirstName(req.getParameter("engFirstName_" + i));
			p.setGender(req.getParameter("gender_" + i));

			String birthStr = req.getParameter("birthDate_" + i);
			if (birthStr != null && !birthStr.isEmpty()) {
				try {
					p.setBirthDate(sdf.parse(birthStr));
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}

			passengers.add(p);
		}
		
		String contactPhone = req.getParameter("contactPhone");
		String contactEmail = req.getParameter("contactEmail");

		String contactPhone = req.getParameter("contactPhone");
		String contactEmail = req.getParameter("contactEmail");

		session.setAttribute("passengers", passengers);

		if (contactPhone != null && !contactPhone.trim().isEmpty()) {
			session.setAttribute("contactPhone", contactPhone.trim());
		}

		if (contactEmail != null && !contactEmail.trim().isEmpty()) {
			session.setAttribute("contactEmail", contactEmail.trim());
		}
		
		resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
	}
}