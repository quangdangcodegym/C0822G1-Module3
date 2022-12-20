package com.codegym.customermanager.service.jdbc;

public class UserServiceJDBC {
    public static boolean checkUserNamePassword(String username, String password) {
        if (username.equals("admin") && password.equals("123123")) {
            return true;
        }
        return false;
    }
}
