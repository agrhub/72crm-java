<template>
  <div
    :style="{ 'z-index': zIndex }"
    class="create-schedule">
    <div
      v-loading="loading"
      class="add-schedule">
      <div
        slot="header"
        class="header">
        <span class="text">{{ text }}</span>
        <img
          class="el-icon-close rt"
          src="@/assets/img/task_close.png"
          alt=""
          @click="close">
      </div>
      <div class="content">
        <el-form
          ref="form"
          :model="formData"
          :rules="rules">
          <el-form-item
            v-for="(item, index) in formList"
            :prop="item.field"
            :class="'el-form-item'+'-'+item.field"
            :style="{'width': item.width}"
            :label="item.label"
            :key="index">
            <template v-if="item.type == 'time'">
              <el-date-picker
                v-model="formData[item.field]"
                type="datetime"
                value-format="yyyy-MM-dd HH:mm:ss"
                placeholder="Chọn"/>
            </template>
            <template v-else-if="item.type == 'textarea'">
              <el-input
                :autosize="{ minRows: 6}"
                v-model="formData[item.field]"
                type="textarea"
                placeholder="Vui lòng nhập nội dung"/>
            </template>
            <template v-else-if="item.type == 'participant'">
              <el-popover
                placement="bottom-end"
                width="280"
                trigger="click">
                <xh-user
                  ref="xhuser"
                  :selected-data="colleaguesList"
                  @changeCheckout="changeCheckout"/>
                <div
                  slot="reference"
                  class="select-box">
                  <span
                    v-for="(item, index) in colleaguesList"
                    :key="index"
                    class="select-box-span">
                    {{ item.realname }}
                    <span
                      class="el-icon-close"
                      @click.stop="selectDelect(item, index)"/>
                  </span>
                  <span class="el-icon-plus"/>
                </div>
              </el-popover>
            </template>
            <template v-else-if="item.type == 'select'">
              <el-select
                v-model="formData[item.field]"
                placeholder="Chọn">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"/>
              </el-select>
            </template>
            <template v-else-if="item.type == 'color'">
              <el-input
                v-model="formData[item.field]"
                placeholder="Vui lòng nhập nội dung">
                <i
                  slot="prefix"
                  class="el-input__icon">
                  <span
                    :style="{'background': formData.color}"
                    class="bg-color"/>
                </i>
              </el-input>
              <div class="color-box">
                <span
                  v-for="(item, index) in colorList"
                  :key="index"
                  :style="{'background': item}"
                  @click="changeColor(item)"/>
              </div>
            </template>
            <el-input
              v-else
              v-model="formData[item.field]"/>
          </el-form-item>
        </el-form>
        <!-- 关联业务 -->
        <related-business
          :all-data="allData"
          @checkInfos="checkInfos"/>
      </div>
      <div class="footer">
        <el-button
          type="primary"
          @click="onSubmit">Lưu</el-button>
        <el-button @click="close">Hủy</el-button>
      </div>
    </div>
  </div>
</template>

<script>
// API
import { scheduleAdd, scheduleEdit } from '@/api/oamanagement/schedule'
// 关联业务 - 选中列表
import relatedBusiness from '@/components/relatedBusiness'
import XhUser from '@/components/CreateCom/XhUser'
import { getMaxIndex, formatTimeToTimestamp } from '@/utils/index'

