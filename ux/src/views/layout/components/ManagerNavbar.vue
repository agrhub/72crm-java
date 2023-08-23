<template>
  <div class="navbar">
    <img
      :src="logo"
      class="logo" >
    <div class="nav-title">
      Cài đặt hệ thống
    </div>
    <div
      class="back-home"
      @click="enterHome">Hoàn thành</div>
    <div
      class="go-out"
      @click="enterLogin">Đăng xuất</div>
  </div>
</template>

<script>
import { Loading } from 'element-ui'
import { mapGetters } from 'vuex'

export default {
  components: {},
  props: {
    navIndex: {
      type: Number,
      default: 0
    }
  },
  data() {
    return {}
  },
  computed: {
    ...mapGetters(['logo'])
  },
  mounted() {},
  methods: {
    enterHome() {
      this.$router.replace({
        path: '/'
      })
    },
    enterLogin() {
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
              loading.close()
              this.$router.push('/login')
            })
            .catch(() => {
              loading.close()
            })
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
  display: flex;
  align-items: center;
  padding: 0 90px 0 30px;
  background-color: white;
  .logo {
    height: 40px;
    display: block;
    flex-shrink: 0;
    margin-right: 60px;
  }
  .nav-title {
    flex: 1;
    font-size: 16px;
    color: #333333;
  }
}

.back-home {
  width: 94px;
  height: 36px;
  line-height: 36px;
  background-color: #3e84e9;
  border-radius: 3px;
  text-align: center;
  color: #fff;
  font-size: 14px;
  margin-right: 10px;
  cursor: pointer;
}

.go-out {
  width: 94px;
  height: 36px;
  line-height: 36px;
  background-color: #c2c2c2;
  border-radius: 3px;
  text-align: center;
  color: #fff;
  font-size: 14px;
  cursor: pointer;
}
</style>

