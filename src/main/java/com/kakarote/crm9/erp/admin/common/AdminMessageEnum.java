package com.kakarote.crm9.erp.admin.common;


/**
 * 消息通知枚举类
 */
public enum AdminMessageEnum {

    NULL(0,"NULL"),
    OA_TASK_ALLOCATION(1,"Task assigned to me"),
    OA_TASK_JOIN(2,"The task I participated in"),
    OA_TASK_OVER(3,"Task end notification"),
    OA_LOG_REPLY(4,"Log Reply Reminder"),
    OA_LOG_SEND(5,"Log sending reminder"),
    OA_EXAMINE_REJECT(6,"OA approval rejection reminder"),
    OA_EXAMINE_PASS(7,"OA Approval Approval Reminder"),
    OA_NOTICE_MESSAGE(8,"Announcement notification reminder"),
    OA_EVENT_MESSAGE(9,"Schedule Notification"),
    CRM_CONTRACT_REJECT(10, "Notice of Contract Rejection"),
    CRM_CONTRACT_PASS(11, "Notice of all contract approval"),
    CRM_RECEIVABLES_REJECT(12,"Notice of Rejection of Payment"),
    CRM_RECEIVABLES_PASS(13,"Receipt through notification"),
    CRM_CUSTOMER_IMPORT(14,"Import Customer Notification"),
    CRM_CUSTOMER_IMPORT_CANCEL(15,"Import customer cancellation notice"),
    CRM_CONTACTS_IMPORT(16,"Import Contact Notification"),
    CRM_CONTACTS_IMPORT_CANCEL(17,"Import contact cancellation notification"),
    CRM_LEADS_IMPORT(18,"Import Lead Notification"),
    CRM_LEADS_IMPORT_CANCEL(19,"Import lead cancellation notice"),
    CRM_PRODUCT_IMPORT(20,"Import Product Notification"),
    CRM_PRODUCT_IMPORT_CANCEL(21,"Import product cancellation notice"),
    CRM_BUSINESS_USER(22,"Business Opportunity Team Member Notification"),
    CRM_CUSTOMER_USER(23,"Customer Team Member Notification"),
    CRM_CONTRACT_USER(24,"Contract team member notification")
    ;

    AdminMessageEnum(Integer type,String remarks){
        this.type=type;
        this.remarks=remarks;
    }
    private final int  type;
    private final String remarks;

    public int getType() {
        return type;
    }

    public String getRemarks() {
        return remarks;
    }

    public static AdminMessageEnum parse(int type) {
        for (AdminMessageEnum Enum : AdminMessageEnum.values()) {
            if (Enum.getType()==type) {
                return Enum;
            }
        }
        return NULL;
    }
}
