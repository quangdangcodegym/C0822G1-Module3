package com.codegym.customermanager.controller;

import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.model.Customer;
import com.codegym.customermanager.service.CountryService;
import com.codegym.customermanager.service.CustomerService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerServlet" , urlPatterns = { "/customers"})
public class CustomerServlet extends HttpServlet {
    private CustomerService customerService;
    private CountryService countryService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
        countryService = new CountryService();

        List<Country> countryList = countryService.getAllCountry();
        if (getServletContext().getAttribute("countries") == null) {
            getServletContext().setAttribute("countries", countryList);
        }
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
            case "delete":
                long id = Long.parseLong(req.getParameter("id"));
                customerService.deleteCustomer(id);

                req.setAttribute("customers", customerService.getAllCustomers());
                RequestDispatcher requestDispatcher1 = req.getRequestDispatcher("/customer.jsp");
                requestDispatcher1.forward(req, resp);
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
        long idCountry = Long.parseLong(req.getParameter("idCountry"));

        Customer customer = customerService.findCustomerById(id);
        customer.setName(name);
        customer.setAddress(address);
        customer.setIdCountry(idCountry);
        customerService.updateCustomer(customer);

        req.setAttribute("customers", customerService.getAllCustomers());
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/customer.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void insertCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        long idCountry = Long.parseLong(req.getParameter("idCountry"));

        Customer customer = new Customer(customerService.getAllCustomers().size() + 1, name, address, idCountry);
        customerService.addCustomer(customer);

        req.setAttribute("message", "Them khach hang thanh cong");
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/create.jsp");
        requestDispatcher.forward(req, resp);
    }
}
