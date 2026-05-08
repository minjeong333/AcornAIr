package acornAir.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.login.dao.UserDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/users/delete")
public class AdminUserDeleteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("loginUser") == null) {
			response.sendRedirect(request.getContextPath() + "/air/login");
			return;
		}

		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

		if (!"ADMIN".equals(loginUser.getUserRole())) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}

		String userId = request.getParameter("userId");

		if (loginUser.getUserId().equals(userId)) {
			response.sendRedirect(request.getContextPath() + "/admin/users");
			return;
		}

		UserDAO dao = new UserDAO();
		dao.deleteUser(userId);

		response.sendRedirect(request.getContextPath() + "/admin/users");
	}
}