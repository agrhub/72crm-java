<template>
  <div class="role-authorization">
    <p
      ref="title"
      class="title"> {{ title }} </p>
    <div class="role-box">
      <!-- 左边导航 -->
      <div
        v-loading="roleMenuLoading"
        class="nav">
        <div class="nav-new-btn">
          <el-button
            size="medium"
            @click="newRoleBtn"> Thêm vai trò </el-button>
        </div>
        <!-- 角色列表 -->
        <div class="role-nav-box">
          <div
            v-for="(item, index) in roleList"
            :key="index"
            :class="{'item-list-hover' : item.roleId == roleActive.roleId}"
            class="item-list"
            @click="roleMenuSelect(item)">
            {{ item.roleName }}
            <div
              v-if="item.remark != 'admin' && item.remark != 'project'"
              class="icon-close">
              <el-dropdown
                trigger="click"
                @command="roleHandleClick">
                <i
                  class="el-icon-arrow-down"
                  @click="roleDropdownClick(item)"/>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item command="copy">Sao chép</el-dropdown-item>
                  <el-dropdown-item command="edit">Chỉnh sửa</el-dropdown-item>
                  <el-dropdown-item command="delete">Xóa</el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
            </div>
          </div>
        </div>
      </div>

      <!-- 角色编辑 -->
      <el-dialog
        :title="roleTitle"
        :visible.sync="newRoleVisible"
        :before-close="newRoleClose"
        width="30%">
        <label class="label-title">Tên vai trò</label>
        <el-input
          v-model="role.title"
          class="input-role"/>
        <span
          slot="footer"
          class="dialog-footer">
          <el-button
            type="primary"
            @click="newRoleSubmit">Lưu</el-button>
          <el-button @click="newRoleClose">Đóng</el-button>
        </span>
      </el-dialog>

      <!-- 右边内容 -->
      <div class="content-box">
        <el-tabs v-model="mainMenuIndex">
          <el-tab-pane
            label="Nhân viên"
            name="user">
            <div
              v-loading="userLoading"
              class="content-table">
              <flexbox class="content-table-header">
                <div class="content-table-header-reminder">
                  <reminder
                    v-if="showReminder"
                    :content="getReminderContent()"/>
                </div>
                <el-button
                  size="medium"
                  type="primary"
                  @click="addEmployees"> Thêm nhân viên </el-button>
              </flexbox>
              <el-table
                :data="tableData"
                :height="tableHeight"
                style="width: 100%">
                <el-table-column
                  v-for="(item, index) in tableList"
                  :prop="item.field"
                  :label="item.label"
                  :key="index"
                  show-overflow-tooltip>
                  <template
                    slot="header"
                    slot-scope="scope">
                    <div class="table-head-name">{{ scope.column.label }}</div>
                  </template>
                </el-table-column>
                <el-table-column label="Tùy chỉnh">
                  <template slot-scope="scope">
                    <!-- <span class="el-icon-edit content-table-span"
                      @click="editBtn(scope.row)"></span> -->
                    <span
                      class="el-icon-delete content-table-span"
                      @click="delectEmployees(scope.row)"/>
                  </template>
                </el-table-column>
              </el-table>
              <div class="p-contianer">
                <el-pagination
                  :current-page="currentPage"
                  :page-sizes="pageSizes"
                  :page-size.sync="pageSize"
                  :total="total"
                  class="p-bar"
                  layout="total, sizes, prev, pager, next, jumper"
                  @size-change="handleSizeChange"
                  @current-change="handleCurrentChange"/>
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane
            v-if="roleActive && showRuleSet"
            label="Quyền của vai trò"
            name="rule">
            <!-- 权限管理 -->
            <div
              v-loading="ruleLoading"
              class="jurisdiction-box">
              <el-button
                v-if="roleActive"
                size="medium"
                type="primary"
                class="jurisdiction-edit"
                @click="ruleSubmit"> Lưu </el-button>
              <el-tabs v-model="ruleMenuIndex">
                <el-tab-pane
                  v-for="(item, index) in ruleMenuList"
                  :key="index"
                  :label="item.label"
                  :name="item.index">
                  <div
                    v-if="item.type == 'tree'"
                    :style="{ height: treeHeight + 'px'}"
                    class="jurisdiction-content">
                    <div class="jurisdiction-content-checkbox">
                      <el-tree
                        :data="item.data"
                        :ref="'tree' + item.index"
                        :indent="0"
                        :expand-on-click-node="false"
                        :props="defaultProps"
                        show-checkbox
                        node-key="menuId"
                        style="height: 0;"
                        empty-text=""
                        default-expand-all/>
                    </div>
                  </div>
                  <div
                    v-else
                    class="jurisdiction-content">
                    <div class="data-radio">
                      <el-radio-group v-model="item.value">
                        <el-radio :label="1">Chỉ mình bạn</el-radio>
                        <el-radio :label="2">Chỉ bạn và cấp dưới</el-radio>
                        <el-radio :label="3">Cả phòng ban</el-radio>
                        <el-radio :label="4">Cả phòng ban và các bộ phận liên quan</el-radio>
                        <el-radio :label="5">Cả công ty</el-radio>
                      </el-radio-group>
                    </div>
                  </div>

                </el-tab-pane>
              </el-tabs>
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
    <!-- 关联员工 -->
    <relate-empoyee
      :visible.sync="relateEmpoyeeShow"
      :role-id="roleId"
      @save="employeesSave"/>
  </div>
