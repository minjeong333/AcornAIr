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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
	        throws ServletException, IOException {

	    // 1. 세션 확인
	    HttpSession session = req.getSession(false);

	    UserDTO loginUser = null;

	    if(session != null) {
	        loginUser = (UserDTO) session.getAttribute("loginUser");
	    }

	    // 2. 로그인 안 된 경우
	    if (loginUser == null) {

	        // AJAX에게 "로그인 필요" 문자열 전달
	        resp.setContentType("text/plain; charset=UTF-8");
	        resp.getWriter().write("LOGIN_REQUIRED");

	        return;
	    }

	    // 3. 로그인된 사용자 ID 추출
	    String loginId = loginUser.getUserId();

	    // 4. DB 조회
	    UserDAO dao = new UserDAO();
	    UserDTO user = dao.getUserById(loginId);

	    // 5. request 저장
	    req.setAttribute("user", user);

	    // 6. 마이페이지 JSP 반환
	    req.getRequestDispatcher("/WEB-INF/views/mypage/mypage.jsp")
	       .forward(req, resp);
	}
}
