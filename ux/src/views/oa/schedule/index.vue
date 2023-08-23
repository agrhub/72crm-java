<template>
  <div class="task-calendars">
    <div class="add-btn">
      <el-button
        type="primary"
        @click="newTask">
        Tạo lịch biểu
      </el-button>
    </div>
    <div
      ref="hoverDialog"
      class="hover-dialog">
      <div class="img-content">
        <span>{{ hoverDialogList.startTime | moment("YYYY-MM-DD") }}</span>
        <span v-if="hoverDialogList.endTime"> - {{ hoverDialogList.endTime | moment("YYYY-MM-DD") }}</span>
      </div>
      <div>
        {{ hoverDialogList.text }}
      </div>
    </div>
    <!-- 日历 -->
    <div
      v-loading="loading"
      id="calendar"/>
    <!-- 新建日程 -->
    <create-schedule
      v-if="showDialog"
      :text="newText"
      :form-data="formData"
      @onSubmit="onSubmit"
      @closeDialog="closeDialog"/>
    <!-- 详情 -->
    <v-details
      v-if="dialogVisible"
      :dialog-visible="dialogVisible"
      :list-data="listData"
      @editBtn="editBtn"
      @deleteClose="deleteClose"
      @handleClose="handleClose"/>
  </div>
</template>

<script>
import jQuery from 'jquery'
import 'fullcalendar'
import allLocales from 'fullcalendar/dist/locale-all'

import createSchedule from './components/createSchedule'
import VDetails from './components/details'
// API
import {
  scheduleList
} from '@/api/oamanagement/schedule'

// import { timestampToFormatTime } from '@/utils'

export default {
  components: {
    createSchedule,
    VDetails
  },
  data() {
    return {
      showDialog: false,
      hoverDialogList: {},
      dialogVisible: false,
      formData: {
        checkList: []
      },
      newtext: '',
      loading: true,
      // 详情数据
      listData: {}
    }
  },
  watch: {
    $route(to, from) {
      this.$router.go(0)
    }
  },
  /* created() {
    const _this = this
    jQuery(function() {
      _this.listFun()
    })
  }, */
  mounted() {
    // const _this = this
    console.log('Schedule')
    /* this.$nextTick(() => {
      _this.listFun()
    }) */
  },
  methods: {
    // 初始化日历任务
    listFun() {
      console.log('Schedule')
      // const _this = this
      var jq = jQuery.noConflict(false)
      jq('#calendar').fullCalendar({
        height: document.documentElement.clientHeight - 101,
        nextDayThreshold: '00:00:00',
        locales: allLocales,
        locale: 'vi', // the initial locale
        dayClick: function(date, jsEvent, view) {
          this.formData = {
            startTime: date.format('YYYY-MM-DD HH:mm:ss'),
            endTime: date.format('YYYY-MM-DD HH:mm:ss')
          }
          this.newText = 'Tạo lịch biểu'
          this.showDialog = true
        },
        // 点击显示详情
        eventClick: function(val, key) {
          const list = []
          list.push(val.startTime, val.endTime)
          val.time = list
          this.listData = val
          this.showParticulars(val)
        },
        header: {
          left: 'today,agendaDay,agendaWeek,month',
          center: 'prevYear,prev, title, next,nextYear',
          right: ''
        },
        eventMouseover: function(event, jsEvent, view) {
          this.$refs.hoverDialog.style.display = 'block'
          this.$refs.hoverDialog.style.width =
            document.getElementsByClassName('fc-day')[0].offsetWidth + 'px'
          this.$refs.hoverDialog.style.left =
            jsEvent.currentTarget.offsetLeft - 5 + 'px'
          this.$refs.hoverDialog.style.top =
            jsEvent.clientY - jsEvent.offsetY - 60 + 'px'
          this.hoverDialogList = {
            time: event.start._i,
            startTime: event.startTime,
            endTime: event.endTime,
            text: event.title,
            color: event.color,
            priority: event.priority
          }
        },
        eventMouseout: function(event, jsEvent, view) {
          this.$refs.hoverDialog.style.display = 'none'
        },
        events: function(start, end, timezone, callback) {
          this.loading = true
          const startTime = start.format('YYYY-MM-DD HH:mm:ss')
          const endTime = end.format('YYYY-MM-DD HH:mm:ss')
          scheduleList({
            startTime: startTime,
            endTime: endTime
          })
            .then(res => {
              const list = res.data.map(item => {
                item.start = item.startTime
                item.end = item.endTime
                item.color = item.color
                item.textColor = '#333'
                return item
              })
              callback(list)
              this.loading = false
            })
            .catch(() => {
              this.loading = false
            })
        }
      })
    },
    // 详情数据
    showParticulars(val) {
      this.dialogVisible = true
    },
    // 详情关闭
    handleClose() {
      this.dialogVisible = false
    },
    // 详情删除
    deleteClose(val) {
      var jq = jQuery.noConflict(false)
      jq('#calendar').fullCalendar('refetchEvents')
      this.handleClose()
    },
    // 详情编辑
    editBtn(val) {
      this.newText = 'Chỉnh sửa lịch biểu'
      val.startTime = val.startTime
      val.endTime = val.endTime
      this.formData = val
      this.handleClose()
      this.showDialog = true
    },
    // 新建按钮
    newTask() {
      this.newText = 'Tạo lịch biểu'
      this.showDialog = true
      this.formData = {
        checkList: []
      }
    },
    // 新建日程关闭按钮
    closeDialog() {
      this.showDialog = false
    },
    // 新建提交
    onSubmit(data, file) {
      var jq = jQuery.noConflict(false)
      if (this.newText == 'Tạo lịch biểu') {
        this.$message.success('Thành công')
        jq('#calendar').fullCalendar('refetchEvents')
        this.closeDialog()
      } else {
        this.$message.success('Thành công')
        jq('#calendar').fullCalendar('refetchEvents')
        this.closeDialog()
      }
    }
  }
}
</script>