</template>

<script>
import RelateEmpoyee from './components/relateEmpoyee'
import { usersList } from '@/api/common'
import Reminder from '@/components/reminder'
import {
  systemRuleByTypeAPI,
  roleAdd,
  roleDelete,
  roleCopy,
  roleUpdate,
  updateRoleMenu,
  usersDelete,
  systemRoleByTypeAPI
} from '@/api/systemManagement/RoleAuthorization'

export default {
  components: {
    RelateEmpoyee,
    Reminder
  },

  data() {
    return {
      pid: '',
      title: '',
      tableData: [], // 与角色关联的员工
      tableHeight: document.documentElement.clientHeight - 305, // 表的高度
      treeHeight: document.documentElement.clientHeight - 230, // 表的3度
      currentPage: 1,
      pageSize: 15,
      pageSizes: [15, 30, 45, 60],
      total: 0,
      tableList: [
        { label: 'Họ và tên', field: 'realname' },
        { label: 'Tên phòng ban', field: 'deptName' },
        { label: 'Chức vụ', field: 'post' },
        { label: 'Tên vai trò', field: 'roleName' }
      ],

      // 新建角色
      newRoleVisible: false,
      role: {}, // 操作角色的框 关联的信息
      roleList: [], // 角色列表 list属性 是信息

      mainMenuIndex: 'user', // 角色员工  角色权限 切换 默认左边
      // 权限管理
      ruleMenuIndex: 'data', // 默认模块 工作台
      ruleMenuList: [],
      defaultProps: {
        children: 'childMenu',
        label: 'menuName'
      },
      relateEmpoyeeShow: false,
      // 选中的角色
      roleActive: null,
      dropdownHandleRole: null, // 下拉操作编辑角色
      // 新建编辑角色title
      roleTitle: '',
      //   加载
      roleMenuLoading: false,
      // 权限加载中
      ruleLoading: false,
      // 员工列表加载中
      userLoading: false
    }
  },

  computed: {
    roleId() {
      if (this.roleActive) {
        return this.roleActive.roleId
      }
      return ''
    },

    // 展示角色权限
    showRuleSet() {
      if (this.roleActive) {
        return (
          this.roleActive.remark != 'admin' &&
          this.roleActive.remark != 'project'
        )
      }

      return false
    },

    // 展示提示问题
    showReminder() {
      if (this.roleActive) {
        return this.roleActive.remark == 'project'
      }

      return false
    }
  },

  watch: {},

  mounted() {
    /** 控制table的高度 */
    window.onresize = () => {
      this.tableHeight = document.documentElement.clientHeight - 305
      this.treeHeight = document.documentElement.clientHeight - 230
    }
    /** 获取权限信息 */
    this.pid = this.$route.params.pid
    this.title = this.$route.params.title
    this.getRulesList()
    this.getRoleList()
  },

  beforeRouteUpdate(to, from, next) {
    this.pid = to.params.pid
    this.title = to.params.title
    this.roleActive = null
    this.roleList = []
    this.currentPage = 1
    this.total = 0
    this.tableData = []
    this.getRulesList()
    this.getRoleList()
    next()
  },

  methods: {
    /**
     * 获取权限规则信息
     */
    getRulesList() {
      systemRuleByTypeAPI({ roleType: this.pid }).then(res => {
        if (res.data.data) {
          this.ruleMenuList = [
            {
              label: 'Chức năng',
              index: 'data',
              type: 'tree',
              value: [],
              data: [res.data.data]
            }
          ]
          if (res.data.bi) {
            this.ruleMenuList.push({
              label: 'Phân tích dữ liệu',
              index: 'bi',
              type: 'tree',
              value: [],
              data: [res.data.bi]
            })
          }
        } else {
          this.ruleMenuList = []
        }

        this.getRoleRulesInfo()
      })
    },

    /**
     * 获取角色列表
     */
    getRoleList() {
      this.roleMenuLoading = true
      systemRoleByTypeAPI({ roleType: this.pid })
        .then(res => {
          this.roleList = res.data
          /** 判断数据是否存在 */
          let hasActive = false
          if (this.roleActive) {
            for (let index = 0; index < this.roleList.length; index++) {
              const item = this.roleList[index]
              if (item.roleId == this.roleActive.roleId) {
                this.roleActive = item
                this.getRoleRulesInfo()
                hasActive = true
                break
              }
            }
          }
          if (!hasActive && this.roleList.length) {
            this.roleActive = this.roleList[0]
            this.getRoleRulesInfo()
          }
          this.getUserList(this.roleActive)
          this.roleMenuLoading = false
        })
        .catch(() => {
          this.roleMenuLoading = false
        })
    },

    /**
     * 关联员工
     */
    addEmployees() {
      this.relateEmpoyeeShow = true
    },

    /**
     * 关联员工确定
     */
    employeesSave(val) {
      this.relateEmpoyeeShow = false
      this.getUserList(this.roleActive)
    },

    /**
     * 删除
     */
    delectEmployees(val) {
      this.$confirm('Xác nhận xóa nhân viên vĩnh viễn?', 'Thông tin', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      })
        .then(() => {
          this.userLoading = true
          usersDelete({
            userId: val.userId,
            roleId: this.roleActive.roleId
          }).then(res => {
            this.userLoading = true
            this.getUserList(this.roleActive)
            this.$message.success('Thành công')
          })
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: 'Không thành công'
          })
        })
    },

    /**
     * 新建角色
     */
    newRoleClose() {
      this.newRoleVisible = false
    },
    newRoleBtn() {
      this.roleTitle = 'Vai trò mới'
      this.newRoleVisible = true
      this.role = {}
    },

    /**
     * 角色操作
     */
    roleDropdownClick(value) {
      this.dropdownHandleRole = value
    },
    roleHandleClick(command) {
      if (command == 'edit') {
        this.roleEditBtn(this.dropdownHandleRole)
      } else if (command == 'copy') {
        this.ticketsBtn(this.dropdownHandleRole)
      } else if (command == 'delete') {
        this.roleDelect(this.dropdownHandleRole)
      }
    },

    /**
     * 角色说明文字
     */
    getReminderContent() {
      if (this.roleActive && this.roleActive.remark == 'project') {
        return 'Quản trị viên dự án có tất cả các quyền của mô-đun "Quản lý dự án", có thể xem và chỉnh sửa tất cả thông tin dự án'
      }
      return ''
    },

    /**
     * 角色编辑
     */
    roleEditBtn(val) {
      this.roleTitle = 'Chỉnh sửa vai trò'
      this.role = {
        title: val.roleName,
        pid: val.roleType,
        id: val.roleId
      }
      this.newRoleVisible = true
    },

    /**
     * 复制
     */
    ticketsBtn(val) {
      this.$confirm('Xác nhận hành động?', 'Thông báo', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      })
        .then(() => {
          roleCopy({ roleId: val.roleId }).then(res => {
            this.$message.success('Thành công')
            this.getRoleList()
          })
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: 'Không thành công'
          })
        })
    },

    /**
     * 删除
     */
    roleDelect(val) {
      this.$confirm('Xóa vĩnh viễn, xác nhận thực hiện?', 'Thông báo', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      })
        .then(() => {
          roleDelete({ roleId: val.roleId }).then(res => {
            if (this.roleList.length) {
              this.roleActive = this.roleList[0]
              // 点击角色 复制权限 用于编辑操作
              this.getRoleRulesInfo()
            }
            this.getRoleList()
            this.$message.success('Thành công')
          })
        })
        .catch(() => {
          this.$message({
            type: 'info',
            message: 'Không thành công'
          })
        })
    },
    newRoleSubmit() {
      if (!this.role.title) {
        this.$message.error('Không được để trống tên vai trò')
      } else {
        if (this.roleTitle == 'Tạo mới vai trò') {
          roleAdd({
            roleName: this.role.title,
            roleType: this.pid
          }).then(res => {
            this.getRoleList()
            this.$message.success('Thảnh công')
            this.newRoleClose()
          })
        } else {
          roleUpdate({
            roleName: this.role.title,
            roleType: this.role.pid,
            roleId: this.role.id
          }).then(res => {
            this.getRoleList()
            this.$message.success('Thành công')
            this.newRoleClose()
          })
        }
      }
    },

    /**
     * 角色列表点击
     */
    roleMenuSelect(val) {
      this.roleActive = val

      if (this.mainMenuIndex == 'rule' && !this.showRuleSet) {
        this.mainMenuIndex = 'user'
      }

      this.getRoleRulesInfo()

      this.getUserList(this.roleActive)
    },

    /**
     * 获取权限信息 需在roleActive获取之后
     */
    getRoleRulesInfo() {
      if (this.roleActive && this.ruleMenuList.length) {
        if (this.pid == 2) {
          const lastItem = this.ruleMenuList[this.ruleMenuList.length - 1]
          if (lastItem.type != 'data') {
            this.ruleMenuList.push({
              label: 'Quyền dữ liệu',
              index: 'info',
              type: 'data',
              value: this.roleActive.dataType
            })
          }
        }

        for (let index = 0; index < this.ruleMenuList.length; index++) {
          const element = this.ruleMenuList[index]
          if (element.type == 'tree') {
            element.rules = this.getRoleRules(
              this.roleActive.rules[element.index],
              element.data[0]
            )
            this.$nextTick(() => {
              const treeRefs = this.$refs['tree' + element.index]
              if (treeRefs) {
                if (
                  Object.prototype.toString.call(treeRefs) == '[object Array]'
                ) {
                  treeRefs.length && treeRefs[0].setCheckedKeys(element.rules)
                } else {
                  treeRefs.setCheckedKeys(element.rules)
                }
              }
            })
          } else {
            element.value = this.roleActive.dataType
          }
        }
      }
    },

    /**
     * 获得check的实际数据
     */
    getRoleRules(array, tree) {
      if (!array) {
        array = []
      }

      var hasRemove = false
      var copyArray = this.copyItem(array)
      for (
        let firstIndex = 0;
        firstIndex < tree.childMenu.length;
        firstIndex++
      ) {
        const firstItem = tree.childMenu[firstIndex]

        if (!firstItem.hasOwnProperty('children')) {
          if (firstItem.length + 1 != copyArray.length) {
            this.removeItem(copyArray, tree.id)
          }
          return copyArray
        }

        for (let index = 0; index < array.length; index++) {
          const element = array[index]
          var temps = []
          for (
            let secondIndex = 0;
            secondIndex < firstItem.childMenu.length;
            secondIndex++
          ) {
            const secondItem = firstItem.childMenu[secondIndex]
            if (secondItem.id == element) {
              temps.push(secondItem)
            }
          }
          if (temps.length != firstItem.childMenu.length) {
            hasRemove = true
            this.removeItem(copyArray, firstItem.id)
          }
        }
      }

      if (hasRemove) {
        this.removeItem(copyArray, tree.id)
      }

      var checkedKey = []
      for (let index = 0; index < copyArray.length; index++) {
        const element = copyArray[index]
        if (element) {
          checkedKey.push(parseInt(element))
        }
      }

      return checkedKey
    },
    copyItem(array) {
      var temps = []
      for (let index = 0; index < array.length; index++) {
        temps.push(array[index])
      }
      return temps
    },
    removeItem(array, item) {
      var removeIndex = -1
      for (let index = 0; index < array.length; index++) {
        if (item == array[index]) {
          removeIndex = index
          break
        }
      }
      if (removeIndex > 0) {
        array.splice(removeIndex, 1)
      }
    },
    containItem(array, item) {
      for (let index = 0; index < array.length; index++) {
        if (item == array[index]) {
          return true
        }
      }
      return false
    },

    /**
     * 员工列表
     */
    getUserList(role, noReset) {
      if (!role) {
        return
      }

      if (!noReset) {
        this.currentPage = 1
      }
      this.userLoading = true
      usersList({
        page: this.currentPage,
        limit: this.pageSize,
        roleId: role.roleId
      })
        .then(res => {
          this.tableData = res.data.list
          this.total = res.data.totalRow
          this.userLoading = false
        })
        .catch(() => {
          this.userLoading = false
        })
    },
    /**
     * 更改每页展示数量
     */
    handleSizeChange(val) {
      this.pageSize = val
      this.getUserList(this.roleActive, true)
    },
    /**
     * 更改当前页数
     */
    handleCurrentChange(val) {
      this.currentPage = val
      this.getUserList(this.roleActive, true)
    },

    // 权限提交
    ruleSubmit() {
      this.ruleLoading = true

      let rules = []
      let infoData = ''
      for (let index = 0; index < this.ruleMenuList.length; index++) {
        const element = this.ruleMenuList[index]
        if (element.type == 'tree') {
          const treeRefs = this.$refs['tree' + element.index]
          if (treeRefs) {
            if (Object.prototype.toString.call(treeRefs) == '[object Array]') {
              rules = rules.concat(treeRefs[0].getCheckedKeys())
            } else {
              rules = rules.concat(treeRefs.getCheckedKeys())
            }
          }
        } else {
          infoData = element.value
        }
      }

      updateRoleMenu({
        rules: rules,
        type: infoData,
        id: this.roleActive.roleId,
        roleName: this.roleActive.roleName
      })
        .then(res => {
          this.getRoleList()
          this.$message.success('Thành công')
          this.ruleLoading = false
        })
        .catch(() => {
          this.ruleLoading = false
        })
    }
  }
}
</script>

