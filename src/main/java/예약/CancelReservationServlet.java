package 예약;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/reservation/cancel")
public class CancelReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));

        ReservationDAO dao = new ReservationDAO();
        dao.cancelReservation(bookingId);

        resp.sendRedirect(req.getContextPath() + "/reservation/list");
    }
}