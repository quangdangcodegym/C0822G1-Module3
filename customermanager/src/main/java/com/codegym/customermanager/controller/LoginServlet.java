package com.codegym.customermanager.controller;

import com.codegym.customermanager.service.jdbc.UserServiceJDBC;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/admin/login.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (UserServiceJDBC.checkUserNamePassword(username, password)) {
            HttpSession httpSession = req.getSession();
            httpSession.setAttribute("username", username);
            httpSession.setAttribute("password", password);

            resp.sendRedirect("/customers");
        }else{
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/admin/login.jsp");
            requestDispatcher.forward(req, resp);
        }

    }
}
