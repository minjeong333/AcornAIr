package acornAir.booking.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.flight.dao.FlightDAO;
import acornAir.flight.dto.FlightDTO;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // 선택한 항공편
        String goFlightId =
                req.getParameter("goFlightId");

        String seatClass =
                req.getParameter("seatClass");

        String goPrice = req.getParameter("goPrice");
        
        // session 저장
        session.setAttribute("goFlightId", goFlightId);
        session.setAttribute("seatClass", seatClass);
        session.setAttribute("goPrice", goPrice);
        
        // 임시 추가 - dhy
        FlightDTO goFlight = new FlightDTO();
        goFlight.setFlightId(Integer.parseInt(goFlightId));
        goFlight.setPrice(Integer.parseInt(goPrice));
        goFlight.setBizPrice(Integer.parseInt(goPrice));

        session.setAttribute("goFlight", goFlight);
        //

        // 검색 조건 꺼내기
        String tripType =
                (String)session.getAttribute("tripType");

        String depAirport =
                (String)session.getAttribute("depAirport");

        String arrAirport =
                (String)session.getAttribute("arrAirport");

        String returnDate =
                (String)session.getAttribute("returnDate");

        int passCnt =
                (int)session.getAttribute("passCnt");

        // 왕복
        if("RT".equals(tripType)) {

            FlightDAO dao = new FlightDAO();

            ArrayList<FlightDTO> returnList =
                    dao.search(
                            arrAirport,
                            depAirport,
                            returnDate,
                            passCnt
                    );

            req.setAttribute("flightList", returnList);
            req.setAttribute("mode", "return");

            req.getRequestDispatcher(
                    "/WEB-INF/views/flight/flightList.jsp")
                    .forward(req, resp);

        } else {

            req.getRequestDispatcher(
                    "/WEB-INF/views/booking/passenger.jsp")
                    .forward(req, resp);
        }
    }
}