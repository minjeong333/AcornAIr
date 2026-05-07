package acornAir.login.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import acornAir.login.dao.UserDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/air/signup")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        UserDTO user = new UserDTO();
        user.setUserId(req.getParameter("userId"));
        user.setEngLastName(req.getParameter("engLastName"));
        user.setEngFirstName(req.getParameter("engFirstName"));
        user.setKorLastName(req.getParameter("korLastName"));
        user.setKorFirstName(req.getParameter("korFirstName"));
        user.setUserEmail(req.getParameter("userEmail"));
        user.setPhoneCountry(req.getParameter("phoneCountry"));
        user.setUserPhone(req.getParameter("userPhone"));
        user.setGender(req.getParameter("gender"));
        user.setCountry(req.getParameter("country"));

        String birthStr = req.getParameter("birthDate");
        if (birthStr != null && !birthStr.isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                user.setBirthDate(sdf.parse(birthStr));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String userPw = req.getParameter("userPw");

        UserDAO dao = new UserDAO();
        int result = dao.insertUser(user, userPw);

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/WEB-INF/views/login/success.jsp");
        } else {
            req.setAttribute("errorMsg", "회원가입에 실패했습니다. 다시 시도해주세요.");
            req.getRequestDispatcher("/WEB-INF/views/login/register.jsp").forward(req, resp);
        }
    }
}
