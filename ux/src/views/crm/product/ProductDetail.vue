<template>
  <slide-view
    v-empty="!canShowDetail"
    :listener-ids="listenerIDs"
    :no-listener-ids="noListenerIDs"
    :no-listener-class="noListenerClass"
    :body-style="{padding: 0, height: '100%'}"
    xs-empty-icon="nopermission"
    xs-empty-text="Không có quyền"
    @side-close="hideView">
    <flexbox
      v-loading="loading"
      v-if="canShowDetail"
      direction="column"
      align="stretch"
      class="d-container">
      <c-r-m-detail-head
        :detail="detailData"
        :head-details="headDetails"
        :id="id"
        crm-type="product"
        @handle="detailHeadHandle"
        @close="hideView"/>
      <div class="tabs">
        <el-tabs
          v-model="tabCurrentName"
          @tab-click="handleClick">
          <el-tab-pane
            v-for="(item, index) in tabnames"
            :key="index"
            :label="item.label"
            :name="item.name"/>
        </el-tabs>
      </div>
      <div class="t-loading-content">
        <keep-alive>
          <component
            :is="tabName"
            :detail="detailData"
            :id="id"
            crm-type="product"/>
        </keep-alive>
      </div>
    </flexbox>
    <c-r-m-create-view
      v-if="isCreate"
      :action="{type: 'update', id: id, batchId: detailData.batchId}"
      crm-type="product"
      @save-success="editSaveSuccess"
      @hiden-view="isCreate=false"/>
  </slide-view>
</template>

<script>
import { crmProductRead } from '@/api/customermanagement/product'

import SlideView from '@/components/SlideView'
import CRMDetailHead from '../components/CRMDetailHead'
import CRMBaseInfo from '../components/CRMBaseInfo' // 产品基本信息
import RelativeFiles from '../components/RelativeFiles' // 相关附件
import RelativeHandle from '../components/RelativeHandle' // 相关操作

import CRMCreateView from '../components/CRMCreateView' // 新建页面
import detail from '../mixins/detail'

export default {
  /** 客户管理 的 客户详情 */
  name: 'ProductDetail',
  components: {
    SlideView,
    CRMDetailHead,
    CRMBaseInfo,
    RelativeFiles,
    RelativeHandle,
    CRMCreateView
  },
  mixins: [detail],
  props: {
    // 详情信息id
    id: [String, Number],
    // 监听的dom 进行隐藏详情
    listenerIDs: {
      type: Array,
      default: () => {
        return ['crm-main-container']
      }
    },
    // 不监听
    noListenerIDs: {
      type: Array,
      default: () => {
        return []
      }
    },
    noListenerClass: {
      type: Array,
      default: () => {
        return ['el-table__body']
      }
    }
  },
  data() {
    return {
      loading: false, // 展示加载loading
      crmType: 'product',
      detailData: {}, // read 详情
      headDetails: [
        { title: 'Danh mục sản phẩm', value: '' },
        { title: 'Đơn vị sản phẩm', value: '' },
        { title: 'Giá sản phẩm', value: '' },
        { title: 'Mã sản phẩm (SKU)', value: '' }
      ],
      tabnames: [
        { label: 'Thông tin sản phẩm', name: 'basicinfo' },
        { label: 'Ảnh sản phẩm', name: 'file' },
        { label: 'Nhật ký', name: 'operationlog' }
      ],
      tabCurrentName: 'basicinfo',
      isCreate: false // 编辑操作
    }
  },
  computed: {
    tabName() {
      if (this.tabCurrentName == 'basicinfo') {
        return 'c-r-m-base-info'
      } else if (this.tabCurrentName == 'file') {
        return 'relative-files'
      } else if (this.tabCurrentName == 'operationlog') {
        return 'relative-handle'
      }
      return ''
    }
  },
  mounted() {},
  methods: {
    getDetial() {
      this.loading = true
      crmProductRead({
        productId: this.id
      })
        .then(res => {
          this.loading = false
          this.detailData = res.data

          this.headDetails[0].value = res.data.categoryName
          this.headDetails[1].value = res.data.unit
          this.headDetails[2].value = this.moneyFormat(res.data.price)
          this.headDetails[3].value = res.data.num
        })
        .catch(() => {
          this.loading = false
        })
    },
    //* * 点击关闭按钮隐藏视图 */
    hideView() {
      this.$emit('hide-view')
    },
    //* * tab标签点击 */
    handleClick(tab, event) {},
    editSaveSuccess() {
      this.$emit('handle', { type: 'save-success' })
      this.getDetial()
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../styles/crmdetail.scss';
</style>
