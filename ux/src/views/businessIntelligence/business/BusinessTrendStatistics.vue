<template>
  <div
    v-loading="loading"
    class="main-container">
    <filtrate-handle-view
      class="filtrate-bar"
      module-type="business"
      @load="loading=true"
      @change="searchClick"/>
    <div class="content">
      <div class="axis-content">
        <div id="axismain"/>
      </div>
      <div class="table-content">
        <el-table
          :data="list"
          height="400"
          stripe
          border
          highlight-current-row>
          <el-table-column
            v-for="(item, index) in fieldList"
            :key="index"
            :prop="item.field"
            :label="item.name"
            align="center"
            header-align="center"
            show-overflow-tooltip/>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script>
import base from '../mixins/base'
import echarts from 'echarts'
import {
  biBusinessTrendAPI,
  biBusinessTrendListAPI
} from '@/api/businessIntelligence/business'

export default {
  /** 新增商机数与金额趋势分析 */
  name: 'BusinessTrendStatistics',
  mixins: [base],
  data() {
    return {
      loading: false,
      axisOption: null,
      axisChart: null,

      list: [],

      postParams: {}, // 筛选参数
      axisList: [],
      fieldList: [
        { field: 'businessName', name: 'Tên cơ hội' },
        { field: 'customerName', name: 'Tên khách hàng' },
        { field: 'typeName', name: 'Nhóm trạng thái cơ hội' },
        { field: 'statusName', name: 'Giai đoạn cơ hội' },
        { field: 'money', name: 'Số tiền cơ hội' },
        { field: 'dealDate', name: 'Ngày kết thúc dự kiến' },
        { field: 'ownerUserName', name: 'Người phụ trách' },
        { field: 'createTime', name: 'Ngày tạo' }
      ]
    }
  },
  computed: {},
  mounted() {
    this.initAxis()
  },
  methods: {
    /**
     * 搜索点击
     */
    searchClick(params) {
      this.postParams = params
      this.getDataList()
      this.getRecordList()
    },
    /**
     * 图表数据
     */
    getDataList() {
      this.loading = true
      biBusinessTrendAPI(this.postParams)
        .then(res => {
          this.loading = false
          this.axisList = res.data || []

          const moneyCounts = []
          const numCounts = []
          const xAxis = []
          for (let index = 0; index < this.axisList.length; index++) {
            const element = this.axisList[index]
            moneyCounts.push(element.businessMoney)
            numCounts.push(element.businessNum)
            xAxis.push(element.type)
          }
          this.axisOption.xAxis[0].data = xAxis
          this.axisOption.series[0].data = moneyCounts
          this.axisOption.series[1].data = numCounts
          this.axisChart.setOption(this.axisOption, true)
        })
        .catch(() => {
          this.loading = false
        })
    },
    /**
     * 获取相关列表
     */
    getRecordList(dataIndex) {
      this.list = []

      let params = {}

      if (typeof dataIndex !== 'undefined') {
        const dataItem = this.axisList[dataIndex]
        params.userId = this.postParams.userId
        params.deptId = this.postParams.deptId
        params.startTime = dataItem.startTime
        params.endTime = dataItem.endTime
      } else {
        params = this.postParams
      }

      this.loading = true
      biBusinessTrendListAPI(params)
        .then(res => {
          this.loading = false
          this.list = res.data
        })
        .catch(() => {
          this.loading = false
        })
    },
    /** 柱状图 */
    initAxis() {
      var axisChart = echarts.init(document.getElementById('axismain'))

      var option = {
        color: ['#6ca2ff', '#ff7474'],
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            // 坐标轴指示器，坐标轴触发有效
            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
          }
        },
        legend: {
          data: ['Số lượng cơ hội kinh doanh mới', 'Số lượng cơ hội kinh doanh mới'],
          bottom: '0px',
          itemWidth: 14
        },
        grid: {
          top: '40px',
          left: '40px',
          right: '40px',
          bottom: '40px',
          containLabel: true,
          borderColor: '#fff'
        },
        xAxis: [
          {
            type: 'category',
            data: [],
            axisTick: {
              alignWithLabel: true,
              lineStyle: { width: 0 }
            },
            axisLabel: {
              color: '#BDBDBD'
            },
            /** 坐标轴轴线相关设置 */
            axisLine: {
              lineStyle: { color: '#BDBDBD' }
            },
            splitLine: {
              show: false
            }
          }
        ],
        yAxis: [
          {
            type: 'value',
            name: 'Cơ hội kinh doanh mới',
            axisTick: {
              alignWithLabel: true,
              lineStyle: { width: 0 }
            },
            axisLabel: {
              color: '#BDBDBD',
              formatter: '{value}triệu đồng'
            },
            /** 坐标轴轴线相关设置 */
            axisLine: {
              lineStyle: { color: '#BDBDBD' }
            },
            splitLine: {
              show: false
            }
          },
          {
            type: 'value',
            name: 'Số lượng cơ hội kinh doanh mới',
            axisTick: {
              alignWithLabel: true,
              lineStyle: { width: 0 }
            },
            axisLabel: {
              color: '#BDBDBD',
              formatter: '{value}lượt'
            },
            /** 坐标轴轴线相关设置 */
            axisLine: {
              lineStyle: { color: '#BDBDBD' }
            },
            splitLine: {
              show: false
            }
          }
        ],
        series: [
          {
            name: 'Cơ hội kinh doanh mới',
            type: 'line',
            yAxisIndex: 0,
            data: []
          },
          {
            name: 'Số lượng cơ hội kinh doanh mới',
            type: 'line',
            yAxisIndex: 1,
            data: []
          }
        ]
      }

      axisChart.setOption(option, true)
      axisChart.on('click', params => {
        // seriesIndex	1：新增商机金额 2:新增商机数量  dataIndex 具体的哪条数据
        this.getRecordList(params.dataIndex)
      })
      this.axisOption = option
      this.axisChart = axisChart
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
@import '../styles/detail.scss';
</style>
