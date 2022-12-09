package com.codegym.helloservlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@WebServlet(name = "Tudien1Servlet", urlPatterns = {"/tudien1"})
public class Tudien1Servlet extends HttpServlet {
    private Map<String, String> tudiens = new HashMap<>();

    @Override
    public void init() throws ServletException {
        tudiens.put("Hello", "Xin chao");
        tudiens.put("Apple", "qua tao");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/tudien.jsp");
        requestDispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");

        String result = tudiens.get(keyword);

        Set<String> keys = tudiens.keySet();
        req.setAttribute("kq", result);
        req.setAttribute("keys", keys);

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/tudien.jsp");
        requestDispatcher.forward(req, resp);
    }
}
