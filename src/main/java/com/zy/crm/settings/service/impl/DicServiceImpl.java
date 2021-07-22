package com.zy.crm.settings.service.impl;

import com.zy.crm.settings.dao.DicTypeDao;
import com.zy.crm.settings.dao.DicValueDao;
import com.zy.crm.settings.domain.DicType;
import com.zy.crm.settings.domain.DicValue;
import com.zy.crm.settings.service.DicService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zy
 */
@Service
public class DicServiceImpl implements DicService {

    @Resource
    private DicValueDao dicValueDao;

    @Resource
    private DicTypeDao dicTypeDao;


    @Override
    public Map<String, List<DicValue>> getDicValue() {
        Map<String, List<DicValue>> map = new HashMap<>();

        // 取出所有的类型
        List<DicType> types = dicTypeDao.selectAllType();

        // 根据类型取出所有的值
        for (DicType type: types) {
            // 取出每一个code
            String code = type.getCode();

            // 根据code获取values
            List<DicValue> values = dicValueDao.getValuesByCode(code);

            // 在map中设置 每一个code对应一个valueSet
            map.put(code,values);
        }

        return map;
    }
}






















