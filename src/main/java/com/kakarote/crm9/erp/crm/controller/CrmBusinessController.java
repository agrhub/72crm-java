package com.kakarote.crm9.erp.crm.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Aop;
import com.jfinal.aop.Before;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.kakarote.crm9.common.annotation.NotNullValidate;
import com.kakarote.crm9.common.annotation.Permissions;
import com.kakarote.crm9.common.config.paragetter.BasePageRequest;
import com.kakarote.crm9.erp.admin.entity.AdminFieldSort;
import com.kakarote.crm9.erp.admin.entity.AdminRecord;
import com.kakarote.crm9.erp.admin.service.AdminFieldService;
import com.kakarote.crm9.erp.admin.service.AdminSceneService;
import com.kakarote.crm9.erp.crm.common.CrmEnum;
import com.kakarote.crm9.erp.crm.entity.CrmBusiness;
import com.kakarote.crm9.erp.crm.service.CrmBusinessService;
import com.kakarote.crm9.utils.AuthUtil;
import com.kakarote.crm9.utils.R;
import com.jfinal.aop.Inject;
import com.jfinal.core.Controller;
import com.jfinal.core.paragetter.Para;
import org.apache.poi.ss.usermodel.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CrmBusinessController extends Controller {
    @Inject
    private CrmBusinessService crmBusinessService;

    @Inject
    private AdminSceneService adminSceneService;

    /**
     * @author wyq
     * 查看列表页
     */
    @Permissions({"crm:business:index"})
    public void queryPageList(BasePageRequest basePageRequest){
        JSONObject jsonObject = basePageRequest.getJsonObject().fluentPut("type",5);
        basePageRequest.setJsonObject(jsonObject);
        renderJson(adminSceneService.filterConditionAndGetPageList(basePageRequest));
    }

    /**
     * @author wyq
     * 新增或更新商机
     */
    @Permissions({"crm:business:save","crm:business:update"})
    public void addOrUpdate(){
        JSONObject jsonObject = JSON.parseObject(getRawData());
        renderJson(crmBusinessService.addOrUpdate(jsonObject));
    }

    /**
     * @author wyq
     * 根据商机id查询
     */
    @Permissions("crm:business:read")
    @NotNullValidate(value = "businessId",message = "Opportunity id cannot be empty")
    public void queryById(@Para("businessId")Integer businessId){
        renderJson(R.ok().put("data",crmBusinessService.queryById(businessId)));
    }

    /**
     * @author wyq
     * 根据商机名称查询
     */
    @NotNullValidate(value = "name",message = "Name is required")
    public void queryByName(@Para("name")String name){
        renderJson(R.ok().put("data",crmBusinessService.queryByName(name)));
    }

    /**
     * @author wyq
     * 根据商机id查询产品
     */
    public void queryProduct(BasePageRequest<CrmBusiness> basePageRequest){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, basePageRequest.getData().getBusinessId());
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(crmBusinessService.queryProduct(basePageRequest));
    }

    /**
     * @author wyq
     * 根据商机id查询合同
     */
    public void queryContract(BasePageRequest<CrmBusiness> basePageRequest){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, basePageRequest.getData().getBusinessId());
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(crmBusinessService.queryContract(basePageRequest));
    }

    /**
     * @author wyq
     * 根据商机id查询联系人
     */
    public void queryContacts(BasePageRequest<CrmBusiness> basePageRequest){
        renderJson(crmBusinessService.queryContacts(basePageRequest));
    }

    /**
     * @author wyq
     * 商机关联联系人
     */
    public void relateContacts(@Para("businessId")Integer businessId,@Para("contactsIds")String contactsIds){
        renderJson(crmBusinessService.relateContacts(businessId,contactsIds));
    }

    /**
     * @author wyq
     * 商机解除关联联系人
     */
    public void unrelateContacts(@Para("businessId")Integer businessId,@Para("contactsIds")String contactsIds){
        renderJson(crmBusinessService.unrelateContacts(businessId,contactsIds));
    }

    /**
     * @author wyq
     * 根据id删除商机
     */
    @Permissions("crm:business:delete")
    @NotNullValidate(value = "businessIds",message = "Opportunity id cannot be empty")
    public void deleteByIds(@Para("businessIds")String businessIds){
        renderJson(crmBusinessService.deleteByIds(businessIds));
    }

    /**
     * @author wyq
     * 根据商机id变更负责人
     */
    @Permissions("crm:business:transfer")
    @NotNullValidate(value = "businessIds",message = "Business opportunity id cannot be empty")
    @NotNullValidate(value = "newOwnerUserId",message = "The person in charge id cannot be empty")
    @NotNullValidate(value = "transferType",message = "Removal method cannot be empty")
    @Before(Tx.class)
    public void transfer(@Para("")CrmBusiness crmBusiness){
        renderJson(crmBusinessService.transfer(crmBusiness));
    }

    /**
     * @author wyq
     * 查询团队成员
     */
    @NotNullValidate(value = "businessId",message = "Opportunity id cannot be empty")
    public void getMembers(@Para("businessId")Integer businessId){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, businessId);
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(R.ok().put("data",crmBusinessService.getMembers(businessId)));
    }

    /**
     * @author wyq
     * 添加团队成员
     */
    @Permissions("crm:business:teamsave")
    @NotNullValidate(value = "ids",message = "Opportunity id cannot be empty")
    @NotNullValidate(value = "memberIds",message = "member id cannot be empty")
    @NotNullValidate(value = "power",message = "Read and write permissions cannot be empty")
    public void addMembers(@Para("")CrmBusiness crmBusiness){
        renderJson(crmBusinessService.addMember(crmBusiness));
    }

    /**
     * @author wyq
     * 编辑团队成员
     */
    @Permissions("crm:business:teamsave")
    @NotNullValidate(value = "ids",message = "Opportunity id cannot be empty")
    @NotNullValidate(value = "memberIds",message = "member id cannot be empty")
    @NotNullValidate(value = "power",message = "Read and write permissions cannot be empty")
    public void updateMembers(@Para("")CrmBusiness crmBusiness){
        renderJson(crmBusinessService.addMember(crmBusiness));
    }

    /**
     * @author wyq
     * 删除团队成员
     */
    @Permissions("crm:business:teamsave")
    @NotNullValidate(value = "ids",message = "Opportunity id cannot be empty")
    @NotNullValidate(value = "memberIds",message = "member id cannot be empty")
    public void deleteMembers(@Para("")CrmBusiness crmBusiness){
        renderJson(crmBusinessService.deleteMembers(crmBusiness));
    }

    /**
     * @author
     * 商机状态组展示
     */
    @NotNullValidate(value = "businessId",message = "Opportunity id cannot be empty")
    public void queryBusinessStatus(@Para("businessId")Integer businessId){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, businessId);
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(R.ok().put("data",crmBusinessService.queryBusinessStatus(businessId)));
    }

    /**
     * @author wyq
     * 商机状态组推进
     */
    @NotNullValidate(value = "businessId",message = "Opportunity id cannot be empty")
    public void boostBusinessStatus(@Para("")CrmBusiness crmBusiness){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, crmBusiness.getBusinessId());
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(crmBusinessService.boostBusinessStatus(crmBusiness));
    }
    /**
     * @author wyq
     * 查询商机状态组及商机状态
     */
    public void queryBusinessStatusOptions(){
        renderJson(R.ok().put("data",crmBusinessService.queryBusinessStatusOptions(null)));
    }

    /**
     * @author wyq
     * 添加跟进记录
     */
    @NotNullValidate(value = "typesId",message = "opportunity id cannot be empty")
    @NotNullValidate(value = "content",message = "The content cannot be empty")
    @NotNullValidate(value = "category",message = "Follow-up type cannot be empty")
    public void addRecord(@Para("")AdminRecord adminRecord){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, adminRecord.getTypesId());
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(crmBusinessService.addRecord(adminRecord));
    }

    /**
     * @author wyq
     * 查看跟进记录
     */
    public void getRecord(BasePageRequest<CrmBusiness> basePageRequest){
        boolean auth = AuthUtil.isCrmAuth(CrmEnum.CRM_BUSINESS, basePageRequest.getData().getBusinessId());
        if(auth){renderJson(R.noAuth()); return; }
        renderJson(R.ok().put("data",crmBusinessService.getRecord(basePageRequest)));
    }


    /**
     * @author wyq
     * 批量导出商机
     */
    @Permissions("crm:business:excelexport")
    public void batchExportExcel(BasePageRequest basePageRequest){
        JSONObject jsonObject=basePageRequest.getJsonObject();
        String ids=jsonObject.getString("ids");
        JSONObject data =new JSONObject();
        data.fluentPut("businessExport",new JSONObject().fluentPut("name","business_id").fluentPut("condition","in").fluentPut("value", ids));
        jsonObject.fluentPut("data",data).fluentPut("search","").fluentPut("type",5);
        basePageRequest.setJsonObject(jsonObject);
        JSONObject resultData = (JSONObject)adminSceneService.getCrmPageList(basePageRequest).get("data");
        List<Record> recordList = resultData.getJSONArray("list").toJavaList(Record.class);
        export(recordList);
        renderNull();
    }

    /**
     * @author wyq
     * 导出全部商机
     */
    @Permissions("crm:business:excelexport")
    public void allExportExcel(BasePageRequest basePageRequest){
        JSONObject jsonObject = basePageRequest.getJsonObject();
        jsonObject.fluentPut("excel", "yes").fluentPut("type", 5);
        AdminSceneService adminSceneService = new AdminSceneService();
        JSONObject data = (JSONObject)adminSceneService.filterConditionAndGetPageList(basePageRequest).get("data");
        List<Record> recordList = data.getJSONArray("list").toJavaList(Record.class);
        export(recordList);
        renderNull();
    }
    private void export(List<Record> recordList){
        try (ExcelWriter writer = ExcelUtil.getWriter()) {
            AdminFieldSort adminFieldSort = new AdminFieldSort();
            adminFieldSort.setLabel(CrmEnum.CRM_BUSINESS.getType());
            List<Record> headList = Aop.get(AdminFieldService.class).queryListHead(adminFieldSort);
            headList.forEach(head -> writer.addHeaderAlias(StrUtil.toUnderlineCase(head.getStr("fieldName")), head.getStr("name")));
            writer.merge(headList.size() - 1, "Opportunity Information");
            HttpServletResponse response = getResponse();
            List<Map<String, Object>> list = new ArrayList<>();
            if (recordList.size() == 0) {
                Record record = new Record();
                headList.forEach(head -> record.set(StrUtil.toUnderlineCase(head.getStr("fieldName")), ""));
                list.add(record.getColumns());
            }
            recordList.forEach(record -> list.add(record.getColumns()));
            writer.setOnlyAlias(true);
            writer.write(list, true);
            writer.setRowHeight(0, 20);
            writer.setRowHeight(1, 20);
            for (int i = 0; i < headList.size(); i++) {
                writer.setColumnWidth(i, 20);
            }
            Cell cell = writer.getCell(0, 0);
            CellStyle cellStyle = cell.getCellStyle();
            cellStyle.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex());
            cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            Font font = writer.createFont();
            font.setBold(true);
            font.setFontHeightInPoints((short) 16);
            cellStyle.setFont(font);
            cell.setCellStyle(cellStyle);
            //自定义标题别名
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            response.setCharacterEncoding("UTF-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition", "attachment;filename=business.xls");
            ServletOutputStream out = response.getOutputStream();
            writer.flush(out);
        } catch (Exception e) {
            Log.getLog(getClass()).error("Export opportunity error：",e);
        }
    }

