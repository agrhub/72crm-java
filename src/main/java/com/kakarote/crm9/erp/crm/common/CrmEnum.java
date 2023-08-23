package com.kakarote.crm9.erp.crm.common;

public enum CrmEnum {
    /**
     * CRM Enum
     */
    CRM_LEADS("crm_leads",1,"leads"),
    CRM_CUSTOMER("crm_customer",2,"customer"),
    CRM_CONTACTS("crm_contacts",3,"contacts"),
    CRM_PRODUCT("crm_product", 4,"product"),
    CRM_BUSINESS("crm_business",5,"business opportunity"),
    CRM_CONTRACT("crm_contract",6,"contract"),
    CRM_RECEIVABLES("crm_receivables",7,"Receipt"),
    CRM_RECEIVABLES_PLAN("crm_receivables_plan",8,"Receipt Plan"),
    CRM_CUSTOMER_POOL("crm_customer_pool",9,"Customer High Seas"),
    CRM_NULL("NULL",0,"NULL")
    ;

    private final String name;
    private final int  type;
    private final String remarks;

    CrmEnum(String name, int type,String remarks) {
        this.name = name;
        this.type = type;
        this.remarks = remarks;
    }
    public static CrmEnum parse(int type) {
        for (CrmEnum Enum : CrmEnum.values()) {
            if (Enum.getType()==type) {
                return Enum;
            }
        }
        return CRM_NULL;
    }

    public static CrmEnum parse(String name) {
        for (CrmEnum Enum : CrmEnum.values()) {
            if (Enum.getName().equals(name)) {
                return Enum;
            }
        }
        return CRM_NULL;
    }

    public String getName() {
        return name;
    }

    public int getType() {
        return type;
    }

    public String getRemarks() {
        return remarks;
    }

}
