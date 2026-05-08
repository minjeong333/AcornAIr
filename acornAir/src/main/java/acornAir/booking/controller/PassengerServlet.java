package acornAir.booking.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.booking.dto.PassengerDTO;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/booking/passenger")
public class PassengerServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		if (loginUser != null) {
			req.setAttribute("loginUser", loginUser);
		}

		req.getRequestDispatcher("/WEB-INF/views/booking/passenger_info.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		PassengerDTO p = new PassengerDTO();
		
		p.setEngLastName(req.getParameter("engLastName"));
	    p.setEngFirstName(req.getParameter("engFirstName"));
	    p.setGender(req.getParameter("gender"));
	    
	    //date 형변환
	    String birthStr = req.getParameter("birthDate");
	    try {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        java.util.Date birthDate = sdf.parse(birthStr);
	        p.setBirthDate(birthDate);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    
	    HttpSession session = req.getSession();
	    List<PassengerDTO> passengers = new ArrayList<>();
	    passengers.add(p);
	    session.setAttribute("passengers", passengers);
	    session.setAttribute("contactPhone", req.getParameter("contactPhone"));
	    
	    resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
	}
	
			
	}

