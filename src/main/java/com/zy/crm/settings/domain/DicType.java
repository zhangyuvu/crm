package com.zy.crm.settings.domain;

/**
 * @author zy
 *
 *  数据字典
 */
public class DicType {

    private String code;
    private String name;
    private String description;

    @Override
    public String toString() {
        return "DicValue{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public DicType() {
    }

}
