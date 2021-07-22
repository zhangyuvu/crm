package com.zy.crm.vo;

import java.util.List;

/**
 * @author zy
 */
/*
    通用vo
 */
public class PaginationVo<T> {

    //总的记录条数
    private int totalSize;

    //返回给前端的list
    private List<T> dataList;

    @Override
    public String toString() {
        return "PaginationVo{" +
                "total=" + totalSize +
                ", dataList=" + dataList +
                '}';
    }

    public int getTotalSize() {
        return totalSize;
    }

    public void setTotalSize(int totalSize) {
        this.totalSize = totalSize;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public PaginationVo() {
    }
}
