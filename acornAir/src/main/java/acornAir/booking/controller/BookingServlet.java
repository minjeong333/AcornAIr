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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();

		// 선택한 항공편
		//null체크 안해주면 goFlightId의 값이 null일 때 int로 형변환 시도 시 NumberFormatException 오류 남
		String goFlightIdParam = req.getParameter("goFlightId");
		if (goFlightIdParam == null) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}
		int goFlightId = Integer.parseInt(goFlightIdParam);

		String seatClass = req.getParameter("seatClass");

		String goPrice = req.getParameter("goPrice");

		// session 저장
		session.setAttribute("goFlightId", goFlightId);
		session.setAttribute("seatClass", seatClass);
		session.setAttribute("goPrice", goPrice);

		FlightDAO dao = new FlightDAO();

		// goFlight/backFlight session 저장 (passenger_info.jsp 여정정보 표시용)
		if (session.getAttribute("goFlight") == null) {
			FlightDTO goFlight = dao.getById(goFlightId);
			session.setAttribute("goFlight", goFlight);
		} else {
			FlightDTO backFlight = dao.getById(goFlightId);
			session.setAttribute("backFlight", backFlight);
		}

		// 검색 조건 꺼내기
		String tripType = (String) session.getAttribute("tripType");

		String depAirport = (String) session.getAttribute("depAirport");

		String arrAirport = (String) session.getAttribute("arrAirport");

		String returnDate = (String) session.getAttribute("returnDate");

		int passCnt = (int) session.getAttribute("passCnt");

		// backFlight가 설정됐으면 (왕복 오는편 선택 완료) → passenger 페이지로
		if (session.getAttribute("backFlight") != null) {
			resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
			return;
		}

		// 왕복 → 오는편 목록 표시
		if ("RT".equals(tripType)) {

			ArrayList<FlightDTO> returnList = dao.search(arrAirport, depAirport, returnDate, passCnt);

			req.setAttribute("flightList", returnList);
			req.setAttribute("mode", "return");

			req.getRequestDispatcher("/WEB-INF/views/flight/flightList.jsp").forward(req, resp);

		} else {
			// 편도 → passenger 페이지로
			resp.sendRedirect(req.getContextPath() + "/air/booking/passenger");
		}
	}
}