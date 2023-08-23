/** 商业智能管理路由 */
import Layout from '@/views/layout/businessLayout'

// 员工客户分析
const customerAuth = {
  requiresAuth: true,
  index: 1,
  type: 'bi',
  subType: 'customer'
}

const customerRouter = {
  path: 'customer',
  meta: {
    icon: 'employeestatistics',
    title: 'Phân tích KH theo nhân viên',
    ...customerAuth
  },
  hidden: false,
  children: [{
    path: 'customerTotal', // 客户总量分析
    component: () => import('@/views/businessIntelligence/customer/CustomerTotalStatistics'),
    meta: {
      title: 'Tổng số khách hàng',
      ...customerAuth
    }
  }, {
    path: 'customerRecord', // 客户跟进次数分析
    component: () => import('@/views/businessIntelligence/customer/CustomerRecordStatistics'),
    meta: {
      title: 'Liên lạc khách hàng',
      ...customerAuth
    }
  }, {
    path: 'customerRecordmode', // 客户跟进方式分析
    component: () => import('@/views/businessIntelligence/customer/CustomerRecordModeStatistics'),
    meta: {
      title: 'Phương pháp liên lạc KH',
      ...customerAuth
    }
  }, {
    path: 'customerConversion', // 客户转化率分析
    component: () => import('@/views/businessIntelligence/customer/CustomerConversionStatistics'),
    meta: {
      title: 'Tỷ lệ chuyển đổi KH',
      ...customerAuth
    }
  }, {
    path: 'customerPool', // 公海客户分析
    component: () => import('@/views/businessIntelligence/customer/CustomerPoolStatistics'),
    meta: {
      title: 'Khách hàng đầu vào',
      ...customerAuth
    }
  }, {
    path: 'customerCycle', // 成交周期分析
    component: () => import('@/views/businessIntelligence/customer/CustomerCycleStatistics'),
    meta: {
      title: 'Chu kỳ giao dịch',
      ...customerAuth
    }
  }]
}

// 销售漏斗分析
const businessAuth = {
  requiresAuth: true,
  index: 1,
  type: 'bi',
  subType: 'business'
}

const businessRouter = {
  path: 'business',
  meta: {
    icon: 'funnelstatistics',
    title: 'Phân tích phễu bán hàng',
    ...businessAuth
  },
  hidden: false,
  children: [{
    path: 'funnelstatistics', // 销售漏斗
    component: () => import('@/views/businessIntelligence/business/FunnelStatistics'),
    meta: {
      title: 'Phễu bán hàng',
      ...businessAuth
    }
  }, {
    path: 'businessTrend', // 新增商机分析
    component: () => import('@/views/businessIntelligence/business/BusinessTrendStatistics'),
    meta: {
      title: 'Xu hướng mua hàng',
      ...businessAuth
    }
  }, {
    path: 'businessWin', // 商机转化率分析
    component: () => import('@/views/businessIntelligence/business/BusinessWinStatistics'),
    meta: {
      title: 'Tỷ lệ chuyển đổi cơ hội',
      ...businessAuth
    }
  }]
}

// 员工业绩分析
const achievementAuth = {
  requiresAuth: true,
  index: 1,
  type: 'bi',
  subType: 'contract'
}

const achievementRouter = {
  path: 'achievement',
  meta: {
    icon: 'BI_Employee_performance',
    title: 'Phân tích hiệu suất của nhân viên',
    ...achievementAuth
  },
  hidden: false,
  children: [{
    path: 'achievementCount', // 合同数量分析
    component: () => import('@/views/businessIntelligence/achievement/AchievementCountStatistics'),
    meta: {
      title: 'Số lượng hợp đồng',
      ...achievementAuth
    }
  }, {
    path: 'achievementMoney', // 合同金额分析
    component: () => import('@/views/businessIntelligence/achievement/AchievementMoneyStatistics'),
    meta: {
      title: 'Số tiền hợp đồng',
      ...achievementAuth
    }
  }, {
    path: 'achievementBack', // 回款金额分析
    component: () => import('@/views/businessIntelligence/achievement/AchievementBackStatistics'),
    meta: {
      title: 'Số tiền nhận được',
      ...achievementAuth
    }
  }, {
    path: 'achievementSummary', // 合同汇总表
    component: () => import('@/views/businessIntelligence/achievement/AchievementSummaryStatistics'),
    meta: {
      title: 'Thống kê hợp đồng',
      ...achievementAuth
    }
  }]
}

