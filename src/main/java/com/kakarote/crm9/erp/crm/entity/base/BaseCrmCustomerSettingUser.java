package com.kakarote.crm9.erp.crm.entity.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseCrmCustomerSettingUser<M extends BaseCrmCustomerSettingUser<M>> extends Model<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return getInt("id");
	}

	public void setSettingId(java.lang.Integer settingId) {
		set("setting_id", settingId);
	}

	public java.lang.Integer getSettingId() {
		return getInt("setting_id");
	}

	public void setUserId(java.lang.Long userId) {
		set("user_id", userId);
	}

	public java.lang.Long getUserId() {
		return getLong("user_id");
	}

	public void setDeptId(java.lang.Integer deptId) {
		set("dept_id", deptId);
	}

	public java.lang.Integer getDeptId() {
		return getInt("dept_id");
	}

	public void setType(java.lang.Integer type) {
		set("type", type);
	}

	public java.lang.Integer getType() {
		return getInt("type");
	}

}