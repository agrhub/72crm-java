package com.kakarote.crm9.erp.crm.common;

import cn.hutool.core.util.ArrayUtil;
import com.jfinal.plugin.activerecord.Db;

/**
 * @author wyq
 */
public class CrmParamValid {
    String[] wordArr = new String[]{"Vietnam", "Company", "Limited Company", "Limited Liability Company", "Stock Company", "Group", "International", "Branch", "Head Office"};

    public boolean isValid(String para){
        Integer number = Db.queryInt("select count(*) from 72crm_crm_area where city_name = ?",para);
        if (ArrayUtil.contains(wordArr,para) || number > 0){
            return false;
        }
        return true;
    }
}
