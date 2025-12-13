<template>
  <el-container class="ai-profile-container">
    <div class="ai-profile-content">
      <div class="ai-avatar-section">
        <el-upload
            class="avatar-uploader"
            :action="'http://localhost:8080/file/upload'"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
        >
          <div v-if="myData.avator" class="avatar-wrapper">
            <img :src="myData.avator" class="avatar">
            <div class="avatar-hover">
              <i class="el-icon-upload"></i>
              <span>更换头像</span>
            </div>
          </div>
          <div v-else class="avatar-uploader-default">
            <i class="el-icon-plus"></i>
            <span>上传头像</span>
          </div>
        </el-upload>
      </div>

      <div class="ai-form-section">
        <el-form class="ai-profile-form">
          <div class="ai-form-row">
            <el-form-item class="ai-form-item">
              <el-input
                  v-model="myData.userName"
                  :disabled="isDisabled"
                  size="small"
                  class="ai-profile-input"
              >
                <template slot="prepend">
                  <i class="el-icon-user"></i>
                  <span>用户名</span>
                </template>
              </el-input>
            </el-form-item>

            <el-form-item class="ai-form-item">
              <el-input
                  v-model="myData.realname"
                  :disabled="isDisabled"
                  size="small"
                  class="ai-profile-input"
              >
                <template slot="prepend">
                  <i class="el-icon-s-custom"></i>
                  <span>昵称</span>
                </template>
              </el-input>
            </el-form-item>
          </div>

          <el-form-item class="ai-form-item">
            <el-input
                v-model="myData.email"
                :disabled="isDisabled"
                size="small"
                class="ai-profile-input"
            >
              <template slot="prepend">
                <i class="el-icon-message"></i>
                <span>邮箱</span>
              </template>
            </el-input>
          </el-form-item>

          <div class="ai-form-row">
            <el-form-item class="ai-form-item">
              <el-input
                  v-model="myData.userPwd"
                  :disabled="isDisabled"
                  size="small"
                  type="password"
                  class="ai-profile-input"
              >
                <template slot="prepend">
                  <i class="el-icon-lock"></i>
                  <span>密码</span>
                </template>
              </el-input>
            </el-form-item>

            <el-form-item class="ai-form-item">
              <el-input
                  v-model="myData.tel"
                  :disabled="isDisabled"
                  size="small"
                  class="ai-profile-input"
              >
                <template slot="prepend">
                  <i class="el-icon-phone"></i>
                  <span>联系方式</span>
                </template>
              </el-input>
            </el-form-item>
          </div>

          <el-form-item class="ai-form-item">
            <el-input
                v-model="myData.address"
                :disabled="isDisabled"
                size="small"
                class="ai-profile-input"
            >
              <template slot="prepend">
                <i class="el-icon-location-information"></i>
                <span>联系地址</span>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item class="ai-form-item">
            <el-input
                v-model="myData.createTime"
                disabled
                size="small"
                class="ai-profile-input"
            >
              <template slot="prepend">
                <i class="el-icon-time"></i>
                <span>注册时间</span>
              </template>
            </el-input>
          </el-form-item>

          <div class="ai-form-actions" v-show="isUpdateOn">
            <el-button
                type="primary"
                class="ai-confirm-btn"
                size="small"
                @click="updateMyInfo"
            >
              <i class="el-icon-check"></i>
              确认修改
            </el-button>
            <el-button
                class="ai-cancel-btn"
                size="small"
                @click="upDateOn"
            >
              <i class="el-icon-close"></i>
              取消修改
            </el-button>
          </div>
        </el-form>
      </div>

      <div class="ai-sidebar-actions">
        <el-button
            type="primary"
            class="ai-edit-btn"
            size="small"
            @click="upDateOn"
        >
          <i class="el-icon-edit"></i>
          修改信息
        </el-button>
        <el-button
            type="danger"
            class="ai-logout-btn"
            size="small"
            @click="logout"
        >
          <i class="el-icon-switch-button"></i>
          退出登录
        </el-button>
      </div>
    </div>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      isDisabled: true,
      isUpdateOn: false,
      myData: {},
    };
  },
  created() {
    this.getMyInfo();
  },
  methods: {
    handleAvatarSuccess(res) {
      this.myData.avator = res;
      this.updateMyInfo();
      this.getMyInfo();
      this.isDisabled = !this.isDisabled;
      this.isUpdateOn = !this.isUpdateOn;
    },
    logout() {
      this.$router.push({path: '/'});
    },
    getMyInfo() {
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + this.$store.getters.getUserId).then(resp => {
        this.myData = resp.data.data;
        this.$store.commit('SET_USERINFO', resp.data.data)
      });
    },
    updateMyInfo() {
      this.$axios.put('http://localhost:8080/user/userInfoSet', this.myData).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.$router.go(0);

        }
        this.upDateOn();
      });
    },
    upDateOn() {
      this.isDisabled = !this.isDisabled;
      this.isUpdateOn = !this.isUpdateOn;
    },
  }
};
</script>

