
<template>
  <el-container class="ai-admin-container">
    <el-main class="ai-admin-main" :style="{ overflow: 'visible'}">
      <!-- 操作栏 -->
      <div class="ai-action-bar">
        <el-button
            type="primary"
            icon="el-icon-edit"
            class="ai-create-btn"
            @click="create()"
        >
          发布博客
        </el-button>
      </div>

      <!-- 数据表格 -->
      <div class="ai-table-container">
        <el-table
            :data="tradingData.filter(data => !search || data.content.toLowerCase().includes(search.toLowerCase()))"
            height="100%"
            :default-sort="{prop: 'createTime', order: 'descending'}"
            :header-cell-style='headerCellStyle'
            :cell-style='cellStyle'
            class="ai-data-table"
        >
          <!-- 表格列定义 -->
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="title" label="标题" width="150" />
          <el-table-column label="图片" width="120">
            <template slot-scope="scope">
              <img
                  v-if="scope.row.imagesList && scope.row.imagesList.length > 0"
                  :src="scope.row.imagesList[0]"
                  class="ai-table-image"
              >
              <video
                  v-else-if="scope.row.videosList && scope.row.videosList.length > 0"
                  :src="scope.row.videosList[0]"
                  class="ai-table-image"
              ></video>
              <span v-else>无内容</span>
            </template>
          </el-table-column>
          <el-table-column
              prop="content"
              label="内容"
              :show-overflow-tooltip="true"
              min-width="200"
          />
          <el-table-column
              prop="createTime"
              label="创建时间"
              sortable
              width="180"
          />
          <el-table-column align="right" label="操作" width="220" fixed="right">
            <template slot="header" slot-scope="scope">
              <el-input
                  v-model="search"
                  size="small"
                  placeholder="搜索内容"
                  class="ai-search-input"
              />
            </template>
            <template slot-scope="scope">
              <el-button
                  type="primary"
                  icon="el-icon-edit"
                  size="small"
                  class="ai-action-btn"
                  @click="edit(scope.row)"
              >
                编辑
              </el-button>
              <el-button
                  type="danger"
                  icon="el-icon-delete"
                  size="small"
                  class="ai-action-btn"
                  @click="del(scope.row.id)"
              >
                删除
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>

    <!-- 表单对话框 -->
    <el-dialog
        :visible.sync="dialogFormVisible"
        width="70%"
        title="文章信息"
        @close="cancel"
        class="ai-form-dialog"
    >
      <div class="ai-dialog-header">
        <i class="el-icon-document"></i>
        <span>{{ tradingForm.id ? '编辑文章' : '新建文章' }}</span>
      </div>

      <el-form
          ref="form"
          :model="tradingForm"
          label-width="80px"
          class="ai-blog-form"
      >
        <!-- 图片上传 -->
        <el-row>
          <el-col :span="24">
            <el-form-item label="封面图片" class="ai-form-item">
              <el-upload
                  ref="upload"
                  :file-list="fileList"
                  :action="'http://localhost:8080/file/upload'"
                  list-type="picture-card"
                  :on-preview="handlePictureCardPreview"
                  :on-remove="handleRemove"
                  :on-success="handleSuccess"
                  :before-upload="beforeUpload"
                  :class="{'ai-upload-wrapper': true, 'has-files': fileList.length > 0}"
                  accept="image/*"
              >
                <i class="el-icon-plus ai-upload-icon"></i>
              </el-upload>

              <el-dialog :visible.sync="dialogVisible" class="ai-image-preview-dialog">
                <img :src="dialogImageUrl" alt="" class="ai-preview-image">
              </el-dialog>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 视频上传 -->
        <el-row>
          <el-col :span="24">
            <el-form-item label="视频文件" class="ai-form-item">
              <el-upload
                  ref="videoUpload"
                  :file-list="videoFileList"
                  :action="'http://localhost:8080/file/upload'"
                  :on-preview="handleVideoPreview"
                  :on-remove="handleVideoRemove"
                  :on-success="handleVideoSuccess"
                  :before-upload="beforeVideoUpload"
                  :class="{'ai-upload-wrapper': true, 'has-files': videoFileList.length > 0}"
                  accept="video/*"
                  :show-file-list="true"
                  :limit="3"
              >
                <el-button type="success" icon="el-icon-document" class="ai-upload-btn">
                  点击上传视频
                </el-button>
                <div slot="tip" class="el-upload__tip">
                  支持mp4/avi/mov格式，单个不超过100MB
                </div>
              </el-upload>

              <el-dialog :visible.sync="videoDialogVisible" class="ai-video-preview-dialog">
                <video controls width="100%" :src="videoDialogUrl"></video>
              </el-dialog>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 文件上传 -->
        <el-row>
          <el-col :span="24">
            <el-form-item label="附件文件" class="ai-form-item">
              <el-upload
                  ref="fileUpload"
                  :file-list="docFileList"
                  :action="'http://localhost:8080/file/upload'"
                  :on-preview="handleFilePreview"
                  :on-remove="handleFileRemove"
                  :on-success="handleFileSuccess"
                  :before-upload="beforeFileUpload"
                  :class="{'ai-upload-wrapper': true, 'has-files': docFileList.length > 0}"
                  :limit="5"
                  multiple
              >
                <el-button type="primary" icon="el-icon-document" class="ai-upload-btn">
                  点击上传附件
                </el-button>
                <div slot="tip" class="el-upload__tip">
                  支持pdf/doc/xls/ppt/txt/zip等格式，单个不超过50MB
                </div>
              </el-upload>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 标题和类型 -->
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="标题" class="ai-form-item">
              <el-input
                  v-model="tradingForm.title"
                  placeholder="请输入文章标题"
                  class="ai-form-input"
                  prefix-icon="el-icon-edit"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="类型" class="ai-form-item">
              <el-select
                  v-model="tradingForm.type"
                  placeholder="请选择文章类型"
                  class="ai-form-select"
                  style="width: 100%"
              >
                <el-option
                    v-for="type in typeList"
                    :key="type.name"
                    :label="type.name"
                    :value="type.name"
                />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 内容编辑器 -->
        <el-form-item label="内容" class="ai-form-item">
          <vue-ueditor-wrap
              v-model="tradingForm.content"
              editor-id="editor"
              :config="editorConfig"
              :editorDependencies="['UEditor.config.js','UEditor.all.js']"
              class="ai-ueditor"
          />
        </el-form-item>

        <!-- 操作按钮 -->
        <el-form-item class="ai-form-actions">
          <el-button
              type="primary"
              class="ai-submit-btn"
              @click="submit"
          >
            <i class="el-icon-upload2"></i>
            提交
          </el-button>
          <el-button
              class="ai-cancel-btn"
              @click="cancel()"
          >
            <i class="el-icon-close"></i>
            取消
          </el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </el-container>
