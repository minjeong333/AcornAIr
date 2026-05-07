package acornAir.booking.dto;

public class BaggageDTO {

    private int baggageId;
    private int bookingId;
    private int flightId;
    private int extraBaggage; // 추가 수하물 개수 (23kg 단위)
    private int baggagePrice; // 수하물 추가 금액

	public int getBaggageId() {
		return baggageId;
	}
	public void setBaggageId(int baggageId) {
		this.baggageId = baggageId;
	}
	public int getBookingId() {
		return bookingId;
	}
	public void setBookingId(int bookingId) {
		this.bookingId = bookingId;
	}
	public int getFlightId() {
		return flightId;
	}
	public void setFlightId(int flightId) {
		this.flightId = flightId;
	}
	public int getExtraBaggage() {
		return extraBaggage;
	}
	public void setExtraBaggage(int extraBaggage) {
		this.extraBaggage = extraBaggage;
	}
	public int getBaggagePrice() {
		return baggagePrice;
	}
	public void setBaggagePrice(int baggagePrice) {
		this.baggagePrice = baggagePrice;
	}
	public BaggageDTO() {
		
	}
	public BaggageDTO(int baggageId, int bookingId, int flightId, int extraBaggage, int baggagePrice) {
		super();
		this.baggageId = baggageId;
		this.bookingId = bookingId;
		this.flightId = flightId;
		this.extraBaggage = extraBaggage;
		this.baggagePrice = baggagePrice;
	}
	@Override
	public String toString() {
		return "BaggageDTO [baggageId=" + baggageId + ", bookingId=" + bookingId + ", flightId=" + flightId
				+ ", extraBaggage=" + extraBaggage + ", baggagePrice=" + baggagePrice + "]";
	}

   
}
