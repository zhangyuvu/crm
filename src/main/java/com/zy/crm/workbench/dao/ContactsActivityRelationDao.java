package com.zy.crm.workbench.dao;

import com.zy.crm.workbench.domain.ContactsActivityRelation;

public interface ContactsActivityRelationDao {

    // 插入一条联系人和市场活动关联
    int insertRelation(ContactsActivityRelation relation);
}
