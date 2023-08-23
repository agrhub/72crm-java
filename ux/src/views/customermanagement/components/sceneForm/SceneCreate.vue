<template>
  <el-dialog
    :title="edit_id ? 'Chỉnh sửa kịch bản' : 'Thêm kịch bản mới'"
    :visible.sync="visible"
    :append-to-body="true"
    width="800px"
    @close="handleCancel">
    <div class="scene-name-container">
      <div class="scene-name">Tên kịch bản</div>
      <el-input
        v-model.trim="saveName"
        :maxlength="10"
        class="scene-input"
        placeholder="Vui lòng nhập tên kịch bản, tối đa 10 ký tự"/>
    </div>
    <div class="scene-name">Bộ lọc dữ liệu</div>
    <el-form
      id="scene-filter-container"
      class="filter-container">
      <el-form-item>
        <template v-for="(formItem, index) in form">
          <el-row :key="index">
            <el-col :span="8">
              <el-select
                v-model="formItem.fieldName"
                placeholder="Vui lòng chọn tên trường sẽ được lọc"
                @change="fieldChange(formItem)">
                <el-option
                  v-for="item in fieldList"
                  :key="item.fieldName"
                  :label="item.name"
                  :value="item.fieldName"/>
              </el-select>
            </el-col>

            <el-col
              v-if="formItem.formType !== 'date' && formItem.formType !== 'datetime' && formItem.formType !== 'business_type'"
              :span="1">&nbsp;</el-col>
            <el-col
              v-if="formItem.formType !== 'date' && formItem.formType !== 'datetime' && formItem.formType !== 'business_type'"
              :span="4">
              <el-select
                v-model="formItem.condition"
                placeholder="Vui lòng chọn điều kiện">
                <el-option
                  v-for="item in calConditionOptions(formItem.formType, formItem)"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value"/>
              </el-select>
            </el-col>

            <!-- 商机组 -->
            <el-col
              v-if="formItem.formType == 'business_type'"
              :span="1">&nbsp;</el-col>
            <el-col
              v-if="formItem.formType == 'business_type'"
              :span="4">
              <el-select
                v-model="formItem.typeId"
                placeholder="Vui lòng chọn"
                @change="typeOptionsChange(formItem)">
                <el-option
                  v-for="item in formItem.typeOption"
                  :key="item.typeId"
                  :label="item.name"
                  :value="item.typeId"/>
              </el-select>
            </el-col>

            <el-col :span="1">&nbsp;</el-col>
            <el-col :span="formItem.formType === 'datetime' || formItem.formType === 'date' ? 13 : 8">
              <el-select
                v-if="formItem.formType === 'select'"
                v-model="formItem.value"
                placeholder="Vui lòng chọn tiêu chí bộ lọc">
                <el-option
                  v-for="item in formItem.setting"
                  :key="item"
                  :label="item"
                  :value="item"/>
              </el-select>
              <el-select
                v-else-if="formItem.formType === 'checkStatus'"
                v-model="formItem.value"
                placeholder="Vui lòng chọn tiêu chí bộ lọc">
                <el-option
                  v-for="item in formItem.setting"
                  :key="item.value"
                  :label="item.name"
                  :value="item.value"/>
              </el-select>
              <el-date-picker
                v-else-if="formItem.formType === 'date' || formItem.formType === 'datetime'"
                v-model="formItem.value"
                :value-format="formItem.formType === 'date' ? 'yyyy-MM-dd' : 'yyyy-MM-dd HH:mm:ss'"
                :type="formItem.formType === 'date' ? 'daterange' : 'datetimerange'"
                style="padding: 0px 10px;"
                range-separator="-"
                start-placeholder="Ngày bắt đầu"
                end-placeholder="Ngày kết thúc"/>
              <el-select
                v-else-if="formItem.formType === 'business_type'"
                v-model="formItem.statusId"
                placeholder="Chọn">
                <el-option
                  v-for="item in formItem.statusOption"
                  :key="item.statusId"
                  :label="item.name"
                  :value="item.statusId"/>
              </el-select>
              <xh-user-cell
                v-else-if="formItem.formType === 'user'"
                :item="formItem"
                :value="formItem.value"
                @value-change="userValueChange"/>
              <el-input
                v-else
                v-model="formItem.value"
                placeholder="Vui lòng nhập giá trị"/>
            </el-col>
            <el-col
              :span="1"
              class="delete">
              <i
                class="el-icon-error delete-btn"
                @click="handleDelete(index)"/>
            </el-col>
          </el-row>
        </template>
      </el-form-item>
    </el-form>
    <p
      v-show="showErrors"
      class="el-icon-warning warning-info">
      <span class="desc">Có sự trùng lắp trong các điều kiện bộ lọc!</span>
    </p>
    <el-button
      type="text"
      @click="handleAdd">+ Thêm bộ lọc</el-button>
    <div class="save">
      <div class="save-setting">
        <el-checkbox v-model="saveDefault">Đặt làm mặc định</el-checkbox>
      </div>
    </div>
    <div
      slot="footer"
      class="dialog-footer">
      <el-button @click="handleCancel">Hủy</el-button>
      <el-button
        type="primary"
        @click="handleConfirm">Lưu</el-button>
    </div>
  </el-dialog>
