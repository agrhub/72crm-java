(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-00f9"],{"0GEW":function(e,t,n){"use strict";var a=n("wW83");n.n(a).a},EjQ5:function(e,t,n){},Ew9n:function(e,t,n){"use strict";var a=n("7Qib"),i={name:"SlideView",components:{},props:{bodyStyle:{type:Object,default:function(){return{padding:0}}},listenerIDs:{type:Array,default:function(){return[]}},noListenerIDs:{type:Array,default:function(){return[]}},noListenerClass:{type:Array,default:function(){return[]}},appendToBody:{type:Boolean,default:!1}},data:function(){return{zIndex:Object(a.h)()}},computed:{},watch:{},mounted:function(){var e=this;this.appendToBody&&document.body.appendChild(this.$el),this.listenerIDs.forEach(function(t){document.getElementById(t)&&document.getElementById(t).addEventListener("click",e.handleDocumentClick,!1)})},beforeDestroy:function(){this.appendToBody&&this.$el&&this.$el.parentNode&&this.$el.parentNode.removeChild(this.$el)},methods:{handleDocumentClick:function(e){var t=!0;this.noListenerIDs.forEach(function(n){document.getElementById(n)&&document.getElementById(n).contains(e.target)&&(t=!1)}),this.noListenerClass.forEach(function(n){var a=document.getElementsByClassName(n);if(a&&t)for(var i=0;i<a.length;i++){if(a[i].contains(e.target)){t=!1;break}}}),document.getElementById("slide")&&document.getElementById("slide").contains(e.target)&&(t=!1),t&&this.$emit("side-close")},afterEnter:function(){this.$emit("afterEnter")}}},s=(n("0GEW"),n("KHd+")),c=Object(s.a)(i,function(){var e=this.$createElement,t=this._self._c||e;return t("transition",{attrs:{name:"slide-fade"},on:{"after-enter":this.afterEnter}},[t("el-card",{ref:"slide",staticClass:"slide-detail-card-container",style:{"z-index":this.zIndex},attrs:{id:"slide","body-style":this.bodyStyle}},[this._t("default")],2)],1)},[],!1,null,"0f708744",null);c.options.__file="SlideView.vue";t.a=c.exports},LHS1:function(e,t,n){"use strict";var a=n("Y8UV");n.n(a).a},Y8UV:function(e,t,n){},dVmb:function(e,t,n){},qtIl:function(e,t,n){"use strict";n.r(t);var a=n("ViDN"),i=n("t3Un");function s(e){return Object(i.a)({url:"examine/updateStatus",method:"post",data:e})}var c=n("8GhS"),l=n("Ktth"),o=n.n(l),r={name:"CreateSystemExamine",components:{CreateView:a.a,XhInput:c.g,XhTextarea:c.o,XhSelect:c.l,XhUserCell:c.p,XhStrucUserCell:c.m},filters:{typeToComponentName:function(e){return"text"==e?"XhInput":"textarea"==e?"XhTextarea":"select"==e?"XhSelect":"structure"==e?"XhStrucUserCell":void 0},numberToZh:function(e){return o.a.encodeS(e)}},props:{handle:{type:Object,default:function(){return{type:"examineflow",action:"save",id:"",data:null}}}},data:function(){return{loading:!1,crmRules:{},crmForm:{crmFields:[]},currentPage:1,examineType:1,examineList:[{type:1,value:[],show:!1,options:[{name:"Người phụ trách",value:1},{name:"Người dùng được chỉ định (bất kỳ người nào)",value:2},{name:"Người dùng được chỉ định (nhiều người cùng ký)",value:3}]}]}},computed:{title:function(){if("examineflow"===this.handle.type){if("save"===this.handle.action)return"Quy trình phê duyệt mới";if("update"===this.handle.action)return"Chỉnh sửa quy trình phê duyệt"}return""}},mounted:function(){if(document.body.appendChild(this.$el),this.getField(),this.handle.data)if(this.handle.data.examineType&&1===this.handle.data.examineType){this.examineType=1,this.examineList=[];for(var e=0;e<this.handle.data.stepList.length;e++){var t=this.handle.data.stepList[e],n={};n.type=t.stepType,2===t.stepType||3===t.stepType?(n.show=!0,n.value=t.userList):(n.show=!1,n.value=[]),n.options=0===e?[{name:"Người phụ trách",value:1},{name:"Người dùng được chỉ định (bất kỳ người nào)",value:2},{name:"Người dùng được chỉ định (nhiều người cùng ký)",value:3}]:[{name:"Người phụ trách",value:1},{name:"Người dùng được chỉ định (bất kỳ người nào)",value:2},{name:"Người dùng được chỉ định (nhiều người cùng ký)",value:3},{name:"Người giám sát của người phê duyệt cấp trên",value:4}],this.examineList.push(n)}}else this.examineType=2},destroyed:function(){this.$el&&this.$el.parentNode&&this.$el.parentNode.removeChild(this.$el)},methods:{fieldValueChange:function(e){this.crmForm.crmFields[e.index].value=e.value},getField:function(){var e=[];e.push({field:"name",formType:"text",isNull:1,name:"Tên quy trình phê duyệt",setting:[],inputTips:"",value:this.handle.data?this.handle.data.name:""}),e.push({field:"categoryType",formType:"select",isNull:0,name:"Phân loại",setting:[{name:"Hợp đồng",value:1},{name:"Thanh toán",value:2}],value:this.handle.data?this.handle.data.categoryType:1}),e.push({field:"dept",formType:"structure",isNull:0,name:"Phòng ban",setting:[],inputTips:"Toàn công ty (mặc định)",value:{users:this.handle.data?this.handle.data.userIds:[],strucs:this.handle.data?this.handle.data.deptIds:[]}}),e.push({field:"remarks",formType:"textarea",isNull:0,name:"Mô tả",setting:[],inputTips:"Vui lòng điền các lưu ý liên quan để nhân viên tiện kiểm tra khi nộp đơn, và giới hạn đầu vào 2000 từ",value:this.handle.data?this.handle.data.remarks:""}),this.getcrmRulesAndModel(e)},getcrmRulesAndModel:function(e){for(var t=0;t<e.length;t++){var n=e[t],a=[];1==n.isNull&&a.push({required:!0,message:n.name+"Không được để trống",trigger:["blur","change"]}),this.crmRules[n.field]=a;var i={};i.value=n.value,i.key=n.field,i.data=n,"textarea"==n.formType&&(i.showblock=!0),this.crmForm.crmFields.push(i)}},saveField:function(){var e=this;this.$refs.crmForm.validate(function(t){if(!t)return e.$message.error("Vui lòng điền đầy đủ thông tin cần thiết"),!1;e.validStepsInfo()&&e.submiteParams(e.crmForm.crmFields)})},validStepsInfo:function(){for(var e=0;e<this.examineList.length;e++){var t=this.examineList[e];if((2===t.type||3===t.type)&&0===t.value.length)return this.$message.error("Vui lòng thêm nhân viên"),!1}return!0},submiteParams:function(e){var t=this;this.loading=!0;var n=this.getSubmiteParams(e);"update"==this.handle.action&&(n.examineId=this.handle.data.examineId),function(e){return Object(i.a)({url:"examine/saveExamine",method:"post",headers:{"Content-Type":"application/json;charset=UTF-8"},data:e})}(n).then(function(e){t.loading=!1,t.hidenView(),t.$message.success("Thành công"),t.$emit("save")}).catch(function(){t.loading=!1})},getSubmiteParams:function(e){for(var t={},n=0;n<e.length;n++){var a=e[n];"dept"===a.key?(t.userIds=a.value.users.map(function(e){return e.userId}),t.deptIds=a.value.strucs.map(function(e){return e.id})):t[a.key]=a.value}for(var i=[],s=0;s<this.examineList.length;s++){var c=this.examineList[s];i.push({stepType:c.type,checkUserId:c.value.map(function(e){return e.userId})})}return t.examineType=this.examineType,t.step=i,t},nextPage:function(){var e=this;this.$refs.crmForm.validate(function(t){t&&(e.currentPage=2)})},selectOptionsChange:function(e){2==e.type||3==e.type?e.show=!0:e.show=!1},selectOptionsFocus:function(e,t){if(this.examineList.length>1){var n=t>0?this.examineList[t-1]:null,a=null;if(t<this.examineList.length-1)a=this.examineList[t+1];var i=!1,s=!1,c=!1;!n||2!==n.type&&3!==n.type||(c=!0),a&&4===a.type&&(i=!0,s=!0);var l=[{name:"Người phụ trách",value:1}];i||l.push({name:"Người dùng được chỉ định (bất kỳ người nào)",value:2}),s||l.push({name:"Người dùng được chỉ định (nhiều người cùng ký)",value:3}),c||l.push({name:"Người giám sát của người phê duyệt cấp trên",value:4}),e.options=l}},examineItemsAdd:function(){this.examineList.push({type:1,value:[],show:!1,options:[{name:"Người phụ trách",value:1},{name:"Người dùng được chỉ định (bất kỳ người nào)",value:2},{name:"Người dùng được chỉ định (nhiều người cùng ký)",value:3},{name:"Người giám sát của người phê duyệt cấp trên",value:4}]})},flowUserSelect:function(e){this.examineList[e.index].value=e.value},deleteExamineItems:function(e){this.examineList.splice(e,1)},hidenView:function(){this.$emit("hiden-view")},getPaddingLeft:function(e,t){return e.showblock&&1==e.showblock?"0":t%2==0?"0":"25px"},getPaddingRight:function(e,t){return e.showblock&&1==e.showblock?"0":t%2==0?"25px":"0"}}},h=(n("LHS1"),n("KHd+")),u=Object(h.a)(r,function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("create-view",{attrs:{loading:e.loading,"body-style":{height:"100%"}}},[a("flexbox",{staticClass:"crm-create-container",attrs:{direction:"column",align:"stretch"}},[a("flexbox",{staticClass:"crm-create-header"},[a("div",{staticStyle:{flex:"1","font-size":"17px",color:"#333"}},[e._v(e._s(e.title))]),e._v(" "),a("img",{staticClass:"close",attrs:{src:n("cjwK")},on:{click:e.hidenView}})]),e._v(" "),a("flexbox",{staticClass:"crm-create-flex",attrs:{direction:"column",align:"stretch"}},[a("div",{directives:[{name:"show",rawName:"v-show",value:1==e.currentPage,expression:"currentPage == 1"}],staticClass:"crm-create-body"},[a("div",{staticClass:"create-name"},[e._v("Thông tin cơ bản")]),e._v(" "),a("el-form",{ref:"crmForm",staticClass:"crm-create-box",attrs:{model:e.crmForm,"label-position":"top"}},e._l(e.crmForm.crmFields,function(t,n){return a("el-form-item",{key:t.key,class:{"crm-create-block-item":t.showblock,"crm-create-item":!t.showblock},style:{"padding-left":e.getPaddingLeft(t,n),"padding-right":e.getPaddingRight(t,n)},attrs:{prop:"crmFields."+n+".value",rules:e.crmRules[t.key]}},[a("div",{staticStyle:{display:"inline-block"},attrs:{slot:"label"},slot:"label"},[a("div",{staticStyle:{margin:"5px 0","font-size":"12px","word-wrap":"break-word","word-break":"break-all"}},[e._v("\n                "+e._s(t.data.name)+"\n                "),a("span",{staticStyle:{color:"#999"}},[e._v("\n                  "+e._s(t.data.inputTips?"（"+t.data.inputTips+"）":"")+"\n                ")])])]),e._v(" "),a(e._f("typeToComponentName")(t.data.formType),{tag:"component",attrs:{value:t.value,index:n,item:t,radio:!1},on:{"value-change":e.fieldValueChange}})],1)}))],1),e._v(" "),a("div",{directives:[{name:"show",rawName:"v-show",value:2==e.currentPage,expression:"currentPage == 2"}],staticClass:"crm-create-body"},[a("div",{staticStyle:{padding:"0 20px","font-size":"12px"}},[a("el-radio",{attrs:{label:1},model:{value:e.examineType,callback:function(t){e.examineType=t},expression:"examineType"}},[e._v("Quy trình phê duyệt cố định")]),e._v(" "),a("div",{staticClass:"examine-items"},e._l(e.examineList,function(t,n){return a("flexbox",{key:n,staticClass:"examine-item"},[a("div",{staticClass:"examine-item-name"},[e._v("Gồm "+e._s(e._f("numberToZh")(n+1))+" cấp")]),e._v(" "),a("el-select",{staticClass:"examine-item-select",attrs:{placeholder:"Chọn"},on:{focus:function(a){e.selectOptionsFocus(t,n)},change:function(n){e.selectOptionsChange(t)}},model:{value:t.type,callback:function(n){e.$set(t,"type",n)},expression:"item.type"}},e._l(t.options,function(e){return a("el-option",{key:e.value,attrs:{label:e.name,value:e.value}})})),e._v(" "),t.show?a("xh-user-cell",{staticClass:"examine-item-user",attrs:{radio:!1,index:n,value:t.value},on:{"value-change":e.flowUserSelect}}):e._e(),e._v(" "),a("i",{staticClass:"el-icon-remove examine-item-delete",on:{click:function(t){e.deleteExamineItems(n)}}})],1)})),e._v(" "),a("div",{staticClass:"examine-items-add"},[a("span",{on:{click:e.examineItemsAdd}},[e._v("+ Thêm cấp độ phê duyệt")])]),e._v(" "),a("div",{staticClass:"examine-add-des"},[a("p",[a("span",{staticClass:"examine-add-required"},[e._v("*")]),e._v('Khi chọn "người phụ trách" để phê duyệt. Hệ thống sẽ chỉ thông báo cho người phụ trách.')]),e._v(" "),a("p",[a("span",{staticClass:"examine-add-required"},[e._v("*")]),e._v('Khi nhiều "người dùng được chỉ định" được chọn để phê duyệt. Nếu người dùng được chỉ định không có quyền xem hợp đồng tương ứng, hệ thống sẽ thông báo cho anh ta phê duyệt, nhưng anh ta không thể xem thông tin dữ liệu này.')]),e._v(" "),a("p",[a("span",{staticClass:"examine-add-required"},[e._v("*")]),e._v('Khi bạn chọn "Người dùng được chỉ định (Bất kỳ ai)", điều đó có nghĩa là bất kỳ ai trong số những người dùng được chỉ định đều có thể phê duyệt. Khi chọn "Người dùng được chỉ định (Nhiều người được ký)", có nghĩa là tất cả những người dùng được chỉ định phải phê duyệt.')])]),e._v(" "),a("el-radio",{attrs:{label:2},model:{value:e.examineType,callback:function(t){e.examineType=t},expression:"examineType"}},[e._v("Người phê duyệt được ủy quyền")])],1)])]),e._v(" "),1==e.currentPage?a("div",{staticClass:"handle-bar"},[a("el-button",{staticClass:"handle-button",nativeOn:{click:function(t){return e.hidenView(t)}}},[e._v("Hủy")]),e._v(" "),a("el-button",{staticClass:"handle-button",attrs:{type:"primary"},nativeOn:{click:function(t){return e.nextPage(t)}}},[e._v("Trang kế")])],1):e._e(),e._v(" "),2==e.currentPage?a("div",{staticClass:"handle-bar"},[a("el-button",{staticClass:"handle-button",nativeOn:{click:function(t){return e.hidenView(t)}}},[e._v("Hủy")]),e._v(" "),a("el-button",{staticClass:"handle-button",attrs:{type:"primary"},nativeOn:{click:function(t){return e.saveField(t)}}},[e._v("Lưu")]),e._v(" "),a("el-button",{staticClass:"handle-button",attrs:{type:"primary"},nativeOn:{click:function(t){e.currentPage=1}}},[e._v("Trang trước")])],1):e._e()],1)],1)},[],!1,null,"c3212d1e",null);u.options.__file="CreateSystemExamine.vue";var d=u.exports,m=n("P2sY"),p=n.n(m),g=n("Ew9n"),v=n("EP+0"),f={name:"SystemExamineDetail",components:{SlideView:g.a,CreateSections:v.a},filters:{formatedScopeInfo:function(e){for(var t="",n=e.deptIds?e.deptIds:[],a=0;a<n.length;a++){t=t+n[a].name+"、"}for(var i=e.userIds?e.userIds:[],s=0;s<i.length;s++){t=t+i[s].realname+(s===i.length-1?"":"、")}return t||"Toàn công ty"},toRowName:function(e){return"Gồm "+o.a.encodeS(e)+" cấp"},toRowNameDes:function(e){return 1==e.stepType?"Người phụ trách":2==e.stepType?e.userList.length+"Người ký":3==e.stepType?e.userList.length+"Mọi người ký tên":4==e.stepType?"Người giám sát của người phê duyệt cấp trên":""}},props:{data:Object},data:function(){return{showData:{},examineStatus:!1}},computed:{},watch:{data:function(e){this.getShowData()}},mounted:function(){this.getShowData()},methods:{deleteClick:function(){var e=this;this.$confirm("Bạn có chắc chắn muốn xóa quy trình phê duyệt này không?","Thông báo",{confirmButtonText:"OK",cancelButtonText:"Cancel",type:"warning"}).then(function(){s({examineId:e.data.examineId,status:2}).then(function(t){e.$emit("refresh"),e.hideView(),e.$message({type:"success",message:"Thành công"})}).catch(function(){})}).catch(function(){e.$message({type:"info",message:"Không thành công"})})},getShowData:function(){this.showData=p()({},this.data),this.examineStatus=0!=this.showData.status},examineStatusChange:function(e){var t=this;this.showData.status=e?1:0,this.$confirm("Bạn có chắc bạn muốn "+(e?"Kích hoạt":"Hủy kích hoạt")+" quy trình phê duyệt?","Thông báo",{confirmButtonText:"OK",cancelButtonText:"Cancel",type:"warning"}).then(function(){s({examineId:t.data.examineId,status:e?1:0}).then(function(e){t.$emit("refresh"),t.$message({type:"success",message:"Thành công"})}).catch(function(){t.cancelStatusChange()})}).catch(function(){t.cancelStatusChange(),t.$message({type:"info",message:"Không thành công"})})},cancelStatusChange:function(){this.examineStatus=!this.examineStatus,this.showData.status=this.examineStatus?1:0},hideView:function(){this.$emit("hide-view")}}},y=(n("xvDY"),Object(h.a)(f,function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("slide-view",{staticClass:"d-view",attrs:{"listener-ids":["manager-main-container"],"no-listener-ids":["examine-table"],"append-to-body":!0,"body-style":{padding:"10px 30px",height:"100%"}},on:{"side-close":e.hideView}},[a("flexbox",{staticStyle:{height:"100%"},attrs:{orient:"vertical"}},[a("div",{staticClass:"header"},[a("flexbox",{staticClass:"detail-header"},[a("div",{staticClass:"header-name"},[e._v(e._s(e.showData.name)),a("i",{staticClass:"el-icon-delete delete",on:{click:e.deleteClick}})]),e._v(" "),a("img",{staticClass:"header-close",attrs:{src:n("cjwK")},on:{click:e.hideView}})]),e._v(" "),a("div",{staticClass:"detail-header-des"},[a("div",{staticClass:"status"},[e._v("Trạng thái："+e._s(0==e.showData.status?"Hủy kích hoạt":"Kích hoạt"))]),e._v(" "),a("div",{staticClass:"status-handle"},[e._v("\n          Kích hoạt\n          "),a("el-switch",{on:{change:e.examineStatusChange},model:{value:e.examineStatus,callback:function(t){e.examineStatus=t},expression:"examineStatus"}})],1)])],1),e._v(" "),a("div",{staticClass:"detail-body"},[a("create-sections",{staticClass:"create-sections",attrs:{title:"Thông tin cơ bản"}},[a("div",{staticClass:"create-sections-content"},[a("div",{staticClass:"dialog-content"},[a("flexbox",{staticClass:"content-items"},[a("div",{staticClass:"content-items-name"},[e._v("Tên phê duyệt")]),e._v(" "),a("div",{staticClass:"content-items-value"},[e._v(e._s(e.showData.name))])]),e._v(" "),a("flexbox",{staticClass:"content-items"},[a("div",{staticClass:"content-items-name"},[e._v("Phạm vi áp dụng")]),e._v(" "),a("div",{staticClass:"content-items-value"},[e._v(e._s(e._f("formatedScopeInfo")(e.showData)))])]),e._v(" "),a("flexbox",{staticClass:"content-items"},[a("div",{staticClass:"content-items-name"},[e._v("Hướng dẫn phê duyệt")]),e._v(" "),a("div",{staticClass:"content-items-value"},[e._v(e._s(e.showData.remarks))])])],1)])]),e._v(" "),a("create-sections",{staticClass:"create-sections",attrs:{title:"Quá trình"}},[1==e.showData.examineType?a("div",{staticClass:"create-sections-content"},e._l(e.showData.stepList,function(t,n){return a("flexbox",{key:n,staticClass:"examine-flow",attrs:{align:"stretch"}},[a("div",{staticClass:"examine-flow-header"},[a("div",{staticClass:"mark-circle"}),e._v(" "),0!=n?a("div",{staticClass:"mark-top-line"}):e._e(),e._v(" "),n<e.showData.stepList.length-1?a("div",{staticClass:"mark-bottom-line"}):e._e()]),e._v(" "),a("div",{staticClass:"examine-flow-body"},[a("div",{staticClass:"body-header"},[a("span",{staticClass:"body-header-name"},[e._v(e._s(e._f("toRowName")(n+1)))]),a("span",{staticClass:"body-header-des"},[e._v("（"+e._s(e._f("toRowNameDes")(t))+"）")])]),e._v(" "),t.userList.length>0?a("flexbox",{staticClass:"examine-users"},e._l(t.userList,function(t,n){return a("div",{key:n,staticClass:"examine-users-item"},[a("div",{directives:[{name:"photo",rawName:"v-photo",value:t,expression:"userItem"},{name:"lazy",rawName:"v-lazy:background-image",value:e.$options.filters.filterUserLazyImg(t.img),expression:"$options.filters.filterUserLazyImg(userItem.img)",arg:"background-image"}],staticClass:"div-photo"}),e._v(" "),a("div",{staticClass:"name"},[e._v(e._s(t.realname))])])})):e._e()],1)])})):a("div",{staticClass:"create-sections-content"},[e._v("Người phê duyệt được ủy quyền")])])],1)])],1)},[],!1,null,"576f9f34",null));y.options.__file="systemExamineDetail.vue";var x={name:"SystemExamine",components:{CreateSystemExamine:d,SystemExamineDetail:y.exports},mixins:[],data:function(){return{loading:!1,tableHeight:document.documentElement.clientHeight-240,list:[],fieldList:[{prop:"name",label:"Tên quy trình phê duyệt",width:150},{prop:"examineType",label:"Loại quy trình",width:150},{prop:"categoryType",label:"Nhóm quy trình",width:100},{prop:"userIds",label:"Nhân viên",width:150},{prop:"updateUserName",label:"Người chỉnh sửa",width:150},{prop:"updateTime",label:"Ngày chỉnh sửa",width:150},{prop:"status",label:"Trạng thái",width:100}],currentPage:1,pageSize:10,pageSizes:[10,20,30,40],total:0,showHandleView:!1,createHandleInfo:{action:"save",type:"examineflow",id:""},showDetail:!1,detailData:{}}},computed:{},mounted:function(){var e=this;window.onresize=function(){e.tableHeight=document.documentElement.clientHeight-240},this.getList()},methods:{getList:function(){var e=this;this.loading=!0,function(e){return Object(i.a)({url:"examine/queryAllExamine",method:"post",data:e})}({page:this.currentPage,limit:this.pageSize}).then(function(t){e.list=t.data.list,e.total=t.data.totalRow,e.loading=!1}).catch(function(){e.loading=!1})},fieldFormatter:function(e,t){if("examineType"===t.property)return 1===e[t.property]?"Quy trình phê duyệt cố định":2===e[t.property]?"Người phê duyệt được ủy quyền":"";if("categoryType"===t.property)return{1:"Hợp đồng",2:"Thanh toán"}[e[t.property]];if("userIds"===t.property){var n=(e.deptIds||[]).map(function(e){return e.name}).join("、");return n&&(n+="、"),n+(e.userIds||[]).map(function(e){return e.realname}).join("、")||"Toàn công ty"}return"status"===t.property?0===e[t.property]?"Hủy kích hoạt":"Kích hoạt":e[t.property]},addExamine:function(){this.createHandleInfo={action:"save",type:"examineflow",id:""},this.showHandleView=!0},handleRowClick:function(e,t,n){t.property&&(this.detailData=e,this.showDetail=!0)},handleSizeChange:function(e){this.pageSize=e,this.getList()},handleCurrentChange:function(e){this.currentPage=e,this.getList()},handleClick:function(e,t){var n=this;"edit"===e?(this.createHandleInfo.action="update",this.createHandleInfo.id=t.row.examineId,this.createHandleInfo.data=t.row,this.showHandleView=!0):"delete"===e?this.$confirm("Bạn có chắc chắn muốn xóa quy trình phê duyệt này không?","Thông báo",{confirmButtonText:"OK",cancelButtonText:"Cancel",type:"warning"}).then(function(){s({examineId:t.row.examineId}).then(function(e){n.list.splice(t.$index,1),n.getList(),n.$message({type:"success",message:"Thành công"})}).catch(function(){})}).catch(function(){n.$message({type:"info",message:"Không thành công"})}):"change"===e?this.$confirm("Bạn có chắc bạn muốn "+(0===t.row.status?"Hủy kích hoạt":"Kích hoạt")+" quy trình phê duyệt?","Thông báo",{confirmButtonText:"OK",cancelButtonText:"Cancel",type:"warning"}).then(function(){s({examineId:t.row.examineId,status:0===t.row.status?1:0}).then(function(e){t.row.status=0===t.row.status?1:0,n.$message({type:"success",message:"Thành công"})}).catch(function(){})}).catch(function(){n.$message({type:"info",message:"Không thành công"})}):"copy"===e&&(this.createHandleInfo.action="save",this.createHandleInfo.id="",this.createHandleInfo.data=t.row,this.showHandleView=!0)}}},w=(n("yYBc"),Object(h.a)(x,function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:"se-container"},[n("div",{staticClass:"se-header"},[e._v("Quy trình phê duyệt")]),e._v(" "),n("div",{staticClass:"se-body"},[n("div",{staticClass:"se-table-header"},[n("el-button",{staticClass:"se-table-header-button",attrs:{type:"primary"},on:{click:e.addExamine}},[e._v("Thêm quy trình phê duyệt")])],1),e._v(" "),n("el-table",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticClass:"main-table",staticStyle:{width:"100%"},attrs:{id:"examine-table",data:e.list,height:e.tableHeight,"highlight-current-row":""},on:{"row-click":e.handleRowClick}},[e._l(e.fieldList,function(t,a){return n("el-table-column",{key:a,attrs:{formatter:e.fieldFormatter,prop:t.prop,width:t.width,label:t.label,"show-overflow-tooltip":""},scopedSlots:e._u([{key:"header",fn:function(t){return[n("div",{staticClass:"table-head-name"},[e._v(e._s(t.column.label))])]}}])})}),e._v(" "),n("el-table-column"),e._v(" "),n("el-table-column",{attrs:{fixed:"right",label:"Tùy chọn",width:"250"},scopedSlots:e._u([{key:"default",fn:function(t){return[n("el-button",{attrs:{type:"text",size:"small"},on:{click:function(n){e.handleClick("edit",t)}}},[e._v("Chỉnh sửa")]),e._v(" "),n("el-button",{attrs:{type:"text",size:"small"},on:{click:function(n){e.handleClick("delete",t)}}},[e._v("Xóa")]),e._v(" "),n("el-button",{attrs:{type:"text",size:"small"},on:{click:function(n){e.handleClick("change",t)}}},[e._v(e._s(0===t.row.status?"Hủy kích hoạt":"Kích hoạt"))]),e._v(" "),n("el-button",{attrs:{type:"text",size:"small"},on:{click:function(n){e.handleClick("copy",t)}}},[e._v("Sao chép")])]}}])})],2),e._v(" "),n("div",{staticClass:"p-contianer"},[n("el-pagination",{staticClass:"p-bar",attrs:{"current-page":e.currentPage,"page-sizes":e.pageSizes,"page-size":e.pageSize,total:e.total,layout:"total, sizes, prev, pager, next, jumper"},on:{"update:pageSize":function(t){e.pageSize=t},"size-change":e.handleSizeChange,"current-change":e.handleCurrentChange}})],1)],1),e._v(" "),e.showHandleView?n("create-system-examine",{attrs:{handle:e.createHandleInfo},on:{save:e.getList,"hiden-view":function(t){e.showHandleView=!1}}}):e._e(),e._v(" "),e.showDetail?n("system-examine-detail",{attrs:{data:e.detailData},on:{refresh:e.getList,"hide-view":function(t){e.showDetail=!1}}}):e._e()],1)},[],!1,null,"1b3e7ce9",null));w.options.__file="SystemExamine.vue";t.default=w.exports},wW83:function(e,t,n){},xvDY:function(e,t,n){"use strict";var a=n("dVmb");n.n(a).a},yYBc:function(e,t,n){"use strict";var a=n("EjQ5");n.n(a).a}}]);