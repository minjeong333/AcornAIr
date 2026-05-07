package acornAir.flight.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import acornAir.flight.dto.FlightDTO;

public class FlightDAO {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:testdb";
	String user = "scott";
	String password = "tiger";

	// lib -> ojdbc8.jar enrl
	public Connection dbcon() {
		Connection con = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}

	public ArrayList<FlightDTO> search(String depAirport, String arrAirport, String depDate, int passCnt) {

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		ArrayList<FlightDTO> list = new ArrayList<>();

		String sql = "SELECT Y.FLIGHT_ID, Y.FLIGHT_NO,\r\n" + "       Y.DEP_AIRPORT, Y.ARR_AIRPORT,\r\n"
				+ "       A1.AIRPORT_NAME AS DEP_NAME,\r\n" + "       A2.AIRPORT_NAME AS ARR_NAME,\r\n"
				+ "       Y.DEP_TIME, Y.ARR_TIME,\r\n" + "       Y.PRICE AS Y_PRICE,\r\n"
				+ "       C.PRICE AS C_PRICE\r\n" + "FROM TB_FLIGHT Y\r\n" + "JOIN TB_FLIGHT C\r\n"
				+ "  ON Y.FLIGHT_NO = C.FLIGHT_NO\r\n" + "  AND Y.DEP_TIME = C.DEP_TIME\r\n"
				+ "  AND C.SEAT_CLASS = 'C'\r\n" + "JOIN TB_AIRPORT A1 ON Y.DEP_AIRPORT = A1.AIRPORT_CODE\r\n"
				+ "JOIN TB_AIRPORT A2 ON Y.ARR_AIRPORT = A2.AIRPORT_CODE\r\n" + "WHERE Y.SEAT_CLASS = 'Y'\r\n"
				+ "  AND Y.DEP_AIRPORT = ?\r\n" + "  AND Y.ARR_AIRPORT = ?\r\n"
				+ "  AND TRUNC(Y.DEP_TIME) = TO_DATE(?, 'YYYY-MM-DD')\r\n" + "  AND Y.REMAIN_SEAT >= ?\r\n"
				+ "ORDER BY Y.DEP_TIME ASC";

		try {

			con = dbcon();
			pst = con.prepareStatement(sql);

			pst.setString(1, depAirport);
			pst.setString(2, arrAirport);
			pst.setString(3, depDate);
			pst.setInt(4, passCnt);

			rs = pst.executeQuery();

			while (rs.next()) {

			    FlightDTO dto = new FlightDTO();

			    dto.setFlightId(rs.getInt(1));
			    dto.setFlightNo(rs.getString(2));

			    dto.setDepAirport(rs.getString(3));
			    dto.setArrAirport(rs.getString(4));

			    dto.setDepAirportName(rs.getString(5));
			    dto.setArrAirportName(rs.getString(6));

			    dto.setDepTime(rs.getDate(7));
			    dto.setArrTime(rs.getDate(8));

			    dto.setPrice(rs.getInt(9));      // 일반석 가격
			    dto.setBizPrice(rs.getInt(10));  // 비즈니스 가격

			    list.add(dto);
			}

		} catch (Exception e) {

			e.printStackTrace();

		} finally {

			try {
				if (rs != null)
					rs.close();
				if (pst != null)
					pst.close();
				if (con != null)
					con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return list;
	}

}