</template>
<script>
import VueUeditorWrap from "vue-ueditor-wrap";

export default {
  components: {VueUeditorWrap},
  data() {
    return {
      editorConfig: {
        serverUrl: process.env.VUE_APP_BASE_API + "/config",
        UEDITOR_HOME_URL: '/UEditor/',
        UEDITOR_CORS_URL: '/UEditor/',
        zIndex: 99999,
      },
      fileList: [],
      videoFileList: [],
      docFileList: [],
      dialogFormVisible: false,
      tradingForm: {
        images: '',
        videos: '',
        docs: ''
      },
      dialogImageUrl: '',
      dialogVisible: false,
      videoDialogUrl: '',
      videoDialogVisible: false,
      search: '',
      tradingData: [],
      cellStyle: {
        'text-align': 'center',
        'padding': '8px 0'
      },
      headerCellStyle: {
        'background-color': '#f5f7fa',
        'color': '#409EFF',
        'font-weight': '500',
        'text-align': 'center'
      },
      typeList: [],
      uploadedImageUrls: [],
      uploadedVideoUrls: [],
      uploadedDocUrls: []
    }
  },
  mounted() {
    const elMain = document.querySelector('.el-main');
    if (elMain) {
      elMain.style.overflow = 'visible'; // 设置为 visible 或删除该样式
    }
  },
  methods: {
    // 图片上传相关方法
    beforeUpload(file) {
      const isImage = file.type.includes('image/');
      const isLt5M = file.size / 1024 / 1024 < 5;

      if (!isImage) {
        this.$message.error('只能上传图片文件!');
        return false;
      }
      if (!isLt5M) {
        this.$message.error('图片大小不能超过5MB!');
        return false;
      }
      if (this.uploadedImageUrls.length >= 5) {
        this.$message({
          type: 'error',
          message: '最多只能上传五个文件'
        });
        return false;
      }
      return true;
    },
    handleSuccess(response, file) {
      this.uploadedImageUrls.push(response);
      this.tradingForm.images = this.uploadedImageUrls.join(',');
    },
    handleRemove(file, fileList) {
      let url = file.response || file.url;
      const index = this.uploadedImageUrls.indexOf(url);
      if (index !== -1) {
        this.uploadedImageUrls.splice(index, 1);
        this.tradingForm.images = this.uploadedImageUrls.join(',');
      }
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url || file.response;
      this.dialogVisible = true;
    },

    // 视频上传相关方法
    beforeVideoUpload(file) {
      const isVideo = file.type.includes('video/');
      const isLt100M = file.size / 1024 / 1024 < 100;
      const allowedTypes = ['video/mp4', 'video/avi', 'video/quicktime'];

      if (!isVideo || !allowedTypes.includes(file.type)) {
        this.$message.error('只能上传MP4/AVI/MOV格式视频!');
        return false;
      }
      if (!isLt100M) {
        this.$message.error('视频大小不能超过100MB!');
        return false;
      }
      if (this.uploadedVideoUrls.length >= 3) {
        this.$message.error('最多只能上传三个视频文件');
        return false;
      }
      return true;
    },
    handleVideoSuccess(response, file) {
      this.uploadedVideoUrls.push(response);
      this.tradingForm.videos = this.uploadedVideoUrls.join(',');
    },
    handleVideoRemove(file, fileList) {
      let url = file.response || file.url;
      const index = this.uploadedVideoUrls.indexOf(url);
      if (index !== -1) {
        this.uploadedVideoUrls.splice(index, 1);
        this.tradingForm.videos = this.uploadedVideoUrls.join(',');
      }
    },
    handleVideoPreview(file) {
      this.videoDialogUrl = file.url || file.response;
      this.videoDialogVisible = true;
    },

    // 文件上传相关方法
    beforeFileUpload(file) {
      const allowedTypes = [
        'application/pdf',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'application/vnd.ms-excel',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'application/vnd.ms-powerpoint',
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
        'text/plain',
        'application/zip',
        'application/x-rar-compressed'
      ];

      const isAllowedType = allowedTypes.includes(file.type);
      const isLt50M = file.size / 1024 / 1024 < 50;

      if (!isAllowedType) {
        this.$message.error('不支持的文件格式!');
        return false;
      }
      if (!isLt50M) {
        this.$message.error('文件大小不能超过50MB!');
        return false;
      }
      if (this.uploadedDocUrls.length >= 5) {
        this.$message.error('最多只能上传五个文件');
        return false;
      }
      return true;
    },
    handleFileSuccess(response, file) {
      this.uploadedDocUrls.push(response);
      this.tradingForm.docs = this.uploadedDocUrls.join(',');
    },
    handleFileRemove(file, fileList) {
      let url = file.response || file.url;
      const index = this.uploadedDocUrls.indexOf(url);
      if (index !== -1) {
        this.uploadedDocUrls.splice(index, 1);
        this.tradingForm.docs = this.uploadedDocUrls.join(',');
      }
    },
    handleFilePreview(file) {
      // 对于非图片视频文件，直接下载
      this.downloadFile(file.response || file.url);
    },
    getFileName(url) {
      return url.substring(url.lastIndexOf('/') + 1);
    },
    getFileIcon(url) {
      const ext = url.split('.').pop().toLowerCase();
      const iconMap = {
        pdf: 'el-icon-document',
        doc: 'el-icon-document',
        docx: 'el-icon-document',
        xls: 'el-icon-document',
        xlsx: 'el-icon-document',
        ppt: 'el-icon-document',
        pptx: 'el-icon-document',
        txt: 'el-icon-document',
        zip: 'el-icon-folder-opened',
        rar: 'el-icon-folder-opened'
      };
      return iconMap[ext] || 'el-icon-document';
    },
    downloadFile(url) {
      window.open(url, '_blank');
    },

    // 通用方法
    create() {
      this.dialogFormVisible = true;
      this.tradingForm = {images: '', videos: '', docs: ''};
      this.fileList = [];
      this.videoFileList = [];
      this.docFileList = [];
      this.uploadedImageUrls = [];
      this.uploadedVideoUrls = [];
      this.uploadedDocUrls = [];
    },
    getType() {
      this.$axios.post('http://localhost:8080/type/getType').then(resp => {
        this.typeList = resp.data.data;
      });
    },
    submit() {
      this.tradingForm.userId = this.$store.getters.getUserId;
      this.tradingForm.username = this.$store.getters.getUserName;
      this.tradingForm.imagesList = this.uploadedImageUrls;
      this.tradingForm.videosList = this.uploadedVideoUrls;
      this.tradingForm.docsList = this.uploadedDocUrls;

      const api = this.tradingForm.id
          ? 'http://localhost:8080/trading/update'
          : 'http://localhost:8080/trading/create';

      this.$axios.post(api, this.tradingForm).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: this.tradingForm.id ? '修改成功' : '新增成功'
          });
          this.dialogFormVisible = false;
          this.getRepairData();
        }
      });
    },
    cancel() {
      this.dialogFormVisible = false;
      this.tradingForm = {};
      this.fileList = [];
      this.videoFileList = [];
      this.docFileList = [];
      this.uploadedImageUrls = [];
      this.uploadedVideoUrls = [];
      this.uploadedDocUrls = [];
    },
    getRepairData() {
      this.$axios.post('http://localhost:8080/trading/getTradingByUserId/' + this.$store.getters.getUserId).then(resp => {
        this.tradingData = resp.data.data;
      });
    },
    edit(trading) {
      this.fileList = [];
      this.videoFileList = [];
      this.docFileList = [];
      this.uploadedImageUrls = [];
      this.uploadedVideoUrls = [];
      this.uploadedDocUrls = [];

      // 图片处理
      trading.imagesList.forEach(item => {
        this.fileList.push({name: item, url: item})
      })
      this.uploadedImageUrls = trading.imagesList;

      // 视频处理
      if (trading.videosList) {
        trading.videosList.forEach(item => {
          this.videoFileList.push({name: item, url: item})
        })
        this.uploadedVideoUrls = trading.videosList;
      }

      // 文件处理
      if (trading.docsList) {
        trading.docsList.forEach(item => {
          this.docFileList.push({name: item, url: item})
        })
        this.uploadedDocUrls = trading.docsList;
      }

      this.tradingForm = {...trading};
      this.dialogFormVisible = true;
    },
    del(id) {
      this.$confirm('此操作将永久删除该文章, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        customClass: 'ai-confirm-dialog'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/trading/delete/' + id).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
            this.getRepairData();
          }
        });
      });
    },
    previewImage(url) {
      this.$alert(`<img src="${url}" style="max-width: 100%;">`, '图片预览', {
        dangerouslyUseHTMLString: true,
        customClass: 'ai-image-preview'
      });
    }
  },
  created() {
    this.getRepairData();
    this.getType();
  }
}
</script>
<style scoped>
/* 容器样式 */
.ai-admin-container {
  min-height: 100vh;
  background-color: #f5f7fa;
}

