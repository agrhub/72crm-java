(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-1781"],{"0lve":function(t,e,i){"use strict";var s=i("P7Ww");i.n(s).a},"3yi6":function(t,e,i){"use strict";var s=i("7Qib"),a=i("KzkL"),n={name:"FollowRecordCell",components:{CRMFullScreenDetail:function(){return Promise.all([i.e("chunk-66f9"),i.e("chunk-660d"),i.e("chunk-4b7d"),i.e("chunk-4f77"),i.e("chunk-7962e")]).then(i.bind(null,"uMjE"))}},props:{item:{type:Object,default:function(){return{}}},crmType:{type:String,default:""},index:[String,Number]},data:function(){return{showFullDetail:!1,relationID:"",relationCrmType:""}},computed:{},mounted:function(){},methods:{previewImg:function(t,e){this.$bus.emit("preview-image-bus",{index:e,data:t.map(function(t,e,i){return t.url=t.filePath,t})})},downloadFile:function(t){Object(s.b)({path:t.filePath,name:t.name})},handleCommand:function(t){var e=this;this.$confirm("Xác nhận xóa?","Thông báo",{confirmButtonText:"OK",cancelButtonText:"Cancel",type:"warning"}).then(function(){Object(a.p)({recordId:e.item.recordId}).then(function(i){e.$emit("on-handle",{type:t,data:{item:e.item,index:e.index}}),e.$message.success("Thành công")}).catch(function(){})}).catch(function(){e.$message({type:"info",message:"Không thành công"})})},checkRelationDetail:function(t,e){this.relationID=e,this.relationCrmType=t,this.showFullDetail=!0}}},o=(i("VPeB"),i("KHd+")),l=Object(o.a)(n,function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticClass:"fl-c"},[s("flexbox",{staticClass:"fl-h"},[s("div",{directives:[{name:"photo",rawName:"v-photo",value:{img:t.item.userImg,realname:t.item.realname},expression:"{img: item.userImg, realname: item.realname}"},{name:"lazy",rawName:"v-lazy:background-image",value:t.$options.filters.filterUserLazyImg(t.item.userImg),expression:"$options.filters.filterUserLazyImg(item.userImg)",arg:"background-image"}],staticClass:"div-photo fl-h-img"}),t._v(" "),s("div",{staticClass:"fl-h-b"},[s("div",{staticClass:"fl-h-name"},[t._v(t._s(t.item.realname))]),t._v(" "),s("div",{staticClass:"fl-h-time"},[t._v(t._s(t.item.createTime))])]),t._v(" "),s("flexbox",{staticClass:"fl-h-mark"},[s("img",{staticClass:"fl-h-mark-img",attrs:{src:i("N0PQ")}}),t._v(" "),s("div",{staticClass:"fl-h-mark-name"},[t._v("Hồ sơ theo dõi")])]),t._v(" "),s("el-dropdown",{attrs:{trigger:"click"},on:{command:t.handleCommand}},[s("i",{staticClass:"el-icon-arrow-down el-icon-more",staticStyle:{color:"#CDCDCD","margin-left":"8px"}}),t._v(" "),s("el-dropdown-menu",{attrs:{slot:"dropdown"},slot:"dropdown"},[s("el-dropdown-item",{attrs:{command:"delete"}},[t._v("Xóa")])],1)],1)],1),t._v(" "),s("div",{staticClass:"fl-b"},[s("div",{staticClass:"fl-b-content"},[t._v(t._s(t.item.content))]),t._v(" "),t.item.img&&t.item.img.length>0?s("flexbox",{staticClass:"fl-b-images",attrs:{wrap:"wrap"}},t._l(t.item.img,function(e,i){return s("div",{directives:[{name:"lazy",rawName:"v-lazy:background-image",value:e.filePath,expression:"file.filePath",arg:"background-image"}],key:e.filePath,staticClass:"fl-b-img-item",on:{click:function(e){t.previewImg(t.item.img,i)}}})})):t._e(),t._v(" "),t.item.file&&t.item.file.length>0?s("div",{staticClass:"fl-b-files"},t._l(t.item.file,function(e,a){return s("flexbox",{key:a,staticClass:"cell"},[s("img",{staticClass:"cell-head",attrs:{src:i("6KEE")}}),t._v(" "),s("div",{staticClass:"cell-body"},[t._v(t._s(e.name)),s("span",{staticStyle:{color:"#ccc"}},[t._v("（"+t._s(e.size)+"）")])]),t._v(" "),s("el-button",{attrs:{type:"primary",icon:"el-icon-download"},on:{click:function(i){t.downloadFile(e)}}},[t._v("Tải về")])],1)})):t._e(),t._v(" "),t.item.category||t.item.nextTime?s("div",{staticClass:"follow"},[t.item.category?s("span",{staticClass:"follow-info"},[t._v(t._s(t.item.category))]):t._e(),t._v(" "),t.item.nextTime?s("span",{staticClass:"follow-info"},[t._v(t._s(t.item.nextTime))]):t._e()]):t._e(),t._v(" "),t.item.contactsList&&t.item.contactsList.length>0?s("div",{staticClass:"fl-b-other"},[s("div",{staticClass:"fl-b-other-name"},[t._v("Các địa chỉ liên hệ")]),t._v(" "),s("div",t._l(t.item.contactsList,function(e,i){return s("flexbox",{key:i,staticClass:"cell",nativeOn:{click:function(i){t.checkRelationDetail("contacts",e.contactsId)}}},[s("i",{staticClass:"wukong wukong-contacts cell-head crm-type",style:{opacity:0==i?1:0}}),t._v(" "),s("div",{staticClass:"cell-body",staticStyle:{color:"#6394E5",cursor:"pointer"}},[t._v(t._s(e.name))])])}))]):t._e(),t._v(" "),t.item.businessList&&t.item.businessList.length>0?s("div",{staticClass:"fl-b-other"},[s("div",{staticClass:"fl-b-other-name"},[t._v("Các cơ hội kinh doanh")]),t._v(" "),s("div",t._l(t.item.businessList,function(e,i){return s("flexbox",{key:i,staticClass:"cell",nativeOn:{click:function(i){t.checkRelationDetail("business",e.businessId)}}},[s("i",{staticClass:"wukong wukong-business cell-head crm-type",style:{opacity:0==i?1:0}}),t._v(" "),s("div",{staticClass:"cell-body",staticStyle:{color:"#6394E5",cursor:"pointer"}},[t._v(t._s(e.businessName))])])}))]):t._e(),t._v(" "),t._t("default")],2),t._v(" "),s("c-r-m-full-screen-detail",{attrs:{visible:t.showFullDetail,"crm-type":t.relationCrmType,id:t.relationID},on:{"update:visible":function(e){t.showFullDetail=e}}})],1)},[],!1,null,"6a5917be",null);l.options.__file="FollowRecordCell.vue";e.a=l.exports},"7F1U":function(t,e,i){},"7bhQ":function(t,e,i){},B2Fc:function(t,e,i){"use strict";i.d(e,"a",function(){return a}),i.d(e,"c",function(){return n}),i.d(e,"b",function(){return o});var s=i("t3Un");function a(t){return Object(s.a)({url:"bi/taskCompleteStatistics",method:"post",data:t})}function n(t){return Object(s.a)({url:"bi/productStatistics",method:"post",data:t})}function o(t){return Object(s.a)({url:"biFunnel/sellFunnel",method:"post",data:t})}},B7ox:function(t,e,i){"use strict";var s=i("Qq94");i.n(s).a},I0zU:function(t,e,i){},N0PQ:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjZGRjBCRTYxRTBBNzExRTg5QkREOEQxRjlDMkUxOUExIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjZGRjBCRTYyRTBBNzExRTg5QkREOEQxRjlDMkUxOUExIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NkZGMEJFNUZFMEE3MTFFODlCREQ4RDFGOUMyRTE5QTEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NkZGMEJFNjBFMEE3MTFFODlCREQ4RDFGOUMyRTE5QTEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz704RrgAAABwUlEQVR42uSXz0sCQRTH36h1sGNlaHjpVJoHC0KCOnVJOwSdqmM/6NZ/EF071rluQaduGQWd9BZEqWBhQQQmHYIQikDU6bs6G8Oy4q7sskYPPuzOzFu+++a9mZ1lnHNywlzkkDkm7JEb7/m8rWIDoVBHEc+DEuAaSmLMtqk+An6dfr8Ys0T4BHxJUbUzJq6q/yc47kR4CXg1fevgTcf3Faxp+vrAsuHikqxH054A5y2mWvYxnEaPwZTc/Kl1zJPJBt27gbR667YlnUjYMNWMORMxi8edETZhH+AZ9IIx4LZb+A5sieskGALfYMWW4hIFdQtmwJyIVt5gruEziucfrF5OVbAKZsGpzq42BVIQH+6suFovlRRQojnTzWethl73IO52wYaVEd+DcTDSaFUqRPV6c6RYJJ5ON8WJFqwuLkWl/7cWMhmE4SLm8xHP5YhFIkrEJPsYibhqQDgKCur3moXDROUy8Wy2KRoMqn5PZoQLBoSnxTf7otHyeonFYsSiUVlUsUMzwttAOfnV2my3e2ATvKjiFAjIPpdg30yOr0DYRL6VpbMDFoEPPIpz2EGrl2fyn0S3Hm8tNfbv/p1+BBgA+Vdv2Iz9D6cAAAAASUVORK5CYII="},OPCT:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjVENDNERTkxRTA5QjExRThBQkRDQjRERjVBMjY3MzE0IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjVENDNERTkyRTA5QjExRThBQkRDQjRERjVBMjY3MzE0Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NUQ0M0RFOEZFMDlCMTFFOEFCRENCNERGNUEyNjczMTQiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NUQ0M0RFOTBFMDlCMTFFOEFCRENCNERGNUEyNjczMTQiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7c1/V2AAABIElEQVR42mL8//8/AwicPXuWgVxgbGwMZzMRUBsGxBeB+AXITigfL2DBIxcCxHlA7AnEz4CYB4gnQ+VW4dKEz4UNQBwNNQwEvgBxBhAn4XMhPgMFgPghmthPIP5NroF/cYgzkmsgMw7x/+Qa+AGIZbBEIgu5BjYC8VIgloLyQbE8E4gXkJtsVkMt3Ak1DOTiDiBeSa6BDFDNK0nJNdi8rArEa4H4IzQC0PFHqLwqMQaqA/ERID4IxIrQJIKOFaDyR6Dq8Xq5DYon4fHVe6g8J1RtMD4XugDxYiKDazYQu5GSbMgC6AbuAeJYIvWmAPEuQmFYDQ3w/1Cvv8dikCDU0mIgtifkwhtAbAdV+BBHsnkIlbeDqieYsG+ixxwpACDAAIZEQR7SM/O0AAAAAElFTkSuQmCC"},P7Ww:function(t,e,i){},QJC7:function(t,e,i){"use strict";var s=i("3yi6"),a=i("5tgW"),n=i("vG5h"),o=i("qbf4"),l=i("UcQx"),c=i("6zBA"),u={name:"RecordLog",components:{FollowRecordCell:s.a},props:{id:[String,Number],crmType:{type:String,default:""}},data:function(){return{loading:!1,loadMoreLoading:!0,isPost:!1,page:1,list:[]}},computed:{},watch:{id:function(t){this.refreshList()}},mounted:function(){var t=this;this.$bus.on("follow-log-refresh",function(e){"record-log"==e.type&&t.refreshList()});var e=document.getElementById("follow-log-content");e.onscroll=function(){var i=e.scrollTop+e.clientHeight-e.scrollHeight;Math.abs(i)<10&&1==t.loadMoreLoading&&(t.isPost?t.loadMoreLoading=!1:(t.isPost=!0,t.page++,t.getList()))},this.getList()},activated:function(){},deactivated:function(){},beforeDestroy:function(){this.$bus.off("follow-log-refresh")},methods:{getList:function(){var t=this;this.loading=!0;var e={customer:n.v,leads:a.i,contacts:o.j,business:l.j,contract:c.j}[this.crmType],i={page:this.page,limit:10};i[this.crmType+"Id"]=this.id,e(i).then(function(e){t.list=t.list.concat(e.data),e.data.length<10?t.loadMoreLoading=!1:t.loadMoreLoading=!0,t.loading=!1,t.isPost=!1}).catch(function(){t.isPost=!1,t.loading=!1})},refreshList:function(){this.page=1,this.list=[],this.getList()},cellHandle:function(t){"delete"==t.type&&this.list.splice(t.data.index,1)}}},r=(i("gs/v"),i("KHd+")),d=Object(r.a)(u,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}]},[i("div",{directives:[{name:"empty",rawName:"v-empty",value:0===t.list.length,expression:"list.length === 0"}]},[i("div",{staticClass:"log-items"},[t._l(t.list,function(e,s){return i("follow-record-cell",{key:s,attrs:{item:e,index:s,"crm-type":t.crmType},on:{"on-handle":t.cellHandle}})}),t._v(" "),i("div",{staticClass:"load"},[i("el-button",{attrs:{loading:t.loadMoreLoading,type:"text"}},[t._v(t._s(t.loadMoreLoading?"Tải thêm":"Không có dữ liệu"))])],1)],2)])])},[],!1,null,"cfac43fc",null);d.options.__file="RecordLog.vue";e.a=d.exports},Qq94:function(t,e,i){},"RU/L":function(t,e,i){i("Rqdy");var s=i("WEpk").Object;t.exports=function(t,e,i){return s.defineProperty(t,e,i)}},Rqdy:function(t,e,i){var s=i("Y7ZC");s(s.S+s.F*!i("jmDH"),"Object",{defineProperty:i("2faE").f})},SEkw:function(t,e,i){t.exports={default:i("RU/L"),__esModule:!0}},UEWd:function(t,e,i){"use strict";var s=i("7Qib"),a=i("KTTK"),n={name:"MixAdd",components:{CrmRelative:i("mkuN").a},props:{showRelativeBusiness:{type:Boolean,default:!1},showRelativeContacts:{type:Boolean,default:!1},id:[String,Number],crmType:{type:String,default:""}},data:function(){return{content:"",inputAutosize:{minRows:1,maxRows:6},barItems:[{img:i("S1Xc"),title:"Hình ảnh",type:"img",data:"image/*"},{img:i("rl4O"),title:"Đính kèm",type:"file",data:"*.*"}],imgFiles:[],files:[],business:[],contacts:[],showRelativeType:"",batchId:""}},computed:{},mounted:function(){this.showRelativeBusiness&&this.barItems.push({img:i("i91G"),title:"Cơ hội kinh doanh",type:"business",show:!1}),this.showRelativeContacts&&this.barItems.push({img:i("OPCT"),title:"Thông tin liên hệ",type:"contacts",show:!1}),this.$on("submit-info",function(){this.$emit("mixadd-info",{content:this.content,files:this.files,images:this.imgFiles,business:this.business,contacts:this.contacts,batchId:this.batchId})})},beforeDestroy:function(){this.$off("submit-info")},methods:{resetInfo:function(){this.content="",this.imgFiles=[],this.files=[],this.business=[],this.contacts=[],this.showRelativeType="",this.batchId=""},checkRelativeInfos:function(t){"business"==this.showRelativeType?this.business=t.data:"contacts"==this.showRelativeType&&(this.contacts=t.data)},barClick:function(t){this.showRelativeType=t.type,"business"==t.type?t.show=!0:"contacts"==t.type&&(t.show=!0)},uploadFile:function(t){var e=this,i=t.target.files;if(i.length){for(var s=0;s<i.length;s++){if(-1==i[s].type.indexOf("image")&&"img"==this.showRelativeType)return void this.$message.error("Vui lòng chọn đúng hình ảnh")}var a="image/*"==t.target.accept?"img":"file",n=i[0];this.sendFileRequest(n,a,function(){for(var s=1;s<i.length;s++){var n=i[s];e.sendFileRequest(n,a)}t.target.value=""})}},sendFileRequest:function(t,e,i){var n=this,o={file:t,type:e};this.batchId&&(o.batchId=this.batchId),Object(a.e)(o).then(function(a){""==n.batchId&&(n.batchId=a.batchId),a.size=Object(s.d)(t.size),"img"==e?n.imgFiles.push(a):(a.icon=Object(s.g)(t),n.files.push(a)),i&&i()}).catch(function(){})},deleteAllImg:function(){this.imgFiles=[]},deleteImgOrFile:function(t,e,i){var s=this;Object(a.c)({id:e.fileId}).then(function(e){"image"==t?s.imgFiles.splice(i,1):s.files.splice(i,1),s.$message.success("Thành công")}).catch(function(){})},mouseImgOver:function(t,e){t.showDelete=!0,this.$set(this.imgFiles,e,t)},mouseImgLeave:function(t,e){t.showDelete=!1,this.$set(this.imgFiles,e,t)},inputFocus:function(){var t=this;this.inputAutosize={minRows:3,maxRows:6},this.$nextTick(function(){t.$refs.textarea.resizeTextarea()})}}},o=(i("B7ox"),i("KHd+")),l=Object(o.a)(n,function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("div",{staticClass:"mix-container"},[s("div",{staticClass:"i-cont"},[s("el-input",{ref:"textarea",attrs:{autosize:t.inputAutosize,type:"textarea",clearable:"",resize:"none",placeholder:"Vui lòng nhập nội dung"},on:{focus:t.inputFocus},model:{value:t.content,callback:function(e){t.content=e},expression:"content"}})],1),t._v(" "),t.imgFiles.length>0?s("section",{staticClass:"img-cont"},[s("flexbox",{attrs:{wrap:"wrap"}},[t._l(t.imgFiles,function(e,i){return s("div",{key:i,staticClass:"img-item",style:{"background-image":"url("+e.url+")"},on:{mouseover:function(s){t.mouseImgOver(e,i)},mouseleave:function(s){t.mouseImgLeave(e,i)}}},[e.showDelete?s("div",{staticClass:"img-delete",on:{click:function(s){t.deleteImgOrFile("image",e,i)}}},[t._v("×")]):t._e()])}),t._v(" "),s("div",{staticClass:"img-item-add"},[s("input",{staticClass:"img-item-iput",attrs:{type:"file",accept:"image/*",multiple:""},on:{change:t.uploadFile}})])],2),t._v(" "),s("div",{staticClass:"img-bar",on:{click:t.deleteAllImg}},[t._v("Xóa tất cả")])],1):t._e(),t._v(" "),t.files.length>0?s("section",{staticClass:"file-cont"},[s("flexbox",{staticClass:"f-header"},[s("img",{staticClass:"f-logo",attrs:{src:i("rl4O")}}),t._v(" "),s("div",{staticClass:"f-name"},[t._v("Đính kèm")])]),t._v(" "),s("div",{staticClass:"f-body"},t._l(t.files,function(e,i){return s("flexbox",{key:i,staticClass:"f-item"},[s("img",{staticClass:"f-img",attrs:{src:e.icon}}),t._v(" "),s("div",{staticClass:"f-name"},[t._v(t._s(e.name+"("+e.size+")"))]),t._v(" "),s("div",{staticClass:"close-button",on:{click:function(s){t.deleteImgOrFile("file",e,i)}}},[t._v("×")])])})),t._v(" "),s("div",{staticClass:"img-bar",on:{click:function(e){t.files=[]}}},[t._v("Xóa tất cả")])],1):t._e(),t._v(" "),t.business.length>0?s("section",{staticClass:"c-cont"},[s("flexbox",{staticClass:"c-header"},[s("img",{staticClass:"c-logo",attrs:{src:i("i91G")}}),t._v(" "),s("div",{staticClass:"c-name"},[t._v("Gởi")])]),t._v(" "),s("div",{staticClass:"c-body"},[s("flexbox",{attrs:{wrap:"wrap"}},t._l(t.business,function(e,i){return s("flexbox",{key:i,staticClass:"c-item"},[s("div",{staticClass:"c-item-name"},[t._v(t._s(e.businessName))]),t._v(" "),s("div",{staticClass:"c-item-close",on:{click:function(e){t.business.splice(i,1)}}},[t._v("×")])])}))],1)],1):t._e(),t._v(" "),t.contacts.length>0?s("section",{staticClass:"c-cont"},[s("flexbox",{staticClass:"c-header"},[s("img",{staticClass:"c-logo",attrs:{src:i("OPCT")}}),t._v(" "),s("div",{staticClass:"c-name"},[t._v("Người liên hệ")])]),t._v(" "),s("div",{staticClass:"c-body"},[s("flexbox",{attrs:{wrap:"wrap"}},t._l(t.contacts,function(e,i){return s("flexbox",{key:i,staticClass:"c-item"},[s("div",{staticClass:"c-item-name"},[t._v(t._s(e.name))]),t._v(" "),s("div",{staticClass:"c-item-close",on:{click:function(e){t.contacts.splice(i,1)}}},[t._v("×")])])}))],1)],1):t._e(),t._v(" "),s("flexbox",{staticClass:"bar-cont"},[t._l(t.barItems,function(e,i){return["img"==e.type||"file"==e.type?s("flexbox",{key:i,staticClass:"bar-item",nativeOn:{click:function(i){t.barClick(e)}}},[s("input",{staticClass:"bar-input",attrs:{accept:e.data,type:"file",multiple:""},on:{change:t.uploadFile}}),t._v(" "),s("img",{staticClass:"bar-img",attrs:{src:e.img}}),t._v(" "),s("div",{staticClass:"bar-title"},[t._v(t._s(e.title))])]):s("el-popover",{key:i,attrs:{placement:"bottom",width:"700","popper-class":"no-padding-popover",trigger:"click"},model:{value:e.show,callback:function(i){t.$set(e,"show",i)},expression:"item.show"}},[s("crm-relative",{ref:"crmrelative",refInFor:!0,attrs:{show:e.show,radio:!1,action:{type:"condition",data:{moduleType:t.crmType,customerId:t.id}},"selected-data":"business"==e.type?{business:t.business}:{contacts:t.contacts},"crm-type":e.type},on:{close:function(t){e.show=!1},changeCheckout:t.checkRelativeInfos}}),t._v(" "),s("flexbox",{staticClass:"bar-item",attrs:{slot:"reference"},nativeOn:{click:function(i){t.barClick(e)}},slot:"reference"},[s("img",{staticClass:"bar-img",attrs:{src:e.img}}),t._v(" "),s("div",{staticClass:"bar-title"},[t._v(t._s(e.title))])])],1)]})],2)],1)},[],!1,null,"604eed47",null);l.options.__file="MixAdd.vue";e.a=l.exports},VPeB:function(t,e,i){"use strict";var s=i("I0zU");i.n(s).a},YEIV:function(t,e,i){"use strict";e.__esModule=!0;var s=function(t){return t&&t.__esModule?t:{default:t}}(i("SEkw"));e.default=function(t,e,i){return e in t?(0,s.default)(t,e,{value:i,enumerable:!0,configurable:!0,writable:!0}):t[e]=i,t}},fwlh:function(t,e,i){"use strict";i.r(e);var s=i("B2Fc"),a=i("xfX+"),n=i("ppJE"),o=i("8gwX"),l=i("oj9+"),c={name:"ProductStatistics",components:{ContractDetail:a.a,CustomerDetail:n.a,ProductDetail:o.a},mixins:[l.a],data:function(){return{loading:!1,tableHeight:document.documentElement.clientHeight-155,postParams:{},headFieldList:[{field:"categoryName",name:"Tên danh mục",width:"115px"},{field:"productName",name:"Tên sản phẩm",width:"115px"},{field:"contracNum",name:"Mã hợp đồng",width:"115px"},{field:"ownerUserName",name:"Tên người phụ trách",width:"115px"},{field:"customerName",name:"Tên khách hàng",width:"115px"},{field:"productPrice",name:"Đơn giá",width:"115px"},{field:"productNum",name:"Số lượng",width:"115px"},{field:"productSubtotal",name:"Thành tiền",width:"115px"}],list:[],spanList:[],newList:[],showContractview:!1,showCustomerView:!1,showProductview:!1,rowID:""}},computed:{},mounted:function(){var t=this;window.onresize=function(){var e=document.documentElement.clientHeight;t.tableHeight=e-155}},methods:{objectSpanMethod:function(t){t.row,t.column;var e=t.rowIndex,i=t.columnIndex,s=this.spanList[e];return 0==i?0==s.rowspan?{rowspan:0,colspan:0}:{rowspan:s.rowspan,colspan:1}:1==i?0==s.productRowspan?{rowspan:0,colspan:0}:{rowspan:s.productRowspan,colspan:1}:void 0},handleRowClick:function(t,e,i){"customerName"===e.property?(this.showProductview&&(this.showProductview=!1),this.showContractview&&(this.showContractview=!1),this.rowID=t.customerId,this.showCustomerView=!0):"productName"===e.property?(this.showCustomerView&&(this.showCustomerView=!1),this.showContractview&&(this.showContractview=!1),this.rowID=t.productId,this.showProductview=!0):"contracNum"===e.property&&(this.showProductview&&(this.showProductview=!1),this.showCustomerView&&(this.showCustomerView=!1),this.rowID=t.contractId,this.showContractview=!0)},cellStyle:function(t){t.row,t.column;var e=t.rowIndex,i=t.columnIndex,s=this.spanList[e];return 1==s.isSum?{backgroundColor:"#FFF9F2"}:1==s.isAllSum?{backgroundColor:"#FFF3E8"}:1===i||2===i||4===i?{color:"#3E84E9",cursor:"pointer"}:void 0},getProductDatalist:function(t){var e=this;this.loading=!0,Object(s.c)(t).then(function(t){e.list=t.data,e.handleShowInfo(),e.loading=!1}).catch(function(){e.loading=!1})},handleShowInfo:function(){for(var t=[],e=[],i=0,s=0,a=0,n=0,o=0,l=0,c=0;c<this.list.length;c++){var u=this.list[c];if(0==e.length)i=0,s=0,a=parseFloat(u.productNum),n=parseFloat(u.productSubtotal),o=parseFloat(u.productNum),l=parseFloat(u.productSubtotal),e.push({rowspan:1,productRowspan:1}),t.push(u);else if(u.categoryId!=this.list[c-1].categoryId){(r=e[i]).rowspan+=1,t.push({productNum:a,productSubtotal:n}),e.push({rowspan:0,productRowspan:1,isSum:!0}),t.push({productNum:o,productSubtotal:l}),e.push({rowspan:1,productRowspan:1,isAllSum:!0}),e.push({rowspan:1,productRowspan:1}),a=parseFloat(u.productNum),n=parseFloat(u.productSubtotal),o=parseFloat(u.productNum),l=parseFloat(u.productSubtotal),t.push(u),i=e.length-1,s=e.length-1}else{var r;if((r=e[i]).rowspan+=1,u.productId==this.list[c-1].productId)e[s].productRowspan+=1,e.push({rowspan:0,productRowspan:0}),a+=parseFloat(u.productNum),n+=parseFloat(u.productSubtotal),o+=parseFloat(u.productNum),l+=parseFloat(u.productSubtotal),t.push(u);else r.rowspan+=1,t.push({productNum:a,productSubtotal:n}),e.push({rowspan:0,productRowspan:1,isSum:!0}),e.push({rowspan:0,productRowspan:1}),s=e.length-1,a=parseFloat(u.productNum),n=parseFloat(u.productSubtotal),o+=parseFloat(u.productNum),l+=parseFloat(u.productSubtotal),t.push(u)}if(this.list.length-1==c)(r=e[i]).rowspan+=1,t.push({productNum:a,productSubtotal:n}),a=0,n=0,e.push({rowspan:0,productRowspan:1,isSum:!0}),t.push({productNum:o,productSubtotal:l}),o=0,l=0,e.push({rowspan:1,productRowspan:1,isAllSum:!0})}this.spanList=e,this.newList=t}}},u=(i("hcS2"),i("KHd+")),r=Object(u.a)(c,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{directives:[{name:"loading",rawName:"v-loading",value:t.loading,expression:"loading"}],staticClass:"main-container"},[i("filtrate-handle-view",{staticClass:"filtrate-bar",attrs:{"module-type":"product"},on:{load:function(e){t.loading=!0},change:t.getProductDatalist}}),t._v(" "),i("div",{staticClass:"content"},[i("el-table",{attrs:{id:"crm-table",data:t.newList,height:t.tableHeight,"span-method":t.objectSpanMethod,"cell-style":t.cellStyle,border:""},on:{"row-click":t.handleRowClick}},t._l(t.headFieldList,function(t,e){return i("el-table-column",{key:e,attrs:{prop:t.field,label:t.name,align:"center","header-align":"center","show-overflow-tooltip":""}})}))],1),t._v(" "),t.showContractview&&t.rowID?i("contract-detail",{staticClass:"d-view",attrs:{id:t.rowID},on:{"hide-view":function(e){t.showContractview=!1}}}):t._e(),t._v(" "),t.showCustomerView&&t.rowID?i("customer-detail",{staticClass:"d-view",attrs:{id:t.rowID},on:{"hide-view":function(e){t.showCustomerView=!1}}}):t._e(),t._v(" "),t.showProductview&&t.rowID?i("product-detail",{staticClass:"d-view",attrs:{id:t.rowID},on:{"hide-view":function(e){t.showProductview=!1}}}):t._e()],1)},[],!1,null,"80ffad94",null);r.options.__file="ProductStatistics.vue";e.default=r.exports},"gXW+":function(t,e,i){"use strict";var s=i("KTTK"),a=i("UcQx"),n=i("conU"),o=i("uKQN"),l=i("wd/R"),c=i.n(l),u={name:"FiltrateHandleView",components:{timeTypeSelect:o.a},props:{moduleType:{required:!0,type:String},showYearSelect:{default:!1,type:Boolean},showBusinessSelect:{default:!1,type:Boolean},showUserSelect:{default:!0,type:Boolean},showCustomSelect:{default:!1,type:Boolean},customDefault:"",customOptions:{default:function(){return[]},type:Array},showProductSelect:{default:!1,type:Boolean}},data:function(){return{pickerOptions:{disabledDate:function(t){return t.getTime()>Date.now()}},yearValue:"",timeTypeValue:{},structuresProps:{children:"children",label:"label",value:"id"},deptList:[],structuresSelectValue:"",userOptions:[],userSelectValue:"",businessOptions:[],businessStatusValue:"",productValue:[],productOptions:[],customValue:""}},watch:{},mounted:function(){var t=this;this.showCustomSelect&&(this.customValue=this.customDefault),this.showYearSelect&&(this.yearValue=c()(new Date).year().toString()),this.$emit("load"),this.getDeptList(function(){t.showBusinessSelect?t.getBusinessStatusList(function(){t.postFiltrateValue()}):t.postFiltrateValue()}),this.showProductSelect&&this.getProductCategoryIndex()},beforeDestroy:function(){},methods:{customSelectChange:function(){this.$emit("typeChange",this.customValue)},timeTypeChange:function(t){this.timeTypeValue=t},getDeptList:function(t){var e=this;Object(s.b)({m:"bi",c:this.moduleType,a:"read"}).then(function(i){e.deptList=i.data,i.data.length>0?(e.structuresSelectValue=i.data[0].id,e.showUserSelect&&e.getUserList()):e.structuresSelectValue="",t(!0)}).catch(function(){e.$emit("error")})},structuresValueChange:function(t){this.showUserSelect&&(this.userSelectValue="",this.userOptions=[],this.getUserList())},getUserList:function(){var t=this,e={};e.deptId=this.structuresSelectValue,Object(s.i)(e).then(function(e){t.userOptions=e.data}).catch(function(){t.$emit("error")})},getBusinessStatusList:function(t){var e=this;Object(a.q)().then(function(i){e.businessOptions=i.data,i.data.length>0&&(e.businessStatusValue=i.data[0].typeId),t(!0)}).catch(function(){e.$emit("error")})},getProductCategoryIndex:function(){var t=this;Object(n.u)({type:"tree"}).then(function(e){t.productOptions=e.data}).catch(function(){})},postFiltrateValue:function(){var t={deptId:this.structuresSelectValue};this.showUserSelect&&(t.userId=this.userSelectValue),this.showBusinessSelect&&(t.typeId=this.businessStatusValue),this.showProductSelect&&(t.categoryId=this.productValue.length>0?this.productValue[this.productValue.length-1]:""),this.showYearSelect?t.year=this.yearValue:"custom"==this.timeTypeValue.type?(t.startTime=this.timeTypeValue.startTime,t.endTime=this.timeTypeValue.endTime):t.type=this.timeTypeValue.value,this.$emit("change",t)}}},r=(i("0lve"),i("KHd+")),d=Object(r.a)(u,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"filtrate-content"},[t.showYearSelect?t._e():i("time-type-select",{on:{change:t.timeTypeChange}}),t._v(" "),t.showYearSelect?i("el-date-picker",{attrs:{clearable:!1,"picker-options":t.pickerOptions,type:"year","value-format":"yyyy",placeholder:"Chọn năm"},model:{value:t.yearValue,callback:function(e){t.yearValue=e},expression:"yearValue"}}):t._e(),t._v(" "),i("el-select",{attrs:{placeholder:"Chọn bộ phận"},on:{change:t.structuresValueChange},model:{value:t.structuresSelectValue,callback:function(e){t.structuresSelectValue=e},expression:"structuresSelectValue"}},t._l(t.deptList,function(t){return i("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})})),t._v(" "),t.showUserSelect?i("el-select",{attrs:{clearable:!0,placeholder:"Chọn nhân viên"},model:{value:t.userSelectValue,callback:function(e){t.userSelectValue=e},expression:"userSelectValue"}},t._l(t.userOptions,function(t){return i("el-option",{key:t.id,attrs:{label:t.realname,value:t.id}})})):t._e(),t._v(" "),t.showBusinessSelect?i("el-select",{attrs:{placeholder:"Đơn vị kinh doanh"},model:{value:t.businessStatusValue,callback:function(e){t.businessStatusValue=e},expression:"businessStatusValue"}},t._l(t.businessOptions,function(t){return i("el-option",{key:t.typeId,attrs:{label:t.name,value:t.typeId}})})):t._e(),t._v(" "),t.showProductSelect?i("el-cascader",{staticStyle:{width:"100%"},attrs:{options:t.productOptions,"show-all-levels":!1,props:{children:"children",label:"label",value:"categoryId"},"change-on-select":""},model:{value:t.productValue,callback:function(e){t.productValue=e},expression:"productValue"}}):t._e(),t._v(" "),t.showCustomSelect?i("el-select",{attrs:{placeholder:"Loại biểu tượng"},on:{change:t.customSelectChange},model:{value:t.customValue,callback:function(e){t.customValue=e},expression:"customValue"}},t._l(t.customOptions,function(t){return i("el-option",{key:t.value,attrs:{label:t.name,value:t.value}})})):t._e(),t._v(" "),i("el-button",{attrs:{type:"primary"},nativeOn:{click:function(e){t.postFiltrateValue()}}},[t._v("Tìm kiếm")]),t._v(" "),t._t("default")],2)},[],!1,null,"6eac449c",null);d.options.__file="filtrateHandleView.vue";e.a=d.exports},"gs/v":function(t,e,i){"use strict";var s=i("ta8G");i.n(s).a},hcS2:function(t,e,i){"use strict";var s=i("7bhQ");i.n(s).a},i68b:function(t,e,i){"use strict";var s=i("QbLZ"),a=i.n(s),n=i("KzkL"),o=i("L2JU");e.a={data:function(){return{followTypes:[],followType:""}},computed:a()({},Object(o.b)(["oa"]),{showOAPermission:function(){return this.oa}}),created:function(){this.getFollowLogType()},methods:{getFollowLogType:function(){var t=this;this.loading=!0,Object(n.x)().then(function(e){t.loading=!1,t.followTypes=e.data.map(function(t){return{type:t,name:t}}),t.followType=e.data.length>0?e.data[0]:""}).catch(function(){t.loading=!1})}},deactivated:function(){}}},i91G:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjU2RjI0NjM0RTA5QjExRTg4QTE5QjM2OEE1QUE5MUZBIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjU2RjI0NjM1RTA5QjExRTg4QTE5QjM2OEE1QUE5MUZBIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NTZGMjQ2MzJFMDlCMTFFODhBMTlCMzY4QTVBQTkxRkEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NTZGMjQ2MzNFMDlCMTFFODhBMTlCMzY4QTVBQTkxRkEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4H2LzoAAAAnklEQVR42mI8c+YMA7WAsbExAxMDlQGygSuA+B8Q/8eD/0HV4QQsSOwwNAtwAZChEcS4kJFIXzES62WqhyFdDESOqH1ocjuwRRQLAQPxRZQHEvsvLKKYKIkAbD5FNvA/kZr/ExuGq5HC6wiauo1I4bWa2IQdDsXYgP+gTTZUN5DYiPpHbDqERRQjAUtXE2sgvojCnnD///8/uCMFIMAAVWsql9WKpTgAAAAASUVORK5CYII="},"oj9+":function(t,e,i){"use strict";var s=i("gXW+");e.a={data:function(){return{chartColors:["#6CA2FF","#6AC9D7","#72DCA2","#48E78D","#FECD51","#DBB375","#FF7474","#F59561","#A3AEBC","#4C84FF","#0DBEB4","#00DEDE","#FFAA00","#C7C116","#F7A57C","#F661AC","#8652EE"]}},components:{filtrateHandleView:s.a},props:{},computed:{},watch:{},mounted:function(){},methods:{},deactivated:function(){}}},rl4O:function(t,e){t.exports="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQyIDc5LjE2MDkyNCwgMjAxNy8wNy8xMy0wMTowNjozOSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTggKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjUzM0EzN0E0RTA5QjExRTg4MTZEOEM2ODYxNjE5QjM3IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjUzM0EzN0E1RTA5QjExRTg4MTZEOEM2ODYxNjE5QjM3Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6NTMzQTM3QTJFMDlCMTFFODgxNkQ4QzY4NjE2MTlCMzciIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6NTMzQTM3QTNFMDlCMTFFODgxNkQ4QzY4NjE2MTlCMzciLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7neeY0AAABL0lEQVR42syUv0tCURSA1Vzam5ya+h8ag5DG3GpqqsAiwVFoECJc+jGpCFZrLTpFUjQ7PPwjClxyiCY3+y6cB5fLud0rOXjhG965j++de865L5skSWaRK5dZ8JpHmIUG/MAA1v4jNLIWVKAO6/CmSWOFO3AAJbiCLVjVpLHCV9iAF3ke+6S5wDFr8Az78Ons29LHkNDImnAO3/AAZeU9I+3AZhrI/9EAU7Nd6egIbuEJJk5tL2RPzVCTpfGZ0qieZF/TMvTJzmT+TqzsbFnZ/pidYUORHcKNzF87JHMzPJXUB1ZsBY6gGyNzhUM4lhEYS6ztqZkqc4+8B1N4h4LSgH5I5gq/YFuRprL7kEwbm4kjrYrsLkbmuymp9AMu4VpGZhZz6fOeuJEWl+KP/SvAAHR5UyjSji44AAAAAElFTkSuQmCC"},ta8G:function(t,e,i){},uKQN:function(t,e,i){"use strict";var s={name:"TimeTypeSelect",props:{defaultType:Object},data:function(){return{selectType:{label:"Năm nay",value:"year"},showTypePopover:!1,showCustomContent:!1,sureCustomContent:!1,startTime:"",endTime:"",typeOptions:[{label:"Hôm nay",value:"today"},{label:"Hôm qua",value:"yesterday"},{label:"Tuần này",value:"week"},{label:"Tuần rồi",value:"lastWeek"},{label:"Tháng này",value:"month"},{label:"Tháng trước",value:"lastMonth"},{label:"Quý này",value:"quarter"},{label:"Quý trước",value:"lastQuarter"},{label:"Năm nay",value:"year"},{label:"Năm trước",value:"lastYear"}]}},computed:{iconClass:function(){return this.showTypePopover?"arrow-up":"arrow-down"},typeShowValue:function(){return this.sureCustomContent?this.startTime||this.endTime?(this.startTime||"")+"-"+(this.endTime||""):"":this.selectType.label}},mounted:function(){this.defaultType?this.selectType=this.defaultType:this.$emit("change",{type:"default",value:this.selectType.value})},methods:{typeSelectClick:function(t){this.showTypePopover=!1,this.sureCustomContent=!1,this.showCustomContent=!1,this.selectType=t,this.$emit("change",{type:"default",value:this.selectType.value})},customSureClick:function(){this.startTime&&this.endTime&&(this.sureCustomContent=!0,this.showTypePopover=!1,this.$emit("change",{type:"custom",startTime:this.startTime,endTime:this.endTime}))}}},a=(i("w4JZ"),i("KHd+")),n=Object(a.a)(s,function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("el-popover",{attrs:{placement:"bottom",width:"200","popper-class":"no-padding-popover",trigger:"click"},model:{value:t.showTypePopover,callback:function(e){t.showTypePopover=e},expression:"showTypePopover"}},[i("div",{staticClass:"type-popper"},[i("div",{staticClass:"type-content"},[t._l(t.typeOptions,function(e,s){return i("div",{key:s,staticClass:"type-content-item",class:{selected:t.selectType.value==e.value&&!t.showCustomContent},on:{click:function(i){t.typeSelectClick(e)}}},[i("div",{staticClass:"mark"}),t._v(t._s(e.label)+"\n      ")])}),t._v(" "),i("div",{staticClass:"type-content-item",class:{selected:t.showCustomContent},on:{click:function(e){t.showCustomContent=!0}}},[i("div",{staticClass:"mark"}),t._v("Tùy chỉnh\n      ")])],2),t._v(" "),t.showCustomContent?i("div",{staticClass:"type-content-custom"},[i("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"Chọn ngày bắt đầu"},model:{value:t.startTime,callback:function(e){t.startTime=e},expression:"startTime"}}),t._v(" "),i("el-date-picker",{attrs:{type:"date","value-format":"yyyy-MM-dd",placeholder:"Chọn ngày kết thúc"},model:{value:t.endTime,callback:function(e){t.endTime=e},expression:"endTime"}}),t._v(" "),i("el-button",{on:{click:t.customSureClick}},[t._v("OK")])],1):t._e()]),t._v(" "),i("el-input",{staticClass:"type-select",attrs:{slot:"reference",readonly:!0,placeholder:"Vui lòng chọn"},slot:"reference",model:{value:t.typeShowValue,callback:function(e){t.typeShowValue=e},expression:"typeShowValue"}},[i("i",{class:["el-input__icon","el-icon-"+t.iconClass],attrs:{slot:"suffix"},slot:"suffix"})])],1)},[],!1,null,"398cb27e",null);n.options.__file="index.vue";e.a=n.exports},w4JZ:function(t,e,i){"use strict";var s=i("7F1U");i.n(s).a}}]);