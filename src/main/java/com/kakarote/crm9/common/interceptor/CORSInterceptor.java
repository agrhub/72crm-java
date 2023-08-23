package com.kakarote.crm9.common.interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class CORSInterceptor implements Interceptor{
    @Override
    public void intercept(Invocation invocation) {
        Controller controller = invocation.getController();
        controller.getResponse().addHeader("Access-Control-Allow-Origin", "*");
        controller.getResponse().addHeader("Access-Control-Allow-Headers", "Content-Type,admin-token");
        controller.getResponse().addHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS");

        invocation.invoke();
    }
}