.ai-admin-main {
  padding: 20px;
  height: calc(100vh - 60px);
}

/* 操作栏样式 */
.ai-action-bar {
  margin-bottom: 20px;
  display: flex;
  justify-content: flex-end;
}

.ai-create-btn {
  padding: 10px 20px;
  border-radius: 4px;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.2);
  transition: all 0.3s;
}

.ai-create-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

/* 表格样式 */
.ai-table-container {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 15px;
  height: calc(100% - 160px);
}

.ai-data-table {
  width: 100%;
  border-radius: 8px;
}

.ai-data-table::before {
  display: none;
}

.ai-table-image {
  max-width: 100px;
  max-height: 60px;
  cursor: pointer;
  transition: all 0.3s;
  border-radius: 4px;
}

.ai-table-image:hover {
  transform: scale(1.05);
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* 搜索框样式 */
.ai-search-input >>> .el-input__inner {
  border-radius: 20px;
  border-color: #dcdfe6;
  transition: all 0.3s;
}

.ai-search-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

/* 操作按钮样式 */
.ai-action-btn {
  padding: 7px 12px;
  margin-left: 5px;
}

/* 对话框样式 */
.ai-form-dialog >>> .el-dialog {
  border-radius: 8px;
  box-shadow: 0 5px 20px rgba(64, 158, 255, 0.2);
  border: 1px solid rgba(64, 158, 255, 0.2);
}

.ai-form-dialog >>> .el-dialog__header {
  display: none;
}

.ai-dialog-header {
  display: flex;
  align-items: center;
  padding: 0 0 15px 0;
  margin-bottom: 20px;
  border-bottom: 1px solid #ebeef5;
}

.ai-dialog-header i {
  font-size: 24px;
  color: #409EFF;
  margin-right: 10px;
}

.ai-dialog-header span {
  font-size: 18px;
  font-weight: 500;
  color: #303133;
}

/* 表单样式 */
.ai-blog-form {
  padding: 0 20px;
}

.ai-form-item {
  margin-bottom: 22px;
}

/* 输入框样式 */
.ai-form-input >>> .el-input__inner {
  border-radius: 4px;
  transition: all 0.3s;
}

.ai-form-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

/* 选择框样式 */
.ai-form-select >>> .el-input__inner {
  border-radius: 4px;
  transition: all 0.3s;
}

.ai-form-select >>> .el-input__inner:focus {
  border-color: #409EFF;
}

/* 富文本编辑器样式 */
.ai-ueditor {
  height: 400px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
}

/* 按钮区域样式 */
.ai-form-actions {
  margin-top: 30px;
  text-align: center;
}

.ai-submit-btn {
  padding: 10px 25px;
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.3);
  transition: all 0.3s;
}

