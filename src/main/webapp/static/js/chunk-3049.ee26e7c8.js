(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-3049"],{"0lve":function(e,t,n){"use strict";var a=n("P7Ww");n.n(a).a},"1oTa":function(e,t,n){"use strict";n.r(t);var a=n("ULJF"),s={name:"LogStatistics",components:{filtrateHandleView:n("gXW+").a},data:function(){return{loading:!1,tableHeight:document.documentElement.clientHeight-190,postParams:{},list:[],fieldList:[{field:"realname",name:"Nhân viên"},{field:"count",name:"Số lượng"},{field:"unReadCont",name:"Người nhận không đọc"},{field:"unCommentCount",name:"Không phản hồi"},{field:"commentCount",name:"Số lượng phản hồi"}]}},mounted:function(){var e=this;window.onresize=function(){e.tableHeight=document.documentElement.clientHeight-190}},methods:{getDataList:function(e){var t=this;this.postParams=e,this.loading=!0,Object(a.e)(e).then(function(e){t.list=e.data||[],t.loading=!1}).catch(function(){t.loading=!1})},exportExcel:function(){var e=this;this.loading=!0,Object(a.d)(this.postParams).then(function(t){e.loading=!1;var n=new Blob([t.data],{type:"application/vnd.ms-excel;charset=utf-8"}),a=document.createElement("a"),s=window.URL.createObjectURL(n);a.href=s,a.download=decodeURI(t.headers["content-disposition"].split("filename=")[1])||"",document.body.appendChild(a),a.click(),document.body.removeChild(a),window.URL.revokeObjectURL(s)}).catch(function(){e.loading=!1})}}},i=(n("Etek"),n("KHd+")),l=Object(i.a)(s,function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticClass:"main-container"},[n("filtrate-handle-view",{staticClass:"filtrate-bar",attrs:{"module-type":"oa"},on:{load:function(t){e.loading=!0},change:e.getDataList}},[n("el-button",{staticClass:"export-button",attrs:{type:"primary"},nativeOn:{click:function(t){return e.exportExcel(t)}}},[e._v("Xuất báo cáo")])],1),e._v(" "),n("div",{staticClass:"content"},[n("div",{staticClass:"table-content"},[n("el-table",{attrs:{data:e.list,height:e.tableHeight,stripe:"",border:"","highlight-current-row":""}},e._l(e.fieldList,function(e,t){return n("el-table-column",{key:t,attrs:{prop:e.field,label:e.name,align:"center","header-align":"center"}})}))],1)])],1)},[],!1,null,"d773b858",null);l.options.__file="log.vue";t.default=l.exports},"7F1U":function(e,t,n){},Etek:function(e,t,n){"use strict";var a=n("tOIf");n.n(a).a},P7Ww:function(e,t,n){},ULJF:function(e,t,n){"use strict";n.d(t,"e",function(){return s}),n.d(t,"d",function(){return i}),n.d(t,"c",function(){return l}),n.d(t,"b",function(){return o}),n.d(t,"a",function(){return u});var a=n("t3Un");function s(e){return Object(a.a)({url:"biWork/logStatistics",method:"post",data:e})}function i(e){return Object(a.a)({url:"biWork/logStatisticsExport",method:"post",data:e,responseType:"blob",timeout:6e5})}function l(e){return Object(a.a)({url:"biWork/examineStatistics",method:"post",data:e})}function o(e){return Object(a.a)({url:"biWork/examineInfo",method:"post",data:e})}function u(e){return Object(a.a)({url:"biWork/examineStatisticsExport",method:"post",data:e,responseType:"blob",timeout:6e5})}},"gXW+":function(e,t,n){"use strict";var a=n("KTTK"),s=n("UcQx"),i=n("conU"),l=n("uKQN"),o=n("wd/R"),u=n.n(o),c={name:"FiltrateHandleView",components:{timeTypeSelect:l.a},props:{moduleType:{required:!0,type:String},showYearSelect:{default:!1,type:Boolean},showBusinessSelect:{default:!1,type:Boolean},showUserSelect:{default:!0,type:Boolean},showCustomSelect:{default:!1,type:Boolean},customDefault:"",customOptions:{default:function(){return[]},type:Array},showProductSelect:{default:!1,type:Boolean}},data:function(){return{pickerOptions:{disabledDate:function(e){return e.getTime()>Date.now()}},yearValue:"",timeTypeValue:{},structuresProps:{children:"children",label:"label",value:"id"},deptList:[],structuresSelectValue:"",userOptions:[],userSelectValue:"",businessOptions:[],businessStatusValue:"",productValue:[],productOptions:[],customValue:""}},watch:{},mounted:function(){var e=this;this.showCustomSelect&&(this.customValue=this.customDefault),this.showYearSelect&&(this.yearValue=u()(new Date).year().toString()),this.$emit("load"),this.getDeptList(function(){e.showBusinessSelect?e.getBusinessStatusList(function(){e.postFiltrateValue()}):e.postFiltrateValue()}),this.showProductSelect&&this.getProductCategoryIndex()},beforeDestroy:function(){},methods:{customSelectChange:function(){this.$emit("typeChange",this.customValue)},timeTypeChange:function(e){this.timeTypeValue=e},getDeptList:function(e){var t=this;Object(a.b)({m:"bi",c:this.moduleType,a:"read"}).then(function(n){t.deptList=n.data,n.data.length>0?(t.structuresSelectValue=n.data[0].id,t.showUserSelect&&t.getUserList()):t.structuresSelectValue="",e(!0)}).catch(function(){t.$emit("error")})},structuresValueChange:function(e){this.showUserSelect&&(this.userSelectValue="",this.userOptions=[],this.getUserList())},getUserList:function(){var e=this,t={};t.deptId=this.structuresSelectValue,Object(a.i)(t).then(function(t){e.userOptions=t.data}).catch(function(){e.$emit("error")})},getBusinessStatusList:function(e){var t=this;Object(s.q)().then(function(n){t.businessOptions=n.data,n.data.length>0&&(t.businessStatusValue=n.data[0].typeId),e(!0)}).catch(function(){t.$emit("error")})},getProductCategoryIndex:function(){var e=this;Object(i.u)({type:"tree"}).then(function(t){e.productOptions=t.data}).catch(function(){})},postFiltrateValue:function(){var e={deptId:this.structuresSelectValue};this.showUserSelect&&(e.userId=this.userSelectValue),this.showBusinessSelect&&(e.typeId=this.businessStatusValue),this.showProductSelect&&(e.categoryId=this.productValue.length>0?this.productValue[this.productValue.length-1]:""),this.showYearSelect?e.year=this.yearValue:"custom"==this.timeTypeValue.type?(e.startTime=this.timeTypeValue.startTime,e.endTime=this.timeTypeValue.endTime):e.type=this.timeTypeValue.value,this.$emit("change",e)}}},r=(n("0lve"),n("KHd+")),d=Object(r.a)(c,function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"filtrate-content"},[e.showYearSelect?e._e():n("time-type-select",{on:{change:e.timeTypeChange}}),e._v(" "),e.showYearSelect?n("el-date-picker",{attrs:{clearable:!1,"picker-options":e.pickerOptions,type:"year","value-format":"yyyy",placeholder:"Chọn năm"},model:{value:e.yearValue,callback:function(t){e.yearValue=t},expression:"yearValue"}}):e._e(),e._v(" "),n("el-select",{attrs:{placeholder:"Chọn bộ phận"},on:{change:e.structuresValueChange},model:{value:e.structuresSelectValue,callback:function(t){e.structuresSelectValue=t},expression:"structuresSelectValue"}},e._l(e.deptList,function(e){return n("el-option",{key:e.id,attrs:{label:e.name,value:e.id}})})),e._v(" "),e.showUserSelect?n("el-select",{attrs:{clearable:!0,placeholder:"Chọn nhân viên"},model:{value:e.userSelectValue,callback:function(t){e.userSelectValue=t},expression:"userSelectValue"}},e._l(e.userOptions,function(e){return n("el-option",{key:e.id,attrs:{label:e.realname,value:e.id}})})):e._e(),e._v(" "),e.showBusinessSelect?n("el-select",{attrs:{placeholder:"Đơn vị kinh doanh"},model:{value:e.businessStatusValue,callback:function(t){e.businessStatusValue=t},expression:"businessStatusValue"}},e._l(e.businessOptions,function(e){return n("el-option",{key:e.typeId,attrs:{label:e.name,value:e.typeId}})})):e._e(),e._v(" "),e.showProductSelect?n("el-cascader",{staticStyle:{width:"100%"},attrs:{options:e.productOptions,"show-all-levels":!1,props:{children:"children",label:"label",value:"categoryId"},"change-on-select":""},model:{value:e.productValue,callback:function(t){e.productValue=t},expression:"productValue"}}):e._e(),e._v(" "),e.showCustomSelect?n("el-select",{attrs:{placeholder:"Loại biểu tượng"},on:{change:e.customSelectChange},model:{value:e.customValue,callback:function(t){e.customValue=t},expression:"customValue"}},e._l(e.customOptions,function(e){return n("el-option",{key:e.value,attrs:{label:e.name,value:e.value}})})):e._e(),e._v(" "),n("el-button",{attrs:{type:"primary"},nativeOn:{click:function(t){e.postFiltrateValue()}}},[e._v("Tìm kiếm")]),e._v(" "),e._t("default")],2)},[],!1,null,"6eac449c",null);d.options.__file="filtrateHandleView.vue";t.a=d.exports},tOIf:function(e,t,n){},uKQN:function(e,t,n){"use strict";var a={name:"TimeTypeSelect",props:{defaultType:Object},data:function(){return{selectType:{label:"Năm nay",value:"year"},showTypePopover:!1,showCustomContent:!1,sureCustomContent:!1,startTime:"",endTime:"",typeOptions:[{label:"Hôm nay",value:"today"},{label:"Hôm qua",value:"yesterday"},{label:"Tuần này",value:"week"},{label:"Tuần rồi",value:"lastWeek"},{label:"Tháng này",value:"month"},{label:"Tháng trước",value:"lastMonth"},{label:"Quý này",value:"quarter"},{label:"Quý trước",value:"lastQuarter"},{label:"Năm nay",value:"year"},{label:"Năm trước",value:"lastYear"}]}},computed:{iconClass:function(){return this.showTypePopover?"arrow-up":"arrow-down"},typeShowValue:function(){return this.sureCustomContent?this.startTime||this.endTime?(this.startTime||"")+"-"+(this.endTime||""):"":this.selectType.label}},mounted:function(){this.defaultType?this.selectType=this.defaultType:this.$emit("change",{type:"default",value:this.selectType.value})},methods:{typeSelectClick:function(e){this.showTypePopover=!1,this.sureCustomContent=!1,this.showCustomContent=!1,this.selectType=e,this.$emit("change",{type:"default",value:this.selectType.value})},customSureClick:function(){this.startTime&&this.endTime&&(this.sureCustomContent=!0,this.showTypePopover=!1,this.$emit("change",{type:"custom",startTime:this.startTime,endTime:this.endTime}))}}},s=(n("w4JZ"),n("KHd+")),i=Object(s.a)(a,function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("el-popover",{attrs:{placement:"bottom",width:"200","popper-class":"no-padding-popover",trigger:"click"},model:{value:e.showTypePopover,callback:function(t){e.showTypePopover=t},expression:"showTypePopover"}},[n("div",{staticClass:"type-popper"},[n("div",{staticClass:"type-content"},[e._l(e.typeOptions,function(t,a){return n("div",{key:a,staticClass:"type-content-item",class:{selected:e.selectType.value==t.value&&!e.showCustomContent},on:{click:function(n){e.typeSelectClick(t)}}},[n("div",{staticClass:"mark"}),e._v(e._s(t.label)+"\n      ")])}),e._v(" "),n("div",{staticClass:"type-content-item",class:{selected:e.showCustomContent},on:{click:function(t){e.showCustomContent=!0}}},[n("div",{staticClass:"mark"}),e._v("Tùy chỉnh\n      ")])],2),e._v(" "),e.showCustomContent?n("div",{staticClass:"type-content-custom"},[n("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"Chọn ngày bắt đầu"},model:{value:e.startTime,callback:function(t){e.startTime=t},expression:"startTime"}}),e._v(" "),n("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"Chọn ngày kết thúc"},model:{value:e.endTime,callback:function(t){e.endTime=t},expression:"endTime"}}),e._v(" "),n("el-button",{on:{click:e.customSureClick}},[e._v("OK")])],1):e._e()]),e._v(" "),n("el-input",{staticClass:"type-select",attrs:{slot:"reference",readonly:!0,placeholder:"Vui lòng chọn"},slot:"reference",model:{value:e.typeShowValue,callback:function(t){e.typeShowValue=t},expression:"typeShowValue"}},[n("i",{class:["el-input__icon","el-icon-"+e.iconClass],attrs:{slot:"suffix"},slot:"suffix"})])],1)},[],!1,null,"398cb27e",null);i.options.__file="index.vue";t.a=i.exports},w4JZ:function(e,t,n){"use strict";var a=n("7F1U");n.n(a).a}}]);