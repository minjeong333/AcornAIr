package acornAir.booking.dto;

import java.util.Date;
import java.util.List;

import acornAir.flight.dto.FlightDTO;

public class BookingDTO {
	
    private int    bookingId;    // BOOKING_ID (PK)
    private String userId;       // USER_ID (FK)

    // 항공편 정보
    private FlightDTO goFlight;   // 가는편
    private FlightDTO backFlight; // 오는편 (편도면 null)
    private String    tripType;   // OW / RT

    // 승객
    private List<PassengerDTO> passengers;

    // 좌석
    private List<String> goSeats;   // 가는편 선택 좌석 (25B, 25E)
    private List<String> backSeats; // 오는편 선택 좌석

    // 수하물
    private List<BaggageDTO> baggages;

    // 금액
    private int basePrice;    // 항공권 운임 고정 합계 
    private int baggagePrice; // 초과수화물 금액
    private int totalPrice;   // 최종 결제 금액 = basePrice + baggagePrice

    // 연락처
    private String contactPhone;
    private String phoneCountry;

    // 결제
    private String payMethod;  // CARD / TRANSFER / SIMPLE
    private String bookStatus; // Y / N
    private java.util.Date bookDate; // 예약일시
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public FlightDTO getGoFlight() {
		return goFlight;
	}
	public void setGoFlight(FlightDTO goFlight) {
		this.goFlight = goFlight;
	}
	public FlightDTO getBackFlight() {
		return backFlight;
	}
	public void setBackFlight(FlightDTO backFlight) {
		this.backFlight = backFlight;
	}
	public String getTripType() {
		return tripType;
	}
	public void setTripType(String tripType) {
		this.tripType = tripType;
	}
	public List<PassengerDTO> getPassengers() {
		return passengers;
	}
	public void setPassengers(List<PassengerDTO> passengers) {
		this.passengers = passengers;
	}
	public List<String> getGoSeats() {
		return goSeats;
	}
	public void setGoSeats(List<String> goSeats) {
		this.goSeats = goSeats;
	}
	public List<String> getBackSeats() {
		return backSeats;
	}
	public void setBackSeats(List<String> backSeats) {
		this.backSeats = backSeats;
	}
	public List<BaggageDTO> getBaggages() {
		return baggages;
	}
	public void setBaggages(List<BaggageDTO> baggages) {
		this.baggages = baggages;
	}
	public int getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(int basePrice) {
		this.basePrice = basePrice;
	}
	public int getBaggagePrice() {
		return baggagePrice;
	}
	public void setBaggagePrice(int baggagePrice) {
		this.baggagePrice = baggagePrice;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getContactPhone() {
		return contactPhone;
	}
	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}
	public String getPhoneCountry() {
		return phoneCountry;
	}
	public void setPhoneCountry(String phoneCountry) {
		this.phoneCountry = phoneCountry;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getBookStatus() {
		return bookStatus;
	}
	public void setBookStatus(String bookStatus) {
		this.bookStatus = bookStatus;
	}
	public java.util.Date getBookDate() {
		return bookDate;
	}
	public void setBookDate(java.util.Date bookDate) {
		this.bookDate = bookDate;
	}
	public BookingDTO() {
		
	}
	
	public BookingDTO(int bookingId, String userId, FlightDTO goFlight, FlightDTO backFlight, String tripType,
			List<PassengerDTO> passengers, List<String> goSeats, List<String> backSeats, List<BaggageDTO> baggages,
			int basePrice, int baggagePrice, int totalPrice, String payMethod, String bookStatus, Date bookDate) {
		super();
		this.bookingId = bookingId;
		this.userId = userId;
		this.goFlight = goFlight;
		this.backFlight = backFlight;
		this.tripType = tripType;
		this.passengers = passengers;
		this.goSeats = goSeats;
		this.backSeats = backSeats;
		this.baggages = baggages;
		this.basePrice = basePrice;
		this.baggagePrice = baggagePrice;
		this.totalPrice = totalPrice;
		this.payMethod = payMethod;
		this.bookStatus = bookStatus;
		this.bookDate = bookDate;
	}
	@Override
	public String toString() {
		return "BookingDTO [bookingId=" + bookingId + ", userId=" + userId + ", goFlight=" + goFlight + ", backFlight="
				+ backFlight + ", tripType=" + tripType + ", basePrice=" + basePrice + ", baggagePrice=" + baggagePrice
				+ ", totalPrice=" + totalPrice + ", payMethod=" + payMethod + ", bookStatus=" + bookStatus
				+ ", bookDate=" + bookDate + "]";
	}
    
    
}
