<template>
  <div class="se-container">
    <div class="se-header">Quyền quản trị dự án</div>
    <div class="se-body">
      <div class="se-table-header">
        <reminder
          class="project-reminder"
          content="Đặt quyền hoạt động cho các dự án phù hợp, danh sách nhiệm vụ và nhiệm vụ cho các quyền được yêu cầu bởi các thành viên dự án trong các tình huống khác nhau"/>
        <el-button
          class="se-table-header-button"
          type="primary"
          @click="addJurisdiction">Quyền mới</el-button>
      </div>
      <el-table
        v-loading="loading"
        id="examine-table"
        :data="list"
        :height="tableHeight"
        class="main-table"
        highlight-current-row
        style="width: 100%"
        @row-click="handleRowClick">
        <el-table-column
          show-overflow-tooltip
          prop="roleName"
          width="150"
          label="Tên quyền"/>
        <el-table-column
          show-overflow-tooltip
          prop="remark"
          label="Mô tả"/>
        <el-table-column
          fixed="right"
          label="Tủy chỉnh"
          width="100">
          <template slot-scope="scope">
            <el-button
              :disabled="scope.row.roleType == 5"
              type="text"
              size="small"
              @click="handleClick('edit', scope)">Chỉnh sửa</el-button>
            <el-button
              :disabled="scope.row.roleType == 5"
              type="text"
              size="small"
              @click="handleClick('delete', scope)">Xóa</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <jurisdiction-create
      :show.sync="jurisdictionCreateShow"
      :action="createAction"
      @submite="getList"/>
  </div>
</template>

<script>
import JurisdictionCreate from './components/jurisdictionCreate'
import Reminder from '@/components/reminder'
import {
  systemRoleQueryProjectRoleListAPI,
  systemRoleDeleteWorkRoleAPI
} from '@/api/systemManagement/project'

export default {
  /** 系统管理 的 项目管理 */
  name: 'SystemProject',
  components: {
    JurisdictionCreate,
    Reminder
  },
  mixins: [],
  data() {
    return {
      loading: false, // 加载动画
      tableHeight: document.documentElement.clientHeight - 196, // 表的高度
      list: [],
      createAction: {
        type: 'save'
      },
      jurisdictionCreateShow: false
    }
  },
  computed: {},
  mounted() {
    var self = this
    /** 控制table的高度 */
    window.onresize = function() {
      self.tableHeight = document.documentElement.clientHeight - 196
    }

    this.getList()
  },
  methods: {
    /**
     * 获取列表数据
     */
    getList() {
      this.loading = true
      systemRoleQueryProjectRoleListAPI()
        .then(res => {
          this.list = res.data
          this.loading = false
        })
        .catch(() => {
          this.loading = false
        })
    },

    /**
     *  添加权限
     */
    addJurisdiction() {
      this.createAction = {
        type: 'save'
      }
      this.jurisdictionCreateShow = true
    },

    /** 列表操作 */
    /**
     * 当某一行被点击时会触发该事件
     */
    handleRowClick(row, column, event) {},

    /**
     * 编辑删除
     */
    handleClick(type, scope) {
      if (type === 'edit') {
        this.createAction = {
          type: 'update',
          data: scope.row
        }
        this.jurisdictionCreateShow = true
      } else if (type === 'delete') {
        // 启用停用
        this.$confirm('Xác nhận xóa?', 'Thông báo', {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          type: 'warning'
        })
          .then(() => {
            systemRoleDeleteWorkRoleAPI({
              roleId: scope.row.roleId
            })
              .then(res => {
                this.list.splice(scope.$index, 1)
                this.$message({
                  type: 'success',
                  message: 'Thành công'
                })
              })
              .catch(() => {})
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
}
</script>

<style lang="scss" scoped>
.se-header {
  height: 60px;
  position: relative;
  z-index: 100;
  padding: 0 20px;
  font-size: 18px;
  line-height: 60px;
}

.se-body {
  background-color: white;
  border: 1px solid #e6e6e6;
  border-radius: 2px;
}

.se-table-header {
  height: 50px;
  background-color: white;
  position: relative;
  .se-table-header-button {
    float: right;
    margin-right: 20px;
    margin-top: 10px;
  }
}

.project-reminder {
  width: auto;
  float: left;
  margin-left: 20px;
  margin-top: 10px;
}
@import '../styles/table.scss';
</style>
