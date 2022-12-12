package com.codegym.customermanager.controller;

import com.codegym.customermanager.model.Customer;
import com.codegym.customermanager.service.CustomerService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CustomerServlet" , urlPatterns = { "/customers"})
public class CustomerServlet extends HttpServlet {
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        RequestDispatcher requestDispatcher;
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showFormCreateCustomer(req, resp);
                break;
            case "edit":
                showEditCustomer(req, resp);
                break;
            default:
                showListCustomer(req, resp);
        }


    }

    private void showListCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("customers", customerService.getAllCustomers());
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/customer.jsp");

        requestDispatcher.forward(req, resp);
    }

    private void showEditCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        Customer customer = customerService.findCustomerById(id);

        req.setAttribute("customer", customer);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/edit.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void showFormCreateCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/create.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create": {
                insertCustomer(req, resp);
                break;
            }
            case "edit":
                editCustomer(req, resp);
                break;
            default:

        }

    }

    private void editCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long id = Long.parseLong(req.getParameter("id"));
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String country = req.getParameter("country");

        Customer customer = customerService.findCustomerById(id);
        customer.setName(name);
        customer.setAddress(address);
        customer.setCountry(country);
        customerService.updateCustomer(customer);

        req.setAttribute("customers", customerService.getAllCustomers());
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/customer.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void insertCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String country = req.getParameter("country");

        Customer customer = new Customer(customerService.getAllCustomers().size() + 1, name, address, country);
        customerService.addCustomer(customer);

        req.setAttribute("message", "Add customer success");
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/create.jsp");
        requestDispatcher.forward(req, resp);
    }
}
