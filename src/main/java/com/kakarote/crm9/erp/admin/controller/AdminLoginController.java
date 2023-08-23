package com.kakarote.crm9.erp.admin.controller;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.servlet.ServletUtil;
import com.jfinal.aop.Before;
import com.jfinal.core.paragetter.Para;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.kakarote.crm9.common.config.redis.Redis;
import com.kakarote.crm9.common.config.redis.RedisManager;
import com.kakarote.crm9.common.constant.BaseConstant;
import com.kakarote.crm9.common.interceptor.CORSInterceptor;
import com.kakarote.crm9.erp.admin.entity.AdminUser;
import com.kakarote.crm9.erp.admin.service.AdminRoleService;
import com.kakarote.crm9.utils.BaseUtil;
import com.kakarote.crm9.utils.R;
import com.jfinal.aop.Clear;
import com.jfinal.aop.Inject;
import com.jfinal.core.Controller;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

/**
 * 用户登录
 *
 * @author z
 */
@Clear
@Before(CORSInterceptor.class)
public class AdminLoginController extends Controller{


    @Inject
    private AdminRoleService adminRoleService;

    public final static Prop prop = PropKit.use("config/crm9-config.txt");

    public void index(){
        redirect("/index.html");
    }

    /**
     * @param username 用户名
     * @param password 密码
     * @author zhangzhiwei
     * 用户登录
     */
    public void login(@Para("username") String username, @Para("password") String password){
        String key = BaseConstant.USER_LOGIN_ERROR_KEY + username;
        Redis redis= RedisManager.getRedis();
        long beforeTime = System.currentTimeMillis() - 60 * 5 * 1000;
        if(redis.exists(key)){
            if(redis.zcount(key, beforeTime, System.currentTimeMillis()) >= 5){
                Set zrevrange = redis.zrevrange(key, 4, 5);
                Long time = (Long) zrevrange.iterator().next() + 60 * 5 * 1000;
                long expire = (time - System.currentTimeMillis()) / 1000;
                renderJson(R.error("Too many incorrect passwords, please wait " + expire + ". Retrying in seconds！"));
                return;
            }
        }
        redis.zadd(key, System.currentTimeMillis(), System.currentTimeMillis());
        if(StrUtil.isEmpty(username) || StrUtil.isEmpty(password)){
            renderJson(R.error("Please enter username and password！"));
            return;
        }
        AdminUser user = AdminUser.dao.findFirst(Db.getSql("admin.user.queryByUserName"), username.trim());
        if(user == null){
            renderJson(R.error("Wrong user name or password！"));
            return;
        }
        if(user.getStatus() == 0){
            renderJson(R.error("Account is disabled！"));
            return;
        }
        if(BaseUtil.verify(username + password, user.getSalt(), user.getPassword())){
            if(user.getStatus() == 2){
                user.setStatus(1);
            }
            redis.del(key);
            String token = IdUtil.simpleUUID();
            user.setLastLoginIp(ServletUtil.getClientIP(getRequest()));
            user.setLastLoginTime(new Date());
            user.update();
            user.setRoles(adminRoleService.queryRoleIdsByUserId(user.getUserId()));
            redis.setex(token, 3600, user);
            Integer type=getParaToInt("type",1);
            BaseUtil.setToken(user.getUserId(),token,type);
            user.remove("password", "salt");
            renderJson(R.ok().put("Admin-Token", token).put("user", user).put("auth", adminRoleService.auth(user.getUserId())));
        }else{
            Log.getLog(getClass()).warn("User login failed");
            renderJson(R.error("Wrong user name or password！"));
        }

    }
    /**
     * @author zhangzhiwei
     * 退出登录
     */
    public void logout(){
        String token = BaseUtil.getToken(getRequest());
        if(! StrUtil.isEmpty(token)){
            RedisManager.getRedis().del(token);
            removeCookie("Admin-Token");
        }
        renderJson(R.ok());
    }

    public void version(){
        renderJson(R.ok().put("name", BaseConstant.NAME).put("version", BaseConstant.VERSION));
    }


    public void ping(){
        List<String> arrays = new ArrayList<>();
        Connection connection = null;
        try{
            connection = Db.use().getConfig().getConnection();
            if(connection != null){
                arrays.add("Database connection is successful");
            }
        }catch(Exception e){
            arrays.add("Database connection abnormal");
        }finally{
            if(connection != null){
                try{
                    connection.close();
                }catch(SQLException e){
                    Log.getLog(getClass()).error("",e);
                }
            }

        }
        try{
            String ping = RedisManager.getRedis().ping();
            if("PONG".equals(ping)){
                arrays.add("Redis configuration is successful");
            }else{
                arrays.add("Redis configuration failed");
            }
        }catch(Exception e){
            arrays.add("Redis configuration failed");
        }
        renderJson(R.ok().put("data", arrays));
    }
}
