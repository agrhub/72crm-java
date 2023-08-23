package com.kakarote.crm9.erp.oa.common;

public enum OaEnum {
    /**
     * OaEnum
     */
    COMMENT_TYPE_KEY( "Comment", 6),
    LOG_TYPE_KEY ("Log", 1 ),
    EXAMINE_TYPE_KEY ("Approval", 5 ),
    TASK_TYPE_KEY ("Task", 4 ),
    EVENT_TYPE_KEY ("Agenda", 2 ),
    ANNOUNCEMENT_TYPE_KEY ("Announcement", 3 ),
    ALL_TYPE_KEY ("All", 0 );
    private String name;
    private Integer types;

    OaEnum(String name, Integer types) {
        this.name = name;
        this.types = types;
    }

    public static String getName(Integer types) {
        for (OaEnum c : OaEnum.values ()) {
            if ( c.getTypes ().equals ( types ) ) {
                return c.name;
            }
        }
        return null;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getTypes() {
        return types;
    }

    public void setTypes(Integer types) {
        this.types = types;
    }

}
