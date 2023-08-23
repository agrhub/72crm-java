<template>
  <div class="navbar">
    <img
      :src="logo"
      class="logo" >
    <div class="nav-items-container">
      <flexbox style="width: auto;">
        <router-link
          v-for="(item, index) in items"
          :style="{ 'color' : item.type == navIndexChild ? '#3E84E9' : '#333333' }"
          :to="item.path"
          :key="index"
          class="nav-item"
          @click.native="navItemsClick(item.type)">
          <i
            :class="'wukong-' + item.icon"
            :style="{ 'color': item.type == navIndexChild ? '#3E84E9' : '#333333'}"
            class="wukong"
            style="margin-right: 10px;"/>
          <div class="nav-item-title">{{ item.title }}</div>
        </router-link>
      </flexbox>
    </div>

    <el-popover
      :visible-arrow="false"
      placement="bottom"
      popper-class="no-padding-popover"
      width="200"
      trigger="hover">
      <div class="auth-content">
        <div class="title">Bạn chưa được cấp quyền truy cập chức năng</div>
        <div class="detail">Liên hệ quản trị viên để được hỗ trợ</div>
        <span class="phone">(+84) 833-236-933</span>
      </div>
      <button
        slot="reference"
        type="text"
        class="auth-button">Mở khóa chức năng</button>
    </el-popover>

    <el-popover
      :visible-arrow="false"
      placement="bottom"
      popper-class="no-padding-popover"
      width="200"
      trigger="click">
      <div class="handel-items">
        <div
          class="handel-item"
          @click="handleClick('person')"><i class="wukong wukong-personcenter"/>Thông tin tài khoản</div>
        <div
          class="handel-item"
          @click="handleClick('goout')"><i class="wukong wukong-goout"/>Đăng xuất</div>
        <div
          :style="{'margin-bottom': manage ? '15px' : '0'}"
          class="handel-item hr-top"
          style="pointer-events: none;"><i class="wukong wukong-versions"/>Phiên bản V9.2.3.191220</div>
        <div
          v-if="manage"
          class="handel-box">
          <el-button
            type="primary"
            class="handel-button"
            @click="enterSystemSet()">Quản trị hệ thống</el-button>
        </div>
      </div>
      <div
        slot="reference"
        class="user-container">
        <div
          v-photo="userInfo"
          v-lazy:background-image="$options.filters.filterUserLazyImg(userInfo.img)"
          :key="userInfo.img"
          class="user-img div-photo"/>
        <i class="el-icon-caret-bottom mark"/>
      </div>
    </el-popover>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { Loading } from 'element-ui'
import { adminGroupsTypeListAPI } from '@/api/systemManagement/RoleAuthorization'

