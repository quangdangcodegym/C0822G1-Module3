package com.codegym.customermanager.service.jdbc;

import com.codegym.customermanager.model.Country;
import com.codegym.customermanager.repositoryv1.CountryRepository;
import com.codegym.customermanager.service.ICountryService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CountryServiceJDBC implements ICountryService {
    CountryRepository countryRepository;
    public CountryServiceJDBC() {
        countryRepository = new CountryRepository();
    }
    @Override
    public List<Country> getAllCountry() {
        return countryRepository.getAll();
    }

    @Override
    public Country findCountryById(long id) {
        return countryRepository.findById(id);
    }

}
