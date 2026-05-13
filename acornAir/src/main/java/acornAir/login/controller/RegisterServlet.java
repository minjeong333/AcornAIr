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

        String userId = req.getParameter("userId");
        String userPw = req.getParameter("userPw");
        String engLastName = req.getParameter("engLastName");
        String engFirstName = req.getParameter("engFirstName");
        String korLastName = req.getParameter("korLastName");
        String korFirstName = req.getParameter("korFirstName");
        String userEmail = req.getParameter("userEmail");
        String phoneCountry = req.getParameter("phoneCountry");
        String userPhone = req.getParameter("userPhone");
        String gender = req.getParameter("gender");
        String country = req.getParameter("country");
        String birthStr = req.getParameter("birthDate");

        if (isEmpty(userId) || isEmpty(userPw) ||
            isEmpty(engLastName) || isEmpty(engFirstName) ||
            isEmpty(korLastName) || isEmpty(korFirstName) ||
            isEmpty(userEmail) || isEmpty(phoneCountry) ||
            isEmpty(userPhone) || isEmpty(gender) ||
            isEmpty(country) || isEmpty(birthStr)) {

            req.setAttribute("errorMsg", "필수 정보를 모두 입력해 주세요.");
            req.getRequestDispatcher("/WEB-INF/views/login/register.jsp").forward(req, resp);
            return;
        }

        UserDTO user = new UserDTO();
        user.setUserId(userId);
        user.setEngLastName(engLastName);
        user.setEngFirstName(engFirstName);
        user.setKorLastName(korLastName);
        user.setKorFirstName(korFirstName);
        user.setUserEmail(userEmail);
        user.setPhoneCountry(phoneCountry);
        user.setUserPhone(userPhone);
        user.setGender(gender);
        user.setCountry(country);

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            user.setBirthDate(sdf.parse(birthStr));
        } catch (Exception e) {
            req.setAttribute("errorMsg", "생년월일 형식이 올바르지 않습니다.");
            req.getRequestDispatcher("/WEB-INF/views/login/register.jsp").forward(req, resp);
            return;
        }

        UserDAO dao = new UserDAO();

        int idCount = dao.checkId(userId);

        if (idCount > 0) {
            req.setAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
            req.getRequestDispatcher("/WEB-INF/views/login/register.jsp").forward(req, resp);
            return;
        }

        int result = dao.insertUser(user, userPw);

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/air/login");
        } else {
            req.setAttribute("errorMsg", "회원가입에 실패했습니다. 다시 시도해주세요.");
            req.getRequestDispatcher("/WEB-INF/views/login/register.jsp").forward(req, resp);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}