<style lang="scss" scoped>
.role-authorization {
  height: 100%;
  box-sizing: border-box;
  overflow: hidden;
}
.title {
  font-size: 18px;
  height: 40px;
  padding: 0 20px;
  line-height: 40px;
  margin: 10px 0;
  color: #333;
}
.role-box {
  height: calc(100% - 60px);
  overflow: hidden;
  position: relative;
}
.nav {
  width: 200px;
  background: #fff;
  border: 1px solid #e6e6e6;
  height: 100%;
  position: absolute;
  top: 0;
  left: 0;
}
.nav-new-btn {
  text-align: center;
  padding-top: 15px;
  padding-bottom: 15px;
}
.nav-new-btn .el-button {
  background: #4ab8b8;
  border-color: #4ab8b8;
  color: #fff;
  width: 140px;
  border-radius: 2px;
}
.content-box {
  background: #fff;
  border: 1px solid #e6e6e6;
  margin-left: 215px;
  height: 100%;
  overflow: hidden;
  padding-top: 10px;
  position: relative;
}
.content-table {
  overflow: hidden;
}
.content-table > .el-button {
  float: right;
  margin-bottom: 15px;
  margin-right: 30px;
}
.content-box .content-table-span {
  color: #3e84e9;
  margin-left: 5px;
  cursor: pointer;
}

