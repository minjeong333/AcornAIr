package acornAir.booking.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import acornAir.booking.dto.BaggageDTO;
import acornAir.booking.dto.BookingDTO;
import acornAir.booking.dto.PassengerDTO;

public class BookingDAO {

	// 1. 예약 등록 후 BOOKING_ID 반환
	public int insertBooking(BookingDTO dto, Connection con) throws SQLException {
		String sql = "INSERT INTO TB_BOOKING ( " + "BOOKING_ID, USER_ID, GO_FLIGHT_ID, BACK_FLIGHT_ID, "
				+ "TRIP_TYPE, CONTACT_PHONE, PHONE_COUNTRY, " + "BASE_PRICE, FUEL_SURCHARGE, TAX_PRICE, "
				+ "BAGGAGE_PRICE, TOTAL_PRICE, " + "PAY_METHOD, BOOK_STATUS, BOOK_DATE " + ") VALUES ( "
				+ "SEQ_BOOKING.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Y', SYSDATE " + ")";

		int bookingId = 0;

		try (PreparedStatement pstmt = con.prepareStatement(sql, new String[] { "BOOKING_ID" })) {

			pstmt.setString(1, dto.getUserId());
			pstmt.setInt(2, dto.getGoFlight().getFlightId());

			if (dto.getBackFlight() == null) {
				pstmt.setNull(3, java.sql.Types.NUMERIC);
			} else {
				pstmt.setInt(3, dto.getBackFlight().getFlightId());
			}

			pstmt.setString(4, dto.getTripType());
			pstmt.setString(5, dto.getContactPhone());
			pstmt.setString(6, dto.getPhoneCountry());

			pstmt.setInt(7, dto.getBasePrice());
			pstmt.setInt(8, dto.getFuelSurcharge());
			pstmt.setInt(9, dto.getTaxPrice());

			pstmt.setInt(10, dto.getBaggagePrice());
			pstmt.setInt(11, dto.getTotalPrice());

			pstmt.setString(12, dto.getPayMethod());

			pstmt.executeUpdate();

			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					bookingId = rs.getInt(1);
				}
			}
		}

		return bookingId;
	}

	// 2. 승객 등록
	public void insertPassengers(List<PassengerDTO> passengers, int bookingId, Connection con) throws SQLException {
		String sql = "INSERT INTO TB_PASSENGER ( "
				+ "PASSENGER_ID, BOOKING_ID, ENG_LAST_NAME, ENG_FIRST_NAME, GENDER, BIRTH_DATE "
				+ ") VALUES (SEQ_PASSENGER.NEXTVAL, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			for (PassengerDTO p : passengers) {
				pstmt.setInt(1, bookingId);
				pstmt.setString(2, p.getEngLastName());
				pstmt.setString(3, p.getEngFirstName());
				pstmt.setString(4, p.getGender());
				pstmt.setDate(5, new java.sql.Date(p.getBirthDate().getTime()));
				pstmt.addBatch();
			}

			pstmt.executeBatch();
		}
	}

	// 3. 항공편의 예약된 좌석 목록 조회
	public List<String> getBookedSeats(int flightId, Connection con) throws SQLException {

		List<String> list = new ArrayList<>();

		String sql = "SELECT S.SEAT_NO " + "FROM TB_SEAT S " + "JOIN TB_BOOKING B " + "ON S.BOOKING_ID = B.BOOKING_ID "
				+ "WHERE S.FLIGHT_ID = ? " + "AND B.BOOK_STATUS = 'Y'";

		try (PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, flightId);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {
					list.add(rs.getString("SEAT_NO"));
				}
			}
		}

		return list;
	}

	// 4. 좌석 중복 확인
	public boolean isSeatAlreadyBooked(int flightId, String seatNo, Connection con) throws SQLException {
		String sql = "SELECT COUNT(*) " + "FROM TB_SEAT S " + "JOIN TB_BOOKING B ON S.BOOKING_ID = B.BOOKING_ID "
				+ "WHERE S.FLIGHT_ID = ? " + "AND S.SEAT_NO = ? " + "AND B.BOOK_STATUS = 'Y'";

		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, flightId);
			pstmt.setString(2, seatNo);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1) > 0;
				}
			}
		}

		return false;
	}

	// 4. 좌석 등록
	public void insertSeats(List<String> seats, int bookingId, int flightId, Connection con) throws SQLException {
		String sql = "INSERT INTO TB_SEAT (SEAT_ID, BOOKING_ID, FLIGHT_ID, SEAT_NO) "
				+ "VALUES (SEQ_SEAT.NEXTVAL, ?, ?, ?)";

		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			for (String seatNo : seats) {
				if (isSeatAlreadyBooked(flightId, seatNo, con)) {
					throw new SQLException("이미 예약된 좌석입니다: " + seatNo);
				}

				pstmt.setInt(1, bookingId);
				pstmt.setInt(2, flightId);
				pstmt.setString(3, seatNo);
				pstmt.addBatch();
			}

			pstmt.executeBatch();
		}
	}

	// 5. 수하물 등록
	public void insertBaggage(BaggageDTO dto, int bookingId, Connection con) throws SQLException {
		String sql = "INSERT INTO TB_BAGGAGE ( " + "BAGGAGE_ID, BOOKING_ID, FLIGHT_ID, EXTRA_BAGGAGE, BAGGAGE_PRICE "
				+ ") VALUES (SEQ_BAGGAGE.NEXTVAL, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, bookingId);
			pstmt.setInt(2, dto.getFlightId());
			pstmt.setInt(3, dto.getExtraBaggage());
			pstmt.setInt(4, dto.getBaggagePrice());

			pstmt.executeUpdate();
		}
	}

	// 6. 잔여 좌석 감소
	public int updateRemainSeat(int flightId, int passengerCount, Connection con) throws SQLException {
		String sql = "UPDATE TB_FLIGHT " + "SET REMAIN_SEAT = REMAIN_SEAT - ? " + "WHERE FLIGHT_ID = ?";

		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, passengerCount);
			pstmt.setInt(2, flightId);

			return pstmt.executeUpdate();
		}
	}

	// 관리자 예약 전체 조회
	public java.util.ArrayList<BookingDTO> getAllBookings() {

		java.util.ArrayList<BookingDTO> list = new java.util.ArrayList<>();

		String sql = "SELECT b.BOOKING_ID, b.USER_ID, b.GO_FLIGHT_ID, b.BACK_FLIGHT_ID, "
				+ "b.TRIP_TYPE, b.CONTACT_PHONE, b.PHONE_COUNTRY, " + "b.BASE_PRICE, b.FUEL_SURCHARGE, b.TAX_PRICE, "
				+ "b.BAGGAGE_PRICE, b.TOTAL_PRICE, " + "b.PAY_METHOD, b.BOOK_STATUS, b.BOOK_DATE, "
				+ "gf.FLIGHT_NO AS GO_FLIGHT_NO, " + "bf.FLIGHT_NO AS BACK_FLIGHT_NO " + "FROM TB_BOOKING b "
				+ "JOIN TB_FLIGHT gf ON b.GO_FLIGHT_ID = gf.FLIGHT_ID "
				+ "LEFT JOIN TB_FLIGHT bf ON b.BACK_FLIGHT_ID = bf.FLIGHT_ID " + "ORDER BY b.BOOK_DATE DESC";

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			acornAir.util.DBUtil db = new acornAir.util.DBUtil();
			con = db.dbcon();

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BookingDTO booking = new BookingDTO();

				booking.setBookingId(rs.getInt("BOOKING_ID"));
				booking.setUserId(rs.getString("USER_ID"));
				booking.setTripType(rs.getString("TRIP_TYPE"));
				booking.setContactPhone(rs.getString("CONTACT_PHONE"));
				booking.setPhoneCountry(rs.getString("PHONE_COUNTRY"));
				booking.setBasePrice(rs.getInt("BASE_PRICE"));
				booking.setFuelSurcharge(rs.getInt("FUEL_SURCHARGE"));
				booking.setTaxPrice(rs.getInt("TAX_PRICE"));
				booking.setBaggagePrice(rs.getInt("BAGGAGE_PRICE"));
				booking.setTotalPrice(rs.getInt("TOTAL_PRICE"));
				booking.setPayMethod(rs.getString("PAY_METHOD"));
				booking.setBookStatus(rs.getString("BOOK_STATUS"));
				booking.setBookDate(rs.getDate("BOOK_DATE"));

				acornAir.flight.dto.FlightDTO goFlight = new acornAir.flight.dto.FlightDTO();

				goFlight.setFlightId(rs.getInt("GO_FLIGHT_ID"));
				goFlight.setFlightNo(rs.getString("GO_FLIGHT_NO"));

				booking.setGoFlight(goFlight);

				int backFlightId = rs.getInt("BACK_FLIGHT_ID");

				if (!rs.wasNull()) {
					acornAir.flight.dto.FlightDTO backFlight = new acornAir.flight.dto.FlightDTO();

					backFlight.setFlightId(backFlightId);
					backFlight.setFlightNo(rs.getString("BACK_FLIGHT_NO"));

					booking.setBackFlight(backFlight);
				}

				list.add(booking);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return list;
	}

	// 관리자 예약 취소
	public int cancelBooking(int bookingId) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int result = 0;

		try {
			acornAir.util.DBUtil db = new acornAir.util.DBUtil();
			con = db.dbcon();
			con.setAutoCommit(false);

			String selectSql = "SELECT B.GO_FLIGHT_ID, B.BACK_FLIGHT_ID, " + "COUNT(P.PASSENGER_ID) AS PASSENGER_COUNT "
					+ "FROM TB_BOOKING B " + "LEFT JOIN TB_PASSENGER P " + "ON B.BOOKING_ID = P.BOOKING_ID "
					+ "WHERE B.BOOKING_ID = ? " + "AND B.BOOK_STATUS = 'Y' "
					+ "GROUP BY B.GO_FLIGHT_ID, B.BACK_FLIGHT_ID";

			pstmt = con.prepareStatement(selectSql);
			pstmt.setInt(1, bookingId);
			rs = pstmt.executeQuery();

			if (!rs.next()) {
				con.rollback();
				return 0;
			}

			int goFlightId = rs.getInt("GO_FLIGHT_ID");

			int backFlightId = rs.getInt("BACK_FLIGHT_ID");
			boolean hasBackFlight = !rs.wasNull();

			int passengerCount = rs.getInt("PASSENGER_COUNT");

			rs.close();
			pstmt.close();

			String updateBookingSql = "UPDATE TB_BOOKING " + "SET BOOK_STATUS = 'N' " + "WHERE BOOKING_ID = ?";

			pstmt = con.prepareStatement(updateBookingSql);
			pstmt.setInt(1, bookingId);
			result = pstmt.executeUpdate();

			pstmt.close();

			String updateFlightSql = "UPDATE TB_FLIGHT " + "SET REMAIN_SEAT = REMAIN_SEAT + ? " + "WHERE FLIGHT_ID = ?";

			pstmt = con.prepareStatement(updateFlightSql);

			pstmt.setInt(1, passengerCount);
			pstmt.setInt(2, goFlightId);
			pstmt.executeUpdate();

			if (hasBackFlight) {
				pstmt.setInt(1, passengerCount);
				pstmt.setInt(2, backFlightId);
				pstmt.executeUpdate();
			}

			con.commit();

		} catch (Exception e) {
			try {
				if (con != null)
					con.rollback();
			} catch (Exception ex) {
				ex.printStackTrace();
			}

			e.printStackTrace();

		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return result;
	}
}