.ai-submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.4);
}

.ai-cancel-btn {
  padding: 10px 25px;
  background: white;
  border: 1px solid #dcdfe6;
  transition: all 0.3s;
}

.ai-cancel-btn:hover {
  border-color: #409EFF;
  color: #409EFF;
}

/* 上传组件样式 */
.ai-upload-wrapper {
  width: 100%;
  border: 1px dashed #dcdfe6;
  border-radius: 4px;
  background-color: #f5f7fa;
  transition: all 0.3s;
  padding: 10px;
}

.ai-upload-wrapper:hover {
  border-color: #409EFF;
}

.ai-upload-wrapper >>> .el-upload--picture-card {
  width: 120px;
  height: 120px;
  line-height: 120px;
  background-color: #f5f7fa;
  border: 1px dashed #dcdfe6;
  border-radius: 4px;
  transition: all 0.3s;
}

.ai-upload-wrapper >>> .el-upload--picture-card:hover {
  border-color: #409EFF;
  background-color: rgba(64, 158, 255, 0.05);
}

.ai-upload-icon {
  font-size: 28px;
  color: #909399;
  margin-top: 30px;
  transition: all 0.3s;
}

.ai-upload-wrapper >>> .el-upload--picture-card:hover .ai-upload-icon {
  color: #409EFF;
}

