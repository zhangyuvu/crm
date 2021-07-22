package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.Contacts;

public interface ContactsDao {

    // 插入一条联系人信息
    int insertContacts(Contacts contacts);
}
