(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-3898"],{"0lve":function(t,e,n){"use strict";var a=n("P7Ww");n.n(a).a},"7F1U":function(t,e,n){},NAyz:function(t,e,n){"use strict";var a=n("oj9+");e.a={data:function(){return{loading:!1,axisOption:{color:["#6ca2ff"],tooltip:{trigger:"axis",formatter:"{b} : {c}đồng",axisPointer:{type:"shadow"}},grid:{top:"40px",left:"30px",right:"50px",bottom:"40px",containLabel:!0,borderColor:"#fff"},xAxis:[{name:"（đồng）",type:"value",data:[],axisTick:{alignWithLabel:!0,lineStyle:{width:0}},axisLabel:{color:"#BDBDBD",formatter:"{value}"},axisLine:{show:!1}}],yAxis:[{type:"category",axisTick:{alignWithLabel:!0,lineStyle:{width:0}},axisLabel:{color:"#BDBDBD"},axisLine:{lineStyle:{color:"#BDBDBD"}},splitLine:{show:!1}}],series:[{type:"bar",label:{normal:{show:!0,position:"right",color:"#333"}},barWidth:20,data:[]}]},axisChart:null,list:[],fieldList:[]}},mixins:[a.a],components:{},props:{},computed:{},watch:{},mounted:function(){},methods:{},deactivated:function(){}}},P7Ww:function(t,e,n){},"PW6+":function(t,e,n){"use strict";var a=n("U97t");n.n(a).a},U97t:function(t,e,n){},W3Rq:function(t,e,n){"use strict";n.r(e);var a=n("NAyz"),i=n("MT78"),s=n.n(i),o=n("X8ug"),l={name:"RankingRecordNunStatistics",mixins:[a.a],data:function(){return{}},computed:{},mounted:function(){this.fieldList=[{field:"realname",name:"Chữ ký"},{field:"structureName",name:"Phòng ban"},{field:"count",name:"Số lượt theo dõi (lần)"}],this.initAxis()},methods:{getDataList:function(t){var e=this;this.loading=!0,Object(o.h)(t).then(function(t){e.loading=!1,e.list=t.data||[];for(var n=[],a=[],i=t.data.length>10?10:t.data.length,s=0;s<i;s++){var o=t.data[s];n.splice(0,0,parseFloat(o.count)),a.splice(0,0,o.realname)}e.axisOption.yAxis[0].data=a,e.axisOption.series[0].data=n,e.axisChart.setOption(e.axisOption,!0)}).catch(function(){e.loading=!1})},initAxis:function(){this.axisChart=s.a.init(document.getElementById("axismain")),this.axisOption.tooltip.formatter="{b} : {c}lần",this.axisOption.xAxis[0].name="（lần）",this.axisChart.setOption(this.axisOption,!0)}}},u=(n("PW6+"),n("KHd+")),c=Object(u.a)(l,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],staticClass:"main-container"},[n("filtrate-handle-view",{staticClass:"filtrate-bar",attrs:{"show-user-select":!1,"module-type":"ranking"},on:{load:function(e){t.loading=!0},change:t.getDataList}}),t._v(" "),n("div",{staticClass:"content"},[n("div",{staticClass:"content-title"},[t._v("Xếp hạng thời gian theo dõi (dựa trên thời gian trao đổi)")]),t._v(" "),n("div",{directives:[{name:"empty",rawName:"v-empty",value:0===t.list.length,expression:"list.length === 0"}],staticClass:"axis-content",attrs:{"xs-empty-text":"Không có xếp hạng"}},[n("div",{attrs:{id:"axismain"}})]),t._v(" "),n("div",{staticClass:"table-content"},[n("el-table",{attrs:{data:t.list,height:"400",stripe:"",border:"","highlight-current-row":""}},[n("el-table-column",{attrs:{align:"center","header-align":"center","show-overflow-tooltip":"",label:"Xếp hạng tổng thể của công ty"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v("\n            "+t._s(e.$index+1)+"\n          ")]}}])}),t._v(" "),t._l(t.fieldList,function(t,e){return n("el-table-column",{key:e,attrs:{prop:t.field,label:t.name,align:"center","header-align":"center","show-overflow-tooltip":""}})})],2)],1)])],1)},[],!1,null,"709c5294",null);c.options.__file="RankingRecordNunStatistics.vue";e.default=c.exports},X8ug:function(t,e,n){"use strict";n.d(e,"c",function(){return i}),n.d(e,"f",function(){return s}),n.d(e,"i",function(){return o}),n.d(e,"e",function(){return l}),n.d(e,"b",function(){return u}),n.d(e,"a",function(){return c}),n.d(e,"h",function(){return r}),n.d(e,"g",function(){return d}),n.d(e,"d",function(){return h});var a=n("t3Un");function i(t){return Object(a.a)({url:"biRanking/contractRanKing",method:"post",data:t})}function s(t){return Object(a.a)({url:"biRanking/receivablesRanKing",method:"post",data:t})}function o(t){return Object(a.a)({url:"biRanking/contractCountRanKing",method:"post",data:t})}function l(t){return Object(a.a)({url:"biRanking/productCountRanKing",method:"post",data:t})}function u(t){return Object(a.a)({url:"biRanking/customerCountRanKing",method:"post",data:t})}function c(t){return Object(a.a)({url:"biRanking/contactsCountRanKing",method:"post",data:t})}function r(t){return Object(a.a)({url:"biRanking/recordCountRanKing",method:"post",data:t})}function d(t){return Object(a.a)({url:"biRanking/customerGenjinCountRanKing",method:"post",data:t})}function h(t){return Object(a.a)({url:"biRanking/travelCountRanKing",method:"post",data:t})}},"gXW+":function(t,e,n){"use strict";var a=n("KTTK"),i=n("UcQx"),s=n("conU"),o=n("uKQN"),l=n("wd/R"),u=n.n(l),c={name:"FiltrateHandleView",components:{timeTypeSelect:o.a},props:{moduleType:{required:!0,type:String},showYearSelect:{default:!1,type:Boolean},showBusinessSelect:{default:!1,type:Boolean},showUserSelect:{default:!0,type:Boolean},showCustomSelect:{default:!1,type:Boolean},customDefault:"",customOptions:{default:function(){return[]},type:Array},showProductSelect:{default:!1,type:Boolean}},data:function(){return{pickerOptions:{disabledDate:function(t){return t.getTime()>Date.now()}},yearValue:"",timeTypeValue:{},structuresProps:{children:"children",label:"label",value:"id"},deptList:[],structuresSelectValue:"",userOptions:[],userSelectValue:"",businessOptions:[],businessStatusValue:"",productValue:[],productOptions:[],customValue:""}},watch:{},mounted:function(){var t=this;this.showCustomSelect&&(this.customValue=this.customDefault),this.showYearSelect&&(this.yearValue=u()(new Date).year().toString()),this.$emit("load"),this.getDeptList(function(){t.showBusinessSelect?t.getBusinessStatusList(function(){t.postFiltrateValue()}):t.postFiltrateValue()}),this.showProductSelect&&this.getProductCategoryIndex()},beforeDestroy:function(){},methods:{customSelectChange:function(){this.$emit("typeChange",this.customValue)},timeTypeChange:function(t){this.timeTypeValue=t},getDeptList:function(t){var e=this;Object(a.b)({m:"bi",c:this.moduleType,a:"read"}).then(function(n){e.deptList=n.data,n.data.length>0?(e.structuresSelectValue=n.data[0].id,e.showUserSelect&&e.getUserList()):e.structuresSelectValue="",t(!0)}).catch(function(){e.$emit("error")})},structuresValueChange:function(t){this.showUserSelect&&(this.userSelectValue="",this.userOptions=[],this.getUserList())},getUserList:function(){var t=this,e={};e.deptId=this.structuresSelectValue,Object(a.i)(e).then(function(e){t.userOptions=e.data}).catch(function(){t.$emit("error")})},getBusinessStatusList:function(t){var e=this;Object(i.q)().then(function(n){e.businessOptions=n.data,n.data.length>0&&(e.businessStatusValue=n.data[0].typeId),t(!0)}).catch(function(){e.$emit("error")})},getProductCategoryIndex:function(){var t=this;Object(s.u)({type:"tree"}).then(function(e){t.productOptions=e.data}).catch(function(){})},postFiltrateValue:function(){var t={deptId:this.structuresSelectValue};this.showUserSelect&&(t.userId=this.userSelectValue),this.showBusinessSelect&&(t.typeId=this.businessStatusValue),this.showProductSelect&&(t.categoryId=this.productValue.length>0?this.productValue[this.productValue.length-1]:""),this.showYearSelect?t.year=this.yearValue:"custom"==this.timeTypeValue.type?(t.startTime=this.timeTypeValue.startTime,t.endTime=this.timeTypeValue.endTime):t.type=this.timeTypeValue.value,this.$emit("change",t)}}},r=(n("0lve"),n("KHd+")),d=Object(r.a)(c,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"filtrate-content"},[t.showYearSelect?t._e():n("time-type-select",{on:{change:t.timeTypeChange}}),t._v(" "),t.showYearSelect?n("el-date-picker",{attrs:{clearable:!1,"picker-options":t.pickerOptions,type:"year","value-format":"yyyy",placeholder:"Chọn năm"},model:{value:t.yearValue,callback:function(e){t.yearValue=e},expression:"yearValue"}}):t._e(),t._v(" "),n("el-select",{attrs:{placeholder:"Chọn bộ phận"},on:{change:t.structuresValueChange},model:{value:t.structuresSelectValue,callback:function(e){t.structuresSelectValue=e},expression:"structuresSelectValue"}},t._l(t.deptList,function(t){return n("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})})),t._v(" "),t.showUserSelect?n("el-select",{attrs:{clearable:!0,placeholder:"Chọn nhân viên"},model:{value:t.userSelectValue,callback:function(e){t.userSelectValue=e},expression:"userSelectValue"}},t._l(t.userOptions,function(t){return n("el-option",{key:t.id,attrs:{label:t.realname,value:t.id}})})):t._e(),t._v(" "),t.showBusinessSelect?n("el-select",{attrs:{placeholder:"Đơn vị kinh doanh"},model:{value:t.businessStatusValue,callback:function(e){t.businessStatusValue=e},expression:"businessStatusValue"}},t._l(t.businessOptions,function(t){return n("el-option",{key:t.typeId,attrs:{label:t.name,value:t.typeId}})})):t._e(),t._v(" "),t.showProductSelect?n("el-cascader",{staticStyle:{width:"100%"},attrs:{options:t.productOptions,"show-all-levels":!1,props:{children:"children",label:"label",value:"categoryId"},"change-on-select":""},model:{value:t.productValue,callback:function(e){t.productValue=e},expression:"productValue"}}):t._e(),t._v(" "),t.showCustomSelect?n("el-select",{attrs:{placeholder:"Loại biểu tượng"},on:{change:t.customSelectChange},model:{value:t.customValue,callback:function(e){t.customValue=e},expression:"customValue"}},t._l(t.customOptions,function(t){return n("el-option",{key:t.value,attrs:{label:t.name,value:t.value}})})):t._e(),t._v(" "),n("el-button",{attrs:{type:"primary"},nativeOn:{click:function(e){t.postFiltrateValue()}}},[t._v("Tìm kiếm")]),t._v(" "),t._t("default")],2)},[],!1,null,"6eac449c",null);d.options.__file="filtrateHandleView.vue";e.a=d.exports},"oj9+":function(t,e,n){"use strict";var a=n("gXW+");e.a={data:function(){return{chartColors:["#6CA2FF","#6AC9D7","#72DCA2","#48E78D","#FECD51","#DBB375","#FF7474","#F59561","#A3AEBC","#4C84FF","#0DBEB4","#00DEDE","#FFAA00","#C7C116","#F7A57C","#F661AC","#8652EE"]}},components:{filtrateHandleView:a.a},props:{},computed:{},watch:{},mounted:function(){},methods:{},deactivated:function(){}}},uKQN:function(t,e,n){"use strict";var a={name:"TimeTypeSelect",props:{defaultType:Object},data:function(){return{selectType:{label:"Năm nay",value:"year"},showTypePopover:!1,showCustomContent:!1,sureCustomContent:!1,startTime:"",endTime:"",typeOptions:[{label:"Hôm nay",value:"today"},{label:"Hôm qua",value:"yesterday"},{label:"Tuần này",value:"week"},{label:"Tuần rồi",value:"lastWeek"},{label:"Tháng này",value:"month"},{label:"Tháng trước",value:"lastMonth"},{label:"Quý này",value:"quarter"},{label:"Quý trước",value:"lastQuarter"},{label:"Năm nay",value:"year"},{label:"Năm trước",value:"lastYear"}]}},computed:{iconClass:function(){return this.showTypePopover?"arrow-up":"arrow-down"},typeShowValue:function(){return this.sureCustomContent?this.startTime||this.endTime?(this.startTime||"")+"-"+(this.endTime||""):"":this.selectType.label}},mounted:function(){this.defaultType?this.selectType=this.defaultType:this.$emit("change",{type:"default",value:this.selectType.value})},methods:{typeSelectClick:function(t){this.showTypePopover=!1,this.sureCustomContent=!1,this.showCustomContent=!1,this.selectType=t,this.$emit("change",{type:"default",value:this.selectType.value})},customSureClick:function(){this.startTime&&this.endTime&&(this.sureCustomContent=!0,this.showTypePopover=!1,this.$emit("change",{type:"custom",startTime:this.startTime,endTime:this.endTime}))}}},i=(n("w4JZ"),n("KHd+")),s=Object(i.a)(a,function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("el-popover",{attrs:{placement:"bottom",width:"200","popper-class":"no-padding-popover",trigger:"click"},model:{value:t.showTypePopover,callback:function(e){t.showTypePopover=e},expression:"showTypePopover"}},[n("div",{staticClass:"type-popper"},[n("div",{staticClass:"type-content"},[t._l(t.typeOptions,function(e,a){return n("div",{key:a,staticClass:"type-content-item",class:{selected:t.selectType.value==e.value&&!t.showCustomContent},on:{click:function(n){t.typeSelectClick(e)}}},[n("div",{staticClass:"mark"}),t._v(t._s(e.label)+"\n      ")])}),t._v(" "),n("div",{staticClass:"type-content-item",class:{selected:t.showCustomContent},on:{click:function(e){t.showCustomContent=!0}}},[n("div",{staticClass:"mark"}),t._v("Tùy chỉnh\n      ")])],2),t._v(" "),t.showCustomContent?n("div",{staticClass:"type-content-custom"},[n("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"Chọn ngày bắt đầu"},model:{value:t.startTime,callback:function(e){t.startTime=e},expression:"startTime"}}),t._v(" "),n("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"Chọn ngày kết thúc"},model:{value:t.endTime,callback:function(e){t.endTime=e},expression:"endTime"}}),t._v(" "),n("el-button",{on:{click:t.customSureClick}},[t._v("OK")])],1):t._e()]),t._v(" "),n("el-input",{staticClass:"type-select",attrs:{slot:"reference",readonly:!0,placeholder:"Vui lòng chọn"},slot:"reference",model:{value:t.typeShowValue,callback:function(e){t.typeShowValue=e},expression:"typeShowValue"}},[n("i",{class:["el-input__icon","el-icon-"+t.iconClass],attrs:{slot:"suffix"},slot:"suffix"})])],1)},[],!1,null,"398cb27e",null);s.options.__file="index.vue";e.a=s.exports},w4JZ:function(t,e,n){"use strict";var a=n("7F1U");n.n(a).a}}]);