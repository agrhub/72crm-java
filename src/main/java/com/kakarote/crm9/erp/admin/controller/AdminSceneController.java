package com.kakarote.crm9.erp.admin.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.kakarote.crm9.common.annotation.NotNullValidate;
import com.kakarote.crm9.common.config.paragetter.BasePageRequest;
import com.kakarote.crm9.erp.admin.entity.AdminScene;
import com.kakarote.crm9.erp.admin.service.AdminSceneService;
import com.jfinal.aop.Inject;
import com.jfinal.core.Controller;
import com.jfinal.core.paragetter.Para;

/**
 * @author wyq
 */
public class AdminSceneController extends Controller {
    @Inject
    private AdminSceneService adminSceneService;

    /**
     * @author wyq
     * @param label 模块类型
     * 查询场景字段
     */
    @NotNullValidate(value = "label",message = "label cannot be empty")
    public void queryField(@Para("label")Integer label){
        renderJson(adminSceneService.queryField(label));
    }

    /**
     * @author wyq
     * 增加场景
     */
    @NotNullValidate(value = "type",message = "type cannot be empty")
    @NotNullValidate(value = "name",message = "Scene name cannot be empty")
    @NotNullValidate(value = "data",message = "data cannot be empty")
    public void addScene(@Para("") AdminScene adminScene){
        renderJson(adminSceneService.addScene(adminScene));
    }

    /**
     * @author wyq
     * 更新场景
     */
    @NotNullValidate(value = "sceneId",message = "Scene id cannot be empty")
    public void updateScene(@Para("")AdminScene adminScene){
        renderJson(adminSceneService.updateScene(adminScene));
    }

    /**
     * @author wyq
     * @param sceneId 场景id
     * 设置默认场景
     */
    @NotNullValidate(value = "sceneId",message = "Scene id cannot be empty")
    public void setDefaultScene(@Para("sceneId")Integer sceneId){
        renderJson(adminSceneService.setDefaultScene(sceneId));
    }

    /**
     * @author wyq
     * 删除场景
     */
    @NotNullValidate(value = "sceneId",message = "Scene id cannot be empty")
    public void deleteScene(@Para("")AdminScene adminScene){
        renderJson(adminSceneService.deleteScene(adminScene));
    }

    /**
     * @author wyq
     * 查询场景
     */
    @NotNullValidate(value = "type",message = "type cannot be empty")
    public void queryScene(@Para("type") Integer type){
        renderJson(adminSceneService.queryScene(type));
    }

    /**
     * @author wyq
     * 查询场景设置
     */
    @NotNullValidate(value = "type",message = "type cannot be empty")
    public void querySceneConfig(@Para("") AdminScene adminScene){
        renderJson(adminSceneService.querySceneConfig(adminScene));
    }

    /**
     * @author wyq
     * 设置场景
     */
    @NotNullValidate(value = "type",message = "type cannot be empty")
    @NotNullValidate(value = "noHideIds",message = "The display scene cannot be empty")
    public void sceneConfig(@Para("") AdminScene adminScene){
        renderJson(adminSceneService.sceneConfig(adminScene));
    }

    /**
     * @author wyq
     * Crm列表页查询
     */
    public void queryPageList(BasePageRequest basePageRequest){
        renderJson(adminSceneService.filterConditionAndGetPageList(basePageRequest));
    }
}
