package acornAir.Chat.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import acornAir.Chat.dao.ChatDao;

@WebServlet("/air/chat")
public class ChatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/chat/chat.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/plain; charset=UTF-8");

        String keyword = req.getParameter("keyword");

        if (keyword == null || keyword.trim().isEmpty()) {
            resp.getWriter().write("질문을 입력해 주세요.");
            return;
        }

        keyword = keyword.trim();

        String answer = "";

        if ("회원가입안내".equals(keyword)) {
            answer = "회원가입은 홈페이지 우측 상단 버튼을 통해 진행하실 수 있습니다.";
        } else if ("항공권 구매".equals(keyword)) {
            answer = "항공권 구매는 [예약] 메뉴에서 실시간으로 가능합니다.";
        } else if ("예약조회".equals(keyword)) {
            answer = "로그인 후 마이페이지에서 예약 내역 확인이 가능합니다.";
        } else if ("수하물규정".equals(keyword)) {
            answer = "기내 수하물은 1인당 10kg까지 허용됩니다.";
        } else {
            try {
                ChatDao dao = new ChatDao();
                answer = dao.getAnswer(keyword);

                if (answer == null || answer.trim().isEmpty()) {
                    answer = "죄송합니다. '" + keyword + "'에 대한 답변을 찾지 못했습니다.";
                }

            } catch (Exception e) {
                e.printStackTrace();
                answer = "챗봇 답변을 불러오는 중 오류가 발생했습니다.";
            }
        }

        resp.getWriter().write(answer);
    }
}