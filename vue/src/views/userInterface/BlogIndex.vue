<template>
  <el-container class="ai-blog-container">
    <div class="ai-content-wrapper">
      <div class="ai-blog-main">
        <Trading ref="child" class="ai-trading-component"></Trading>
      </div>
    </div>

    <el-dialog
        :visible.sync="dialogFormVisible"
        width="70%"
        title="发布新博客"
        class="ai-dialog"
    >
      <div class="ai-dialog-header">
        <h2>发布新内容</h2>
        <i class="el-icon-edit-outline"></i>
      </div>

      <el-form ref="form" :model="tradingForm" label-width="100px" class="ai-blog-form">
        <!-- 第一行：标题和类型 -->
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="文章标题" class="ai-form-item">
              <el-input
                  v-model="tradingForm.title"
                  placeholder="请输入文章标题"
                  class="ai-input"
                  prefix-icon="el-icon-edit"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="文章类型" class="ai-form-item">
              <el-select
                  v-model="tradingForm.type"
                  placeholder="选择分类"
                  class="ai-select"
                  popper-class="ai-select-dropdown"
              >
                <el-option
                    v-for="type in typeList"
                    :label="type.name"
                    :value="type.name"
                    class="ai-option"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <!-- 其他表单项保持不变 -->
        <el-form-item label="封面图片" class="ai-form-item">
          <el-upload
              action="#"
              :on-change="handleChange"
              :on-remove="handleRemove"
              :file-list="fileList"
              list-type="picture-card"
              class="ai-upload"
          >
            <i class="el-icon-plus"></i>
          </el-upload>
        </el-form-item>

        <el-form-item label="文章内容" class="ai-form-item">
          <vue-ueditor-wrap
              v-model="tradingForm.content"
              editor-id="editor"
              :config="editorConfig"
              :editorDependencies="['UEditor.config.js','UEditor.all.js']"
              class="ai-editor"
          />
        </el-form-item>

        <el-form-item size="large" class="ai-form-actions">
          <el-button
              type="primary"
              class="ai-submit-btn"
              @click="submit"
          >
            <i class="el-icon-upload2"></i>
            发布文章
          </el-button>
          <el-button
              class="ai-cancel-btn"
              @click="dialogFormVisible=false"
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
import Trading from "@/views/userInterface/componet/Blog.vue";
import Avatar from 'vue-avatar'
import VueUeditorWrap from 'vue-ueditor-wrap';

export default {
  name: "HomePage",
  components: {Trading,Avatar,VueUeditorWrap},
  data() {
    return {
      key:'',
      editorConfig: {
        serverUrl: process.env.VUE_APP_BASE_API + "/config",
        UEDITOR_HOME_URL: '/UEditor/',
        UEDITOR_CORS_URL: '/UEditor/',
        zIndex: 99999,
      },
      fileList: [],
      dialogFormVisible:false,
      tradingForm: {
        images:''
      },
      realname: this.$store.getters.getUser.realname,
      avator: this.$store.getters.getUser.avator,
      currentUser: this.$store.getters.getUser,
      problemData: {
        userId: this.$store.getters.getUserId,
        title: "",
        content: "",
      },
      typeList:[]
    }
  },
  created() {
    this.getType()
  },
  methods: {
    selectByType() {
      this.$axios.post('http://localhost:8080/trading/selectBlog?key=' + this.key).then(resp => {
        this.tradingData = resp.data.data;
        this.tradingTotal = this.tradingData.length;
      });
    },
    getType() {
      this.$axios.post('http://localhost:8080/type/getType').then(resp => {
        this.typeList = resp.data.data
      })
    },
    create() {
      this.dialogFormVisible=true;
      this.fileList=[];
      this.tradingForm={images:''};
    },
    submit(){
      for (let fileListElement of this.fileList) {
        this.tradingForm.images+=fileListElement.response+"=="
      }

      this.tradingForm.userId=this.$store.getters.getUserId;
      this.tradingForm.username=this.$store.getters.getUserName;

      this.$axios.post('http://localhost:8080/trading/create', this.tradingForm).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: resp.data.msg
          });
          this.dialogFormVisible = false
          this.$refs.child.$emit("getProblems")
        }
      })
    },
    handleChange(file, fileList) {
      console.log(file)
      this.fileList = fileList.slice(-3);
    },
    handleRemove(file, fileList) {
      const filteredList = fileList.filter(fileItem => fileItem.response !== file.response);
      this.fileList = filteredList;
    }
  }
}
</script>

