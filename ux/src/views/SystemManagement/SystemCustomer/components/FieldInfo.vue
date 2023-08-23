<template>
  <div class="field-info-section">
    <div class="item-section">
      <div class="name">
        Tên trường
      </div>
      <el-input
        v-model="field.name"
        :disabled="disabled"/>
      <div class="input-tips"><span>*</span>Tên trường không được để trống</div>
    </div>
    <div class="item-section">
      <div class="name">
        Lời nhắc
      </div>
      <el-input
        v-model="field.inputTips"
        :rows="3"
        :disabled="disabled"
        type="textarea"
        resize="none"/>
      <div class="input-tips"><span>*</span>Văn bản mô tả được hiển thị ở phía bên phải của tên trường</div>
    </div>

    <div
      v-if="showSelect"
      class="item-section">
      <div class="name">
        Cài đặt tùy chọn
      </div>
      <el-radio-group
        v-if="field.formType == 'select'"
        v-model="field.defaultValue"
        :disabled="disabled">
        <draggable :list="field.showSetting">
          <div
            v-for="(item, index) in field.showSetting"
            :key="index"
            class="radio">
            <el-radio
              :label="item.value"
              @click.native.prevent="radioChange(item.value)">
              <el-input
                v-model="item.value"
                :disabled="disabled"
                class="input"/>
            </el-radio>
            <i
              class="el-icon-circle-plus handle"
              @click="handleRadio('add', item, index)"/>
            <i
              v-if="field.showSetting.length > 1"
              class="el-icon-remove handle"
              @click="handleRadio('remove', item, index)"/>
          </div>
        </draggable>
      </el-radio-group>
      <el-checkbox-group
        v-if="field.formType == 'checkbox'"
        v-model="field.defaultValue"
        :disabled="disabled">
        <draggable :list="field.showSetting">
          <div
            v-for="(item, index) in field.showSetting"
            :key="index"
            class="checkbox">
            <el-checkbox :label="item.value"/>
            <el-input
              v-model="item.value"
              :disabled="disabled"
              class="input"/>
            <i
              class="el-icon-circle-plus handle"
              @click.stop="handleCheckbox('add', item, index)"/>
            <i
              v-if="field.showSetting.length > 1"
              class="el-icon-remove handle"
              @click.stop="handleCheckbox('remove', item, index)"/>
          </div>

        </draggable>
      </el-checkbox-group>
    </div>

    <div
      v-if="showDefaultValue&&!isUserStructure"
      class="item-section">
      <div class="name">
        Mặc định
      </div>
      <el-input
        v-if="!showDatepicker"
        v-model="field.defaultValue"
        :disabled="disabled"
        @blur="inputBlur"/>
      <el-date-picker
        v-if="showDatepicker"
        v-model="field.defaultValue"
        :disabled="disabled"
        :type="field.formType == 'date' ? 'date' : 'datetime'"
        :value-format="field.formType == 'date' ? 'yyyy-MM-dd' : 'yyyy-MM-dd HH:mm:ss'"
        placeholder="选择日期"/>
      <div
        v-if="defaultTips"
        class="input-tips"><span>*</span>{{ defaultTips }}</div>
    </div>

    <div
      v-if="showMaxInput"
      class="item-section">
      <div class="name">
        Giới hạn ký tự
      </div>
      <el-input
        v-model="field.maxLength"
        :maxlength="4"
        :disabled="disabled"/>
      <div class="input-tips"><span>*</span>Tối đa 2000 ký tự</div>
    </div>

    <div
      v-if="canTransform && transformData && transformData[field.formType]"
      class="item-section">
      <div class="name">
        Chuyển đổi kiểu dữ liệu trường thông tin
      </div>
      <el-select
        v-model="field.relevant"
        clearable
        placeholder="Chọn">
        <el-option
          v-for="item in transformData[field.formType]"
          :key="item.value"
          :label="item.label"
          :value="item.value"/>
      </el-select>
    </div>

    <div class="item-check-section">
      <el-checkbox
        v-model="field.isNull"
        :disabled="disabled">Đặt mặt định</el-checkbox>
    </div>
    <div class="item-check-section">
      <el-checkbox
        v-model="field.isUnique"
        :disabled="disabled">Đặt duy nhất</el-checkbox>
    </div>
  </div>
</template>
<script type="text/javascript">
import draggable from 'vuedraggable'
import { regexIsCRMMobile, regexIsCRMEmail } from '@/utils'

