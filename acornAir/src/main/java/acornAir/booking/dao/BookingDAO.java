package acornAir.booking.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import acornAir.booking.dto.BaggageDTO;
import acornAir.booking.dto.BookingDTO;
import acornAir.booking.dto.PassengerDTO;

public class BookingDAO {

    // 1. 예약 등록 후 BOOKING_ID 반환
    public int insertBooking(BookingDTO dto, Connection con) throws SQLException {
        String sql =
            "INSERT INTO TB_BOOKING ( " +
            "BOOKING_ID, USER_ID, GO_FLIGHT_ID, BACK_FLIGHT_ID, " +
            "TRIP_TYPE, CONTACT_PHONE, PHONE_COUNTRY, " +
            "BASE_PRICE, BAGGAGE_PRICE, TOTAL_PRICE, " +
            "PAY_METHOD, BOOK_STATUS, BOOK_DATE " +
            ") VALUES ( " +
            "SEQ_BOOKING.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Y', SYSDATE " +
            ")";

        int bookingId = 0;

        try (PreparedStatement pstmt =
                     con.prepareStatement(sql, new String[] {"BOOKING_ID"})) {

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
            pstmt.setInt(8, dto.getBaggagePrice());
            pstmt.setInt(9, dto.getTotalPrice());
            pstmt.setString(10, dto.getPayMethod());

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
    public void insertPassengers(List<PassengerDTO> passengers,
                                 int bookingId,
                                 Connection con) throws SQLException {
        String sql =
            "INSERT INTO TB_PASSENGER ( " +
            "PASSENGER_ID, BOOKING_ID, ENG_LAST_NAME, ENG_FIRST_NAME, GENDER, BIRTH_DATE " +
            ") VALUES (SEQ_PASSENGER.NEXTVAL, ?, ?, ?, ?, ?)";

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

    // 3. 좌석 중복 확인
    public boolean isSeatAlreadyBooked(int flightId,
                                       String seatNo,
                                       Connection con) throws SQLException {
        String sql =
            "SELECT COUNT(*) FROM TB_SEAT " +
            "WHERE FLIGHT_ID = ? AND SEAT_NO = ?";

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
    public void insertSeats(List<String> seats,
                            int bookingId,
                            int flightId,
                            Connection con) throws SQLException {
        String sql =
            "INSERT INTO TB_SEAT (SEAT_ID, BOOKING_ID, FLIGHT_ID, SEAT_NO) " +
            "VALUES (SEQ_SEAT.NEXTVAL, ?, ?, ?)";

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
    public void insertBaggage(BaggageDTO dto,
                              int bookingId,
                              Connection con) throws SQLException {
        String sql =
            "INSERT INTO TB_BAGGAGE ( " +
            "BAGGAGE_ID, BOOKING_ID, FLIGHT_ID, EXTRA_BAGGAGE, BAGGAGE_PRICE " +
            ") VALUES (SEQ_BAGGAGE.NEXTVAL, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, bookingId);
            pstmt.setInt(2, dto.getFlightId());
            pstmt.setInt(3, dto.getExtraBaggage());
            pstmt.setInt(4, dto.getBaggagePrice());

            pstmt.executeUpdate();
        }
    }

    // 6. 잔여 좌석 감소
    public int updateRemainSeat(int flightId,
                                int passengerCount,
                                Connection con) throws SQLException {
        String sql =
            "UPDATE TB_FLIGHT " +
            "SET REMAIN_SEAT = REMAIN_SEAT - ? " +
            "WHERE FLIGHT_ID = ?";

        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, passengerCount);
            pstmt.setInt(2, flightId);

            return pstmt.executeUpdate();
        }
    }
}