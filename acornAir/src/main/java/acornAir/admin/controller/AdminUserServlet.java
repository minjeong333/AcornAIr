package acornAir.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import acornAir.login.dao.UserDAO;
import acornAir.login.dto.UserDTO;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

		UserDAO dao = new UserDAO();
		List<UserDTO> userList = dao.getAllUsers();

		request.setAttribute("userList", userList);

		request.getRequestDispatcher("/WEB-INF/views/admin/adminUserList.jsp").forward(request, response);
	}
}