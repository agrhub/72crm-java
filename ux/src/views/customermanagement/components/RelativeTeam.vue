<template>
  <div class="rc-cont">
    <flexbox
      v-if="!isSeas"
      class="rc-head"
      direction="row-reverse">
      <el-button
        class="rc-head-item"
        type="primary"
        @click.native="handleClick('remove')">Xóa</el-button>
      <el-button
        class="rc-head-item"
        type="primary"
        @click.native="handleClick('edit')">Chỉnh sửa</el-button>
      <el-button
        class="rc-head-item"
        type="primary"
        @click.native="handleClick('add')">Thêm mới</el-button>
    </flexbox>
    <el-table
      :data="list"
      :height="tableHeight"
      :header-cell-style="headerRowStyle"
      :cell-style="cellStyle"
      stripe
      style="width: 100%;border: 1px solid #E6E6E6;"
      @row-click="handleRowClick"
      @selection-change="handleSelectionChange">
      <el-table-column
        :selectable="handleSelectable"
        show-overflow-tooltip
        type="selection"
        align="center"
        width="55"/>
      <el-table-column
        v-for="(item, index) in fieldList"
        :key="index"
        :prop="item.prop"
        :label="item.label"
        show-overflow-tooltip/>
    </el-table>
    <teams-handle
      :crm-type="crmType"
      :selection-list="[detail]"
      :dialog-visible.sync="teamsDialogShow"
      title="Thêm thành viên trong nhóm"
      @handle="handleCallBack"/>

    <el-dialog
      v-loading="loading"
      :visible.sync="editPermissionShow"
      :append-to-body="true"
      title="Chỉnh sửa quyền"
      width="400px">
      <div class="handle-box">
        <flexbox class="handle-item">
          <div class="handle-item-name">Quyền:</div>
          <el-radio-group v-model="handleType">
            <el-radio :label="1">Chỉ xem</el-radio>
            <el-radio :label="2">Chỉnh sửa</el-radio>
          </el-radio-group>
        </flexbox>
      </div>
      <span
        slot="footer"
        class="dialog-footer">
        <el-button @click.native="editPermissionShow=false">Đóng</el-button>
        <el-button
          type="primary"
          @click.native="handleEditConfirm">Lưu</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script type="text/javascript">
import loading from '../mixins/loading'
import TeamsHandle from './selectionHandle/TeamsHandle' // 操作团队成员
import {
  crmCustomerTeamMembers,
  crmCustomerUpdateMembers,
  crmCustomerSettingTeamDelete
} from '@/api/customermanagement/customer'
import {
  crmBusinessTeamMembers,
  crmBusinessUpdateMembers,
  crmBusinessSettingTeamDelete
} from '@/api/customermanagement/business'
import {
  crmContractTeamMembers,
  crmContractUpdateMembers,
  crmContractSettingTeamDelete
} from '@/api/customermanagement/contract'

export default {
  name: 'RelativeTeam', // 相关团队  可能再很多地方展示 放到客户管理目录下
  components: {
    TeamsHandle
  },
  mixins: [loading],
  props: {
    /** 模块ID */
    id: [String, Number],
    /** 联系人人下 新建商机 需要联系人里的客户信息  合同下需要客户和商机信息 */
    detail: {
      type: Object,
      default: () => {
        return {}
      }
    },
    /** 没有值就是全部类型 有值就是当个类型 */
    crmType: {
      type: String,
      default: ''
    },
    /** 是公海 默认是客户 */
    isSeas: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      list: [],
      fieldList: [],
      tableHeight: '400px',
      teamsDialogShow: false, // 是否展示添加团队成员窗口
      handleType: 1, // 权限类型
      editPermissionShow: false, // 编辑权限接口展示
      selectionList: [] // 勾选的数据
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
    this.fieldList.push({ prop: 'realname', width: '200', label: 'Họ và tên' })
    this.fieldList.push({ prop: 'name', width: '200', label: 'Chức vụ' })
    this.fieldList.push({ prop: 'groupRole', width: '200', label: 'Vai trò trong nhóm' })
    this.fieldList.push({ prop: 'power', width: '200', label: 'Quyền' })

    this.getDetail()
  },
  activated: function() {},
  deactivated: function() {},
  methods: {
    getDetail() {
      this.loading = true
      const request = {
        customer: crmCustomerTeamMembers,
        business: crmBusinessTeamMembers,
        contract: crmContractTeamMembers
      }[this.crmType]
      const params = {}
      params[this.crmType + 'Id'] = this.id
      request(params)
        .then(res => {
          this.loading = false
          this.list = res.data
        })
        .catch(() => {
          this.loading = false
        })
    },
    // 当选择项发生变化时会触发该事件
    handleSelectionChange(val) {
      this.selectionList = val
    },
    handleClick(type) {
      if (type == 'add') {
        this.teamsDialogShow = true
      } else {
        if (this.selectionList.length == 0) {
          this.$message.error('Chưa chọn thành viên')
        } else {
          if (type == 'edit') {
            this.editPermissionShow = true
          } else if (type == 'remove') {
            this.$confirm('Xác nhận xóa thành viên khỏi nhóm?', 'Thông báo', {
              confirmButtonText: 'OK',
              cancelButtonText: 'Cancel',
              type: 'warning'
            })
              .then(() => {
                var userIds = this.selectionList.map(function(
                  item,
                  index,
                  array
                ) {
                  return item.id
                })

                const request = {
                  customer: crmCustomerSettingTeamDelete,
                  contract: crmContractSettingTeamDelete,
                  business: crmBusinessSettingTeamDelete
                }[this.crmType]

                var params = {
                  ids: this.id,
                  memberIds: userIds.join(',')
                }

                this.loading = true
                request(params)
                  .then(res => {
                    this.$message({
                      type: 'success',
                      message: 'Thành công'
                    })
                    this.loading = false
                    this.getDetail()
                  })
                  .catch(() => {
                    this.loading = false
                  })
              })
              .catch(() => {
                this.$message({
                  type: 'info',
                  message: 'Không thành công'
                })
              })
          }
        }
      }
    },
    /** 添加操作 */
    handleCallBack(data) {
      this.getDetail()
    },
    /** 编辑操作确定 */
    handleEditConfirm() {
      var userIds = this.selectionList.map(function(item, index, array) {
        return item.id
      })
      this.loading = true
      const request = {
        customer: crmCustomerUpdateMembers,
        business: crmBusinessUpdateMembers,
        contract: crmContractUpdateMembers
      }[this.crmType]
      request({
        ids: this.id,
        memberIds: userIds.join(','),
        power: this.handleType
      })
        .then(res => {
          this.editPermissionShow = false
          this.$message({
            type: 'success',
            message: 'Thành công'
          })
          this.loading = false
          this.getDetail()
        })
        .catch(() => {
          this.loading = false
        })
    },
    // 返回值用来决定这一行的 CheckBox 是否可以勾选
    handleSelectable(row, index) {
      if (row.power == 'Quản lý nhóm') {
        return false
      }
      return true
    },
    // 当某一行被点击时会触发该事件
    handleRowClick(row, column, event) {},
    /** 通过回调控制表头style */
    headerRowStyle({ row, column, rowIndex, columnIndex }) {
      return { textAlign: 'center' }
    },
    /** 通过回调控制style */
    cellStyle({ row, column, rowIndex, columnIndex }) {
      return { textAlign: 'center' }
    }
  }
}
</script>
<style lang="scss" scoped>
@import '../styles/relativecrm.scss';
</style>
