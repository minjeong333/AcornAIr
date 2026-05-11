package acornAir.reservation.dto;

public class ReservationDTO {

	private int bookingId;

	private String userName;

	private String goDep;
	private String goArr;
	private String goDate;

	private String backDep;
	private String backArr;
	private String backDate;

	private int passengerCount;

	private String goSeatClass;
	private String backSeatClass;
	private String goSeatNo;
	private String backSeatNo;

	private int baggageKg;

	private int totalPrice;

	private String bookStatus;

	private String backFlightId;
	


	public String getBackFlightId() {
	    return backFlightId;
	}

	public void setBackFlightId(String backFlightId) {
	    this.backFlightId = backFlightId;
	}
	// getter setter

	public String getBookStatus() {
		return bookStatus;
	}

	public void setBookStatus(String bookStatus) {
		this.bookStatus = bookStatus;
	}

	public int getBookingId() {
		return bookingId;
	}

	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGoDep() {
		return goDep;
	}

	public void setGoDep(String goDep) {
		this.goDep = goDep;
	}

	public String getGoArr() {
		return goArr;
	}

	public void setGoArr(String goArr) {
		this.goArr = goArr;
	}

	public String getGoDate() {
		return goDate;
	}

	public void setGoDate(String goDate) {
		this.goDate = goDate;
	}

	public String getBackDep() {
		return backDep;
	}

	public void setBackDep(String backDep) {
		this.backDep = backDep;
	}

	public String getBackArr() {
		return backArr;
	}

	public void setBackArr(String backArr) {
		this.backArr = backArr;
	}

	public String getBackDate() {
		return backDate;
	}

	public void setBackDate(String backDate) {
		this.backDate = backDate;
	}

	public int getPassengerCount() {
		return passengerCount;
	}

	public void setPassengerCount(int passengerCount) {
		this.passengerCount = passengerCount;
	}

	public int getBaggageKg() {
		return baggageKg;
	}

	public void setBaggageKg(int baggageKg) {
		this.baggageKg = baggageKg;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getBackSeatNo() {
		return backSeatNo;
	}

	public void setBackSeatNo(String backSeatNo) {
		this.backSeatNo = backSeatNo;
	}

	public String getBackSeatClass() {
		return backSeatClass;
	}

	public void setBackSeatClass(String backSeatClass) {
		this.backSeatClass = backSeatClass;
	}

	public String getGoSeatClass() {
		return goSeatClass;
	}

	public void setGoSeatClass(String goSeatClass) {
		this.goSeatClass = goSeatClass;
	}

	public String getGoSeatNo() {
		return goSeatNo;
	}

	public void setGoSeatNo(String goSeatNo) {
		this.goSeatNo = goSeatNo;
	}
}