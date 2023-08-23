<template>
  <div
    v-loading="loading"
    class="main-container">
    <filtrate-handle-view
      class="filtrate-bar"
      module-type="oa"
      @load="loading=true"
      @change="getDataList">
      <el-button
        class="export-button"
        type="primary"
        @click.native="exportExcel">Xuất báo cáo</el-button>
    </filtrate-handle-view>
    <div class="content">
      <div class="table-content">
        <el-table
          :data="list"
          :height="tableHeight"
          stripe
          border
          highlight-current-row>
          <el-table-column
            v-for="(item, index) in fieldList"
            :key="index"
            :prop="item.field"
            :label="item.name"
            align="center"
            header-align="center"/>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script>
import {
  biLogStatisticsAPI,
  biLogExcelExportAPI
} from '@/api/businessIntelligence/oa'
import filtrateHandleView from '../components/filtrateHandleView'

export default {
  /** 日志统计表 */
  name: 'LogStatistics',

  components: {
    filtrateHandleView
  },

  data() {
    return {
      loading: false,
      tableHeight: document.documentElement.clientHeight - 190,
      postParams: {},
      list: [],
      fieldList: [
        { field: 'realname', name: 'Nhân viên' },
        { field: 'count', name: 'Số lượng' },
        { field: 'unReadCont', name: 'Người nhận không đọc' },
        { field: 'unCommentCount', name: 'Không phản hồi' },
        { field: 'commentCount', name: 'Số lượng phản hồi' }
      ]
    }
  },

  mounted() {
    /** 控制table的高度 */
    window.onresize = () => {
      this.tableHeight = document.documentElement.clientHeight - 190
    }
  },

  methods: {
    /**
     * 列表数据
     */
    getDataList(params) {
      this.postParams = params
      this.loading = true
      biLogStatisticsAPI(params)
        .then(res => {
          this.list = res.data || []
          this.loading = false
        })
        .catch(() => {
          this.loading = false
        })
    },

    /**
     * 导出
     */
    exportExcel() {
      this.loading = true
      biLogExcelExportAPI(this.postParams)
        .then(res => {
          this.loading = false
          var blob = new Blob([res.data], {
            type: 'application/vnd.ms-excel;charset=utf-8'
          })
          var downloadElement = document.createElement('a')
          var href = window.URL.createObjectURL(blob) // 创建下载的链接
          downloadElement.href = href
          downloadElement.download =
            decodeURI(
              res.headers['content-disposition'].split('filename=')[1]
            ) || '' // 下载后文件名
          document.body.appendChild(downloadElement)
          downloadElement.click() // 点击下载
          document.body.removeChild(downloadElement) // 下载完成移除元素
          window.URL.revokeObjectURL(href) // 释放掉blob对象
        })
        .catch(() => {
          this.loading = false
        })
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
@import '../styles/detail.scss';
</style>