<style>
@import 'fullcalendar/dist/fullcalendar.css';
</style>

<style lang="scss" scoped>
.task-calendars {
  position: relative;
  border: 1px solid #e6e6e6;
  border-radius: 4px;
  .hover-dialog {
    display: none;
    padding: 15px;
    z-index: 99;
    position: absolute;
    background: #fff;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    border-left: 2px solid transparent;
    .img-content {
      color: #999;
      margin-bottom: 10px;
      font-size: 12px;
      img {
        vertical-align: middle;
      }
    }
  }
  .add-btn {
    position: absolute;
    top: 14px;
    right: 40px;
  }
  #calendar {
    height: 100%;
    display: flex;
    flex-direction: column;
    background: #fff;
  }
  #calendar /deep/ .fc-license-message {
    display: none !important;
  }
  #calendar /deep/ .fc-toolbar {
    padding-top: 1em;
    .fc-left {
      padding-left: 20px;
      .fc-button-group {
        .fc-button {
          text-shadow: none;
        }
        .fc-state-default {
          background: #f0f0f0;
          padding: 0 1.2em;
          border: 0;
          margin-right: 3px;
        }
        .fc-state-down {
          box-shadow: none;
          text-shadow: none;
        }
        .fc-state-active {
          background: #3e84e9;
          color: #fff;
        }
      }
      .fc-today-button {
        background: #fff;
        margin-right: 50px;
      }
    }
    .fc-center {
      margin-left: -277px;
      h2 {
        font-size: 20px;
        font-weight: normal;
        margin-top: 5px;
      }
      .fc-prevYear-button,
      .fc-prev-button,
      .fc-next-button,
      .fc-nextYear-button {
        background: none;
        border: 0;
        color: #aaa;
        outline: none;
        box-shadow: none;
      }
      .fc-button-group {
        .fc-prev-button .fc-icon-left-single-arrow:after,
        .fc-next-button .fc-icon-right-single-arrow:after {
          font-size: 160%;
          font-weight: none;
        }
      }
    }
  }
  #calendar /deep/ .fc-view-container {
    .fc-body {
      .fc-row {
        .fc-day {
          border-color: #e9e9e9;
        }
        .fc-bg {
          .fc-sat,
          .fc-sun {
            background: #fbfbfb;
          }
          .fc-today {
            background: none;
          }
        }
        .fc-content-skeleton {
          .fc-today {
            .fc-day-number {
              background: #3e84e9;
              border-radius: 50%;
              padding: 3px;
              color: #fff;
              min-width: 16px;
              text-align: center;
            }
          }
          .fc-day-grid-event {
            border: 0 !important;
            border-radius: 23px;
            margin-left: 5px;
            margin-right: 5px;
            .fc-content {
              color: #fff;
              .fc-time {
                display: none;
              }
              .fc-title {
                float: left;
                width: 100%;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
              }
            }
          }
        }
        .fc-day-number {
          margin: 5px;
        }
        .fc-day-grid-event {
          border-left: 2px solid #ff9668 !important;
          border-radius: 0;
          margin-left: 0;
          margin-right: 0;
          padding: 2px 15px;
        }
      }
    }
    .fc-body > tr > .fc-widget-content {
      border: 0;
    }
    .fc-head {
      .fc-head-container {
        border: 0;
        border-bottom: 1px solid #ddd;
      }
    }
  }
  #calendar /deep/ .fc-day-header {
    background: #f5f5f5;
    border-width: 0;
    font-weight: normal;
    span {
      height: 50px;
      line-height: 50px;
    }
  }
}
</style>