export default {
  name: 'FieldInfo', // 自定义字段 字段详情
  components: {
    draggable
  },
  props: {
    // 单个字段详情
    field: {
      type: Object,
      default: () => {
        return {
          name: '', //  标识名
          formType: '', // 字段类型
          isUnique: false, // 是否唯一
          isNull: false, // 是否必填
          inputTips: '', // 输入提示
          maxLength: '', // textarea 多行文本有最大数量
          defaultValue: '', // 默认值
          setting: '', // 接口返回setting数据
          showSetting: '', // 单选选项
          relevant: '' // 转移字段
        }
      }
    },
    // 是否开启转移  转移对应数据
    canTransform: Boolean,
    transformData: Object
  },
  data() {
    return {}
  },
  computed: {
    defaultTips() {
      if (this.field.formType == 'floatnumber') {
        return 'Phần nguyên của đơn vị tiền tệ phải dưới 10 chữ số và phần thập phân phải nhỏ hơn 2 chữ số'
      } else if (this.field.formType == 'number') {
        return 'Phần nguyên của số phải có ít hơn 12 chữ số và phần thập phân phải có ít hơn 4 chữ số'
      }
      return ''
    },
    /** 展示最大输入 */
    showMaxInput() {
      if (this.field.formType == 'textarea') {
        return true
      }
      return false
    },
    /** 展示默认值块 */
    showDefaultValue() {
      if (
        this.field.formType == 'select' ||
        this.field.formType == 'checkbox'
      ) {
        return false
      }
      return true
    },
    /** 展示单选多选 */
    showSelect() {
      if (
        this.field.formType == 'select' ||
        this.field.formType == 'checkbox'
      ) {
        return true
      }
      return false
    },
    /** 展示时间选择 */
    showDatepicker() {
      if (this.field.formType == 'date' || this.field.formType == 'datetime') {
        return true
      }
      return false
    },
    /** 控制人员和部分不展示默认值 */
    isUserStructure() {
      if (this.field.formType == 'user' || this.field.formType == 'structure') {
        return true
      }
      return false
    },
    /** 只读 */
    disabled() {
      // operating 0 改删 1改 2删 3无
      if (this.field.operating == 2 || this.field.operating == 3) {
        return true
      }
      return false
    }
  },
  watch: {
    field() {
      if (this.showSelect && this.field.showSetting.length == 0) {
        this.field.showSetting = [
          { value: 'Chọn 1' },
          { value: 'Chọn 2' },
          { value: 'Chọn 3' }
        ]
      }
    }
  },
  mounted() {
    if (this.showSelect && this.field.showSetting.length == 0) {
      this.field.showSetting = [
        { value: 'Chọn 1' },
        { value: 'Chọn 2' },
        { value: 'Chọn 3' }
      ]
    }
  },
  methods: {
    // 当选的操作
    handleRadio(type, item, index) {
      if (this.disabled) {
        // 不能点击
        return
      }
      if (type == 'add') {
        this.field.showSetting.push({
          value: 'Đã chọn ' + (this.field.showSetting.length + 1)
        })
      } else if (type == 'remove') {
        if (item.value == this.field.defaultValue) {
          this.field.defaultValue = ''
        }
        this.field.showSetting.splice(index, 1)
      }
    },
    radioChange(val) {
      this.field.defaultValue == val
        ? (this.field.defaultValue = '')
        : (this.field.defaultValue = val)
    },
    /**
     * 多选
     */
    handleCheckbox(type, item, index) {
      if (this.disabled) {
        // 不能点击
        return
      }
      if (type == 'add') {
        this.field.showSetting.push({
          value: 'Đã chọn ' + (this.field.showSetting.length + 1)
        })
      } else if (type == 'remove') {
        const removeIndex = this.field.default_value.indexOf(item.value)
        if (removeIndex != -1) {
          this.field.default_value.splice(removeIndex, 1)
        }
        this.field.showSetting.splice(index, 1)
      }
    },
    /** * 输入默认值触发 */
    inputBlur(e) {
      if (this.field.formType == 'mobile') {
        if (!regexIsCRMMobile(this.field.defaultValue)) {
          this.$message({
            message: 'Sai định dạng số điện thoại',
            type: 'error'
          })
        }
      } else if (this.field.formType == 'email') {
        if (!regexIsCRMEmail(this.field.defaultValue)) {
          this.$message({
            message: 'Sai định dạng email',
            type: 'error'
          })
        }
      }
    }
  }
}
</script>
<style lang="scss" scoped>
.field-info-section {
  padding: 0 20px;
}

.item-section {
  padding: 10px 0 12px 0;
  border-bottom: 1px solid #e6e6e6;
  .name {
    font-size: 13px;
    font-size: 500;
    color: #333;
    margin: 10px 0;
  }
}

.input-tips {
  font-size: 12px;
  margin-top: 10px;
  color: #999;
  span {
    color: red;
  }
}

.el-checkbox /deep/ .el-checkbox__label {
  font-size: 13px;
  color: #333333;
}

.item-check-section {
  margin-top: 15px;
}

.radio {
  margin-top: 5px;
  margin-left: 0;
  /deep/ .el-radio {
    margin-right: 10px !important;
  }
  .input {
    display: inline-block;
    width: 180px;
  }
  .handle {
    color: #ccc;
    font-size: 20px;
  }
}

.checkbox {
  display: block;
  margin-left: 0;
  margin-top: 5px;
  /deep/.el-checkbox {
    margin-right: 10px;
    .el-checkbox__label {
      display: none;
    }
  }
  .input {
    display: inline-block;
    width: 180px;
  }
  .handle {
    color: #ccc;
    font-size: 20px;
  }
}
</style>
