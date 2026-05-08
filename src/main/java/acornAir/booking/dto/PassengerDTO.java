package acornAir.booking.dto;

import java.util.Date;

public class PassengerDTO {
    private int    passengerId;
    private int    bookingId;
    private String engLastName;
    private String engFirstName;
    private String gender;
    private java.util.Date birthDate;
	public int getPassengerId() {
		return passengerId;
	}
	public void setPassengerId(int passengerId) {
		this.passengerId = passengerId;
	}
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public String getEngLastName() {
		return engLastName;
	}
	public void setEngLastName(String engLastName) {
		this.engLastName = engLastName;
	}
	public String getEngFirstName() {
		return engFirstName;
	}
	public void setEngFirstName(String engFirstName) {
		this.engFirstName = engFirstName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public java.util.Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(java.util.Date birthDate) {
		this.birthDate = birthDate;
	}
	public PassengerDTO() {
		
	}
	public PassengerDTO(int passengerId, int bookingId, String engLastName, String engFirstName, String gender, Date birthDate) {
		super();
		this.passengerId = passengerId;
		this.bookingId = bookingId;
		this.engLastName = engLastName;
		this.engFirstName = engFirstName;
		this.gender = gender;
		this.birthDate = birthDate;
	}
	@Override
	public String toString() {
		return "PassengerDTO [passengerId=" + passengerId + ", bookingId=" + bookingId + ", engLastName=" + engLastName
				+ ", engFirstName=" + engFirstName + ", gender=" + gender + ", birthDate=" + birthDate + "]";
	}

    
}