export default {
  components: {
    relatedBusiness,
    XhUser
  },
  props: {
    formData: {
      type: Object,
      default: () => {
        return {
          color: ''
        }
      }
    },
    text: {
      type: String,
      default: 'Tạo lịch biểu'
    },
    appendToBody: {
      type: Boolean,
      default: false
    }
  },
  data() {
    var validateTime = (rule, value, callback) => {
      if (this.formData.startTime && this.formData.endTime) {
        if (
          formatTimeToTimestamp(this.formData.startTime) >=
          formatTimeToTimestamp(this.formData.endTime)
        ) {
          callback(new Error('Thời gian bắt đầu phải nhỏ hơn thời gian kết thúc'))
        }
      }
      callback()
    }
    return {
      zIndex: getMaxIndex(),
      formList: [
        { label: 'Tên', field: 'title', type: 'color' },
        { label: 'Giờ bắt đầu', field: 'startTime', type: 'time' },
        { label: 'Giờ kết thức', field: 'endTime', type: 'time' },
        { label: 'Người tham dự', field: 'ownerUserIds', type: 'participant' },
        { label: 'Mô tả', field: 'remark', type: 'textarea', width: '100%' }
      ],
      // 提醒
      options: [
        {
          value: 0,
          label: 'Không nhắc'
        },
        {
          value: 1,
          label: 'Nhắc đúng giờ'
        },
        {
          value: 2,
          label: 'Nhắc trước 5 phút'
        },
        {
          value: 3,
          label: 'Nhắc trước 15 phút'
        },
        {
          value: 4,
          label: 'Nhắc trước 30 phút'
        },
        {
          value: 5,
          label: 'Nhắc trước 1 giờ'
        },
        {
          value: 6,
          label: 'Nhắc trước 2 giờ'
        },
        {
          value: 7,
          label: 'Nhắc trước 1 ngày'
        },
        {
          value: 8,
          label: 'Nhắc trước 2 ngày'
        },
        {
          value: 9,
          label: 'Nhắc trước 1 tuần'
        }
      ],
      // 上传的附件列表
      fileList: [],
      loading: false,
      colorList: [
        '#3E8EF7',
        '#11C06C',
        '#0BB2D4',
        '#EB6709',
        '#FF4C52',
        '#526069',
        '#9262F4'
      ],
      rules: {
        title: [
          { required: true, message: 'Tên không được trống', trigger: 'blur' },
          { max: 50, message: 'Tên tối đa 50 ký tự', trigger: 'blur' }
        ],
        startTime: [
          { required: true, message: 'Phải chọn giờ bắt đầu', trigger: 'blur' },
          { validator: validateTime, trigger: 'blur' }
        ],
        endTime: [
          { required: true, message: 'Phải chọn giờ kết thúc', trigger: 'blur' },
          { validator: validateTime, trigger: 'blur' }
        ]
      },
      // 获取选择的数据id数组
      relevanceAll: {},
      allData: {},
      // 负责人弹出框
      colleaguesList: []
    }
  },
  created() {},
  mounted() {
    if (this.appendToBody) {
      document.body.appendChild(this.$el)
    }
    // 编辑时引用 - 自动勾选
    this.allData.business = this.formData.businessList
      ? this.formData.businessList
      : []
    this.allData.contacts = this.formData.contactsList
      ? this.formData.contactsList
      : []
    this.allData.contract = this.formData.contractList
      ? this.formData.contractList
      : []
    this.allData.customer = this.formData.customerList
      ? this.formData.customerList
      : []
    if (this.formData.ownerList) {
      this.colleaguesList = [].concat(this.formData.ownerList)
    }
    if (this.text == 'Tạo lịch biểu') {
      this.$set(this.formData, 'color', '#3E8EF7')
    }
  },

  beforeDestroy() {
    if (this.appendToBody && this.$el && this.$el.parentNode) {
      this.$el.parentNode.removeChild(this.$el)
    }
  },
  methods: {
    close() {
      if (this.$route.query.routerKey == 1) {
        this.$router.go(-1)
      } else {
        this.$emit('closeDialog')
      }
    },
    checkInfos(val) {
      this.relevanceAll = val
    },
    onSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loading = true
          const data = this.formData
          const ownerUserIds = []
          for (const item of this.colleaguesList) {
            ownerUserIds.push(item.userId)
          }
          if (this.text == 'Tạo lịch biểu') {
            scheduleAdd({
              title: data.title,
              startTime: data.startTime,
              endTime: data.endTime,
              ownerUserIds: ownerUserIds.join(','),
              remark: data.remark,
              color: data.color,
              customerIds: this.relevanceAll.customerIds
                ? this.relevanceAll.customerIds.join(',')
                : [],
              contactsIds: this.relevanceAll.contactsIds
                ? this.relevanceAll.contactsIds.join(',')
                : [],
              businessIds: this.relevanceAll.businessIds
                ? this.relevanceAll.businessIds.join(',')
                : [],
              contractIds: this.relevanceAll.contractIds
                ? this.relevanceAll.contractIds.join(',')
                : []
            })
              .then(res => {
                if (this.$route.query.routerKey == 1) {
                  this.$router.push('schedule')
                } else {
                  this.$emit('onSubmit')
                }
                this.loading = false
              })
              .catch(() => {
                this.loading = false
              })
          } else {
            const list = {
              customerIds: [],
              contractIds: [],
              contactsIds: [],
              businessIds: []
            }
            // 客户
            if (this.allData.customer) {
              for (const item of this.allData.customer) {
                list.customerIds.push(item.customerId)
              }
            }
            // 合同
            if (this.allData.contract) {
              for (const item of this.allData.contract) {
                list.contractIds.push(item.contractId)
              }
            }
            // 联系人
            if (this.allData.contacts) {
              for (const item of this.allData.contacts) {
                list.contactsIds.push(item.contactsId)
              }
            }
            // 关联商机
            if (this.allData.business) {
              for (const item of this.allData.business) {
                list.businessIds.push(item.businessId)
              }
            }
            const ids =
              JSON.stringify(this.relevanceAll) == '{}'
                ? list
                : this.relevanceAll
            scheduleEdit({
              eventId: data.eventId,
              title: data.title,
              startTime: data.startTime,
              endTime: data.endTime,
              ownerUserIds: ownerUserIds.join(','),
              remark: data.remark,
              color: data.color,
              customerIds: ids.customerIds.join(','),
              contactsIds: ids.contactsIds.join(','),
              businessIds: ids.businessIds.join(','),
              contractIds: ids.contractIds.join(',')
            })
              .then(res => {
                this.$emit('onSubmit')
                this.loading = false
              })
              .catch(() => {
                this.loading = false
              })
          }
        } else {
          return false
        }
      })
    },
    // 附件 -- 上传
    httpRequest(file) {
      this.fileList.push(file.file)
    },
    // 附件 -- 删除
    onRemove(file) {
      for (const i in this.fileList) {
        if (this.fileList[i].uid == file.uid) {
          this.fileList.splice(i, 1)
        }
      }
    },
    changeColor(val) {
      this.$set(this.formData, 'color', val)
    },
    changeCheckout(data) {
      this.colleaguesList = data.data
    },
    // 删除选择员工
    selectDelect(value, index) {
      this.$refs.xhuser[0].cancelCheckItem(value)
      this.colleaguesList.splice(index, 1)
    }
  }
}
</script>
<style scoped lang="scss">
.create-schedule {
  background: #f5f6f9;
  position: fixed;
  top: 0;
  right: 0;
  left: 0;
  bottom: 0;
  z-index: 100;
  padding: 40px 0;
  .add-schedule {
    display: flex;
    flex-direction: column;
    height: 100%;
    width: 700px;
    margin: 0 auto;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    z-index: 100;
    padding: 20px;
    border-radius: 4px;
    border: 1px solid #ebeef5;
    background-color: #fff;
    .header {
      line-height: 40px;
      height: 40px;
      padding: 0 0 0 10px;
      .text {
        font-size: 17px;
      }
      .el-icon-close {
        margin-right: 0;
        width: 40px;
        line-height: 40px;
        padding: 10px;
        cursor: pointer;
      }
    }
    .content {
      flex: 1;
      overflow: auto;
      .el-form /deep/ {
        padding: 20px 20px 0;
        overflow: hidden;
        .el-form-item {
          margin-bottom: 10px;
          padding-bottom: 10px;
          width: 50%;
          float: left;
          .el-date-editor {
            width: 100%;
            .el-range-separator {
              width: 7%;
            }
          }
          // .el-form-item__content>.el-input {
          //     width: 45%;
          // }
          .el-form-item__content {
            .el-select {
              width: 100%;
              .el-input--suffix {
                .el-input__inner {
                  height: 34px !important;
                }
              }
            }
            .el-input__inner {
              vertical-align: bottom;
            }
          }
          .el-form-item__label {
            float: none;
            font-size: 12px;
          }
          .el-textarea {
            margin-top: 8px;
            .el-textarea__inner {
              resize: none;
            }
          }
          .reinvent {
            background: #f5f5f5;
            margin-left: 20px;
            padding: 20px;
            font-size: 12px;
            margin-top: 10px;
            .top-nav {
              // margin-left: 50px;
              .el-select {
                width: 178px;
                margin: 0 5px 0 26px;
              }
              .checkbox-box {
                margin-left: 53px;
                line-height: normal;
                margin-top: 10px;
                .el-checkbox-group {
                  .el-checkbox + .el-checkbox {
                    margin-left: 15px;
                  }
                }
              }
            }
            .end-time {
              margin-top: 15px;
              .title {
                float: left;
                // line-height: normal;
              }
              .radio-box {
                margin-left: 53px;
                width: 178px;
                .el-radio-group {
                  .never {
                    margin-top: 3px;
                  }
                  p {
                    margin-bottom: 10px;
                  }
                  .radio-epetition {
                    .el-select {
                      width: 80px;
                      margin: 0 5px;
                    }
                  }
                  .radio-end-time {
                    .el-date-editor {
                      width: 150px;
                      margin-left: 5px;
                    }
                  }
                }
              }
              .result {
                margin-left: 26px;
                display: inline-block;
              }
            }
            .el-input__inner {
              vertical-align: middle !important;
            }
          }
          .color-box {
            margin-top: 10px;
            line-height: normal;
            span {
              display: inline-block;
              width: 18px;
              height: 18px;
              margin-right: 25px;
              border-radius: 50%;
              cursor: pointer;
            }
            span:last-child {
              margin: 0;
            }
          }
          .bg-color {
            width: 15px;
            height: 15px;
            border-radius: 50%;
            display: inline-block;
            vertical-align: middle;
          }
          .el-input__prefix {
            margin-top: 3px;
            margin-left: 3px;
          }
        }
        .el-form-item-ownerUserIds,
        .el-form-item-startTime,
        .el-form-item-remind_time {
          padding-right: 25px;
        }

        .el-form-item-endTime,
        .el-form-item-address {
          padding-left: 25px;
          padding-right: 0;
        }
        .el-form-item-title {
          width: 100%;
          margin-bottom: 5px;
          .el-form-item__content {
            width: 50%;
            padding-right: 25px;
          }
        }
        .select-box {
          border: 1px solid #e6e6e6;
          min-height: 34px;
          line-height: 34px;
          border-radius: 3px;
          cursor: pointer;
          display: inline-block;
          width: 100%;
          vertical-align: bottom;
          position: relative;
          padding-right: 36px;
        }
        .select-box > .el-icon-plus {
          position: absolute;
          top: 50%;
          right: 0;
          transform: translateY(-50%);
          line-height: 34px;
          font-size: 16px;
          font-weight: 600;
          color: #aaa;
          padding-right: 10px;
        }
        .select-box > .select-box-span {
          background: #eff3fc;
          margin: 0 5px;
          height: 27px;
          line-height: 28px;
          font-size: 12px;
          color: #333;
          padding: 0 5px;
          display: inline-block;
        }
      }
    }
    .footer {
      text-align: right;
      padding-right: 20px;
    }
  }
}
</style>