.el-upload__text {
  color: #909399;
  font-size: 14px;
  margin-top: 8px;
}

.ai-upload-wrapper >>> .el-upload-list--picture-card .el-upload-list__item {
  width: 120px;
  height: 120px;
  border-radius: 4px;
  border: 1px solid #dcdfe6;
  transition: all 0.3s;
}

.ai-upload-wrapper >>> .el-upload-list--picture-card .el-upload-list__item:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.2);
}

.el-upload__tip {
  font-size: 12px;
  color: #909399;
  margin-top: 10px;
}

.ai-upload-wrapper.has-files >>> .el-upload--picture-card {
  margin-top: 10px;
}

/* 上传按钮样式 */
.ai-upload-btn {
  padding: 10px 20px;
  border-radius: 4px;
  transition: all 0.3s;
}

.ai-upload-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.3);
}

/* 图片预览对话框 */
.ai-image-preview-dialog {
  border-radius: 8px !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
}

.ai-image-preview-dialog .el-dialog__header {
  border-bottom: 1px solid #ebeef5;
}

.ai-image-preview-dialog .el-dialog__title {
  color: #409EFF;
}

.ai-preview-image {
  max-width: 100%;
  display: block;
  margin: 0 auto;
  border-radius: 4px;
}

/* 视频预览对话框 */
.ai-video-preview-dialog {
  border-radius: 8px !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
}

