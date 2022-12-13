package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Country;

import java.util.ArrayList;
import java.util.List;

public class CountryService {
    private List<Country> countries;
    public CountryService() {
        countries = new ArrayList<>();
        countries.add(new Country(1L, "Viet Nam"));
        countries.add(new Country(2L, "Lao"));
        countries.add(new Country(3L, "Thai Lan"));
    }
    public List<Country> getAllCountry() {
        return countries;
    }
}
