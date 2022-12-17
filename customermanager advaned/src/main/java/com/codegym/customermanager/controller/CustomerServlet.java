package com.codegym.customermanager.controller;

import com.codegym.customermanager.exception.CountryInvalidException;
import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.model.Customer;
import com.codegym.customermanager.repository.CustomerRepository;
import com.codegym.customermanager.service.ICountryService;
import com.codegym.customermanager.service.inmemory.CountryService;
import com.codegym.customermanager.service.jdbc.CountryServiceJDBC;
import com.codegym.customermanager.service.jdbc.CustomerServiceJDBC;
import com.codegym.customermanager.service.ICustomerService;
import com.codegym.customermanager.utils.ValidateUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerServlet" , urlPatterns = { "/customers"})
public class CustomerServlet extends HttpServlet {
    private ICustomerService customerService;
    private ICountryService countryService;

    @Override
    public void init() throws ServletException {


        customerService = new CustomerServiceJDBC();
        countryService = new CountryServiceJDBC();

        List<Country> countryList = countryService.getAllCountry();
        if (getServletContext().getAttribute("countries") == null) {
            getServletContext().setAttribute("countries", countryList);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println(getServletContext().getRealPath("/"));
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
        String error = null;
        Customer customer;
        try {
            long id = Long.parseLong(req.getParameter("id"));
            if ((customer = customerService.findCustomerById(id)) == null) {
                error = "ID customer not exists";
                req.setAttribute("error", error);
            }else{
                req.setAttribute("customer", customer);
            }
        } catch (NumberFormatException numberFormatException) {
            error = "ID customer not valid";
            req.setAttribute("error", error);
        }



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
        List<String> errors = new ArrayList<>();
        Customer customer = new Customer();


        validateIdView(errors, req, customer);
        validateFullNameView(errors, req, customer);
        validateAddressView(errors, req, customer);
        validateCountryView(errors, req, customer);

        RequestDispatcher requestDispatcher;
        if (errors.isEmpty()) {
            customerService.updateCustomer(customer);
            req.setAttribute("customers", customerService.getAllCustomers());
            requestDispatcher = req.getRequestDispatcher("/customer.jsp");
        }else{
            req.setAttribute("errors", errors);
            req.setAttribute("customer", customer);
            requestDispatcher = req.getRequestDispatcher("/edit.jsp");
        }
        requestDispatcher.forward(req, resp);



    }

    private boolean validateIdView(List<String> errors, HttpServletRequest req, Customer customer) {
        try {
            long id = Long.parseLong(req.getParameter("id"));
            if (customerService.findCustomerById(id) == null) {
                throw new NullPointerException("Customer not exists");
            }
            customer.setId(id);
        } catch (NumberFormatException numberFormatException) {
            errors.add("ID customer not valid");
            return false;
        } catch (NullPointerException nullPointerException) {
            errors.add(nullPointerException.getMessage());
            return false;
        }
        return true;

    }

    private void insertCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        Customer customer = new Customer();

        validateFullNameView(errors, req, customer);     // false
        validateAddressView(errors, req, customer);      // false
        validateCountryView(errors, req, customer);
        if (errors.isEmpty()) {
            customer.setId(customerService.getAllCustomers().size() + 1);
            customerService.addCustomer(customer);
            req.setAttribute("message", "Them khach hang thanh cong");
        }else{
            req.setAttribute("errors", errors);
            req.setAttribute("customer", customer);
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/create.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void validateCountryView(List<String> errors, HttpServletRequest req, Customer customer) {
        long idCountry = -1;

        try {
            idCountry = Long.parseLong(req.getParameter("idCountry"));
            // kiem tra country co hop le hay khong
            if (countryService.findCountryById(idCountry) == null) {
                throw new CountryInvalidException("Country is exists");
            }
        } catch (NumberFormatException numberFormatException) {
            errors.add("Country is not valid");
        } catch (CountryInvalidException countryInvalidException) {
            errors.add(countryInvalidException.getMessage());
        }
        customer.setIdCountry(idCountry);
    }

    private void validateAddressView(List<String> errors, HttpServletRequest req, Customer customer) {
        String address = req.getParameter("address");
        customer.setAddress(address);
        if (address.equals("")) {
            errors.add("Address is not empty");
        }
    }

    private void validateFullNameView(List<String> errors, HttpServletRequest req, Customer customer) {
        String name = req.getParameter("name");
        customer.setName(name);
        if (name.equals("")) {
            errors.add("Fullname is not empty");
        }else{
            if (ValidateUtils.isFullNameValid(name)==false) {
                errors.add("Fullname not valid. Start with Upcase, least 4 character");
            }
        }
    }
}
