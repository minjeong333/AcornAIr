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
        
        //입력값 검증
        if (keyword == null || keyword.trim().isEmpty()) {
            resp.getWriter().write("질문을 입력해 주세요.");
            return;
        }

        keyword = keyword.trim();
        String answer = "";

            try {
            	//DB연동
                ChatDao dao = new ChatDao();
                answer = dao.getAnswer(keyword);
                
                //DB에 결과가 없을 경우
                if (answer == null || answer.trim().isEmpty()) {
                    //answer = "죄송합니다. '" + keyword + "'에 대한 답변을 찾지 못했습니다.";
                	answer = "'" + keyword + " '에 대한 답변을 찾지 못했습니다. 예약, 수하물, 공항 등의 키워드로 질문해 주세요.";
                }

            } catch (Exception e) {
                e.printStackTrace();
                answer = "챗봇 답변을 불러오는 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.";
            }

    	//답변 전송
        resp.getWriter().write(answer);
}
}