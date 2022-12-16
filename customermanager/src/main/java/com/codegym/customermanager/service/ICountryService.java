package com.codegym.customermanager.service;

import com.codegym.customermanager.model.Country;

import java.sql.SQLException;
import java.util.List;

public interface ICountryService {
    List<Country> getAllCountry();
    Country findCountryById(long id);

    boolean insertCountryBySP(String nameCountry);


    boolean testProcedure();
}
