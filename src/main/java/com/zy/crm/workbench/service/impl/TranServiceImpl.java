package com.zy.crm.workbench.service.impl;

import com.zy.crm.exception.ChangeStageException;
import com.zy.crm.exception.TranSaveException;
import com.zy.crm.utils.DateTimeUtil;
import com.zy.crm.utils.UUDIUtil;
import com.zy.crm.vo.PaginationVo;
import com.zy.crm.workbench.dao.CustomerDao;
import com.zy.crm.workbench.dao.TranDao;
import com.zy.crm.workbench.dao.TranHistoryDao;
import com.zy.crm.workbench.domain.Customer;
import com.zy.crm.workbench.domain.Tran;
import com.zy.crm.workbench.domain.TranHistory;
import com.zy.crm.workbench.service.TranService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author zy
 */
@Service
public class TranServiceImpl implements TranService {

    @Resource
    private TranDao tranDao;

    @Resource
    private TranHistoryDao tranHistoryDao;

    @Resource
    private CustomerDao customerDao;

    // 插入一条tran记录
    @Override
    @Transactional
    public int saveTran(Tran tran, String customerName) {
        // 获取客户信息通过客户名称
        Customer customer = customerDao.selectCusByName(customerName);
        int result = 0;
        // 该客户不存在则创建客户
        if (customer == null){
            customer = new Customer();
            customer.setId(UUDIUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setOwner(tran.getOwner());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setContactSummary(tran.getContactSummary());
            result = customerDao.insertCustomer(customer);
            if(result != 1){
                throw  new TranSaveException("客户创建失败，交易保存失败");
            }
        }

        // 设置客户id
        tran.setCustomerId(customer.getId());
        tran.setId(UUDIUtil.getUUID());
        tran.setCreateTime(DateTimeUtil.getSysTime());
        result =  tranDao.insertTran(tran);
        if(result != 1){
            throw  new TranSaveException("交易保存失败");
        }
        // 添加交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUDIUtil.getUUID());
        tranHistory.setTranId(tran.getId());
        tranHistory.setStage(tran.getStage());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setCreateBy(tran.getCreateBy());

        result = tranHistoryDao.insertTranHistory(tranHistory);
        if(result != 1){
            throw  new TranSaveException("交易历史创建失败");
        }


        return result;
    }


    /*
        id对应的交易记录的详细信息
     */
    @Override
    public Tran detail(String id) {

        Tran tran = tranDao.selectDetail(id);

        return tran;
    }

    /*
            查询交易历史记录
         */
    @Override
    public List<TranHistory> getHistoryListByTranId(String id) {

        List<TranHistory> tranHistoryList = tranHistoryDao.selectHistoryByTranId(id);

        return tranHistoryList;
    }


    /*
        更新交易阶段
     */
    @Override
    @Transactional
    public Tran updateStage(Tran tran) {
        tran.setEditTime(DateTimeUtil.getSysTime());
        int result = tranDao.updateStage(tran);
        if(result != 1){
            throw new ChangeStageException("改变交易阶段失败");
        }


        TranHistory history = new TranHistory();
        history.setCreateTime(DateTimeUtil.getSysTime());
        history.setCreateBy(tran.getEditBy());
        history.setId(UUDIUtil.getUUID());
        history.setStage(tran.getStage());
        history.setTranId(tran.getId());
        history.setMoney(tran.getMoney());
        history.setExpectedDate(tran.getExpectedDate());

        result = tranHistoryDao.insertTranHistory(history);
        if(result != 1){
            throw new ChangeStageException("创建交易历史失败");
        }

        return tran;
    }
    /*
            获取交易阶段漏斗图
         */
    @Override
    public PaginationVo<Map<String, Integer>> getCharts() {
        PaginationVo<Map<String, Integer>> paginationVo = new PaginationVo<>();

        // 获取前端所需要的数据   json数组形式的 name（stage） , value(对应stage的数量) 两个键值对
        List<Map<String , Integer>> list = tranDao.selectStageSize();


        int totalSize = tranDao.getTotalSize();

        paginationVo.setTotalSize(totalSize);
        paginationVo.setDataList(list);

        return paginationVo;
    }
}
