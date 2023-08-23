package com.kakarote.crm9.erp.crm.service;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.kakarote.crm9.common.config.paragetter.BasePageRequest;
import com.kakarote.crm9.erp.admin.service.AdminFieldService;
import com.kakarote.crm9.erp.crm.entity.CrmReceivables;
import com.kakarote.crm9.erp.crm.entity.CrmReceivablesPlan;
import com.kakarote.crm9.utils.BaseUtil;
import com.kakarote.crm9.utils.FieldUtil;
import com.kakarote.crm9.utils.R;
import com.jfinal.aop.Inject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import java.util.ArrayList;
import java.util.List;

public class CrmReceivablesPlanService {
    @Inject
    private FieldUtil fieldUtil;
    @Inject
    private AdminFieldService adminFieldService;

    /**
     * 添加或修改回款计划
     */
    public R saveAndUpdate(JSONObject jsonObject) {
        CrmReceivablesPlan crmReceivablesPlan = jsonObject.getObject("entity", CrmReceivablesPlan.class);
        String batchId = StrUtil.isNotEmpty(crmReceivablesPlan.getFileBatch()) ? crmReceivablesPlan.getFileBatch() : IdUtil.simpleUUID();
        adminFieldService.save(jsonObject.getJSONArray("field"), batchId);
        if (null == crmReceivablesPlan.getPlanId()) {
            crmReceivablesPlan.setCreateTime(DateUtil.date());
            crmReceivablesPlan.setCreateUserId(BaseUtil.getUser().getUserId());
            crmReceivablesPlan.setFileBatch(batchId);
            CrmReceivablesPlan receivablesPlan = CrmReceivablesPlan.dao.findFirst(Db.getSql("crm.receivablesplan.queryByContractId"), crmReceivablesPlan.getContractId());
            if (receivablesPlan == null) {
                crmReceivablesPlan.setNum("1");
            } else {
                crmReceivablesPlan.setNum(Integer.valueOf(receivablesPlan.getNum()) + 1 + "");
            }
            return crmReceivablesPlan.save() ? R.ok() : R.error();
        } else {
            Integer number = Db.queryInt("select count(*) from 72crm_crm_receivables where plan_id = ?",crmReceivablesPlan.getPlanId());
            if (number > 0 ){
                return R.error("The refund plan has been received, please do not edit");
            }
            crmReceivablesPlan.setUpdateTime(DateUtil.date());
            return crmReceivablesPlan.update() ? R.ok() : R.error();
        }
    }

    /**
     * @author wyq
     * 删除回款计划
     */
    @Before(Tx.class)
    public R deleteByIds(String planIds){
        String[] idsArr = planIds.split(",");
        List<Record> idsList = new ArrayList<>();
        for (String id : idsArr) {
            CrmReceivablesPlan.dao.deleteById(id);
        }
        return R.ok();
    }

    /**
     * @author zxy
     * 查询回款自定义字段（新增）
     */
    public List<Record> queryField() {
        List<Record> fieldList = new ArrayList<>();
        String[] settingArr = new String[]{};
        String[] returnTypeArr = new String[]{"Check","Cash","Postal Remittance","Wire Transfer","Online Transfer","Alipay","WeChat Pay","Other"};
        fieldUtil.getFixedField(fieldList, "customer_id", "Customer Name", "", "customer", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "contract_id", "contract number", "", "contract", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "money", "Planned payment amount", "", "number", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "return_date", "Planned payment date", "", "date", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "return_type", "Planned payment method", "", "select", returnTypeArr, 1);
        fieldUtil.getFixedField(fieldList, "remind", "Remind a few days in advance", "", "number", settingArr, 0);
        fieldUtil.getFixedField(fieldList, "remark", "remarks", "", "textarea", settingArr, 0);
        return fieldList;
    }

    /**
     * @author wyq
     * 查询回款自定义字段（编辑）
     */
    public List<Record> queryField(Integer id) {
        Record receivablesPlan = Db.findFirst(Db.getSql("crm.receivablesplan.queryUpdateField"),id);
        List<Record> fieldList = new ArrayList<>();
        String[] settingArr = new String[]{};
        String[] returnTypeArr = new String[]{"Check","Cash","Postal Remittance","Wire Transfer","Online Transfer","Alipay","WeChat Pay","Other"};
        List<Record> customerList = new ArrayList<>();
        customerList.add(new Record().set("customer_id", receivablesPlan.getInt("customer_id")).set("customer_name", receivablesPlan.getStr("customer_name")));
        fieldUtil.getFixedField(fieldList, "customer_id", "Customer Name", customerList, "customer", settingArr, 1);
        List<Record> contractList = new ArrayList<>();
        contractList.add(new Record().set("contract_id", receivablesPlan.getInt("contract_id")).set("num", receivablesPlan.getStr("num")));
        fieldUtil.getFixedField(fieldList, "contract_id", "contract number", contractList, "contract", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "money", "Planned refund amount", receivablesPlan.getStr("money"), "number", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "return_date", "Planned payment date", receivablesPlan.getStr("return_date"), "date", settingArr, 1);
        fieldUtil.getFixedField(fieldList, "return_type", "Planned payment method", receivablesPlan.getStr("return_type"), "select", returnTypeArr, 1);
        fieldUtil.getFixedField(fieldList, "remind", "remind a few days in advance", receivablesPlan.getStr("remind"), "number", settingArr, 0);
        fieldUtil.getFixedField(fieldList, "remark", "remarks", receivablesPlan.getStr("remark"), "textarea", settingArr, 0);
        return fieldList;
    }

    /**
     * 根据合同查询回款计划
     */
    public R qureyListByContractId(BasePageRequest<CrmReceivables> basePageRequest) {

        Integer pageType = basePageRequest.getPageType();
        if (pageType == null || 0 == pageType) {
            return R.ok().put("data", Db.find(Db.getSql("crm.receivablesplan.queryListByContractId"), basePageRequest.getData().getContractId()));
        }
        if (1 == pageType) {
            return R.ok().put("data", Db.paginate(basePageRequest.getPage(), basePageRequest.getLimit(), Db.getSqlPara("crm.receivablesplan.queryListByContractId", basePageRequest.getData().getContractId())));
        }
        return R.error();
    }

    /**
     * 新建汇款时根据合同ID查询回款计划
     * @author wyq
     */
    public R queryReceivablesPlansByContractId(Integer contractId){
        return R.ok().put("data",Db.find(Db.getSql("crm.receivablesplan.queryReceivablesPlansByContractId"),contractId));
    }

    /**
     * 根据合同id和客户id查询未使用的回款计划
     */
    public R queryByContractAndCustomer(CrmReceivablesPlan receivablesPlan) {
        List<CrmReceivablesPlan> plans = CrmReceivablesPlan.dao.find(Db.getSql("crm.receivablesplan.queryByCustomerIdContractId"), receivablesPlan.getContractId(), receivablesPlan.getCustomerId());
        return R.ok().put("data", plans);
    }
}
