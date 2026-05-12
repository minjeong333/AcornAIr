package acornAir.flight.controller;

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
import acornAir.reservation.dao.ReservationDAO;

@WebServlet("/home")
public class FlightSearchServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

		// 검색 조건 받기
		String depAirport = req.getParameter("depAirport");
		String arrAirport = req.getParameter("arrAirport");
		String depDate = req.getParameter("depDate");
		String passCntStr = req.getParameter("passCnt");
		String tripType = req.getParameter("tripType");
		String returnDate = req.getParameter("returnDate");
		String seatClass = req.getParameter("seatClass");
		
		int passCnt = 1;

		if (passCntStr != null && !passCntStr.equals("")) {
			passCnt = Integer.parseInt(passCntStr);
		}

		// 처음 home 들어왔을 때
		if (depAirport == null) {

		    FlightDAO dao = new FlightDAO();

		    req.setAttribute("nyPrice", dao.getRoundTripLowestPrice("JFK"));
		    req.setAttribute("sfPrice", dao.getRoundTripLowestPrice("SFO"));
		    req.setAttribute("londonPrice", dao.getRoundTripLowestPrice("LHR"));
		    req.setAttribute("parisPrice", dao.getRoundTripLowestPrice("CDG"));

		    req.getRequestDispatcher("/WEB-INF/views/flight/main.jsp").forward(req, resp);

		    return;
		}
		// DAO 호출
		FlightDAO dao = new FlightDAO();

		ArrayList<FlightDTO> list = dao.search(depAirport, arrAirport, depDate, passCnt);

		// request 저장
		req.setAttribute("flightList", list);

		if ("RT".equals(tripType)) {

		    ArrayList<FlightDTO> backList =
		            dao.search(arrAirport, depAirport, returnDate, passCnt);

		    req.setAttribute("backFlightList", backList);
		}
		// session 저장
		HttpSession session = req.getSession();

		// 이전 예약 흐름 세션 초기화 (재검색 시 오염 방지)
		session.removeAttribute("goFlight");
		session.removeAttribute("backFlight");
		session.removeAttribute("goSeatClass");
		session.removeAttribute("backSeatClass");
		session.removeAttribute("goFlightId");
		session.removeAttribute("goPrice");
		session.removeAttribute("passengers");
		session.removeAttribute("bookingDTO");
		session.removeAttribute("goSeats");
		session.removeAttribute("backSeats");
		session.removeAttribute("bags");

		session.setAttribute("depAirport", depAirport);
		session.setAttribute("arrAirport", arrAirport);
		session.setAttribute("depDate", depDate);
		session.setAttribute("passCnt", passCnt);
		session.setAttribute("tripType", tripType);
		session.setAttribute("returnDate", returnDate);

		// 결과 페이지 이동
		req.getRequestDispatcher("/WEB-INF/views/flight/flightList.jsp").forward(req, resp);

	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {

	    req.setCharacterEncoding("UTF-8");

	    String mode = req.getParameter("mode");

	    if (!"mytrip".equals(mode)) {
	        resp.sendRedirect(req.getContextPath() + "/home");
	        return;
	    }

	    String bookingId = req.getParameter("bookingId");
	    String depDate = req.getParameter("depDate");
	    String lastName = req.getParameter("lastName");
	    String firstName = req.getParameter("firstName");

 
	    ReservationDAO dao = new ReservationDAO();
 

	    boolean result = dao.checkReservation(
	            bookingId,
	            depDate,
	            lastName,
	            firstName
	    );

	    if (result) {
	        resp.sendRedirect(req.getContextPath() + "/reservation/list");
	    } else {
	        resp.setContentType("text/html;charset=utf-8");
	        resp.getWriter().println("""
	            <script>
	                alert('입력한 항목이 올바르지 않습니다.');
	                history.back();
	            </script>
	        """);
	    }
	}
}
