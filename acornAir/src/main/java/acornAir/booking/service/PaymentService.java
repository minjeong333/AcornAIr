package acornAir.booking.service;

import java.sql.Connection;
import java.sql.SQLException;

import acornAir.booking.dao.BookingDAO;
import acornAir.booking.dto.BaggageDTO;
import acornAir.booking.dto.BookingDTO;
import acornAir.util.DBUtil;

public class PaymentService {

	private BookingDAO bookingDAO = new BookingDAO();

	public void pay(BookingDTO bookingDTO) throws Exception {

		Connection con = null;

		try {
			DBUtil db = new DBUtil();
			con = db.dbcon();

			if (con == null) {
			    throw new SQLException("DB 연결 실패: DBUtil.dbcon()이 null을 반환했습니다.");
			}

			con.setAutoCommit(false);

			// 1. 예약 등록
			int bookingId = bookingDAO.insertBooking(bookingDTO, con);

			// 2. 승객 등록
			bookingDAO.insertPassengers(bookingDTO.getPassengers(), bookingId, con);

			// 3. 가는편 좌석 등록
			bookingDAO.insertSeats(bookingDTO.getGoSeats(), bookingId, bookingDTO.getGoFlight().getFlightId(), con);

			// 4. 오는편 좌석 등록
			if (bookingDTO.getBackFlight() != null && bookingDTO.getBackSeats() != null) {

				bookingDAO.insertSeats(bookingDTO.getBackSeats(), bookingId, bookingDTO.getBackFlight().getFlightId(),
						con);
			}

			// 5. 수하물 등록
			if (bookingDTO.getBaggages() != null) {
				for (BaggageDTO baggage : bookingDTO.getBaggages()) {
					bookingDAO.insertBaggage(baggage, bookingId, con);
				}
			}

			int passengerCount = bookingDTO.getPassengers().size();

			// 6. 가는편 잔여좌석 감소
			bookingDAO.updateRemainSeat(bookingDTO.getGoFlight().getFlightId(), passengerCount, con);

			// 7. 오는편 잔여좌석 감소
			if (bookingDTO.getBackFlight() != null) {
				bookingDAO.updateRemainSeat(bookingDTO.getBackFlight().getFlightId(), passengerCount, con);
			}

			con.commit();

		} catch (Exception e) {
			if (con != null) {
				con.rollback();
			}

			throw e;

		} finally {
			if (con != null) {
				con.close();
			}
		}
	}
}