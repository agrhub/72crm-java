<template>
  <div
    v-empty="nopermission"
    class="rc-cont"
    xs-empty-icon="nopermission"
    xs-empty-text="Không có quyền">
    <flexbox
      v-if="!isSeas"
      class="rc-head"
      direction="row-reverse">
      <el-button
        class="rc-head-item"
        type="primary"
        @click.native="createClick">Tạo hợp đồng mới
      </el-button>
    </flexbox>
    <el-table
      :data="list"
      :height="tableHeight"
      :header-cell-style="headerRowStyle"
      :cell-style="cellStyle"
      stripe
      style="width: 100%;border: 1px solid #E6E6E6;"
      @row-click="handleRowClick">
      <el-table-column
        v-for="(item, index) in fieldList"
        :key="index"
        :prop="item.prop"
        :formatter="fieldFormatter"
        :label="item.label"
        show-overflow-tooltip/>
    </el-table>
    <c-r-m-full-screen-detail
      :visible.sync="showFullDetail"
      :id="contractId"
      crm-type="contract"/>
    <c-r-m-create-view
      v-if="isCreate"
      :action="createActionInfo"
      crm-type="contract"
      @save-success="createSaveSuccess"
      @hiden-view="isCreate=false"/>
  </div>
</template>

<script type="text/javascript">
import loading from '../mixins/loading'
import CRMCreateView from './CRMCreateView'
import { crmCustomerQueryContract } from '@/api/customermanagement/customer'
import { crmBusinessQueryContract } from '@/api/customermanagement/business'
import { moneyFormat } from '@/utils'

export default {
  name: 'RelativeContract', // 相关联系人  可能再很多地方展示 放到客户管理目录下
  components: {
    CRMFullScreenDetail: () => import('./CRMFullScreenDetail.vue'),
    CRMCreateView
  },
  mixins: [loading],
  props: {
    /** 模块ID */
    id: [String, Number],
    /** 没有值就是全部类型 有值就是当个类型 */
    crmType: {
      type: String,
      default: ''
    },
    /** 是公海 默认是客户 */
    isSeas: {
      type: Boolean,
      default: false
    },
    /** 联系人人下 新建商机 需要联系人里的客户信息  合同下需要客户和商机信息 */
    detail: {
      type: Object,
      default: () => {
        return {}
      }
    }
  },
  data() {
    return {
      nopermission: false,
      list: [],
      fieldList: [],
      tableHeight: '400px',
      showFullDetail: false,
      isCreate: false, // 控制新建
      contractId: '', // 查看全屏联系人详情的 ID
      // 创建的相关信息
      createActionInfo: { type: 'relative', crmType: this.crmType, data: {}}
    }
  },
  computed: {},
  watch: {
    id: function(val) {
      this.list = []
      this.getDetail()
    }
  },
  mounted() {
    this.getDetail()
  },
  activated: function() {},
  deactivated: function() {},
  methods: {
    getFieldList() {
      this.fieldList.push({ prop: 'num', width: '200', label: 'Số kỳ' })
      this.fieldList.push({
        prop: 'contractName',
        width: '200',
        label: 'Hợp đồng'
      })
      this.fieldList.push({
        prop: 'customerName',
        width: '200',
        label: 'Tên khách hàng'
      })
      this.fieldList.push({ prop: 'money', width: '200', label: 'Số tiền trong hợp đồng' })
      this.fieldList.push({
        prop: 'startTime',
        width: '200',
        label: 'Ngày bắt đầu'
      })

      this.fieldList.push({ prop: 'endTime', width: '200', label: 'Ngày kết thúc' })
      this.fieldList.push({ prop: 'checkStatus', width: '200', label: 'Trạng thái' })
    },
    getDetail() {
      this.loading = true
      const request = {
        customer: crmCustomerQueryContract,
        business: crmBusinessQueryContract
      }[this.crmType]
      const params = { pageType: 0 }
      params[this.crmType + 'Id'] = this.id
      request(params)
        .then(res => {
          if (this.fieldList.length == 0) {
            this.getFieldList()
          }
          this.nopermission = false
          this.loading = false
          this.list = res.data
        })
        .catch(data => {
          if (data.code == 102) {
            this.nopermission = true
          }
          this.loading = false
        })
    },
    /** 格式化字段 */
    fieldFormatter(row, column) {
      // 如果需要格式化
      if (column.property === 'checkStatus') {
        return this.getStatusName(row.checkStatus)
      } else if (column.property == 'money') {
        return moneyFormat(row[column.property])
      }
      return row[column.property]
    },

    /**
     * 对应的状态名
     */
    getStatusName(status) {
      if (status == 0) {
        return 'Chờ xử lý'
      } else if (status == 1) {
        return 'Đã duyệt'
      } else if (status == 2) {
        return 'Từ chối'
      } else if (status == 3) {
        return 'Đang xem xét'
      } else if (status == 4) {
        return 'Rút lại'
      } else if (status == 5) {
        return 'Chưa gởi'
      } else if (status == 6) {
        return 'Hủy'
      }
      return ''
    },
    // 当某一行被点击时会触发该事件
    handleRowClick(row, column, event) {
      this.contractId = row.contractId
      this.showFullDetail = true
    },
    /** 通过回调控制表头style */
    headerRowStyle({ row, column, rowIndex, columnIndex }) {
      return { textAlign: 'center' }
    },
    /** 通过回调控制style */
    cellStyle({ row, column, rowIndex, columnIndex }) {
      return { textAlign: 'center' }
    },
    /** 新建 */
    createClick() {
      /** 客户 和 商机 下新建合同 */
      if (this.crmType == 'business') {
        this.createActionInfo.data['customer'] = this.detail
        this.createActionInfo.data['business'] = this.detail
      } else if (this.crmType == 'customer') {
        this.createActionInfo.data['customer'] = this.detail
      }
      this.isCreate = true
    },
    createSaveSuccess() {
      this.getDetail()
    }
  }
}
</script>
<style lang="scss" scoped>
@import '../styles/relativecrm.scss';
</style>
