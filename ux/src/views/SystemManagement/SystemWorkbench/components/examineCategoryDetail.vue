<template>
  <slide-view
    :listener-ids="['manager-main-container']"
    :no-listener-ids="['examine-table']"
    :append-to-body="true"
    :body-style="{padding: '10px 30px', height: '100%'}"
    class="d-view"
    @side-close="hideView">
    <flexbox
      orient="vertical"
      style="height: 100%;">
      <div class="header">
        <flexbox class="detail-header">
          <div class="header-name">{{ showData.title }}<i
            v-if="showData.isSys != 1"
            class="el-icon-delete delete"
            @click="deleteClick"/></div>
          <img
            class="header-close"
            src="@/assets/img/task_close.png"
            @click="hideView" >
        </flexbox>
        <div class="detail-header-des">
          <div class="status">Trạng thái：{{ showData.status == 0 ? 'Hủy kích hoạt' : 'Kích hoạt' }}</div>
          <div class="status-handle">
            Kích hoạt
            <el-switch
              v-model="examineStatus"
              @change="examineStatusChange"/>
          </div>
        </div>
      </div>
      <div class="detail-body">
        <create-sections
          title="Thông tin cơ bản"
          class="create-sections">
          <div class="create-sections-content">
            <div class="dialog-content">
              <flexbox class="content-items">
                <div class="content-items-name">Tên phê duyệt</div>
                <div class="content-items-value">{{ showData.title }}</div>
              </flexbox>
              <flexbox class="content-items">
                <div class="content-items-name">Phạm vi áp dụng</div>
                <div class="content-items-value">{{ showData|formatedScopeInfo }}</div>
              </flexbox>
              <flexbox class="content-items">
                <div class="content-items-name">Hướng dẫn phê duyệt</div>
                <div class="content-items-value">{{ showData.remarks }}</div>
              </flexbox>
            </div>
          </div>
        </create-sections>
        <create-sections
          title="Hình thức"
          class="create-sections">
          <div
            slot="header"
            class="preview-section">
            <el-button
              type="text"
              @click="handlePreview">Xem trước</el-button>
          </div>
        </create-sections>
        <create-sections
          title="Quá trình"
          class="create-sections">
          <div
            v-if="showData.examineType == 1"
            class="create-sections-content">
            <flexbox
              v-for="(item, index) in showData.stepList"
              :key="index"
              align="stretch"
              class="examine-flow">
              <div class="examine-flow-header">
                <div class="mark-circle"/>
                <div
                  v-if="index != 0"
                  class="mark-top-line"/>
                <div
                  v-if="index < showData.stepList.length - 1"
                  class="mark-bottom-line"/>
              </div>
              <div class="examine-flow-body">
                <div class="body-header"><span class="body-header-name">{{ index + 1|toRowName }}</span><span class="body-header-des">（{{ item|toRowNameDes }}）</span></div>
                <flexbox
                  v-if="item.userList.length > 0"
                  class="examine-users">
                  <div
                    v-for="(userItem, userIndex) in item.userList"
                    :key="userIndex"
                    class="examine-users-item">
                    <div
                      v-photo="userItem"
                      v-lazy:background-image="$options.filters.filterUserLazyImg(userItem.img)"
                      class="div-photo"/>
                    <div class="name">{{ userItem.realname }}</div>
                  </div>
                </flexbox>
              </div>
            </flexbox>
          </div>
          <div
            v-else
            class="create-sections-content">Người phê duyệt được ủy quyền</div>
        </create-sections>
      </div>
    </flexbox>
    <!-- 表单预览 -->
    <preview-field-view
      v-if="showTablePreview"
      :types="tablePreviewData.types"
      :types-id="tablePreviewData.typesId"
      label="10"
      @hiden-view="showTablePreview=false"/>
  </slide-view>
</template>

<script>
import SlideView from '@/components/SlideView'
import CreateSections from '@/components/CreateSections'
import PreviewFieldView from '@/views/SystemManagement/components/previewFieldView'
import Nzhcn from 'nzh/cn'
import {
  oaExamineCategoryDelete,
  oaExamineCategoryEnables
} from '@/api/systemManagement/workbench'

