package acornAir.login.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import acornAir.login.dao.UserDAO;

@WebServlet("/air/checkId")
public class CheckIdServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String userId = req.getParameter("userId");

        UserDAO dao = new UserDAO();
        int count = dao.checkId(userId);

        resp.setContentType("application/json; charset=UTF-8");
        if (count == 0) {
            resp.getWriter().write("{\"available\": true}");
        } else {
            resp.getWriter().write("{\"available\": false}");
        }
    }
}
