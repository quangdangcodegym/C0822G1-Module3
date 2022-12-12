package com.codegym.helloservlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "TuDienServlet", urlPatterns = {"/tudien", "/dictionary"})
public class TuDienServlet extends HttpServlet {
    private Map<String, String> tudiens = new HashMap<>();

    @Override
    public void init() throws ServletException {
        System.out.println("Khoi tao servlet");

        tudiens.put("Hello", "Xin chao");
        tudiens.put("Apple", "qua tao");


    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Chay vao ham doGEt");
        PrintWriter outWriter = resp.getWriter();

        getServletContext().setAttribute("dung", 10000);

        outWriter.println("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
                "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                "    <title>Document</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <form action=\"/tudien\" method=\"post\">\n" +
                "        <label for=\"\">Key </label>\n" +
                "        <input type=\"text\" name=\"keyword\">\n" +
                "        <label>Result</label>\n" +
                "        <button type=\"submit\"> Translate</button>\n" +
                "    </form>\n" +
                "\n" +
                "</body>\n" +
                "</html>");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("Chay vao ham doPost");
        String keyword = req.getParameter("keyword");

        String result = tudiens.get(keyword);

        PrintWriter out = resp.getWriter();
        String noidungTraVe =
                String.format("<!DOCTYPE html>\n" +
                        "<html lang=\"en\">\n" +
                        "<head>\n" +
                        "    <meta charset=\"UTF-8\">\n" +
                        "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n" +
                        "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                        "    <title>Document</title>\n" +
                        "</head>\n" +
                        "<body>\n" +
                        "    <form action=\"/tudien\" method=\"post\">\n" +
                        "        <label for=\"\">Key </label>\n" +
                        "        <input type=\"text\" name=\"keyword\">\n" +
                        "        <label>Result: %s</label>\n" +
                        "        <button type=\"submit\"> Translate</button>\n" +
                        "    </form>\n" +
                        "\n" +
                        "</body>\n" +
                        "</html>", result);

        out.println(noidungTraVe);
    }

    @Override
    public void destroy() {
        System.out.println("Huy servlet");
    }
}