export default {
  /** 办公审批类型详情 */
  name: 'ExamineCategoryDetail',
  components: {
    SlideView,
    CreateSections,
    PreviewFieldView
  },
  filters: {
    formatedScopeInfo(data) {
      var name = ''
      var structures = data['deptIds']
        ? data['deptIds']
        : []
      for (let index = 0; index < structures.length; index++) {
        const element = structures[index]
        name = name + element.name + '、'
      }
      var users = data['userIds'] ? data['userIds'] : []
      for (let index = 0; index < users.length; index++) {
        const element = users[index]
        name =
          name + element.realname + (index === users.length - 1 ? '' : '、')
      }
      return name || 'Toàn công ty'
    },
    // 标题
    toRowName: function(value) {
      return 'Đầu tiên' + Nzhcn.encodeS(value) + 'cấp độ'
    },
    // 标题描述
    toRowNameDes: function(data) {
      if (data.stepType == 1) {
        return 'Người phụ trách'
      } else if (data.stepType == 2) {
        return data.userList.length + 'Người ký'
      } else if (data.stepType == 3) {
        return data.userList.length + 'Mọi người ký tên'
      } else if (data.stepType == 4) {
        return 'Người giám sát của người phê duyệt cấp trên'
      }
      return ''
    }
  },
  props: {
    // 详情信息
    data: Object
  },
  data() {
    return {
      showData: {},
      examineStatus: false,
      // 展示表单预览
      tablePreviewData: { types: '', typesId: '' },
      showTablePreview: false
    }
  },
  computed: {},
  watch: {
    data: function(value) {
      this.getShowData()
    }
  },
  mounted() {
    this.getShowData()
  },
  methods: {
    // 预览表单
    handlePreview() {
      this.tablePreviewData.types = 'oa_examine'
      this.tablePreviewData.typesId = this.data.categoryId
      this.showTablePreview = true
    },
    deleteClick() {
      // 启用停用
      this.$confirm('Bạn có chắc chắn muốn xóa quy trình phê duyệt này không?', 'Thông báo', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning'
      })
        .then(() => {
          oaExamineCategoryDelete({
            id: this.data['categoryId']
          })
            .then(res => {
              this.$emit('refresh')
              this.hideView()
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
    },
    getShowData() {
      this.showData = Object.assign({}, this.data)
      this.examineStatus = this.showData.status != 0
    },
    // 切换审批状态
    examineStatusChange(status) {
      this.showData.status = status ? 1 : 0
      // 启用停用
      this.$confirm(
        'Bạn có chắc bạn muốn ' + (status ? 'kích hoạt' : 'hủy kích hoạt') + ' quy trình phê duyệt này?',
        'Thông báo',
        {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }
      )
        .then(() => {
          oaExamineCategoryEnables({
            id: this.data['categoryId'],
            status: status ? 1 : 0
          })
            .then(res => {
              this.$emit('refresh')
              this.$message({
                type: 'success',
                message: 'Thành công'
              })
            })
            .catch(() => {
              this.cancelStatusChange()
            })
        })
        .catch(() => {
          this.cancelStatusChange()
          this.$message({
            type: 'info',
            message: 'Không thành công'
          })
        })
    },
    cancelStatusChange() {
      this.examineStatus = !this.examineStatus
      this.showData.status = this.examineStatus ? 1 : 0
    },
    //* * 点击关闭按钮隐藏视图 */
    hideView() {
      this.$emit('hide-view')
    }
  }
}
</script>

<style lang="scss" scoped>
.header {
  width: 100%;
  margin-bottom: 30px;
}
.detail-header {
  position: relative;
  min-height: 60px;
  .header-name {
    font-size: 14px;
    color: #333333;
    flex: 1;
    .delete {
      color: #3e84e9;
      padding: 0 10px;
      font-size: 13px;
      cursor: pointer;
    }
  }
  .header-close {
    display: block;
    width: 30px;
    height: 30px;
    margin-left: 20px;
    padding: 5px;
    cursor: pointer;
  }
}

.detail-header-des {
  color: #999999;
  font-size: 12px;
  .status {
    float: left;
  }
  .status-handle {
    float: right;
  }
}

.detail-body {
  flex: 1;
  overflow-y: auto;
  width: 100%;

  .create-sections {
    padding: 5px 0;
    /deep/ .section-header {
      padding: 5px 0;
    }
  }

  .create-sections-content {
    padding: 0;
  }

  .dialog-content {
    margin-top: 10px;
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
}
// 预览
.preview-section {
  flex: 1;
  button {
    float: right;
    margin-right: 20px;
  }
}

// 审批流
.examine-flow {
  .examine-flow-header {
    position: relative;
    .mark-circle {
      width: 8px;
      height: 8px;
      border-radius: 4px;
      background-color: #ee7228;
      margin: 11px 20px 0 5px;
    }
    .mark-top-line {
      width: 1px;
      background-color: #e6e6e6;
      position: absolute;
      top: 0;
      left: 9px;
      height: 11px;
    }
    .mark-bottom-line {
      width: 1px;
      background-color: #e6e6e6;
      position: absolute;
      top: 19px;
      left: 9px;
      bottom: 0;
    }
  }

  .examine-flow-body {
    .body-header {
      padding: 8px 0;
      font-size: 13px;
      .body-header-name {
        color: #333333;
      }
      .body-header-des {
        color: #777777;
      }
    }
  }
}

// 人信息
.examine-users {
  text-align: center;
  .examine-users-item {
    padding: 10px 20px 10px 0;
    .div-photo {
      width: 40px;
      height: 40px;
      border-radius: 20px;
    }
    .name {
      color: #333333;
      font-size: 12px;
      padding: 2px 0;
      width: 60px;
      overflow: hidden;
    }
  }
}

.d-view {
  position: fixed;
  width: 500px;
  top: 60px;
  bottom: 0px;
  right: 0px;
}
</style>

