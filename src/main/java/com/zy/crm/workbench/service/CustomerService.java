package com.zy.crm.workbench.service;

import com.zy.crm.workbench.domain.Customer;

import java.util.List;

public interface CustomerService {


    /*
    模糊查询客户名称
 */
    List<String> getCustomerName(String name);

    /*
        根据客户名称查询客户id
     */
    Customer getCustomerByName(String customerName);


    // 插入一条customer记录
    void saveCustomer(Customer customer);
}
