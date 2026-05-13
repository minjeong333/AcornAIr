package acornAir.flight.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.airport.dao.AirportDAO;
import acornAir.flight.dao.FlightDAO;
import acornAir.flight.dto.FlightDTO;

@WebServlet("/res")
public class AirportResServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		AirportDAO airportDAO = new AirportDAO();
		req.setAttribute("airportList", airportDAO.selectAllAirports());
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

			req.getRequestDispatcher("/WEB-INF/views/flight/res.jsp").forward(req, resp);

			return;
		}

		// DAO 호출
		FlightDAO dao = new FlightDAO();

		ArrayList<FlightDTO> list = dao.search(depAirport, arrAirport, depDate, passCnt);

		// request 저장
		req.setAttribute("flightList", list);

		// session 저장
		HttpSession session = req.getSession();

		session.setAttribute("depAirport", depAirport);
		session.setAttribute("arrAirport", arrAirport);
		session.setAttribute("depDate", depDate);
		session.setAttribute("passCnt", passCnt);
		session.setAttribute("tripType", tripType);
		session.setAttribute("returnDate", returnDate);
		session.setAttribute("seatClass", seatClass);

		// 결과 페이지 이동
		req.getRequestDispatcher("/WEB-INF/views/flightList.jsp").forward(req, resp);

	}
}
