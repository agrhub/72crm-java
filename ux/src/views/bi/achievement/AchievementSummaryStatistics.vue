<template>
  <div
    v-loading="loading"
    class="main-container">
    <filtrate-handle-view
      class="filtrate-bar"
      module-type="contract"
      @load="loading=true"
      @change="getDataList"/>
    <div class="content">
      <div class="content-title">Số lượng hợp đồng đã ký:{{ data.count_zong }} lượt；Giá trị hợp đồng：{{ data.money_zong }} đồng；Số tiền thanh toán：{{ data.back_zong }} đồng；Số tiền chưa được trả：{{ data.w_back_zong }} đồng</div>
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
            header-align="center"
            show-overflow-tooltip/>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script>
import { biAchievementSummaryAPI } from '@/api/businessIntelligence/achievement'
import filtrateHandleView from '../components/filtrateHandleView'

export default {
  /** 合同汇总表 */
  name: 'AchievementSummaryStatistics',
  components: {
    filtrateHandleView
  },
  data() {
    return {
      loading: false,
      tableHeight: document.documentElement.clientHeight - 220,
      list: [],
      data: {
        back_zong: 0,
        count_zong: 0,
        money_zong: 0,
        w_back_zong: 0
      },
      fieldList: [
        { field: 'type', name: 'Ngày' },
        { field: 'contractNum', name: 'Số lượng hợp đồng đã ký (lượt)' },
        { field: 'contractMoney', name: 'Số tiền hợp đồng (đồng)' },
        { field: 'receivablesMoney', name: 'Số tiền thanh toán (đồng)' }
      ]
    }
  },
  computed: {},
  mounted() {
    /** 控制table的高度 */
    window.onresize = () => {
      this.tableHeight = document.documentElement.clientHeight - 220
    }
  },
  methods: {
    getDataList(params) {
      this.loading = true
      biAchievementSummaryAPI(params)
        .then(res => {
          const data = res.data
          this.data = {
            back_zong: data.receivablesMoney,
            count_zong: data.contractNum,
            money_zong: data.contractMoney,
            w_back_zong: data.unreceivedMoney
          }
          this.list = data.list || []
          this.loading = false
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
.content-title {
  padding-bottom: 15px;
}
</style>
