(window.webpackJsonp=window.webpackJsonp||[]).push([["chunk-4f5b"],{"+H+P":function(e,t,i){"use strict";var a={name:"EditImage",components:{VueCropper:i("fnnb").VueCropper},props:{width:{type:String,default:"450px"},title:{type:String,default:"Chỉnh sửa ảnh đại diện"},saveButtonTitle:{type:String,default:"Bắt đầu tải lên"},show:{type:Boolean,default:!1},fixedNumber:{type:Array,default:function(){return[1,1]}},previewWidth:{type:String,default:"70px"},previewHeight:{type:String,default:"70px"},previewRadius:{type:String,default:"35px"},file:[File],image:String},data:function(){return{loading:!1,showDialog:!1,cropperImg:"",previewImg:""}},computed:{},watch:{show:{handler:function(e){this.showDialog=e},deep:!0,immediate:!0},image:function(e){this.cropperImg=e}},mounted:function(){this.cropperImg=this.image},methods:{realTime:function(e){var t=this;this.$refs.cropper.getCropData(function(e){t.previewImg=e})},submiteImage:function(){var e=this;this.$refs.cropper.getCropBlob(function(t){e.$emit("save",{blob:t,file:e.file,image:e.previewImg}),e.hiddenView()})},hiddenView:function(){this.$emit("close")}}},s=(i("B6D4"),i("KHd+")),n=Object(s.a)(a,function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("el-dialog",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],attrs:{title:e.title,width:e.width,"append-to-body":!0,visible:e.showDialog},on:{"update:visible":function(t){e.showDialog=t},close:e.hiddenView}},[i("flexbox",{staticClass:"content"},[i("div",{staticClass:"cropper-box"},[i("vueCropper",{ref:"cropper",attrs:{"can-move":!0,"auto-crop":!0,fixed:!0,"fixed-number":e.fixedNumber,img:e.cropperImg,"output-type":"png"},on:{realTime:e.realTime}})],1),e._v(" "),i("div",{staticClass:"preview"},[i("div",{staticClass:"preview-name"},[e._v("Xem trước")]),e._v(" "),i("img",{staticClass:"preview-img",style:{width:e.previewWidth,height:e.previewHeight,"border-radius":e.previewRadius},attrs:{src:e.previewImg}})])]),e._v(" "),i("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[i("el-button",{attrs:{type:"primary"},on:{click:function(t){e.submiteImage()}}},[e._v(e._s(e.saveButtonTitle))])],1)],1)},[],!1,null,"2214f45e",null);n.options.__file="EditImage.vue";t.a=n.exports},"/s93":function(e,t,i){},"8T3t":function(e,t,i){},B6D4:function(e,t,i){"use strict";var a=i("/s93");i.n(a).a},PiaH:function(e,t,i){"use strict";var a=i("8T3t");i.n(a).a},XR9T:function(e,t,i){"use strict";i.r(t);var a=i("EJiy"),s=i.n(a),n=i("QbLZ"),o=i.n(n),l=i("QabZ"),r=i("+H+P"),d=i("L2JU"),m={name:"SystemConfig",components:{EditImage:r.a},data:function(){return{loading:!1,showEditImage:!1,editImage:null,editFile:null,systemName:"",systemImage:"",editedImage:null}},computed:o()({},Object(d.b)(["manage"]),{systemSaveAuth:function(){return this.manage&&this.manage.system&&this.manage.system.update}}),mounted:function(){this.getDetail()},methods:{fileUpload:function(e){var t=new FileReader,i=this;t.onload=function(t){var a=void 0;a="object"===s()(t.target.result)?window.URL.createObjectURL(new Blob([t.target.result])):t.target.result,i.editImage=a,i.editFile=e.file,i.showEditImage=!0},t.readAsDataURL(e.file)},deleteSystemImage:function(){this.systemImage="",this.editedImage=null},getDetail:function(){var e=this;this.loading=!0,this.$store.dispatch("SystemLogoAndName").then(function(t){e.loading=!1,e.systemName=t.data.name?t.data.name:"",e.systemImage=t.data.logo}).catch(function(){e.loading=!1})},submiteImage:function(e){this.editedImage=e,this.systemImage=e.image},save:function(){var e=this;if(this.systemName){this.loading=!0;var t=new FormData;t.append("name",this.systemName),this.editedImage&&t.append("file",this.editedImage.blob,this.editedImage.file.name),Object(l.b)(t).then(function(t){e.loading=!1,e.$message.success("Thành công"),e.getDetail()}).catch(function(){e.loading=!1})}else this.$message.error("Tên công ty không được để trống")}}},c=(i("PiaH"),i("KHd+")),g=Object(c.a)(m,function(){var e=this,t=e.$createElement,i=e._self._c||t;return i("flexbox",{staticStyle:{height:"100%"},attrs:{direction:"column",align:"stretch"}},[i("div",{staticClass:"header"},[e._v("\n    Thông tin công ty\n  ")]),e._v(" "),i("div",{directives:[{name:"loading",rawName:"v-loading",value:e.loading,expression:"loading"}],staticClass:"body"},[e.systemSaveAuth?i("el-button",{staticClass:"save-button",attrs:{type:"primary"},on:{click:e.save}},[e._v("Lưu")]):e._e(),e._v(" "),i("div",{staticClass:"section"},[i("div",{staticClass:"name"},[e._v("Tên công ty")]),e._v(" "),i("el-input",{model:{value:e.systemName,callback:function(t){e.systemName=t},expression:"systemName"}})],1),e._v(" "),i("div",{staticClass:"section"},[i("div",{staticClass:"name"},[e._v("Logo công ty")]),e._v(" "),""==e.systemImage?i("el-upload",{staticClass:"upload",attrs:{"show-file-list":!1,"http-request":e.fileUpload,drag:"",action:"http",accept:"image/png, image/jpeg, image/gif, image/jpg"}},[i("i",{staticClass:"el-icon-plus uploader-icon"})]):i("div",{staticClass:"upload-show"},[i("img",{attrs:{src:e.systemImage}}),e._v(" "),i("i",{staticClass:"el-icon-remove icon-delete",on:{click:e.deleteSystemImage}})])],1)],1),e._v(" "),i("edit-image",{attrs:{"fixed-number":[15,4],show:e.showEditImage,image:e.editImage,file:e.editFile,title:"Chỉnh sửa logo","preview-width":"150px","preview-height":"40px","preview-radius":"0",width:"550px","save-button-title":"Lưu"},on:{save:e.submiteImage,close:function(t){e.showEditImage=!1}}})],1)},[],!1,null,"6b1c2690",null);g.options.__file="index.vue";t.default=g.exports}}]);