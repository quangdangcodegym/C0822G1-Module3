package com.codegym.customermanager.model;

public class Customer {
    private long id;
    private String name;
    private String address;
    private long idCountry;

    public Customer() {

    }

    public Customer(long id, String name, String address, long idCountry) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.idCountry = idCountry;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getIdCountry() {
        return idCountry;
    }

    public void setIdCountry(long idCountry) {
        this.idCountry = idCountry;
    }
}
