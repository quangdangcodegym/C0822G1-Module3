package com.codegym.customermanager.utils;

import java.util.regex.Pattern;

public class ValidateUtils {

    public static final String FULLNAME_PATTERN = "^[A-Z][a-zA-Z]{3,}(?: [A-Z][a-zA-Z]*){0,2}$";
    public static final String USERNAME_PATTERN = "^[a-zA-Z0-9_]{4,20}$";
    public static final String PASSWORD_PATTERN = "^([a-zA-Z0-9]{6,})";
    public static final String NAME_REGEX = "^([A-Z]+[a-z]*[ ]?)+$";
    public static final String PHONE_REGEX = "^[0][1-9][0-9]{8}$";
    public static final String EMAIL_REGEX = "^[A-Za-z0-9._]+@[a-z]+\\.[a-z]{2,3}$";

    public static boolean isFullNameValid(String fullName) {
        return Pattern.compile(NAME_REGEX).matcher(fullName).matches();
    }
    public static boolean isPasswordValid(String password) {
        return Pattern.compile(PASSWORD_PATTERN).matcher(password).matches();
    }
    public static boolean isUsernameValid(String username) {
        return Pattern.compile(USERNAME_PATTERN).matcher(username).matches();
    }
    public static boolean isNameValid(String name) {
        return Pattern.compile(NAME_REGEX).matcher(name).matches();
    }
    public static  boolean isPhoneValid(String number) {
        return Pattern.compile(PHONE_REGEX).matcher(number).matches();
    }
    public static  boolean isEmailValid(String email) {
        return Pattern.compile(EMAIL_REGEX).matcher(email).matches();
    }
}