.content-table-header {
  padding: 0 15px 5px;
  .content-table-header-reminder {
    flex: 1;
    margin-right: 5px;
  }
}

/* 权限管理 */
.jurisdiction-content {
  height: calc(100% - 61px);
  position: relative;
  overflow: hidden;
}
.content-left {
  height: 100%;
  margin-right: 250px;
  overflow: hidden;
}
.content-right {
  width: 250px;
  position: absolute;
  top: 0;
  right: 0;
  height: 100%;
}
.jurisdiction-box {
  padding-bottom: 15px;
  height: calc(100% - 61px);
  overflow: hidden;
  position: relative;
}
.jurisdiction-content-checkbox {
  border-right: 1px dashed #e6e6e6;
  height: calc(100% - 47px);
  overflow-y: scroll;
  padding: 20px;
}
.jurisdiction-content-checkbox
  .el-tree
  /deep/
  .el-tree-node
  > .el-tree-node__content {
  margin-bottom: 20px;
  width: 150px;
}
.jurisdiction-content-checkbox /deep/ .el-tree .el-tree-node {
  white-space: inherit;
  margin-bottom: 5px;
}
.jurisdiction-content-checkbox
  /deep/
  .el-tree
  > .el-tree-node
  > .el-tree-node__children
  > .is-expanded
  > .el-tree-node__children
  > .is-expanded {
  display: inline-block;
}
.role-authorization /deep/ .el-tree-node__expand-icon {
  display: none;
}
.data-radio {
  padding: 5px 30px;
}
.data-radio .el-radio {
  display: block;
  margin: 20px 0;
}
/* 新建角色 */
.input-role {
  padding: 10px 0 20px;
  width: 100%;
}
.role-nav-box {
  line-height: 30px;
  overflow-y: auto;
  padding: 5px 0 20px 0;
  height: calc(100% - 65px);
}
.role-nav-box .item-list {
  color: #333;
  font-size: 13px;
  padding-left: 30px;
  height: 40px;
  line-height: 40px;
  border-right: 2px solid transparent;
  cursor: pointer;
  position: relative;
  .icon-close {
    position: absolute;
    top: 0;
    right: 8px;
    z-index: 1;
    display: none;
  }
}
.role-nav-box .item-list:hover {
  background: #ebf3ff;
  border-right-color: #46cdcf;
  .icon-close {
    display: block;
  }
}
.item-list-hover {
  background: #ebf3ff;
  border-right: 2px solid #46cdcf;
}

.role-nav-box .item-list:hover .icon-close {
  display: block;
  float: right;
}
.jurisdiction-edit {
  text-align: right;
  padding: 10px 30px;
  position: absolute;
  top: 0;
  right: 20px;
  z-index: 3;
}

/** 分页布局 */
.p-contianer {
  position: relative;
  background-color: white;
  height: 44px;
  .p-bar {
    float: right;
    margin: 5px 100px 0 0;
    font-size: 14px !important;
  }
}

// .el-tabs /deep/ .el-tabs__nav-wrap::after {
//   display: none !important;
// }

.el-tabs /deep/ .el-tabs__header {
  padding: 0 17px;
  margin: 0 0 15px !important;
}

.el-tabs /deep/ .el-tabs__item {
  font-size: 13px !important;
  height: 40px !important;
  line-height: 40px !important;
}

@import '../styles/table.scss';
</style>