</template>

<script>
import crmTypeModel from '@/views/customermanagement/model/crmTypeModel'
import { crmSceneSave, crmSceneUpdate } from '@/api/customermanagement/common'
import {
  objDeepCopy
} from '@/utils'
import { XhUserCell } from '@/components/CreateCom'

/**
 * fieldList: 高级筛选的字段
 *     type:  date || datetime || select || 其他 input
 */
export default {
  name: 'SceneCreate', // 新建场景
  components: {
    XhUserCell
  },
  props: {
    dialogVisible: {
      type: Boolean,
      required: true,
      default: false
    },
    fieldList: {
      type: Array,
      required: true,
      default: () => {
        return []
      }
    },
    obj: {
      type: Object,
      default: () => {
        return {}
      },
      required: true
    },
    /** 没有值就是全部类型 有值就是当个类型 */
    crmType: {
      type: String,
      default: ''
    },
    /** 名字和 默认 id 编辑的时候需要 */
    name: {
      type: String,
      default: ''
    },
    isDefault: {
      type: Boolean,
      default: false
    },
    edit_id: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      form: [],
      visible: false, // 控制展示
      showErrors: false,
      saveDefault: false, // 设置为默认场景
      saveName: null // 场景名称
    }
  },
  watch: {
    dialogVisible: {
      handler(val) {
        if (val) {
          // 处理编辑数据
          if (this.edit_id) {
            this.form = []
            for (const field in this.obj.obj) {
              const element = this.obj.obj[field]
              const item = this.getItem()
              item.fieldName = element.name
              item.condition = element.condition
              item.formType = element.formType
              if (element.formType == 'date') {
                item.value = [element.start_date, element.end_date]
              } else if (element.formType == 'datetime') {
                item.value = [element.start, element.end]
              } else if (element.formType == 'business_type') {
                item.typeId = element.typeId
                item.statusId = element.statusId
                item.typeOption = element.setting
                if (element.typeId) {
                  const obj = element.setting.find(typeItem => {
                    return typeItem.typeId === element.typeId
                  })
                  if (obj) {
                    item.statusOption = obj.statusList
                  } else {
                    item.statusOption = []
                  }
                }
              } else if (element.formType == 'user') {
                item.value = element.setting ? [element.setting] : []
              } else {
                item.setting = element.setting
                item.value = element.value
              }
              this.form.push(item)
            }
          } else {
            this.form = objDeepCopy(this.obj.form)
            if (this.form.length == 0) {
              this.form.push(this.getItem())
            }
          }

          /** 只有编辑会牵扯到这两个字段赋值 */
          if (this.name) {
            this.saveName = this.name
          } else {
            this.saveName = ''
          }
          if (this.isDefault) {
            this.saveDefault = this.isDefault
          } else {
            this.saveDefault = false
          }
        }
        this.visible = this.dialogVisible
      },
      deep: true,
      immediate: true
    },

    form() {
      this.$nextTick(() => {
        var container = document.getElementById('scene-filter-container')
        container.scrollTop = container.scrollHeight
      })
    }
  },
  methods: {
    getItem() {
      return {
        fieldName: '',
        name: '',
        formType: '',
        condition: 'is',
        value: '',
        typeOption: [],
        statusOption: [],
        typeId: '',
        statusId: ''
      }
    },
    /**
     * 商机组状态
     */
    typeOptionsChange(formItem) {
      if (formItem.typeId) {
        const obj = formItem.typeOption.find(item => {
          return item.typeId === formItem.typeId
        })
        formItem.statusOption = obj.statusList || []
      } else {
        formItem.statusOption = []
      }
      formItem.statusId = ''
    },
    /**
     * 用户创建人
     */
    userValueChange(data) {
      if (data.value.length > 0) {
        data.item.value = data.value
      } else {
        data.item.value = []
      }
    },
    /** 条件数据源 */
    calConditionOptions(formType, item) {
      if (
        formType == 'select' ||
        formType == 'checkbox' ||
        formType == 'user' ||
        formType == 'checkStatus'
      ) {
        return [
          { value: 'is', label: 'bằng', disabled: false },
          { value: 'isNot', label: 'không bằng', disabled: false }
        ]
      } else if (
        formType == 'module' ||
        formType == 'text' ||
        formType == 'textarea'
      ) {
        return [
          { value: 'is', label: 'bằng', disabled: false },
          { value: 'isNot', label: 'không bằng', disabled: false },
          { value: 'contains', label: 'có chứa', disabled: false },
          { value: 'notContains', label: 'không chứa', disabled: false }
        ]
      } else if (formType == 'floatnumber' || formType == 'number') {
        return [
          { value: 'is', label: 'bằng', disabled: false },
          { value: 'isNot', label: 'không bằng', disabled: false },
          { value: 'contains', label: 'có chứa', disabled: false },
          { value: 'notContains', label: 'không chứa', disabled: false },
          { value: 'isNull', label: 'là rỗng', disabled: false },
          { value: 'isNotNull', label: 'không rỗng', disabled: false },
          { value: 'gt', label: 'lớn hơn', disabled: false },
          { value: 'egt', label: 'lớn hơn hoặc bằng', disabled: false },
          { value: 'lt', label: 'nhỏ hơn', disabled: false },
          { value: 'elt', label: 'nhỏ hơn hoặc bằng', disabled: false }
        ]
      } else {
        return [
          { value: 'is', label: 'bằng', disabled: false },
          { value: 'isNot', label: 'không bằng', disabled: false },
          { value: 'contains', label: 'có chứa', disabled: false },
          { value: 'notContains', label: 'không chứa', disabled: false },
          { value: 'startWith', label: 'bắt đầu từ', disabled: false },
          { value: 'endWith', label: 'kết thúc lúc', disabled: false },
          { value: 'isNull', label: 'là rỗng', disabled: false },
          { value: 'isNotNull', label: 'không rỗng', disabled: false },
          { value: 'gt', label: 'lớn hơn', disabled: false },
          { value: 'egt', label: 'lớn hơn hoặc bằng', disabled: false },
          { value: 'lt', label: 'nhỏ hơn', disabled: false },
          { value: 'elt', label: 'nhỏ hơn hoặc bằng', disabled: false }
        ]
      }
    },
    /**
     * 当前选择的字段名改变，判断是否有重复
     * @param formItem
     */
    fieldChange(formItem) {
      const obj = this.fieldList.find(item => {
        return item.fieldName === formItem.fieldName
      })
      if (obj) {
        formItem.formType = obj.formType
        formItem.name = obj.name
        if (formItem.formType == 'business_type') {
          formItem.typeOption = obj.setting
          formItem.statusOption = []
          formItem.typeId = ''
          formItem.statusId = ''
        } else if (
          formItem.formType == 'select' ||
          formItem.formType == 'checkStatus'
        ) {
          formItem.setting = obj.setting || []
        } else if (
          formItem.formType === 'date' ||
          formItem.formType === 'datetime' ||
          formItem.formType === 'user'
        ) {
          formItem.value = []
        }
      }

      const arr = this.form.filter(item => {
        return item.fieldName === formItem.fieldName
      })
      if (arr.length > 1) this.showErrors = true
      else this.showErrors = false
    },
    /**
     * 取消选择
     */
    handleCancel() {
      this.visible = false
      this.$emit('update:dialogVisible', false)
    },
    /**
     * 确定选择
     */
    handleConfirm() {
      if (this.showErrors) {
        this.$message.error('Có sự trùng lắp trong bộ lọc!')
        return
      }
      if (!this.saveName || this.saveName === '') {
        this.$message.error('Tên kịch bản không được để trống!')
        return
      }
      for (let i = 0; i < this.form.length; i++) {
        const o = this.form[i]
        if (!o.fieldName || o.fieldName === '') {
          this.$message.error('Tên trường được lọc không được để trống!')
          return
        }

        if (o.formType == 'business_type') {
          if (!o.typeId && !o.statusId) {
            this.$message.error('Vui lòng nhập giá trị của tiêu chí lọc!')
            return
          }
        } else if (
          o.formType == 'date' ||
          o.formType == 'datetime' ||
          o.formType == 'user'
        ) {
          if (!o.value || o.value.length === 0) {
            this.$message.error('Vui lòng nhập giá trị của tiêu chí lọc!')
            return
          }
        } else if (!o.value) {
          this.$message.error('Vui lòng nhập giá trị của tiêu chí lọc!')
          return
        }
      }
      const obj = {}
      this.form.forEach(o => {
        if (o.formType == 'datetime' || o.formType == 'date') {
          obj[o.fieldName] = {
            start: o.value[0],
            end: o.value[1],
            formType: o.formType,
            name: o.fieldName
          }
        } else if (o.formType == 'business_type') {
          obj[o.fieldName] = {
            typeId: o.typeId,
            statusId: o.statusId,
            formType: o.formType,
            name: o.fieldName
          }
        } else if (o.formType == 'user') {
          obj[o.fieldName] = {
            condition: o.condition,
            value: o.value[0].userId,
            formType: o.formType,
            setting: o.value[0],
            name: o.fieldName
          }
        } else {
          obj[o.fieldName] = {
            condition: o.condition,
            value: o.value,
            formType: o.formType,
            name: o.fieldName
          }
        }
      })
      const data = {
        obj: obj,
        form: this.form,
        saveDefault: this.saveDefault,
        saveName: this.saveName
      }
      this.requestCreateScene(data)
    },
    // 创建场景
    requestCreateScene(data) {
      /** 编辑操作 */
      if (this.edit_id) {
        crmSceneUpdate({
          isDefault: data.saveDefault ? 1 : 0,
          name: data.saveName,
          sceneId: this.edit_id,
          data: JSON.stringify(data.obj)
        })
          .then(res => {
            this.$message({
              type: 'success',
              message: 'Thành công'
            })
            // 新建成功
            this.$emit('saveSuccess')
            this.handleCancel()
          })
          .catch(() => {})
      } else {
        crmSceneSave({
          type: crmTypeModel[this.crmType],
          isDefault: data.saveDefault ? 1 : 0,
          name: data.saveName,
          data: JSON.stringify(data.obj)
        })
          .then(res => {
            this.$message({
              type: 'success',
              message: 'Thành công'
            })
            // 新建成功
            this.$emit('saveSuccess')
            this.handleCancel()
          })
          .catch(() => {})
      }
    },
    /**
     * 添加筛选条件
     */
    handleAdd() {
      this.form.push(this.getItem())
    },
    /**
     * 删除筛选条件
     * @param index
     */
    handleDelete(index) {
      this.$confirm('Xác nhận xóa?', 'Thông báo', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      })
        .then(() => {
          this.form.splice(index, 1)
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
</script>

<style lang="scss" scoped>
/deep/ .el-dialog__body {
  padding: 10px 20px;
}

/deep/ .el-form-item__label {
  width: 100%;
  text-align: left;
}
.filter-container {
  max-height: 200px;
  overflow-y: auto;
}

.save {
  margin-top: 10px;
  .name {
    width: 300px;
    margin-left: 10px;
    /deep/ .el-input__inner {
      height: 32px;
    }
  }
  .save-setting {
    margin-top: 20px;
  }
}

.el-form-item {
  margin-bottom: 0;
}

.el-row {
  margin-bottom: 20px;
  .delete-btn {
    margin-left: 15px;
    color: #bbb;
    cursor: pointer;
  }
  .el-select,
  .el-date-editor {
    width: 100%;
  }
}

.warning-info {
  width: 100%;
  font-size: 14px;
  color: #f56c6c;
  margin-top: 10px;
  .desc {
    padding-left: 8px;
  }
}

.scene-name-container {
  padding-bottom: 15px;
  .scene-input {
    width: 300px;
  }
}
.scene-name {
  margin-bottom: 10px;
}
</style>
