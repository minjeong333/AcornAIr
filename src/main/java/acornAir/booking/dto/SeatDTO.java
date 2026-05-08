package acornAir.booking.dto;

public class SeatDTO {

    private int    seatId;
    private int    bookingId;
    private int    flightId;
    private String seatNo;

    public int getSeatId() {
        return seatId;
    }
    public void setSeatId(int seatId) {
        this.seatId = seatId;
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
    public String getSeatNo() {
        return seatNo;
    }
    public void setSeatNo(String seatNo) {
        this.seatNo = seatNo;
    }
    public SeatDTO() {
    }
    public SeatDTO(int seatId, int bookingId, int flightId, String seatNo) {
        this.seatId = seatId;
        this.bookingId = bookingId;
        this.flightId = flightId;
        this.seatNo = seatNo;
    }
    @Override
    public String toString() {
        return "SeatDTO [seatId=" + seatId + ", bookingId=" + bookingId
                + ", flightId=" + flightId + ", seatNo=" + seatNo + "]";
    }
}
