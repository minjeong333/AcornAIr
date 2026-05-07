package acornAir.mypage.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.login.dao.UserDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/mypage")
public class MypageServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		// 1. 세션에서 로그인한 유저 ID 가져오기 (로그인 시 세션에 "userId"를 저장했다고 가정)
        HttpSession session = req.getSession();
        String loginId = (String) session.getAttribute("userId");
        */
		//테스트용
		String loginId = "airtraveler";
		/*
        if (loginId == null) {
            // 로그인이 안 되어 있다면 로그인 페이지로 리다이렉트 하거나 알림 처리
            resp.sendRedirect(req.getContextPath() + "/air/login");
            return;
        }
       */
        // 2. DAO를 통해 DB에서 유저 정보(UserDTO) 가져오기
        UserDAO dao = new UserDAO();
        UserDTO user = dao.getUserById(loginId); 
        /*
       // --- 테스트용 가상 데이터 ---
         UserDTO user = new UserDTO("ACORN", "에이", "콘", "ACORN", "AIR", 
                                    "abc@acorn.com", "82", "010-123-4567", 
                                    new java.sql.Date(System.currentTimeMillis()), "M", "KR");
        // ------------------------------------------------------------------
         */
        // 3. request 객체에 데이터 담기        
        req.setAttribute("user", user);		
		
		req.getRequestDispatcher("/WEB-INF/views/mypage/mypage.jsp").forward(req, resp);
	}

}
