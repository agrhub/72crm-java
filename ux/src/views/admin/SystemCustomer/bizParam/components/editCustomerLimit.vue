<template>
  <el-dialog
    :visible.sync="visible"
    :title="title"
    :append-to-body="true"
    :before-close="close"
    width="550px">
    <div class="position-relative">
      <flexbox
        class="handle-item"
        align="stretch">
        <div
          class="handle-item-name"
          style="margin-top: 8px;">Phạm vi áp dụng:</div>
        <xh-struc-user-cell
          :users="users"
          :strucs="strucs"
          style="width: 100%;"
          @value-change="strcUserChange"/>
      </flexbox>
      <flexbox
        class="handle-item"
        align="stretch">
        <div
          class="handle-item-name"
          style="margin-top: 8px;">{{ valueLabel }}</div>
        <el-input
          v-model="customerNum"
          placeholder="Vui lòng nhập nội dung"/>
      </flexbox>
      <flexbox v-if="showDeal" class="handle-item">
        <div class="handle-item-name">{{ dealLabel }}</div>
        <el-radio-group v-model="customerDeal">
          <el-radio :label="1">Chốt</el-radio>
          <el-radio :label="0">Không</el-radio>
        </el-radio-group>
      </flexbox>
    </div>
    <span
      slot="footer"
      class="dialog-footer">
      <el-button @click.native="close">Đóng</el-button>
      <el-button
        type="primary"
        @click="sure">Lưu</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { crmSettingCustomerConfigSetAPI } from '@/api/systemManagement/SystemCustomer'
import { XhStrucUserCell } from '@/components/CreateCom'

export default {
  name: 'EditCustomerLimit',
  components: {
    XhStrucUserCell
  },
  props: {
    types: [String, Number], // 1拥有客户上限2锁定客户上限

    visible: {
      type: Boolean,
      default: false
    },

    action: {
      type: Object,
      default: () => {
        return {
          type: 'save'
        }
      }
    }
  },
  data() {
    return {
      customerDeal: 1,
      customerNum: '',
      users: [],
      strucs: []
    }
  },
  computed: {
    valueLabel() {
      return {
        1: 'Số lượng khách hàng tối đa（个）',
        2: 'Số lượng khách hàng từ chối tối đa（个）'
      }[this.types]
    },

    dealLabel() {
      return {
        1: 'Số lượng khách chốt đơn：',
        2: 'Số lượng khách từ chối：'
      }[this.types]
    },

    title() {
      return this.action.type == 'update' ? 'Chỉnh sửa quy tắc' : 'Thêm quy tắc'
    },

    // 展示是否
    showDeal() {
      return this.types == 1
    }
  },
  watch: {
    visible(val) {
      if (val) {
        if (this.action.type == 'save') {
          this.clearInfo()
        } else if (this.action.type == 'update') {
          const data = this.action.data
          this.customerDeal = data.customerDeal
          this.customerNum = data.customerNum
          this.$nextTick(() => {
            this.users = data.userIds
            this.strucs = data.deptIds
          })
        }
      }
    }
  },
  mounted() {},
  methods: {
    close() {
      this.$emit('update:visible', false)
    },

    strcUserChange(data) {
      this.users = data.value.users
      this.strucs = data.value.strucs
    },

    sure() {
      if ((!this.users.length && !this.strucs.length) || !this.customerNum) {
        this.$message.error('Vui lòng điền đầy đủ thông tin')
      } else {
        const params = {
          userList: this.users.map(item => {
            return item.userId
          }),
          deptList: this.strucs.map(item => {
            return item.id
          }),
          customerNum: this.customerNum,
          type: this.types
        }

        if (this.showDeal) {
          params.customerDeal = this.customerDeal
        }

        if (this.action.type == 'update') {
          params.settingId = this.action.data.settingId
        }

        crmSettingCustomerConfigSetAPI(params)
          .then(res => {
            this.$emit('success')
            this.close()
          })
          .catch(() => {})
      }
    },

    clearInfo() {
      this.users = []
      this.strucs = []
      this.customerDeal = 1
      this.customerNum = ''
    }
  }
}
</script>

<style scoped lang="scss">
.position-relative {
  position: relative;
}

.handle-box {
  color: #333;
  font-size: 12px;
}
.handle-item {
  padding-bottom: 15px;
  position: relative;
  .handle-item-name {
    flex-shrink: 0;
    width: 150px;
  }
  .handle-item-content {
    flex: 1;
  }
}
</style>
