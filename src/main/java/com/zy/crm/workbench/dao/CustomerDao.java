package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.Customer;

import java.util.List;

public interface CustomerDao {


    // 根据公司名查找客户公司
    Customer selectCusByName(String company);

    // 插入一条客户记录
    int insertCustomer(Customer customer);

    /*
       模糊查询客户名称
    */
    List<String> selectCustomerName(String name);


    // 插入一条残缺的客户信息
    int insertCustomerByName(Customer customer);
}
