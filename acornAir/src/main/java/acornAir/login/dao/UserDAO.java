package acornAir.login.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import acornAir.login.dto.UserDTO;
import acornAir.util.DBUtil;

public class UserDAO {

    DBUtil db = new DBUtil();

    public int insertUser(UserDTO user, String userPw) {
        String sql = "INSERT INTO TB_USER "
                + "(USER_ID, USER_PW, ENG_FIRST_NAME, ENG_LAST_NAME, "
                + " KOR_FIRST_NAME, KOR_LAST_NAME, BIRTH_DATE, GENDER, "
                + " PHONE_COUNTRY, USER_PHONE, USER_EMAIL, COUNTRY, REG_DATE) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";

        Connection con = null;
        PreparedStatement pst = null;
        int result = 0;

        try {
            con = db.dbcon();
            pst = con.prepareStatement(sql);

            pst.setString(1, user.getUserId());
            pst.setString(2, userPw);
            pst.setString(3, user.getEngFirstName());
            pst.setString(4, user.getEngLastName());
            pst.setString(5, user.getKorFirstName());
            pst.setString(6, user.getKorLastName());

            if (user.getBirthDate() != null) {
                pst.setDate(7, new java.sql.Date(user.getBirthDate().getTime()));
            } else {
                pst.setNull(7, java.sql.Types.DATE);
            }

            pst.setString(8, user.getGender());
            pst.setString(9, user.getPhoneCountry());
            pst.setString(10, user.getUserPhone());
            pst.setString(11, user.getUserEmail());
            pst.setString(12, user.getCountry());

            result = pst.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return result;
    }

    public UserDTO login(String userId, String userPw) {
        String sql = "SELECT USER_ID, ENG_LAST_NAME, ENG_FIRST_NAME, "
                + "KOR_LAST_NAME, KOR_FIRST_NAME, USER_EMAIL, "
                + "PHONE_COUNTRY, USER_PHONE, BIRTH_DATE, GENDER, COUNTRY "
                + "FROM TB_USER "
                + "WHERE USER_ID = ? AND USER_PW = ?";

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        UserDTO user = null;

        try {
            con = db.dbcon();
            pst = con.prepareStatement(sql);
            pst.setString(1, userId);
            pst.setString(2, userPw);
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new UserDTO();
                user.setUserId(rs.getString(1));
                user.setEngLastName(rs.getString(2));
                user.setEngFirstName(rs.getString(3));
                user.setKorLastName(rs.getString(4));
                user.setKorFirstName(rs.getString(5));
                user.setUserEmail(rs.getString(6));
                user.setPhoneCountry(rs.getString(7));
                user.setUserPhone(rs.getString(8));
                user.setBirthDate(rs.getDate(9));
                user.setGender(rs.getString(10));
                user.setCountry(rs.getString(11));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs  != null) rs.close();  } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return user;
    }

    public int checkId(String userId) {
        String sql = "SELECT COUNT(*) FROM TB_USER WHERE USER_ID = ?";

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        int count = 0;

        try {
            con = db.dbcon();
            pst = con.prepareStatement(sql);
            pst.setString(1, userId);
            rs = pst.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs  != null) rs.close();  } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return count;
    }
    
    //mypage getUserById 추가
    
    public UserDTO getUserById(String userId) {
        
    	// 1. SQL 수정: login 활용
        String sql = "SELECT USER_ID, ENG_LAST_NAME, ENG_FIRST_NAME, "
                + "KOR_LAST_NAME, KOR_FIRST_NAME, USER_EMAIL, "
                + "PHONE_COUNTRY, USER_PHONE, BIRTH_DATE, GENDER, COUNTRY "
                + "FROM TB_USER "
                + "WHERE USER_ID = ?"; // ID만으로 조회

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        UserDTO user = null;

        try {
            con = db.dbcon();
            pst = con.prepareStatement(sql);
            pst.setString(1, userId); // 파라미터도 ID 하나만 설정
            rs = pst.executeQuery();

            if (rs.next()) {
                user = new UserDTO();
                // 기존 login 메서드의 Mapping 로직 그대로 사용
                user.setUserId(rs.getString(1));
                user.setEngLastName(rs.getString(2));
                user.setEngFirstName(rs.getString(3));
                user.setKorLastName(rs.getString(4));
                user.setKorFirstName(rs.getString(5));
                user.setUserEmail(rs.getString(6));
                user.setPhoneCountry(rs.getString(7));
                user.setUserPhone(rs.getString(8));
                user.setBirthDate(rs.getDate(9));
                user.setGender(rs.getString(10));
                user.setCountry(rs.getString(11));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 해제 로직 (login 메서드와 동일)
            try { if (rs  != null) rs.close();  } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return user;
    }
    
}
