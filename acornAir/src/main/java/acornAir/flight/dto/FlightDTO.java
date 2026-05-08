package acornAir.flight.dto;

import java.util.Date;

public class FlightDTO {
	
	private int    flightId;       // FLIGHT_ID
    private String flightNo;       // 편명 (KE741)
    private String depAirport;     // 출발 공항 코드 (ICN)
    private String arrAirport;     // 도착 공항 코드 (NGO)
    private String depAirportName; // 출발 공항명 (서울/인천)
    private String arrAirportName; // 도착 공항명 (나고야)
    private java.util.Date depTime; // 출발 일시
    private java.util.Date arrTime; // 도착 일시
    private String seatClass;       // 좌석 등급 (Y/C)
    private int    price;           // 기본 운임
    private int bizPrice;    // 비즈니스석 가격 (C)  ← 추가
    private int    remainSeat;      // 잔여 좌석
    
    
	public int getFlightId() {
		return flightId;
	}
	public void setFlightId(int flightId) {
		this.flightId = flightId;
	}
	public String getFlightNo() {
		return flightNo;
	}
	public void setFlightNo(String flightNo) {
		this.flightNo = flightNo;
	}
	public String getDepAirport() {
		return depAirport;
	}
	public void setDepAirport(String depAirport) {
		this.depAirport = depAirport;
	}
	public String getArrAirport() {
		return arrAirport;
	}
	public void setArrAirport(String arrAirport) {
		this.arrAirport = arrAirport;
	}
	public String getDepAirportName() {
		return depAirportName;
	}
	public void setDepAirportName(String depAirportName) {
		this.depAirportName = depAirportName;
	}
	public String getArrAirportName() {
		return arrAirportName;
	}
	public void setArrAirportName(String arrAirportName) {
		this.arrAirportName = arrAirportName;
	}
	public java.util.Date getDepTime() {
		return depTime;
	}
	public void setDepTime(java.util.Date depTime) {
		this.depTime = depTime;
	}
	public java.util.Date getArrTime() {
		return arrTime;
	}
	public void setArrTime(java.util.Date arrTime) {
		this.arrTime = arrTime;
	}
	public String getSeatClass() {
		return seatClass;
	}
	public void setSeatClass(String seatClass) {
		this.seatClass = seatClass;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
		
	}
	public int getBizPrice() {
		return bizPrice;
	}
	public void setBizPrice(int bizPrice) {
		this.bizPrice = bizPrice;
	}
	public int getRemainSeat() {
		return remainSeat;
	}
	public void setRemainSeat(int remainSeat) {
		this.remainSeat = remainSeat;
	}
	public FlightDTO() {
		
	}

	public FlightDTO(int flightId, String flightNo, String depAirport, String arrAirport, String depAirportName,
			String arrAirportName, Date depTime, Date arrTime, String seatClass, int price, int bizPrice,
			int remainSeat) {
		super();
		this.flightId = flightId;
		this.flightNo = flightNo;
		this.depAirport = depAirport;
		this.arrAirport = arrAirport;
		this.depAirportName = depAirportName;
		this.arrAirportName = arrAirportName;
		this.depTime = depTime;
		this.arrTime = arrTime;
		this.seatClass = seatClass;
		this.price = price;
		this.bizPrice = bizPrice;
		this.remainSeat = remainSeat;
	}
	@Override
	public String toString() {
		return "FlightDTO [flightId=" + flightId + ", flightNo=" + flightNo + ", depAirport=" + depAirport
				+ ", arrAirport=" + arrAirport + ", depAirportName=" + depAirportName + ", arrAirportName="
				+ arrAirportName + ", depTime=" + depTime + ", arrTime=" + arrTime + ", seatClass=" + seatClass
				+ ", price=" + price + ", bizPrice=" + bizPrice + ", remainSeat=" + remainSeat + "]";
	}
	

   
}
