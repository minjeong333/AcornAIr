package acornAir.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import acornAir.login.dao.UserDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String userId = req.getParameter("userId");
        String userPw = req.getParameter("userPw");
        String saveId = req.getParameter("saveId");
        
        //to-do
        System.out.println("로그인 아이디 = " + userId);
        System.out.println("로그인 비번 = " + userPw);
       

        UserDAO dao = new UserDAO();
        UserDTO loginUser = dao.login(userId, userPw);
        
        //to-do
        System.out.println("loginUser = " + loginUser);

        if (loginUser != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", loginUser);

            if ("Y".equals(saveId)) {
                Cookie cookie = new Cookie("savedId", userId);
                cookie.setMaxAge(60 * 60 * 24 * 7);
                resp.addCookie(cookie);
            }

//            resp.sendRedirect(req.getContextPath() + "/home");
            if ("ADMIN".equals(loginUser.getUserRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }

        } else {
            req.setAttribute("errorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
            req.getRequestDispatcher("/WEB-INF/views/login/login.jsp").forward(req, resp);
        }
    }
}
