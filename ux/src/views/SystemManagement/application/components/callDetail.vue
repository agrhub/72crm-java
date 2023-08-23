<template>
  <el-dialog
    :visible.sync="visible"
    :append-to-body="true"
    :before-close="handleClose"
    width="700px">
    <div class="position-relative">
      <div>Liên hệ ngay với AGRHUB để được hỗ trợ các chức năng và dịch vụ tổng đài ảo:</div>
      <flexbox class="phone-info">
        <img src="@/assets/img/system/app/phone.png" >
        Hotline：(+84) 833-236-933
      </flexbox>
      <el-table
        :data="tableData"
        border
        style="width: 100%">
        <el-table-column
          prop="name"
          label="Chức năng"
          width="180"/>
        <el-table-column
          prop="des"
          label="Mô tả chức năng"/>
      </el-table>
      <div class="switch">
        <el-switch
          v-model="callSwitch"
          disabled/>
        Chưa kích hoạt
      </div>
    </div>
    <span
      slot="footer"
      class="dialog-footer">
      <el-button
        type="primary"
        @click="handleClose">Đóng</el-button>
    </span>
  </el-dialog>
</template>

<script>
export default {
  name: 'CallDetail',
  components: {},
  props: {
    visible: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      tableData: [
        {
          name: 'Gọi nhanh',
          des: 'Nhấp vào nút quay số trong hệ thống để thực hiện các cuộc gọi đi bằng một phím.'
        },
        {
          name: 'Màn hình gọi đến',
          des: 'Các cuộc gọi của khách hàng, khách hàng của hệ thống được đối sánh tự động và thông tin khách hàng có thể được xem bằng một cú nhấp chuột.'
        },
        {
          name: 'Thu âm cuộc gọi',
          des: 'Tự động ghi âm cuộc gọi, hỗ trợ phát và tải trực tuyến.'
        },
        {
          name: 'Lịch sử cuộc gọi',
          des: 'Tự động tạo bản ghi cuộc gọi, bạn có thể xem thời lượng cuộc gọi, thời gian cuộc gọi và các thông tin khác bất kỳ lúc nào.'
        }
      ],
      callSwitch: false
    }
  },
  computed: {},
  mounted() {},
  methods: {
    handleClose() {
      this.$emit('update:visible', false)
    }
  }
}
</script>

<style scoped lang="scss">
.position-relative {
  position: relative;
}

.phone-info {
  margin: 15px 0;
  img {
    width: 16px;
    margin-right: 5px;
  }
}

.switch {
  color: #666666;
  font-size: 13px;
  position: absolute;
  left: 0;
  bottom: -30px;
}
</style>
