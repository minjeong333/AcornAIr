package acornAir.login.dto;

import java.util.Date;

public class UserDTO {				// 이 줄은 테이블 컬럼명
    private String userId;          // USER_ID
    private String userPw;          // USER_PW
    private String korLastName;     // KOR_LAST_NAME
    private String korFirstName;    // KOR_FIRST_NAME
    private String engLastName;     // ENG_LAST_NAME
    private String engFirstName;    // ENG_FIRST_NAME
    private String userEmail;       // USER_EMAIL
    private String phoneCountry;    // PHONE_COUNTRY
    private String userPhone;       // USER_PHONE
    private java.util.Date birthDate; // BIRTH_DATE
    private String gender;          // GENDER
    private String country;         // COUNTRY
    private java.util.Date regDate; // REG_DATE
    private String userRole;     // USER_ROLE
    private int reservationCount;

    public int getReservationCount() {
        return reservationCount;
    }

    public void setReservationCount(int reservationCount) {
        this.reservationCount = reservationCount;
    }

    public String getReservationStatus() {
        return reservationCount > 0 ? "O" : "X";
    }
    
    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getKorLastName() {
		return korLastName;
	}
	public void setKorLastName(String korLastName) {
		this.korLastName = korLastName;
	}
	public String getKorFirstName() {
		return korFirstName;
	}
	public void setKorFirstName(String korFirstName) {
		this.korFirstName = korFirstName;
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
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getPhoneCountry() {
		return phoneCountry;
	}
	public void setPhoneCountry(String phoneCountry) {
		this.phoneCountry = phoneCountry;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public java.util.Date getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(java.util.Date birthDate) {
		this.birthDate = birthDate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public java.util.Date getRegDate() {
		return regDate;
	}
	public void setRegDate(java.util.Date regDate) {
		this.regDate = regDate;
	}
	public UserDTO(){
		
	}
	public UserDTO(String userId, String korLastName, String korFirstName, String engLastName, String engFirstName,
			String userEmail, String phoneCountry, String userPhone, Date birthDate, String gender, String country) {
		super();
		this.userId = userId;
		this.korLastName = korLastName;
		this.korFirstName = korFirstName;
		this.engLastName = engLastName;
		this.engFirstName = engFirstName;
		this.userEmail = userEmail;
		this.phoneCountry = phoneCountry;
		this.userPhone = userPhone;
		this.birthDate = birthDate;
		this.gender = gender;
		this.country = country;
	}
	@Override
	public String toString() {
		return "UserDTO [userId=" + userId + ", korLastName=" + korLastName + ", korFirstName=" + korFirstName
				+ ", engLastName=" + engLastName + ", engFirstName=" + engFirstName + ", userEmail=" + userEmail
				+ ", phoneCountry=" + phoneCountry + ", userPhone=" + userPhone + ", birthDate=" + birthDate
				+ ", gender=" + gender + ", country=" + country + "]";
	}
  
}
