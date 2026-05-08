package acornAir.booking.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import acornAir.booking.dto.PassengerDTO;
import acornAir.util.DBUtil;

public class PassangerDAO {

	DBUtil db = new DBUtil();
	Connection con = db.dbcon();

	//승객정보 삽입 매서드 
	public int insert(PassengerDTO passenger) {

		Connection con = db.dbcon();
		PreparedStatement pst = null;

		String sql = "insert into TB_PASSENGER(PASSENGER_ID, BOOKING_ID, ENG_LAST_NAME, ENG_FIRST_NAME, GENDER, BIRTH_DATE) values (SEQ_PASSENGER.NEXTVAL,?,?,?,?,?)";
		ArrayList<PassengerDTO> list = new ArrayList<>();

		try {
			pst = con.prepareStatement(sql);

			pst.setInt(1, passenger.getBookingId());
			pst.setString(2, passenger.getEngLastName());
			pst.setString(3, passenger.getEngFirstName());
			pst.setString(4, passenger.getGender());
			pst.setDate(5, new java.sql.Date(passenger.getBirthDate().getTime()));

			return pst.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	//승객 조회 매서드
	public List<PassengerDTO> selectByBookingId(int bookingId) {

		Connection con = db.dbcon();
		PreparedStatement pst = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM TB_PASSENGER WHERE BOOKING_ID = ?";
		ArrayList<PassengerDTO> list = new ArrayList<>();

		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, bookingId);
			rs = pst.executeQuery();

			while (rs.next()) {

				PassengerDTO p = new PassengerDTO();

				p.setPassengerId(rs.getInt(1));
				p.setBookingId(rs.getInt(2));
				p.setEngLastName(rs.getString(3));
				p.setEngFirstName(rs.getString(4));
				p.setGender(rs.getString(5));
				p.setBirthDate(rs.getDate(6));
				list.add(p);
			}

		} catch (

		SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public static void main(String[] args) {

		// db연결 확인용
//		DBUtil db = new DBUtil();
//		Connection con = db.dbcon();
//		System.out.println(con);

		// insert문 확인용
//		PassangerDAO dao = new PassangerDAO();
//
//		PassengerDTO p = new PassengerDTO();
//		p.setBookingId(1);
//		p.setEngLastName("PARK");
//		p.setEngFirstName("TEST");
//		p.setGender("M");
//		p.setBirthDate(new java.util.Date());
//
//		int result = dao.insert(p);
//		System.out.println("삽입된 행 수: " + result);
		
		//select문 확인용
		PassangerDAO dao = new PassangerDAO();
		
		List<PassengerDTO> list = dao.selectByBookingId(1);

		for (PassengerDTO p : list) {
		    System.out.println(p);
		}
	}
}
