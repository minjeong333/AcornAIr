package acornAir.reservation.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.login.dto.UserDTO;
import acornAir.reservation.dao.ReservationDAO;
import acornAir.reservation.dto.ReservationDTO;
 

@WebServlet("/reservation/list")
public class ReservationListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
//
    	HttpSession session = req.getSession();

    	UserDTO loginUser =
    	        (UserDTO) session.getAttribute("loginUser");

    	if (loginUser == null) {
    	    resp.sendRedirect(req.getContextPath() + "/air/login");
    	    return;
    	}

    	String userId = loginUser.getUserId();
        ReservationDAO dao = new ReservationDAO();

        // 테스트용 아이디
        //String userId = "user01";

        ArrayList<ReservationDTO> list =
                dao.selectReservationList(userId);

        req.setAttribute("reservationList", list);

        req.getRequestDispatcher(
                "/WEB-INF/views/예약/reservationList.jsp")
                .forward(req, resp);
    }
}