export default {
  filters: {
    langName: function(value) {
      if (value) {
        return { vn: 'Tiếng Việt', en: 'English' }[value]
      } else {
        return 'Tiếng Việt'
      }
    }
  },
  components: {},
  props: {
    navIndex: {
      type: [Number, String],
      default: 0
    }
  },
  data() {
    return {
      navIndexChild: 0,
      authRedirect: ''
    }
  },
  computed: {
    ...mapGetters([
      'userInfo',
      'lang',
      'logo',
      'crm',
      'bi',
      'manage',
      'oa',
      'project'
    ]),
    items() {
      var tempsItems = []
      if (this.oa) {
        tempsItems.push({
          title: 'Quản lý công việc',
          type: 0,
          path: '/workbench',
          icon: 'workbench'
        })
      }
      if (this.crm) {
        tempsItems.push({
          title: 'Quản lý kinh doanh',
          type: 1,
          path: '/crm',
          icon: 'customer'
        })
      }
      if (this.bi) {
        tempsItems.push({
          title: 'Báo cáo kinh doanh',
          type: 5,
          path: '/bi',
          icon: 'statistics'
        })
      }
      if (this.project) {
        tempsItems.push({
          title: 'Quản lý dự án',
          type: 2,
          path: '/project',
          icon: 'project'
        })
      }
      return tempsItems
    }
  },
  mounted() {
    this.navIndexChild = this.navIndex
    if (
      this.manage &&
      (!this.manage.system ||
        (this.manage.system && !this.manage.system.read)) &&
        (!this.manage.configSet ||
        (this.manage.configSet && !this.manage.configSet.read)) &&
        (!this.manage.users ||
        (this.manage.users && !this.manage.users.read))
    ) {
      this.getAuthPath()
    }
  },
  methods: {
    navItemsClick(type) {
      this.navIndexChild = type
      this.$store.commit('SET_NAVACTIVEINDEX', type)
      this.$emit('nav-items-click', type)
    },
    enterSystemSet() {
      this.$router.push({
        path: this.authRedirect || '/manager'
      })
    },
    handleClick(type) {
      if (type === 'goout') {
        this.$confirm('Xác nhận đăng xuất？', 'Thông báo', {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          type: 'warning'
        })
          .then(() => {
            var loading = Loading.service({
              target: document.getElementById('#app')
            })
            this.$store
              .dispatch('LogOut')
              .then(() => {
                location.reload()
                loading.close()
              })
              .catch(() => {
                location.reload()
                loading.close()
              })
          })
          .catch(() => {})
      } else if (type === 'person') {
        this.$router.push({
          name: 'person'
        })
      }
    },
    switchLang(item) {
      this.$store.commit('SET_LANG', item.lang)
      this.langName = item.name
    },
    getAuthPath() {
      adminGroupsTypeListAPI()
        .then(res => {
          if (res.data && res.data.length) {
            const item = res.data[0]
            this.authRedirect = `/manager/role-auth/${item.roleType}/${encodeURI(
              item.name
            )}`
          }
        })
        .catch(() => {})
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.navbar {
  height: 60px;
  min-height: 60px;
  background-color: white;
  display: flex;
  align-items: center;
  position: relative;
  padding: 0 30px;
  .logo {
    height: 40px;
    display: block;
    flex-shrink: 0;
    margin-right: 15px;
  }
  .nav-items-container {
    flex: 1;
    display: flex;
    min-width: 500px;
    height: 100%;
    overflow-x: auto;
    line-height: 60px;
    font-size: 15px;
  }

  .user-container {
    display: flex;
    align-items: center;
    flex-shrink: 0;
    cursor: pointer;
    .user-img {
      display: block;
      width: 32px;
      min-width: 32px;
      min-height: 32px;
      height: 32px;
      margin-right: 8px;
      border-radius: 50%;
    }
    .mark {
      font-size: 15px;
      color: #aaaaaa;
    }
  }

  .user-container:hover {
    .mark {
      color: #2486e4;
    }
  }
}

.nav-item {
  padding: 0 30px;
  display: flex;
  align-items: center;
  cursor: pointer;
}

.nav-item-img {
  width: 24px;
  height: 24px;
  display: block;
  margin-right: 5px;
}

.handel-items {
  padding: 10px 0 18px 0;
  .handel-item {
    padding: 5px 20px;
    font-size: 14px;
    color: #aaa;
    cursor: pointer;
    i {
      margin-right: 8px;
      font-size: 15px;
    }
  }
  .handel-item:hover {
    background-color: #f7f8fa;
    color: #3e84e9;
  }
  .handel-box {
    padding: 0 15px;
    .handel-button {
      width: 100%;
      border-radius: 4px;
      border-color: #009df0;
      background-color: #009df0;
    }
  }
}
.hr-top {
  margin-top: 8px;
  border-top: 1px solid #f4f4f4;
  padding-top: 3px;
}

.nav-lang {
  cursor: pointer;
  color: #888;
  padding: 20px;
  &:hover {
    color: #3e84e9;
  }
  &.active {
    font-weight: bold;
    color: #3e84e9;
  }
}

.auth-button {
  background: linear-gradient(to right, #d9ac7c, #c28e5c);
  color: white;
  padding: 5px 15px;
  font-size: 12px;
  height: 24px;
  outline: none;
  margin: 0;
  border: none;
  border-radius: 12px;
  transform: scale(0.9);
  margin-right: 15px;
  cursor: pointer;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.auth-content {
  text-align: center;
  color: #333;
  padding: 30px 20px;
  .title {
    font-size: 16px;
    font-weight: 600px;
  }
  .detail {
    transform: scale(0.9);
    margin-top: 8px;
    font-size: 12px;
    margin-bottom: 15px;
  }
  .phone {
    background: linear-gradient(to right, #f2dfb2, #e5c78a);
    border-radius: 4px;
    padding: 5px 17px;
    font-size: 12px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.12);
    line-height: 17px;
  }
}
</style>