.ai-video-preview-dialog .el-dialog__header {
  border-bottom: 1px solid #ebeef5;
}

.ai-video-preview-dialog .el-dialog__title {
  color: #409EFF;
}

.ai-video-preview-dialog .el-dialog__body {
  padding: 20px;
}

/* 文件列表样式 */
.ai-file-list {
  margin-top: 10px;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  padding: 10px;
}

.ai-file-item {
  display: flex;
  align-items: center;
  padding: 8px 10px;
  border-bottom: 1px dashed #ebeef5;
  transition: all 0.3s;
}

.ai-file-item:last-child {
  border-bottom: none;
}

.ai-file-item:hover {
  background-color: #f5f7fa;
}

.ai-file-name {
  flex: 1;
  margin-left: 10px;
  color: #606266;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.ai-download-btn {
  font-size: 16px;
  color: #409EFF;
  padding: 0 5px;
}

.ai-download-btn:hover {
  color: #66b1ff;
}
</style>

<style>
/* 全局样式 */
.ai-confirm-dialog {
  border-radius: 8px !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
}

.ai-confirm-dialog .el-message-box__header {
  border-bottom: 1px solid #ebeef5;
}

.ai-confirm-dialog .el-message-box__title {
  color: #409EFF;
}

.ai-confirm-dialog .el-message-box__content {
  padding: 20px 20px;
}

.ai-image-preview {
  width: auto;
  max-width: 80%;
  border-radius: 8px !important;
}

.ai-image-preview .el-message-box__content {
  padding: 20px;
  text-align: center;
}

.el-select-dropdown {
  border-radius: 4px !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
  box-shadow: 0 2px 12px 0 rgba(64, 158, 255, 0.1) !important;
}

.el-select-dropdown__item {
  transition: all 0.2s;
}

.el-select-dropdown__item.hover,
.el-select-dropdown__item:hover {
  background-color: rgba(64, 158, 255, 0.1) !important;
  color: #409EFF !important;
}

.el-select-dropdown__item.selected {
  color: #409EFF !important;
  font-weight: 500;
}
</style>