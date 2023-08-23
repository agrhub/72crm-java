/** 项目管理路由 */
import Layout from '@/views/layout/managerLayout'

/**
 * 系统管理里的 客户管理
 */
const systemCustomerRouter = {
  name: 'system-customer',
  path: 'system-customer',
  meta: {
    title: 'Khách hàng',
    icon: 'customer',
    requiresAuth: true,
    index: 1,
    type: 'manage',
    subType: 'crm'
  },
  children: [{
    path: 'custom-field',
    component: () => import('@/views/SystemManagement/SystemCustomer/customField'),
    meta: {
      title: 'Cài đặt trường thông tin KH',
      requiresAuth: true,
      index: 2,
      type: 'manage',
      subType: ['crm', 'field']
    }
  }, {
    path: 'customer',
    component: () => import('@/views/SystemManagement/SystemCustomer/customer'),
    meta: {
      title: 'Cài đặt quy tắc phân loại KH',
      requiresAuth: true,
      index: 2,
      type: 'manage',
      subType: ['crm', 'pool']
    }
  }, {
    path: 'biz-param',
    component: () => import('@/views/SystemManagement/SystemCustomer/bizParam'),
    meta: {
      title: 'Cài đặt thông số kinh doanh',
      requiresAuth: true,
      index: 2,
      type: 'manage',
      subType: ['crm', 'setting']
    }
  }, {
    path: 'biz-goals',
    component: () => import('@/views/SystemManagement/SystemCustomer/bizGoals'),
    meta: {
      title: 'Cài đặt KPIs kinh doanh',
      requiresAuth: true,
      index: 2,
      type: 'manage',
      subType: ['crm', 'achievement']
    }
  }]
}

/**
 * 不包含children的路由
 */
const systemEmployeeRouter = {
  path: '/manager',
  component: Layout,
  redirect: '/manager/systemconfig',
  name: 'manager',
  meta: {
    requiresAuth: true,
    title: 'Quản lý hệ thống',
    index: 0,
    type: 'manage'
  },
  children: [{
    name: 'systemconfig',
    path: 'systemconfig', // 企业首页
    component: () => import('@/views/SystemManagement/SystemConfig/index'),
    meta: {
      requiresAuth: true,
      title: 'Thông tin công ty',
      icon: 'systemconfig',
      index: 2,
      type: 'manage',
      subType: ['system', 'read']
    }
  },
  {
    name: 'application',
    path: 'application', // 应用管理
    component: () => import('@/views/SystemManagement/application/index'),
    meta: {
      requiresAuth: true,
      title: 'Ứng dụng',
      icon: 'product',
      index: 2,
      type: 'manage',
      subType: ['configSet', 'read']
    }
  },
  {
    name: 'employee-dep',
    path: 'employee-dep', // 员工与部门管理
    component: () => import('@/views/SystemManagement/SystemEmployee/EmployeeDepManagement'),
    meta: {
      requiresAuth: true,
      title: 'Phòng ban & Nhân viên',
      icon: 'department',
      index: 2,
      type: 'manage',
      subType: ['users', 'read']
    }
  }
  ]
}

const authRouter = {
  path: '/role-auth',
  component: Layout,
  name: 'role-auth',
  meta: {
    requiresAuth: true,
    title: 'Quyền',
    index: 1,
    type: 'manage',
    subType: 'permission'
  },
  children: [{
    name: 'role-auth',
    path: 'role-auth/:pid/:title',
    component: () => import('@/views/SystemManagement/roleAuth/index'),
    meta: {
      requiresAuth: true,
      title: 'Thông tin liên lạc',
      icon: 'contacts',
      index: 1,
      type: 'manage',
      subType: 'permission'
    }
  }
  ]
}

const authMenuRouter = {
  path: '/role-auth',
  component: Layout,
  name: 'role-auth',
  meta: {
    requiresAuth: true,
    title: 'Vai trò',
    icon: 'contacts',
    index: 1,
    type: 'manage',
    subType: 'permission'
  },
  children: [
  ]
}

const examineWorkbenchRouter = {
  path: '/manager',
  component: Layout,
  redirect: '/manager/systemconfig',
  name: 'manager',
  meta: {
    requiresAuth: true,
    title: 'Quản lý hệ thống',
    index: 0,
    type: 'manage'
  },
  children: [
    {
      name: 'system-examine',
      path: 'system-examine',
      component: () => import('@/views/SystemManagement/SystemExamine/SystemExamine'),
      meta: {
        requiresAuth: true,
        title: 'Quy trình kinh doanh',
        icon: 'examine',
        index: 1,
        type: 'manage',
        subType: 'examineFlow'
      }
    },
    {
      name: 'system-workbench',
      path: 'system-workbench', // 工作台
      component: () => import('@/views/SystemManagement/SystemWorkbench'),
      meta: {
        requiresAuth: true,
        title: 'Quy trình nội bộ',
        icon: 'workbench',
        index: 1,
        type: 'manage',
        subType: 'oa'
      }
    },
    {
      name: 'system-project',
      path: 'system-project', // 项目管理
      component: () => import('@/views/SystemManagement/project'),
      meta: {
        requiresAuth: true,
        title: 'Dự án',
        icon: 'project',
        index: 1,
        type: 'manage',
        subType: 'work'
      }
    }
  ]
}

const handlefieldRouter = {
  name: 'handlefield',
  path: 'custom-field/handlefield/:type/:id:label', // type customer contacts business contract money
  component: () => import('@/views/SystemManagement/SystemCustomer/HandleField'),
  meta: {
    changeMenu: false, // 跳转不更改路径
    menuSelct: 'system-customer'
  },
  hidden: true
}

export const managerRouter = {
  path: '/manager',
  component: Layout,
  redirect: '/manager/systemconfig',
  name: 'manager',
  hidden: true,
  meta: {
    requiresAuth: true,
    title: 'Quản lý hệ thống',
    index: 0,
    type: 'manage'
  },
  children: [
    ...systemEmployeeRouter.children,
    ...authRouter.children,
    ...examineWorkbenchRouter.children,
    ...systemCustomerRouter.children,
    handlefieldRouter
  ]
}

export const managerRouterMenu = [
  ...systemEmployeeRouter.children,
  authMenuRouter,
  ...examineWorkbenchRouter.children,
  systemCustomerRouter
]
