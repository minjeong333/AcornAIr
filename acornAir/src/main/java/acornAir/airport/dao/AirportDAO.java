package acornAir.airport.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import acornAir.airport.dto.AirportDTO;
import acornAir.util.DBUtil;

public class AirportDAO {

    public List<AirportDTO> selectAllAirports() {
        List<AirportDTO> list = new ArrayList<>();

        String sql = """
            SELECT AIRPORT_CODE, AIRPORT_NAME, CITY_NAME, COUNTRY
            FROM TB_AIRPORT
            ORDER BY COUNTRY, CITY_NAME
        """;

        try (
            Connection con = new DBUtil().dbcon();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                AirportDTO dto = new AirportDTO();
                dto.setAirportCode(rs.getString("AIRPORT_CODE"));
                dto.setAirportName(rs.getString("AIRPORT_NAME"));
                dto.setCityName(rs.getString("CITY_NAME"));
                dto.setCountry(rs.getString("COUNTRY"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}