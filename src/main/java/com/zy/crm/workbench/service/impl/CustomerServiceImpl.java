package com.zy.crm.workbench.service.impl;

import com.zy.crm.workbench.dao.CustomerDao;
import com.zy.crm.workbench.domain.Customer;
import com.zy.crm.workbench.service.CustomerService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author zy
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    @Resource
    private CustomerDao customerDao;

    /*
      模糊查询客户名称
   */
    @Override
    public List<String> getCustomerName(String name) {

        List<String> nameList = customerDao.selectCustomerName(name);

        return nameList;
    }

    /*
            根据客户名称查询客户id
         */
    @Override
    public Customer getCustomerByName(String customerName) {

       Customer customer = customerDao.selectCusByName(customerName);
        return customer;
    }

    /*
        保存一条客户信息
     */
    @Override
    public void saveCustomer(Customer customer) {

       int result = customerDao.insertCustomerByName(customer);


    }

}
