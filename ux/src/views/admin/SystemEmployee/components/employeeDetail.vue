<template>
  <slide-view
    :listener-ids="['manager-main-container']"
    :no-listener-ids="['depTable']"
    :body-style="{padding: '10px 30px', height: '100%'}"
    class="d-view"
    @side-close="hideView">
    <flexbox
      orient="vertical"
      style="height: 100%;">
      <flexbox class="detail-header">
        <div class="header-name"/>
        <img
          class="header-close"
          src="@/assets/img/task_close.png"
          @click="hideView" >
      </flexbox>
      <div class="detail-body">
        <div class="dialog-top">
          <img
            :src="data.img"
            alt="">
          <span>{{ data.realname }}</span>
          <div class="dialog-btn-group">
            <el-button
              type="primary"
              size="medium"
              @click="editBtn"> Chỉnh sửa </el-button>
            <el-dropdown
              v-if="userUpdateAuth || userEnablesAuth"
              trigger="click"
              @command="handleCommand">
              <el-button size="medium">
                Mở rộng<i class="el-icon-arrow-down el-icon--right"/>
              </el-button>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item
                  v-if="userUpdateAuth"
                  command="reset">Đổi mật khẩu</el-dropdown-item>
                <el-dropdown-item
                  v-if="userEnablesAuth"
                  command="status">{{ data.status === 0 ? 'Kích hoạt' : 'Hủy kích hoạt' }}</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
          <div class="dialog-remark">
            <p>Tình trạng tài khoản：{{ {'0':'Chưa kích hoạt','1':'Kích hoạt','2':'Khóa' }[data.status] }}</p>
            <p>Ngày cập nhật：{{ data.createTime }}</p>
          </div>
        </div>
        <div class="dialog-content">
          <flexbox
            v-for="(item, index) in detailList"
            :key="index"
            class="content-items"
            align="stretch">
            <div class="content-items-name">{{ item.value }}</div>
            <div class="content-items-value">{{ data|formatedInfo(item.field) }}</div>
          </flexbox>
        </div>
      </div>
    </flexbox>
  </slide-view>
</template>

<script>
import SlideView from '@/components/SlideView'
import { mapGetters } from 'vuex'

export default {
  /** 审批详情 */
  name: 'EmployeeDetail',
  components: {
    SlideView
  },
  filters: {
    formatedInfo(data, field) {
      if (field == 'sex') {
        return { 1: 'Nam', 2: 'Nữ' }[data.sex]
      }
      return data[field]
    }
  },
  props: {
    // 详情信息
    data: Object
  },
  data() {
    return {
      detailList: [
        { field: 'username', value: 'Tên đăng nhập' },
        { field: 'realname', value: 'Họ và tền' },
        { field: 'sex', value: 'Giới tính', type: 'select' },
        { field: 'email', value: 'Email' },
        { field: 'deptName', value: 'Phòng ban', type: 'select' },
        { field: 'post', value: 'Chức vụ' },
        { field: 'parentName', value: 'Cấp trên', type: 'select' },
        { field: 'roleName', value: 'Vai trò', type: 'selectCheckout' }
      ]
    }
  },
  computed: {
    ...mapGetters(['manage']),
    // 员工编辑操作权限
    userUpdateAuth() {
      return this.manage && this.manage.users && this.manage.users.userUpdate
    },
    // 员工禁用启用权限
    userEnablesAuth() {
      return this.manage && this.manage.users && this.manage.users.userEnables
    }
  },
  watch: {},
  mounted() {},
  methods: {
    editBtn() {
      this.$emit('edit')
    },
    handleCommand(command) {
      this.$emit('command', command)
    },
    //* * 点击关闭按钮隐藏视图 */
    hideView() {
      this.$emit('hide-view')
    }
  }
}
</script>

<style lang="scss" scoped>
.detail-header {
  position: relative;
  min-height: 60px;
  .header-name {
    font-size: 14px;
    color: #333333;
    flex: 1;
  }
  .header-close {
    display: block;
    width: 40px;
    height: 40px;
    margin-left: 20px;
    padding: 10px;
    cursor: pointer;
  }
}

.dialog-top > img {
  vertical-align: middle;
  margin-right: 10px;
  height: 36px;
}
.dialog-btn-group {
  float: right;
}
.dialog-remark {
  font-size: 14px;
  color: #999;
  margin-top: 10px;
  p + p {
    margin-top: 5px;
  }
}
.dialog-content {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #e6e6e6;
  .content-items {
    padding: 10px 0;
    .content-items-name {
      width: 132px;
      color: #777;
      flex-shrink: 0;
    }
    .content-items-value {
      flex: 1;
    }
  }
}

.detail-body {
  flex: 1;
  overflow-y: auto;
  width: 100%;
}

.d-view {
  position: fixed;
  width: 500px;
  top: 60px;
  bottom: 0px;
  right: 0px;
}
</style>

