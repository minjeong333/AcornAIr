package 예약;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReservationDAO {

    String driver = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@localhost:1521:testdb";
    String user = "scott";
    String password = "tiger";

    public Connection dbcon() {
        Connection con = null;

        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return con;
    }

    public ArrayList<ReservationDTO> selectReservationList(String userId) {

        ArrayList<ReservationDTO> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = dbcon();

            String sql = """
                SELECT
                    B.BOOKING_ID,
                    B.BOOK_STATUS,
                    U.KOR_LAST_NAME || U.KOR_FIRST_NAME AS USER_NAME,

                    GF.DEP_AIRPORT AS GO_DEP,
                    GF.ARR_AIRPORT AS GO_ARR,
                    TO_CHAR(GF.DEP_TIME, 'YYYY-MM-DD HH24:MI') AS GO_DATE,

                    BF.DEP_AIRPORT AS BACK_DEP,
                    BF.ARR_AIRPORT AS BACK_ARR,
                    TO_CHAR(BF.DEP_TIME, 'YYYY-MM-DD HH24:MI') AS BACK_DATE,

                    COUNT(P.PASSENGER_ID) AS PASSENGER_COUNT,

                    CASE
                        WHEN GF.SEAT_CLASS = 'Y' THEN '일반석'
                        WHEN GF.SEAT_CLASS = 'C' THEN '비즈니스석'
                    END AS SEAT_CLASS,

                    B.TOTAL_PRICE,
                    S.SEAT_NO,
                    BG.EXTRA_BAGGAGE

                FROM TB_BOOKING B

                JOIN TB_USER U
                ON B.USER_ID = U.USER_ID

                JOIN TB_FLIGHT GF
                ON B.GO_FLIGHT_ID = GF.FLIGHT_ID

                LEFT JOIN TB_FLIGHT BF
                ON B.BACK_FLIGHT_ID = BF.FLIGHT_ID

                LEFT JOIN TB_SEAT S
                ON B.BOOKING_ID = S.BOOKING_ID

                LEFT JOIN TB_BAGGAGE BG
                ON B.BOOKING_ID = BG.BOOKING_ID

                LEFT JOIN TB_PASSENGER P
                ON B.BOOKING_ID = P.BOOKING_ID

                WHERE B.USER_ID = ?

                GROUP BY
                    B.BOOKING_ID,
                    B.BOOK_STATUS,
                    U.KOR_LAST_NAME,
                    U.KOR_FIRST_NAME,
                    GF.DEP_AIRPORT,
                    GF.ARR_AIRPORT,
                    GF.DEP_TIME,
                    BF.DEP_AIRPORT,
                    BF.ARR_AIRPORT,
                    BF.DEP_TIME,
                    GF.SEAT_CLASS,
                    B.TOTAL_PRICE,
                    S.SEAT_NO,
                    BG.EXTRA_BAGGAGE,
                    B.BOOK_DATE

                ORDER BY B.BOOK_DATE DESC
            """;

            pst = con.prepareStatement(sql);
            pst.setString(1, userId);

            rs = pst.executeQuery();

            while (rs.next()) {
                ReservationDTO dto = new ReservationDTO();

                dto.setBookingId(rs.getInt("BOOKING_ID"));
                dto.setBookStatus(rs.getString("BOOK_STATUS"));
                dto.setUserName(rs.getString("USER_NAME"));

                dto.setGoDep(rs.getString("GO_DEP"));
                dto.setGoArr(rs.getString("GO_ARR"));
                dto.setGoDate(rs.getString("GO_DATE"));

                dto.setBackDep(rs.getString("BACK_DEP"));
                dto.setBackArr(rs.getString("BACK_ARR"));
                dto.setBackDate(rs.getString("BACK_DATE"));

                dto.setPassengerCount(rs.getInt("PASSENGER_COUNT"));
                dto.setSeatClass(rs.getString("SEAT_CLASS"));
                dto.setSeatNo(rs.getString("SEAT_NO"));
                dto.setBaggageKg(rs.getInt("EXTRA_BAGGAGE"));
                dto.setTotalPrice(rs.getInt("TOTAL_PRICE"));

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return list;
    }

    public boolean checkReservation(String bookingId, String depDate, String lastName, String firstName) {

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = dbcon();

            String sql = """
                SELECT COUNT(*)
                FROM TB_BOOKING B

                JOIN TB_USER U
                ON B.USER_ID = U.USER_ID

                JOIN TB_FLIGHT F
                ON B.GO_FLIGHT_ID = F.FLIGHT_ID

                WHERE B.BOOKING_ID = ?
                AND TRUNC(F.DEP_TIME) = TO_DATE(?, 'YYYY-MM-DD')
                AND U.KOR_LAST_NAME = ?
                AND U.KOR_FIRST_NAME = ?
            """;

            pst = con.prepareStatement(sql);

            pst.setInt(1, Integer.parseInt(bookingId));
            pst.setString(2, depDate);
            pst.setString(3, lastName);
            pst.setString(4, firstName);

            rs = pst.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return false;
    }

    public void cancelReservation(int bookingId) {

        Connection con = null;
        PreparedStatement pst1 = null;
        PreparedStatement pst2 = null;
        PreparedStatement pst3 = null;
        PreparedStatement pst4 = null;

        try {
            con = dbcon();
            con.setAutoCommit(false);

            pst1 = con.prepareStatement("DELETE FROM TB_BAGGAGE WHERE BOOKING_ID = ?");
            pst1.setInt(1, bookingId);
            pst1.executeUpdate();

            pst2 = con.prepareStatement("DELETE FROM TB_SEAT WHERE BOOKING_ID = ?");
            pst2.setInt(1, bookingId);
            pst2.executeUpdate();

            pst3 = con.prepareStatement("DELETE FROM TB_PASSENGER WHERE BOOKING_ID = ?");
            pst3.setInt(1, bookingId);
            pst3.executeUpdate();

            pst4 = con.prepareStatement("DELETE FROM TB_BOOKING WHERE BOOKING_ID = ?");
            pst4.setInt(1, bookingId);
            pst4.executeUpdate();

            con.commit();

        } catch (Exception e) {
            e.printStackTrace();

            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        } finally {
            try {
                if (pst1 != null) pst1.close();
                if (pst2 != null) pst2.close();
                if (pst3 != null) pst3.close();
                if (pst4 != null) pst4.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}