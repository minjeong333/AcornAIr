package acornAir.mypage.service;

import acornAir.login.dao.UserDAO;
import acornAir.login.dto.UserDTO;

	public class MyPageService {
	    
	    private UserDAO dao = new UserDAO();

	    public UserDTO getUserInfo(String userId) {
 
	        return dao.getUserById(userId);
	    }
	}
	


