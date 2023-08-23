(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-d837"],{"6XJn":function(t,e,i){},Hhli:function(t,e,i){"use strict";var a=i("EP+0"),s=i("MT78"),r=i.n(s),n=i("UxrY"),o=i.n(n),l={name:"StatisticalOverview",components:{CreateSections:a.a,RadialProgressBar:o.a},props:{data:{type:Object,default:function(){return{allCount:0,archive:0,completionRate:0,overdueRate:0,complete:0,overdue:0,unfinished:0}}},list:Array},data:function(){return{barOption:null,barChart:null}},computed:{showList:function(){return this.list&&this.list.length>3?this.list.slice(0,3):this.list||[]}},watch:{data:function(){this.changeBarData()}},mounted:function(){this.initBar(),this.changeBarData()},methods:{changeBarData:function(){this.barOption.series[0].data=[this.data.allCount||0,this.data.unfinished||0,this.data.complete||0,this.data.overdue||0,this.data.archive||0],this.barChart.setOption(this.barOption,!0)},initBar:function(){this.barChart=r.a.init(document.getElementById("barmain")),this.barOption={tooltip:{show:!1},legend:{show:!1},grid:{top:"15px",left:0,right:0,bottom:"10px",containLabel:!0},xAxis:{type:"category",data:["Tổng công việc","Chưa hoàn thành","Đã hoàn thành","Quá hạn","Đã xóa"],axisTick:{alignWithLabel:!0,lineStyle:{width:0}},axisLabel:{color:"#666"},axisLine:{lineStyle:{color:"#ECECEC"}},splitLine:{show:!1}},yAxis:{show:!1},series:[{name:"Số lượng khách hàng",type:"bar",barWidth:10,label:{show:!0,position:"top",color:"#333"},itemStyle:{barBorderRadius:[7.5,7.5,0,0]},color:function(t){return["#0067E5","#0067E5","#0067E5","#FF5D60","#19DBC1"][t.dataIndex]},data:[]}]}}}},c=(i("wHlG"),i("KHd+")),h=Object(c.a)(l,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("create-sections",{attrs:{title:"Tổng quan về công việc"}},[i("flexbox",{staticClass:"content"},[i("div",{staticClass:"content-progress"},[i("radial-progress-bar",{staticClass:"progress",attrs:{diameter:120,"completed-steps":parseFloat(t.data.completionRate)||0,"total-steps":100,"stroke-width":7,"inner-stroke-color":"#E7F2FA","start-color":"#0067E5","stop-color":"#0067E5"}},[i("p",{staticClass:"progress-title"},[t._v("Tỷ lệ hoàn thành")]),t._v(" "),i("p",{staticClass:"progress-value"},[t._v(t._s(t.data.completionRate||0)),i("span",[t._v("%")])])]),t._v(" "),i("radial-progress-bar",{staticClass:"progress",attrs:{diameter:120,"completed-steps":parseFloat(t.data.overdueRate)||0,"total-steps":100,"stroke-width":7,"inner-stroke-color":"#E8F2FA","start-color":"#FF5D60","stop-color":"#FF5D60"}},[i("p",{staticClass:"progress-title"},[t._v("Tỷ lệ quá hạn")]),t._v(" "),i("p",{staticClass:"progress-value"},[t._v(t._s(t.data.overdueRate||0)),i("span",[t._v("%")])])])],1),t._v(" "),i("div",{staticClass:"content-bar"},[i("div",{attrs:{id:"barmain"}})]),t._v(" "),t.list&&t.list.length>0?i("div",{staticClass:"content-user"},[i("div",{staticClass:"content-user-items"},[t._l(t.showList,function(e,a){return i("div",{key:a,staticClass:"main-user"},[i("div",{directives:[{name:"photo",rawName:"v-photo",value:e,expression:"item"},{name:"lazy",rawName:"v-lazy:background-image",value:t.$options.filters.filterUserLazyImg(e.img),expression:"$options.filters.filterUserLazyImg(item.img)",arg:"background-image"}],key:e.img,staticClass:"div-photo main-user-head"}),t._v(" "),i("div",{staticClass:"main-user-name"},[t._v(t._s(e.realname))])])}),t._v(" "),t.list.length>3?i("el-tooltip",{attrs:{placement:"top",effect:"light","popper-class":"tooltip-change-border task-tooltip"}},[i("div",{staticClass:"tooltip-content",staticStyle:{margin:"10px 10px 10px 0"},attrs:{slot:"content"},slot:"content"},t._l(t.list,function(e,a){return i("div",{key:a,staticClass:"item-label",staticStyle:{display:"inline-block","margin-right":"10px"}},[a>2?i("span",{staticClass:"k-name"},[t._v(t._s(e.realname))]):t._e()])})),t._v(" "),i("span",{staticClass:"main-user-more"},[i("i",[t._v("...")])])]):t._e()],2),t._v(" "),i("div",{staticClass:"content-user-title"},[t._v("Quản lý dự án")])]):t._e()]),t._v(" "),t._t("default")],2)},[],!1,null,"699e3ba5",null);h.options.__file="statisticalOverview.vue";e.a=h.exports},ME4h:function(t,e,i){"use strict";i.d(e,"a",function(){return s});var a=i("t3Un");function s(t){return Object(a.a)({url:"work/workStatistics",method:"post",data:t})}},"U1/L":function(t,e,i){},UrT4:function(t,e,i){"use strict";var a=i("EP+0"),s=i("MT78"),r=i.n(s),n={name:"StatisticalTask",components:{CreateSections:a.a},props:{title:{type:String,default:""},type:String,list:{type:Array,default:function(){return[]}}},data:function(){return{barOption:null,barChart:null,id:Math.ceil(100*Math.random())}},computed:{},watch:{list:function(){this.changeBarData()}},mounted:function(){this.initBar(),this.changeBarData()},methods:{changeBarData:function(){for(var t=[],e=[],i=[],a=0;a<this.list.length;a++){var s=this.list[a];"task"==this.type?(t.push(s.className),e.push(s.undone),i.push(s.complete)):"label"==this.type&&(t.push(s.name),e.push(s.undone),i.push(s.complete))}this.barOption.xAxis[0].data=t,this.barOption.series[0].data=i,this.barOption.series[1].data=e,this.barChart.setOption(this.barOption,!0)},initBar:function(){this.barChart=r.a.init(document.getElementById("barmain"+this.id)),this.barOption={color:["#6ca2ff","#ff7474"],tooltip:{trigger:"axis",axisPointer:{type:"shadow"}},legend:{data:["Hoàn thành","Giao lại"],bottom:"0px",itemWidth:14},grid:{top:"20px",left:"20px",right:"20px",bottom:"30px",containLabel:!0},xAxis:[{type:"category",data:[],axisTick:{alignWithLabel:!0,lineStyle:{width:0}},axisLabel:{color:"#666"},axisLine:{lineStyle:{color:"#ECECEC"}},splitLine:{show:!1}}],yAxis:{splitNumber:3,axisLine:{show:!1},axisTick:{show:!1},splitLine:{lineStyle:{color:"#ECECEC"}},axisLabel:{textStyle:{color:"#666"}}},series:[{name:"Hoàn thành",type:"bar",stack:"one",barWidth:"15%",data:[]},{name:"Giao lại",type:"bar",stack:"one",barWidth:"15%",data:[]}]}}}},o=(i("l3no"),i("KHd+")),l=Object(o.a)(n,function(){var t=this.$createElement,e=this._self._c||t;return e("create-sections",{attrs:{title:this.title}},[e("div",{staticClass:"barmain",attrs:{id:"barmain"+this.id}})])},[],!1,null,"d432ffe8",null);l.options.__file="statisticalTask.vue";e.a=l.exports},UxrY:function(t,e,i){t.exports=i("u1YS")},WFjz:function(t,e,i){},cKmN:function(t,e,i){"use strict";i.r(e);var a=i("F/D6"),s=i("ME4h"),r=i("Hhli"),n=i("UrT4"),o=i("lT1d"),l={components:{StatisticalOverview:r.a,StatisticalTask:n.a,StatisticalMember:o.a},data:function(){return{loading:!1,detailData:{},projectList:[{workId:"all",name:"Tất cả"}],workId:"all"}},created:function(){this.getProjectList(),this.getDetail()},methods:{getDetail:function(){var t=this;this.loading=!0,Object(s.a)({workId:this.workId}).then(function(e){t.detailData=e.data,t.loading=!1}).catch(function(){t.loading=!1})},getProjectList:function(){var t=this;Object(a.c)().then(function(e){t.projectList=[{workId:"all",name:"Tất cả"}].concat(e.data)}).catch(function(){})}}},c=(i("vvMp"),i("KHd+")),h=Object(c.a)(l,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"project"},[i("div",{staticClass:"project-header"},[t._v("\n    Phân tích thống kê\n  ")]),t._v(" "),i("div",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],staticClass:"project-body"},[i("statistical-overview",{staticClass:"statistical-overview",attrs:{data:t.detailData.taskStatistics,list:t.detailData.ownerList}},[i("el-select",{staticClass:"project-body-select",attrs:{placeholder:"Chọn"},on:{change:t.getDetail},model:{value:t.workId,callback:function(e){t.workId=e},expression:"workId"}},t._l(t.projectList,function(t){return i("el-option",{key:t.workId,attrs:{label:t.name,value:t.workId}})}))],1),t._v(" "),"all"!=t.workId?i("flexbox",{staticClass:"statistical-task"},[i("statistical-task",{staticClass:"statistical-task-item",attrs:{list:t.detailData.classStatistics,type:"task",title:"Danh sách công việc"}}),t._v(" "),i("statistical-task",{staticClass:"statistical-task-item",attrs:{list:t.detailData.labelStatistics,type:"label",title:"Phân tích nhãn"}})],1):t._e(),t._v(" "),i("statistical-member",{staticClass:"statistical-member",attrs:{list:t.detailData.memberTaskStatistics}})],1)])},[],!1,null,"1d913748",null);h.options.__file="index.vue";e.default=h.exports},hb9p:function(t,e,i){"use strict";var a=i("6XJn");i.n(a).a},"iU/U":function(t,e,i){},l3no:function(t,e,i){"use strict";var a=i("lSwX");i.n(a).a},lDf1:function(t,e,i){"use strict";var a=i("WFjz");i.n(a).a},lSwX:function(t,e,i){},lT1d:function(t,e,i){"use strict";var a={name:"StatisticalMember",components:{CreateSections:i("EP+0").a},props:{list:Array},data:function(){return{fieldList:[{prop:"realname",label:"Họ và tên"},{prop:"allCount",label:"Tổng cộng"},{prop:"complete",label:"Hoàn thành"},{prop:"unfinished",label:"Không hoàn thành"},{prop:"overdue",label:"Quá hạn"},{prop:"completionRate",label:"Tỉ lệ hoàn thành"}]}},computed:{},mounted:function(){},methods:{cellStyle:function(t){var e=t.row,i=t.column;t.rowIndex,t.columnIndex;return"overtimeCount"===i.property&&e.overtimeCount?{color:"#FF5D60"}:"completionRate"===i.property&&e.completionRate?{color:"#19DBC1"}:{}}}},s=(i("lDf1"),i("KHd+")),r=Object(s.a)(a,function(){var t=this.$createElement,e=this._self._c||t;return e("create-sections",{attrs:{title:"Thành viên hoàn thành"}},[e("el-table",{staticClass:"table",staticStyle:{width:"100%"},attrs:{data:this.list,"cell-style":this.cellStyle,height:"500",stripe:"",border:"","highlight-current-row":""}},this._l(this.fieldList,function(t,i){return e("el-table-column",{key:i,attrs:{prop:t.prop,label:t.label,"show-overflow-tooltip":""}})}))],1)},[],!1,null,"46d3a24d",null);r.options.__file="statisticalMember.vue";e.a=r.exports},u1YS:function(t,e,i){"use strict";i.r(e);var a={props:{diameter:{type:Number,required:!1,default:200},totalSteps:{type:Number,required:!0,default:10},completedSteps:{type:Number,required:!0,default:0},startColor:{type:String,required:!1,default:"#bbff42"},stopColor:{type:String,required:!1,default:"#429321"},strokeWidth:{type:Number,required:!1,default:10},animateSpeed:{type:Number,required:!1,default:1e3},innerStrokeColor:{type:String,required:!1,default:"#323232"},fps:{type:Number,required:!1,default:60},timingFunc:{type:String,required:!1,default:"linear"}},data:()=>({gradient:{fx:.99,fy:.5,cx:.5,cy:.5,r:.65},gradientAnimation:null,currentAngle:0,strokeDashoffset:0}),computed:{radius(){return this.diameter/2},circumference(){return Math.PI*this.innerCircleDiameter},stepSize(){return 0===this.totalSteps?0:100/this.totalSteps},finishedPercentage(){return this.stepSize*this.completedSteps},circleSlice(){return 2*Math.PI/this.totalSteps},animateSlice(){return this.circleSlice/this.totalPoints},innerCircleDiameter(){return this.diameter-2*this.strokeWidth},innerCircleRadius(){return this.innerCircleDiameter/2},totalPoints(){return this.animateSpeed/this.animationIncrements},animationIncrements(){return 1e3/this.fps},hasGradient(){return this.startColor!==this.stopColor},containerStyle(){return{height:`${this.diameter}px`,width:`${this.diameter}px`}},progressStyle(){return{height:`${this.diameter}px`,width:`${this.diameter}px`,strokeWidth:`${this.strokeWidth}px`,strokeDashoffset:this.strokeDashoffset,transition:`stroke-dashoffset ${this.animateSpeed}ms ${this.timingFunc}`}},strokeStyle(){return{height:`${this.diameter}px`,width:`${this.diameter}px`,strokeWidth:`${this.strokeWidth}px`}},innerCircleStyle(){return{width:`${this.innerCircleDiameter}px`}}},methods:{getStopPointsOfCircle(t){const e=[];for(let i=0;i<t;i++){const t=this.circleSlice*i;e.push(this.getPointOfCircle(t))}return e},getPointOfCircle:t=>({x:.5+.5*Math.cos(t),y:.5+.5*Math.sin(t)}),gotoPoint(){const t=this.getPointOfCircle(this.currentAngle);this.gradient.fx=t.x,this.gradient.fy=t.y},changeProgress({isAnimate:t=!0}){if(this.strokeDashoffset=(100-this.finishedPercentage)/100*this.circumference,this.gradientAnimation&&clearInterval(this.gradientAnimation),!t)return void this.gotoNextStep();const e=(this.completedSteps-1)*this.circleSlice;let i=(this.currentAngle-e)/this.animateSlice;const a=Math.abs(i-this.totalPoints)/this.totalPoints,s=i<this.totalPoints;this.gradientAnimation=setInterval(()=>{s&&i>=this.totalPoints||!s&&i<this.totalPoints?clearInterval(this.gradientAnimation):(this.currentAngle=e+this.animateSlice*i,this.gotoPoint(),i+=s?a:-a)},this.animationIncrements)},gotoNextStep(){this.currentAngle=this.completedSteps*this.circleSlice,this.gotoPoint()}},watch:{totalSteps(){this.changeProgress({isAnimate:!0})},completedSteps(){this.changeProgress({isAnimate:!0})},diameter(){this.changeProgress({isAnimate:!0})},strokeWidth(){this.changeProgress({isAnimate:!0})}},created(){this.changeProgress({isAnimate:!1})}},s=(i("hb9p"),i("KHd+")),r=Object(s.a)(a,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"radial-progress-container",style:t.containerStyle},[i("div",{staticClass:"radial-progress-inner",style:t.innerCircleStyle},[t._t("default")],2),t._v(" "),i("svg",{staticClass:"radial-progress-bar",attrs:{width:t.diameter,height:t.diameter,version:"1.1",xmlns:"http://www.w3.org/2000/svg"}},[i("defs",[i("radialGradient",{attrs:{id:"radial-gradient"+t._uid,fx:t.gradient.fx,fy:t.gradient.fy,cx:t.gradient.cx,cy:t.gradient.cy,r:t.gradient.r}},[i("stop",{attrs:{offset:"30%","stop-color":t.startColor}}),t._v(" "),i("stop",{attrs:{offset:"100%","stop-color":t.stopColor}})],1)],1),t._v(" "),i("circle",{style:t.strokeStyle,attrs:{r:t.innerCircleRadius,cx:t.radius,cy:t.radius,fill:"transparent",stroke:t.innerStrokeColor,"stroke-dasharray":t.circumference,"stroke-dashoffset":"0","stroke-linecap":"round"}}),t._v(" "),i("circle",{style:t.progressStyle,attrs:{transform:"rotate(270, "+t.radius+","+t.radius+")",r:t.innerCircleRadius,cx:t.radius,cy:t.radius,fill:"transparent",stroke:"url(#radial-gradient"+t._uid+")","stroke-dasharray":t.circumference,"stroke-dashoffset":t.circumference,"stroke-linecap":"round"}})])])},[],!1,null,null,null);r.options.__file="RadialProgressBar.vue";e.default=r.exports},vvMp:function(t,e,i){"use strict";var a=i("U1/L");i.n(a).a},wHlG:function(t,e,i){"use strict";var a=i("iU/U");i.n(a).a}}]);