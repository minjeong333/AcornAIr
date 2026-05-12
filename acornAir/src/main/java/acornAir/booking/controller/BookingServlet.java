package acornAir.booking.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.flight.dao.FlightDAO;
import acornAir.flight.dto.FlightDTO;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {

   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      req.setCharacterEncoding("UTF-8");

      HttpSession session = req.getSession();

      String goFlightIdParam = req.getParameter("goFlightId");
      String seatClass = req.getParameter("seatClass");

      if (goFlightIdParam == null || goFlightIdParam.trim().isEmpty()) {
         resp.sendRedirect(req.getContextPath() + "/home");
         return;
      }

      if (seatClass == null || seatClass.trim().isEmpty()) {
         seatClass = "Y";
      }

      int selectedFlightId = Integer.parseInt(goFlightIdParam);

      FlightDAO dao = new FlightDAO();
      FlightDTO selectedFlight = dao.getById(selectedFlightId);

      if (selectedFlight == null) {
         resp.sendRedirect(req.getContextPath() + "/home");
         return;
      }

      String tripType = (String) session.getAttribute("tripType");
      String depAirport = (String) session.getAttribute("depAirport");
      String arrAirport = (String) session.getAttribute("arrAirport");
      String returnDate = (String) session.getAttribute("returnDate");

      Integer passCntObj = (Integer) session.getAttribute("passCnt");
      int passCnt = passCntObj != null ? passCntObj : 1;

      FlightDTO goFlight = (FlightDTO) session.getAttribute("goFlight");

      // 편도
      if (!"RT".equals(tripType)) {
         session.setAttribute("goFlight", selectedFlight);
         session.setAttribute("goSeatClass", seatClass);

         session.removeAttribute("backFlight");
         session.removeAttribute("backSeatClass");

         resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
         return;
      }

      // 왕복 - 가는편 선택
      if (goFlight == null) {
         session.setAttribute("goFlight", selectedFlight);
         session.setAttribute("goSeatClass", seatClass);

         ArrayList<FlightDTO> returnList = dao.search(arrAirport, depAirport, returnDate, passCnt);

         req.setAttribute("flightList", returnList);
         req.setAttribute("mode", "return");

         req.getRequestDispatcher("/WEB-INF/views/flight/flightList.jsp").forward(req, resp);
         return;
      }

      // 왕복 - 오는편 선택
      session.setAttribute("backFlight", selectedFlight);
      session.setAttribute("backSeatClass", seatClass);

      resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
   }
}