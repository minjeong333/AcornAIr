package acornAir.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.login.dao.UserDAO;

@WebServlet("/air/checkId")
public class CheckIdServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain;charset=UTF-8");

        String userId = req.getParameter("userId");

        UserDAO dao = new UserDAO();
        int count = dao.checkId(userId);

        System.out.println("중복확인 userId = " + userId);
        System.out.println("중복확인 count = " + count);

        if (count > 0) {
            resp.getWriter().write("duplicate");
        } else {
            resp.getWriter().write("available");
        }
    }
}