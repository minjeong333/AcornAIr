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

	public FlightDTO getById(int flightId) {
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		FlightDTO dto = null;

		String sql = "SELECT Y.FLIGHT_ID, Y.FLIGHT_NO, " + "Y.DEP_AIRPORT, Y.ARR_AIRPORT, "
				+ "A1.AIRPORT_NAME AS DEP_NAME, A2.AIRPORT_NAME AS ARR_NAME, " + "Y.DEP_TIME, Y.ARR_TIME, "
				+ "Y.PRICE AS Y_PRICE, C.PRICE AS C_PRICE, " + "Y.FUEL_SURCHARGE, Y.TAX_PRICE " + "FROM TB_FLIGHT Y "
				+ "JOIN TB_FLIGHT C ON Y.FLIGHT_NO = C.FLIGHT_NO "
				+ "AND Y.DEP_TIME = C.DEP_TIME AND C.SEAT_CLASS = 'C' "
				+ "JOIN TB_AIRPORT A1 ON Y.DEP_AIRPORT = A1.AIRPORT_CODE "
				+ "JOIN TB_AIRPORT A2 ON Y.ARR_AIRPORT = A2.AIRPORT_CODE " + "WHERE Y.FLIGHT_ID = ?";

		try {
			con = dbcon();
			pst = con.prepareStatement(sql);
			pst.setInt(1, flightId);
			rs = pst.executeQuery();

			if (rs.next()) {
				dto = new FlightDTO();
				dto.setFlightId(rs.getInt(1));
				dto.setFlightNo(rs.getString(2));
				dto.setDepAirport(rs.getString(3));
				dto.setArrAirport(rs.getString(4));
				dto.setDepAirportName(rs.getString(5));
				dto.setArrAirportName(rs.getString(6));
				dto.setDepTime(rs.getDate(7));
				dto.setArrTime(rs.getDate(8));
				dto.setPrice(rs.getInt(9));
				dto.setBizPrice(rs.getInt(10));
				dto.setFuelSurcharge(rs.getInt(11));
				dto.setTaxPrice(rs.getInt(12));
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
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return dto;
	}

	public ArrayList<FlightDTO> search(String depAirport, String arrAirport, String depDate, int passCnt) {

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		ArrayList<FlightDTO> list = new ArrayList<>();

		System.out.println("=== FlightDAO search 실행됨 ===");
		System.out.println(depAirport + " -> " + arrAirport + " / " + depDate);
		String sql = "SELECT Y.FLIGHT_ID, NVL(C.FLIGHT_ID, 0) AS C_FLIGHT_ID, Y.FLIGHT_NO, "
				+ "Y.DEP_AIRPORT, Y.ARR_AIRPORT, " + "A1.AIRPORT_NAME AS DEP_NAME, " + "A2.AIRPORT_NAME AS ARR_NAME, "
				+ "Y.DEP_TIME, Y.ARR_TIME, " + "Y.PRICE AS Y_PRICE, " + "NVL(C.PRICE, 0) AS C_PRICE, "
				+ "Y.FUEL_SURCHARGE, Y.TAX_PRICE " + "FROM TB_FLIGHT Y " + "LEFT JOIN TB_FLIGHT C "
				+ "ON C.SEAT_CLASS = 'C' " + "AND Y.FLIGHT_NO = C.FLIGHT_NO " + "AND Y.DEP_AIRPORT = C.DEP_AIRPORT "
				+ "AND Y.ARR_AIRPORT = C.ARR_AIRPORT " + "AND Y.DEP_TIME = C.DEP_TIME "
				+ "JOIN TB_AIRPORT A1 ON Y.DEP_AIRPORT = A1.AIRPORT_CODE "
				+ "JOIN TB_AIRPORT A2 ON Y.ARR_AIRPORT = A2.AIRPORT_CODE " + "WHERE Y.SEAT_CLASS = 'Y' "
				+ "AND Y.DEP_AIRPORT = ? " + "AND Y.ARR_AIRPORT = ? "
				+ "AND TRUNC(Y.DEP_TIME) = TO_DATE(?, 'YYYY-MM-DD') " + "AND Y.REMAIN_SEAT >= ? "
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
				dto.setBizFlightId(rs.getInt(2));
				dto.setFlightNo(rs.getString(3));
				dto.setDepAirport(rs.getString(4));
				dto.setArrAirport(rs.getString(5));
				dto.setDepAirportName(rs.getString(6));
				dto.setArrAirportName(rs.getString(7));
				dto.setDepTime(rs.getDate(8));
				dto.setArrTime(rs.getDate(9));
				dto.setPrice(rs.getInt(10));
				dto.setBizPrice(rs.getInt(11));
				dto.setFuelSurcharge(rs.getInt(12));
				dto.setTaxPrice(rs.getInt(13));
				
				list.add(dto);
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
				if (pst != null)
					pst.close();
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

	// 관리자 항공편 전체 조회
	public ArrayList<FlightDTO> getAllFlights() {
		ArrayList<FlightDTO> list = new ArrayList<>();

		String sql = "SELECT FLIGHT_ID, FLIGHT_NO, DEP_AIRPORT, ARR_AIRPORT, "
				+ "DEP_TIME, ARR_TIME, SEAT_CLASS, PRICE, TOTAL_SEAT, REMAIN_SEAT, "
				+ "FUEL_SURCHARGE, TAX_PRICE " + "FROM TB_FLIGHT "
				+ "ORDER BY DEP_TIME DESC";

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		try {
			con = dbcon();
			pst = con.prepareStatement(sql);
			rs = pst.executeQuery();

			while (rs.next()) {
				FlightDTO dto = new FlightDTO();

				dto.setFlightId(rs.getInt("FLIGHT_ID"));
				dto.setFlightNo(rs.getString("FLIGHT_NO"));
				dto.setDepAirport(rs.getString("DEP_AIRPORT"));
				dto.setArrAirport(rs.getString("ARR_AIRPORT"));
				dto.setDepTime(rs.getDate("DEP_TIME"));
				dto.setArrTime(rs.getDate("ARR_TIME"));
				dto.setSeatClass(rs.getString("SEAT_CLASS"));
				dto.setPrice(rs.getInt("PRICE"));
				dto.setTotalSeat(rs.getInt("TOTAL_SEAT"));
				dto.setRemainSeat(rs.getInt("REMAIN_SEAT"));
				dto.setFuelSurcharge(rs.getInt("FUEL_SURCHARGE"));
				dto.setTaxPrice(rs.getInt("TAX_PRICE"));

				list.add(dto);
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
				if (pst != null)
					pst.close();
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

	// 관리자 항공편 삭제
	public int deleteFlight(int flightId) {
		String sql = "DELETE FROM TB_FLIGHT WHERE FLIGHT_ID = ?";

		Connection con = null;
		PreparedStatement pst = null;
		int result = 0;

		try {
			con = dbcon();
			pst = con.prepareStatement(sql);
			pst.setInt(1, flightId);

			result = pst.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pst != null)
					pst.close();
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

	// 관리자 항공편 추가
	public int insertFlight(FlightDTO flight) {

		String sql = "INSERT INTO TB_FLIGHT " + "(FLIGHT_ID, FLIGHT_NO, DEP_AIRPORT, ARR_AIRPORT, "
				+ "DEP_TIME, ARR_TIME, SEAT_CLASS, PRICE, TOTAL_SEAT, REMAIN_SEAT, "
				+ "FUEL_SURCHARGE, TAX_PRICE) "
				+ "VALUES (SEQ_FLIGHT.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		Connection con = null;
		PreparedStatement pst = null;
		int result = 0;

		try {
			con = dbcon();

			pst = con.prepareStatement(sql);

			pst.setString(1, flight.getFlightNo());
			pst.setString(2, flight.getDepAirport());
			pst.setString(3, flight.getArrAirport());

			pst.setTimestamp(4, new java.sql.Timestamp(flight.getDepTime().getTime()));

			pst.setTimestamp(5, new java.sql.Timestamp(flight.getArrTime().getTime()));

			pst.setString(6, flight.getSeatClass());
			pst.setInt(7, flight.getPrice());
			pst.setInt(8, flight.getTotalSeat());
			pst.setInt(9, flight.getRemainSeat());
			pst.setInt(10, flight.getFuelSurcharge());
			pst.setInt(11, flight.getTaxPrice());
			
			result = pst.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pst != null)
					pst.close();
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

	public int getRoundTripLowestPrice(String arrAirport) {

		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;

		int price = 0;

		String sql = """
				    SELECT MIN(GO.PRICE + BACK.PRICE) AS ROUND_PRICE
				    FROM TB_FLIGHT GO
				    JOIN TB_FLIGHT BACK
				    ON GO.DEP_AIRPORT = BACK.ARR_AIRPORT
				    AND GO.ARR_AIRPORT = BACK.DEP_AIRPORT
				    WHERE GO.DEP_AIRPORT = 'ICN'
				    AND GO.ARR_AIRPORT = ?
				    AND GO.SEAT_CLASS = 'Y'
				    AND BACK.SEAT_CLASS = 'Y'
				""";

		try {
			con = dbcon();
			pst = con.prepareStatement(sql);
			pst.setString(1, arrAirport);

			rs = pst.executeQuery();

			if (rs.next()) {
				price = rs.getInt("ROUND_PRICE");
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
				if (pst != null)
					pst.close();
			} catch (Exception e) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception e) {
			}
		}

		return price;
	}

}