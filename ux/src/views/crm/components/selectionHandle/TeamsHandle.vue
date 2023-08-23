<template>
  <el-dialog
    v-loading="loading"
    :title="title"
    :visible.sync="visible"
    :append-to-body="true"
    width="400px"
    @close="handleCancel">
    <div class="handle-box">
      <flexbox
        class="handle-item"
        align="stretch">
        <div
          class="handle-item-name"
          style="margin-top: 8px;">Chọn thành viên trong nhóm:</div>
        <xh-user-cell
          :radio="false"
          class="handle-item-content"
          placeholder="Bấm để chọn (nhiều lựa chọn)"
          @value-change="userChage"/>
        <div
          v-if="title!='Thêm thành viên trong nhóm'"
          class="tips">Thao tác này không thể xóa dữ liệu gốc</div>
      </flexbox>
      <flexbox
        v-if="title=='Thêm thành viên trong nhóm'"
        class="handle-item">
        <div class="handle-item-name">Quyền:</div>
        <el-radio-group v-model="handleType">
          <el-radio :label="1">Chỉ xem</el-radio>
          <el-radio :label="2">Chỉnh sửa</el-radio>
        </el-radio-group>
      </flexbox>
      <flexbox
        v-if="title=='Thêm thành viên trong nhóm' && crmType === 'customer'"
        class="handle-item">
        <div class="handle-item-name">Đồng thời thêm vào:</div>
        <el-checkbox-group v-model="addsTypes">
          <!-- <el-checkbox label="1">Thông tin liên hệ</el-checkbox> -->
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
import {
  crmCustomerSettingTeamSave,
  crmCustomerSettingTeamDelete
} from '@/api/customermanagement/customer'
import {
  crmContractSettingTeamSave,
  crmContractSettingTeamDelete
} from '@/api/customermanagement/contract'

import {
  crmBusinessSettingTeamSave,
  crmBusinessSettingTeamDelete
} from '@/api/customermanagement/business'

export default {
  /** 客户管理 的 勾选后的 团队成员 操作 移除操作不可移除客户负责人*/
  name: 'TeamsHandle',
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
    title: {
      type: String,
      default: ''
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
      handleType: 1, // 操作类型
      addsTypes: [] // 添加至
    }
  },
  computed: {},
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
      // 移除操作不可移除客户负责人
      if (this.usersList.length === 0) {
        this.$message.error('Vui lòng chọn thành viên trong nhóm')
      } else {
        var self = this
        var actionIds = this.selectionList.map(function(item, index, array) {
          return item[self.crmType + 'Id']
        })
        var userIds = this.usersList.map(function(item, index, array) {
          return item.userId
        })
        var params = {
          ids: actionIds.join(','),
          memberIds: userIds.join(',')
        }
        if (this.crmType === 'customer' && this.title == 'Thêm thành viên trong nhóm') {
          // 只有客户下面同时添加到
          params.changeType = this.addsTypes.join(',')
        }

        let request
        if (this.title == 'Thêm thành viên trong nhóm') {
          // 1只读，2读写
          params.power = this.handleType
          request = {
            customer: crmCustomerSettingTeamSave,
            contract: crmContractSettingTeamSave,
            business: crmBusinessSettingTeamSave
          }[this.crmType]
        } else {
          request = {
            customer: crmCustomerSettingTeamDelete,
            contract: crmContractSettingTeamDelete,
            business: crmBusinessSettingTeamDelete
          }[this.crmType]
        }

        this.loading = true

        request(params)
          .then(res => {
            this.$message({
              type: 'success',
              message: 'Thành công'
            })
            this.loading = false
            this.handleCancel()
            this.$emit('handle', {
              type: this.title == 'Thêm thành viên trong nhóm' ? 'add_user' : 'delete_user'
            })
          })
          .catch(() => {
            this.loading = false
          })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.tips {
  color: #777;
  font-size: 12px;
  position: absolute;
  bottom: -2px;
  right: 125px;
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
    width: 90px;
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
