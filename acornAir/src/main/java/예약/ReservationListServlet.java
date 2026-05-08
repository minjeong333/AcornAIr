package 예약;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.login.dto.UserDTO;

@WebServlet("/reservation/list")
public class ReservationListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
//
    	HttpSession session = req.getSession(false);

    	if (session == null) {
    	    resp.sendRedirect(req.getContextPath() + "/air/login");
    	    return;
    	}

    	UserDTO loginUser =
    	        (UserDTO) session.getAttribute("loginUser");

    	if (loginUser == null) {
    	    resp.sendRedirect(req.getContextPath() + "/air/login");
    	    return;
    	}

    	String userId = loginUser.getUserId();

    	System.out.println("예약조회 로그인아이디 = " + userId);
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