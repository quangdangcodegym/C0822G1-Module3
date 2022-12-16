package com.codegym.customermanager.service.inmemory;

import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.service.ICountryService;

import java.util.ArrayList;
import java.util.List;

public class CountryService implements ICountryService {
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

    public Country findCountryById(long id) {
        for (Country c : countries) {
            if (c.getId() == id) {
                return c;
            }
        }
        return null;
    }

    @Override
    public boolean insertCountryBySP(String nameCountry) {
        return false;
    }

    @Override
    public boolean testProcedure() {
        return false;
    }
}
