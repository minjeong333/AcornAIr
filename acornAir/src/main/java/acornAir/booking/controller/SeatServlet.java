package acornAir.booking.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.booking.dto.PassengerDTO;
import acornAir.flight.dto.FlightDTO;

@WebServlet("/air/booking/seatSelect")
public class SeatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/booking/seatSelect.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();

        // 좌석 파라미터 수신 및 세션 저장
        String goSeats = req.getParameter("goSeats");
        String backSeats = req.getParameter("backSeats");

        session.setAttribute("goSeats", goSeats);
        if (backSeats != null && !backSeats.isEmpty()) {
            session.setAttribute("backSeats", backSeats);
        }

        // 항공편 가격 계산
        FlightDTO goFlight = (FlightDTO) session.getAttribute("goFlight");
        FlightDTO backFlight = (FlightDTO) session.getAttribute("backFlight");
        String seatClass = (String) session.getAttribute("seatClass");

        @SuppressWarnings("unchecked")
        List<PassengerDTO> passengers = (List<PassengerDTO>) session.getAttribute("passengers");
        int passCnt = (passengers != null) ? passengers.size() : 1;

        int unitPrice = 0;
        if (goFlight != null) {
            unitPrice += "C".equals(seatClass) ? goFlight.getBizPrice() : goFlight.getPrice();
        }
        if (backFlight != null) {
            unitPrice += "C".equals(seatClass) ? backFlight.getBizPrice() : backFlight.getPrice();
        }

        int basePrice = unitPrice * passCnt;
        int bagPrice = 40000; // 초과 수하물 1개당 고정 요금

        req.setAttribute("totalPrice", basePrice);
        req.setAttribute("bagPrice", bagPrice);

        //to-do 결제 jsp말고 결제 서블릿으로 보내기 
        req.getRequestDispatcher("/WEB-INF/views/payment.jsp").forward(req, resp);
    }
}