//    private void export(List<Record> recordList) {
//        try (ExcelWriter writer = ExcelUtil.getWriter()) {
//            AdminFieldSort adminFieldSort = new AdminFieldSort();
//            adminFieldSort.setLabel(CrmEnum.CRM_BUSINESS.getType());
//            List<Record> headList = Aop.get(AdminFieldService.class).queryListHead(adminFieldSort);
//            headList.forEach(head -> writer.addHeaderAlias(StrUtil.toUnderlineCase(head.getStr("fieldName")), head.getStr("name")));
//            writer.merge(headList.size() - 1, "商机信息");
//            HttpServletResponse response = getResponse();
//            List<Map<String, Object>> list = new ArrayList<>();
//            if (recordList.size() == 0) {
//                Record record = new Record();
//                headList.forEach(head -> record.set(head.getStr("fieldName"), ""));
//                list.add(record.getColumns());
//            }
//            recordList.forEach(record -> list.add(record.getColumns()));
//            writer.setOnlyAlias(true);
//            writer.write(list, true);
//            writer.setRowHeight(0, 20);
//            writer.setRowHeight(1, 20);
//            for (int i = 0; i < headList.size(); i++) {
//                writer.setColumnWidth(i, 20);
//            }
//            Cell cell = writer.getCell(0, 0);
//            CellStyle cellStyle = cell.getCellStyle();
//            cellStyle.setFillForegroundColor(IndexedColors.SKY_BLUE.getIndex());
//            cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//            Font font = writer.createFont();
//            font.setBold(true);
//            font.setFontHeightInPoints((short) 16);
//            cellStyle.setFont(font);
//            cell.setCellStyle(cellStyle);
//            //自定义标题别名
//            //response为HttpServletResponse对象
//            response.setContentType("application/vnd.ms-excel;charset=utf-8");
//            response.setCharacterEncoding("UTF-8");
//            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
//            response.setHeader("Content-Disposition", "attachment;filename=business.xls");
//            ServletOutputStream out = response.getOutputStream();
//            writer.flush(out);
//        } catch (Exception e) {
//            Log.getLog(getClass()).error("导出商机错误：",e);
//        }
//    }
}