<style scoped>
.ai-profile-container {
  width: 100%;
  min-height: calc(100vh - 60px);
  background: linear-gradient(135deg, #f5f9ff, #ffffff);
  padding: 30px 0;
  display: flex;
  justify-content: center;
}

.ai-profile-content {
  width: 90%;
  max-width: 1200px;
  display: flex;
  flex-wrap: wrap;
  position: relative;
}

.ai-avatar-section {
  width: 100%;
  text-align: center;
  margin-bottom: 30px;
}

/* 头像上传样式 */
.avatar-uploader {
  width: 150px;
  height: 150px;
  margin: 0 auto;
  border-radius: 50%;
  position: relative;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.avatar-uploader:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 16px rgba(64, 158, 255, 0.2);
}

.avatar-wrapper {
  width: 100%;
  height: 100%;
  position: relative;
}

.avatar {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 50%;
  display: block;
}

.avatar-hover {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(64, 158, 255, 0.7);
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s;
  border-radius: 50%;
}

.avatar-wrapper:hover .avatar-hover {
  opacity: 1;
}

.avatar-uploader-default {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
  color: #909399;
  border: 1px dashed #dcdfe6;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.3s;
}

.avatar-uploader-default:hover {
  border-color: #409EFF;
  color: #409EFF;
  background: rgba(64, 158, 255, 0.05);
}

.avatar-uploader-default i {
  font-size: 28px;
  margin-bottom: 8px;
}

.ai-form-section {
  width: 70%;
  padding: 0 20px;
}

.ai-profile-form {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  padding: 30px;
  box-shadow: 0 4px 20px rgba(64, 158, 255, 0.1);
  border: 1px solid rgba(64, 158, 255, 0.1);
}

.ai-form-row {
  display: flex;
  justify-content: space-between;
  gap: 20px;
}

.ai-form-item {
  flex: 1;
  margin-bottom: 20px;
}

.ai-profile-input >>> .el-input-group__prepend {
  background: rgba(64, 158, 255, 0.1);
  border-color: rgba(64, 158, 255, 0.2);
  color: #409EFF;
  padding: 0 15px;
}

.ai-profile-input >>> .el-input-group__prepend i {
  margin-right: 8px;
}

.ai-profile-input >>> .el-input__inner {
  border-radius: 6px;
  border: 1px solid #dcdfe6;
  transition: all 0.3s;
}

.ai-profile-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-profile-input >>> .el-input__inner:disabled {
  background-color: #f5f7fa;
}

.ai-form-actions {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 30px;
}

.ai-confirm-btn {
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  border-radius: 6px;
  padding: 10px 25px;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.3);
  transition: all 0.3s;
}

.ai-confirm-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.4);
}

.ai-cancel-btn {
  background: white;
  border: 1px solid #dcdfe6;
  border-radius: 6px;
  padding: 10px 25px;
  color: #606266;
  transition: all 0.3s;
}

.ai-cancel-btn:hover {
  border-color: #409EFF;
  color: #409EFF;
}

.ai-sidebar-actions {
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  gap: 15px;
  width: 15%;
}

.ai-edit-btn, .ai-logout-btn {
  width: 100%;
  padding: 10px;
  border-radius: 6px;
  transition: all 0.3s;
}

.ai-edit-btn {
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.2);
}

.ai-edit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

.ai-logout-btn {
  background: linear-gradient(90deg, #f56c6c, #f78989);
  border: none;
  box-shadow: 0 2px 10px rgba(245, 108, 108, 0.2);
}

.ai-logout-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(245, 108, 108, 0.3);
}

@media (max-width: 992px) {
  .ai-form-section {
    width: 100%;
  }

  .ai-sidebar-actions {
    position: static;
    transform: none;
    width: 100%;
    flex-direction: row;
    margin-top: 30px;
    justify-content: center;
  }

  .ai-edit-btn, .ai-logout-btn {
    width: auto;
    padding: 10px 25px;
  }
}
</style>