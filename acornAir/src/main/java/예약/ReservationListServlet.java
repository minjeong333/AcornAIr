package 예약;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/reservation/list")
public class ReservationListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ReservationDAO dao = new ReservationDAO();

        // 테스트용 아이디
        String userId = "test";

        ArrayList<ReservationDTO> list =
                dao.selectReservationList(userId);

        req.setAttribute("reservationList", list);

        req.getRequestDispatcher(
                "/WEB-INF/views/예약/reservationList.jsp")
                .forward(req, resp);
    }
}