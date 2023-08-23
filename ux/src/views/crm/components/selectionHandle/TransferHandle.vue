<template>
  <el-dialog
    v-loading="loading"
    :visible.sync="visible"
    :append-to-body="true"
    title="Chuyển giao hàng loạt"
    width="400px"
    @close="handleCancel">
    <div class="handle-box">
      <flexbox class="handle-item">
        <div class="handle-item-name">Nhân viên được bàn giao:</div>
        <xh-user-cell
          class="handle-item-content"
          placeholder="Bấm để chọn"
          @value-change="userChage"/>
      </flexbox>
      <flexbox
        v-if="showRemoveType"
        class="handle-item">
        <div class="handle-item-name">Nhân viên phụ trách ban đầu：</div>
        <el-radio-group v-model="removeType">
          <el-radio :label="1">Nghỉ việc</el-radio>
          <el-radio :label="2">Tham gia bộ phận khác</el-radio>
        </el-radio-group>
      </flexbox>
      <flexbox
        v-if="removeType == 2"
        class="handle-item">
        <div class="handle-item-name">Quyền của nhân viên mới:</div>
        <el-radio-group v-model="handleType">
          <el-radio :label="1">Chỉ xem</el-radio>
          <el-radio :label="2">Chỉnh sửa</el-radio>
        </el-radio-group>
      </flexbox>
      <!-- 仅客户下可进行同时变成负责人 -->
      <flexbox
        v-if="crmType === 'customer'"
        class="handle-item">
        <div class="handle-item-name">Cùng lúc, thay đổi trạng thái khách hàng thành</div>
        <el-checkbox-group v-model="addsTypes">
          <el-checkbox label="1" checked>Thông tin liên hệ</el-checkbox>
          <el-checkbox label="2">Cơ hội kinh doanh</el-checkbox>
          <el-checkbox label="3">Hợp đồng</el-checkbox>
        </el-checkbox-group>
      </flexbox>
    </div>
    <span
      slot="footer"
      class="dialog-footer">
      <el-button @click.native="handleCancel">Hủy</el-button>
      <el-button
        type="primary"
        @click.native="handleConfirm">Lưu</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { XhUserCell } from '@/components/CreateCom'
import { crmCustomerTransfer } from '@/api/customermanagement/customer'
import { crmContactsTransfer } from '@/api/customermanagement/contacts'
import { crmBusinessTransfer } from '@/api/customermanagement/business'
import { crmContractTransfer } from '@/api/customermanagement/contract'
import { crmLeadsTransfer } from '@/api/customermanagement/clue'

export default {
  /** 客户管理 的 勾选后的 转移 操作*/
  name: 'TransferHandle',
  components: {
    XhUserCell
  },
  mixins: [],
  props: {
    dialogVisible: {
      type: Boolean,
      required: true,
      default: false
    },
    /** 没有值就是全部类型 有值就是当个类型 */
    crmType: {
      type: String,
      default: ''
    },
    /** 转移数据 */
    selectionList: {
      type: Array,
      default: () => {
        return []
      }
    }
  },
  data() {
    return {
      loading: false, // 加载动画
      visible: false,

      usersList: [], // 变更负责人
      removeType: 1, // 移动类型
      handleType: 1, // 操作类型
      addsTypes: [] // 添加至
    }
  },
  computed: {
    // 是否展示移除操作类型
    showRemoveType() {
      if (this.crmType == 'leads' || this.crmType == 'contacts') {
        return false
      }
      return true
    }
  },
  watch: {
    dialogVisible: {
      handler(val) {
        this.visible = val
      },
      deep: true,
      immediate: true
    }
  },
  mounted() {
    this.visible = this.dialogVisible
  },
  methods: {
    /**
     * 取消选择
     */
    handleCancel() {
      this.visible = false
      this.$emit('update:dialogVisible', false)
    },
    /** 负责人更改 */
    userChage(data) {
      this.usersList = data.value
    },
    handleConfirm() {
      if (this.usersList.length === 0) {
        this.$message.error('Chưa chọn nhân viên')
      } else {
        this.loading = true
        this.getRequest()(this.getParams())
          .then(res => {
            this.$message({
              type: 'success',
              message: 'Thành công'
            })
            this.loading = false
            this.handleCancel()
            this.$emit('handle', { type: 'transfer' })
          })
          .catch(() => {
            this.loading = false
          })
      }
    },
    getRequest() {
      if (this.crmType === 'leads') {
        return crmLeadsTransfer
      } else if (this.crmType === 'customer') {
        return crmCustomerTransfer
      } else if (this.crmType === 'contacts') {
        return crmContactsTransfer
      } else if (this.crmType === 'business') {
        return crmBusinessTransfer
      } else if (this.crmType === 'contract') {
        return crmContractTransfer
      }
    },
    getParams() {
      var ownerUserId = this.usersList[0].userId
      var params = {
        newOwnerUserId: ownerUserId,
        transferType: this.removeType
      }
      if (this.removeType === 2) {
        // 1移出，2转为团队成员
        params.power = this.handleType
      }

      var self = this
      var actionId = this.selectionList.map(function(item, index, array) {
        return item[self.crmType + 'Id']
      })
      params[this.crmType + 'Ids'] = actionId.join(',')
      if (this.crmType === 'customer') {
        // 只有客户下面有同时变更
        params.changeType = this.addsTypes.join(',')
      }
      return params
    }
  }
}
</script>

<style lang="scss" scoped>
.handle-box {
  color: #333;
  font-size: 12px;
}
.handle-item {
  padding-bottom: 15px;
  .handle-item-name {
    flex-shrink: 0;
    width: 110px;
  }
  .handle-item-content {
    flex: 1;
  }
}
.handle-bar {
  position: relative;
  margin-top: 10px;
  height: 30px;
  button {
    float: right;
    margin-right: 10px;
  }
}
</style>
