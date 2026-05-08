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

	private String seatClass;
	private String seatNo;

	private int baggageKg;

	private int totalPrice;

	private String bookStatus;

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

	public String getSeatClass() {
		return seatClass;
	}

	public void setSeatClass(String seatClass) {
		this.seatClass = seatClass;
	}

	public String getSeatNo() {
		return seatNo;
	}

	public void setSeatNo(String seatNo) {
		this.seatNo = seatNo;
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
}