<style scoped>
.ai-blog-container {
  background: linear-gradient(135deg, #e6f2ff, #f0f7ff, #e6f2ff);
  min-height: 100vh;
  color: #303133;
  position: relative;
  overflow: hidden;
}

.ai-blog-container::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;

  z-index: 0;
}

.ai-content-wrapper {
  width: 100%;
  padding: 20px;
  position: relative;
  z-index: 1;
}



.ai-dialog {
  border-radius: 12px;
  overflow: hidden;
}

.ai-dialog >>> .el-dialog {
  background: rgba(255, 255, 255, 0.98);
  border: 1px solid rgba(64, 158, 255, 0.2);
  box-shadow: 0 10px 30px rgba(64, 158, 255, 0.2);
  color: #606266;
}

.ai-dialog >>> .el-dialog__header {
  border-bottom: 1px solid rgba(64, 158, 255, 0.1);
  padding: 15px 20px;
}

.ai-dialog >>> .el-dialog__title {
  color: #409EFF;
  font-size: 18px;
}

.ai-dialog-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px 15px;
  border-bottom: 1px solid rgba(64, 158, 255, 0.1);
  margin-bottom: 20px;
}

.ai-dialog-header h2 {
  color: #409EFF;
  margin: 0;
  font-size: 20px;
  font-weight: 500;
}

.ai-dialog-header i {
  font-size: 24px;
  color: #409EFF;
}

.ai-blog-form {
  padding: 0 20px;
}

.ai-form-item >>> .el-form-item__label {
  color: #606266;
  font-size: 14px;
  font-weight: 500;
}

.ai-input >>> .el-input__inner {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #dcdfe6;
  color: #606266;
  border-radius: 8px;
  height: 40px;
  transition: all 0.3s;
}

.ai-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-input >>> .el-input__inner::placeholder {
  color: #c0c4cc;
}

.ai-input >>> .el-input__prefix {
  color: #409EFF;
}

.ai-select >>> .el-input__inner {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #dcdfe6;
  color: #606266;
  transition: all 0.3s;
}

.ai-select >>> .el-input__inner:focus {
  border-color: #409EFF;
}

.ai-upload >>> .el-upload {
  background: rgba(255, 255, 255, 0.9);
  border: 1px dashed #dcdfe6;
  color: #409EFF;
  transition: all 0.3s;
}

.ai-upload >>> .el-upload:hover {
  border-color: #409EFF;
}

.ai-editor {
  height: 400px;
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  overflow: hidden;
  transition: all 0.3s;
}

.ai-editor:hover {
  border-color: #409EFF;
}

.ai-form-actions {
  margin-top: 30px;
  text-align: center;
}

.ai-submit-btn {
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  padding: 12px 30px;
  font-weight: 500;
  letter-spacing: 1px;
  transition: all 0.3s;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
  border-radius: 8px;
}

.ai-submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
  background: linear-gradient(90deg, #66b1ff, #409EFF);
}

.ai-cancel-btn {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #dcdfe6;
  color: #606266;
  padding: 12px 30px;
  transition: all 0.3s;
  border-radius: 8px;
}

.ai-cancel-btn:hover {
  background: #f5f7fa;
  color: #409EFF;
  border-color: #409EFF;
}

.ai-trading-component {
  background: transparent;
}

/* 隐藏滚动条 */
div::-webkit-scrollbar {
  display: none;
}
</style>

<style>
.ai-select-dropdown {
  background: rgba(255, 255, 255, 0.98) !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.15) !important;
  border-radius: 8px !important;
}

.ai-select-dropdown .el-select-dropdown__item {
  color: #606266 !important;
}

.ai-select-dropdown .el-select-dropdown__item.hover,
.ai-select-dropdown .el-select-dropdown__item:hover {
  background: rgba(64, 158, 255, 0.1) !important;
  color: #409EFF !important;
}

.ai-select-dropdown .el-select-dropdown__item.selected {
  color: #409EFF !important;
  background: rgba(64, 158, 255, 0.1) !important;
  font-weight: 500 !important;
}

.ai-select-dropdown .popper__arrow {
  border-bottom-color: rgba(64, 158, 255, 0.2) !important;
}
</style>