// 客户画像分析
const portraitAuth = {
  requiresAuth: true,
  index: 1,
  type: 'bi',
  subType: 'portrait'
}

const portrayalRouter = {
  path: 'portrayal',
  meta: {
    icon: 'customer',
    title: 'Phân tích nhân khẩu học khách hàng',
    ...portraitAuth
  },
  hidden: false,
  children: [{
    path: 'portrayalAddress', // 城市分布分析
    component: () => import('@/views/businessIntelligence/customerPortrayal/CustomerAddressStatistics'),
    meta: {
      title: 'Theo khu vực',
      ...portraitAuth
    }
  }, {
    path: 'portrayalIndustry/:type', // 客户行业分析
    component: () => import('@/views/businessIntelligence/customerPortrayal/CustomerPortrayalStatistics'),
    meta: {
      title: 'Theo ngành nghề',
      ...portraitAuth
    }
  }]
}

const portrayalRouterMenu = {
  path: 'portrayal',
  meta: {
    icon: 'customer',
    title: 'Phân tích nhân khẩu học khách hàng',
    ...portraitAuth
  },
  hidden: false,
  children: [{
    path: 'portrayalAddress', // 城市分布分析
    component: () => import('@/views/businessIntelligence/customerPortrayal/CustomerAddressStatistics'),
    meta: {
      title: 'Theo khu vực',
      ...portraitAuth
    }
  }, {
    path: 'portrayalIndustry/industry', // 客户行业分析
    component: () => import('@/views/businessIntelligence/customerPortrayal/CustomerPortrayalStatistics'),
    meta: {
      title: 'Theo ngành nghề',
      ...portraitAuth
    }
  }, {
    path: 'portrayalIndustry/level', // 客户级别分析
    component: () => import('@/views/businessIntelligence/customerPortrayal/CustomerPortrayalStatistics'),
    meta: {
      title: 'Theo cấp bậc',
      ...portraitAuth
    }
  }, {
    path: 'portrayalIndustry/source', // 客户来源分析
    component: () => import('@/views/businessIntelligence/customerPortrayal/CustomerPortrayalStatistics'),
    meta: {
      title: 'Theo nguồn khách hàng',
      ...portraitAuth
    }
  }]
}

// 产品分析
const productAuth = {
  requiresAuth: true,
  index: 1,
  type: 'bi',
  subType: 'product'
}

const productRouter = {
  path: 'product',
  meta: {
    icon: 'productstatistics',
    title: 'Phân tích sản phẩm',
    ...productAuth
  },
  hidden: false,
  children: [{
    path: 'productstatistics', // 产品销售情况统计
    component: () => import('@/views/businessIntelligence/product/ProductStatistics'),
    meta: {
      title: 'Theo sản phẩm bán ra',
      icon: 'productstatistics',
      ...productAuth
    }
  }, {
    path: 'productCategory', // 产品分类销量分析
    component: () => import('@/views/businessIntelligence/product/ProductCategoryStatistics'),
    meta: {
      title: 'Theo danh mục sản phẩm',
      icon: 'productstatistics',
      ...productAuth
    }
  }]
}

// 排行榜
const rankingAuth = {
  requiresAuth: true,
  index: 1,
  type: 'bi',
  subType: 'ranking'
}

