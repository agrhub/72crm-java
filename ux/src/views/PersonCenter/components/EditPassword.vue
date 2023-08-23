<template>
  <!-- 新建和编辑 -->
  <el-dialog
    v-loading="loading"
    :visible.sync="showDialog"
    :before-close="hiddenView"
    title="Đổi mật khẩu"
    width="500px">
    <el-form
      ref="ruleForm"
      :model="ruleForm"
      :rules="rules"
      label-width="80px"
      label-position="top">
      <el-form-item
        label="Mật khẩu cũ"
        prop="oldPwd">
        <el-input v-model="ruleForm.oldPwd"/>
      </el-form-item>
      <el-form-item
        label="Mật khẩu mới"
        prop="newPwd">
        <el-input v-model="ruleForm.newPwd"/>
      </el-form-item>
    </el-form>
    <span
      slot="footer"
      class="dialog-footer">
      <el-button
        type="primary"
        @click="save">Lưu</el-button>
      <el-button @click="hiddenView">Đóng</el-button>
    </span>
  </el-dialog>
</template>
<script type="text/javascript">
import { mapGetters } from 'vuex'
import { adminUsersResetPassword } from '@/api/personCenter/personCenter'
import { removeAuth } from '@/utils/auth'

export default {
  name: 'EditPassword', // 编辑个人密码
  components: {},
  props: {
    show: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      loading: false,
      showDialog: false,
      rules: {
        oldPwd: [
          { required: true, message: 'Mật khẩu không được để trống', trigger: 'blur' },
          { min: 6, max: 12, message: 'Mật khẩu từ 6 đến 12 ký tự', trigger: 'blur' }
        ],
        newPwd: [
          { required: true, message: 'Mật khẩu không được để trống', trigger: 'blur' },
          { min: 6, max: 12, message: 'Mật khẩu từ 6 đến 12 ký tự', trigger: 'blur' }
        ]
      },
      ruleForm: {
        id: '',
        oldPwd: '',
        newPwd: ''
      }
    }
  },
  computed: {
    ...mapGetters(['userInfo'])
  },
  watch: {
    show: {
      handler(val) {
        this.showDialog = val
        this.ruleForm.id = this.userInfo.id
      },
      deep: true,
      immediate: true
    }
  },
  mounted() {},
  methods: {
    hiddenView() {
      this.$emit('close')
    },
    save() {
      this.$refs.ruleForm.validate(valid => {
        if (valid) {
          this.loading = true
          adminUsersResetPassword(this.ruleForm)
            .then(res => {
              this.loading = false
              removeAuth().then(() => {
                this.$confirm('Cập nhật thành công, vui lòng đăng nhập lại', 'Thông báo', {
                  confirmButtonText: 'OK',
                  showCancelButton: false,
                  type: 'warning'
                })
                  .then(() => {
                    this.$router.push('/login')
                  })
                  .catch(() => {})
              })
            })
            .catch(() => {
              this.loading = false
            })
        } else {
          return false
        }
      })
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