const rankingRouter = {
  path: 'ranking',
  meta: {
    icon: 'BI_Leaderboard',
    title: 'Bảng xếp hạng',
    ...rankingAuth
  },
  hidden: false,
  children: [{
    path: 'rankingContract', // 合同金额排行
    component: () => import('@/views/businessIntelligence/ranking/RankingContractStatistics'),
    meta: {
      title: 'Số tiền hợp đồng',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingReceivables', // 回款金额排行
    component: () => import('@/views/businessIntelligence/ranking/RankingReceivablesStatistics'),
    meta: {
      title: 'Số tiền thanh toán',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingSigning', // 签约合同排行
    component: () => import('@/views/businessIntelligence/ranking/RankingSigningStatistics'),
    meta: {
      title: 'Các hợp đồng đã ký',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingProduct', // 产品销量排行
    component: () => import('@/views/businessIntelligence/ranking/RankingProductStatistics'),
    meta: {
      title: 'Sản phẩm bán',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingAddCustomer', // 新增客户数排行
    component: () => import('@/views/businessIntelligence/ranking/RankingAddCustomerStatistics'),
    meta: {
      title: 'Khách hàng mới',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingAddContacts', // 新增联系人数排行
    component: () => import('@/views/businessIntelligence/ranking/RankingAddContactsStatistics'),
    meta: {
      title: 'Thông tin liên hệ mới',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingRecordNun', // 跟进次数排行
    component: () => import('@/views/businessIntelligence/ranking/RankingRecordNunStatistics'),
    meta: {
      title: 'Lượt liên lạc',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingRecordCustomer', // 跟进客户数排行
    component: () => import('@/views/businessIntelligence/ranking/RankingRecordCustomerStatistics'),
    meta: {
      title: 'Xếp hạng khách hàng',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }, {
    path: 'rankingExamine', // 出差次数排行
    component: () => import('@/views/businessIntelligence/ranking/RankingExamineStatistics'),
    meta: {
      title: 'Xếp hạng các đề xuất',
      icon: 'productstatistics',
      ...rankingAuth
    }
  }]
}

// oa分析
const oaAuth = {
  requiresAuth: false,
  index: 1,
  type: 'bi',
  subType: 'oa'
}

const oaRouter = {
  path: 'oa',
  meta: {
    icon: 'oa_analysis',
    title: 'Phân tích khối văn phòng',
    ...oaAuth
  },
  hidden: false,
  children: [{
    path: 'log', // 日志分析
    component: () => import('@/views/businessIntelligence/oa/log'),
    meta: {
      title: 'Nhật ký',
      ...oaAuth
    }
  }, {
    path: 'examine', // 审批分析
    component: () => import('@/views/businessIntelligence/oa/examine'),
    meta: {
      title: 'Đề xuất',
      ...oaAuth
    }
  }]
}


const taskCompleteRouteItem = {
  path: 'taskCompletestatistics', // 业绩目标完成情况
  component: () => import('@/views/businessIntelligence/TaskCompleteStatistics'),
  meta: {
    requiresAuth: true,
    title: 'Thành tích',
    icon: 'taskCompletestatistics',
    index: 1,
    type: 'bi',
    subType: 'achievement'
  }
}


export const biRouter = {
  path: '/bi',
  component: Layout,
  redirect: '/bi/customerTotal',
  name: 'bi',
  hidden: true,
  meta: {
    requiresAuth: true,
    title: 'Kinh doanh thông minh',
    index: 0,
    type: 'bi'
  },
  children: [
    ...customerRouter.children,
    ...businessRouter.children,
    ...achievementRouter.children,
    ...portrayalRouter.children,
    ...productRouter.children,
    ...rankingRouter.children,
    ...oaRouter.children,
    taskCompleteRouteItem
  ]
}

export const biRouterMenu = [
  customerRouter,
  businessRouter,
  achievementRouter,
  portrayalRouterMenu,
  productRouter,
  rankingRouter,
  oaRouter,
  taskCompleteRouteItem
]
