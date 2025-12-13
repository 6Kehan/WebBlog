<template>
  <el-container class="ai-login-container">
    <div class="ai-background">
      <div class="ai-particle-effect"></div>
      <div class="ai-grid-overlay"></div>
    </div>

    <el-main class="ai-login-main">
      <div class="ai-login-card">
        <div class="ai-login-header">
          <h1 class="ai-title">博客交流平台</h1>
          <div class="ai-icon">
            <i class="el-icon-connection"></i>
          </div>
        </div>

        <el-form ref="loginForm" :model="userLogin" class="ai-login-form">
          <el-form-item prop="userName">
            <el-input
                type="text"
                placeholder="用户名/邮箱"
                v-model="userLogin.userName"
                prefix-icon="el-icon-user"
                class="ai-input"
            >
              <template slot="prepend">
                <i class="el-icon-user"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item prop="userPwd">
            <el-input
                type="password"
                placeholder="密码"
                v-model="userLogin.userPwd"
                prefix-icon="el-icon-lock"
                show-password
                class="ai-input"
            >
              <template slot="prepend">
                <i class="el-icon-key"></i>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-button
                type="primary"
                class="ai-login-btn login-btn"
                @click="onSubmit('loginForm')"
            >
              <i class="el-icon-user-solid"></i>
              登录系统
              <i class="el-icon-arrow-right"></i>
            </el-button>
          </el-form-item>
          <el-form-item>
            <el-button
                type="success"
                class="ai-login-btn register-btn"
                @click="register"
            >
              <i class="el-icon-circle-plus"></i>
              立即注册
              <i class="el-icon-arrow-right"></i>
            </el-button>
          </el-form-item>

<!--          <div class="ai-footer">-->
<!--            <span class="ai-text">新用户?</span>-->
<!--            <a href="/register" class="ai-link">立即注册</a>-->
<!--          </div>-->
        </el-form>
      </div>
    </el-main>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      userLogin: {userName: "", userPwd: "", role: "普通用户"},
    }
  },
  methods: {
    register() {
      this.$router.push({path: '/register'})
    },
    onSubmit(loginForm) {
      this.$refs[loginForm].validate((valid) => {
        if (valid) {
          this.$axios.post('http://localhost:8080/user/login', this.userLogin).then(resp => {
            if (resp.data.code === 200) {
              this.$store.commit('SET_USERINFO', resp.data.data)
              let userRole = this.$store.getters.getUser.role
              if(userRole === "普通用户"){
                this.$router.push({path: '/userInterface/tradingIndex'})
              }
            } else {
              this.$message({
                type: 'warning',
                message: resp.data.msg
              })
            }
          })
        } else {
          return false;
        }
      });
    }
  }
}
</script>

<style scoped>
/* 登录按钮样式 */
.login-btn {
  background: linear-gradient(45deg, #409EFF, #3375b9);
  border: none;
  box-shadow: 0 2px 6px rgba(64, 158, 255, 0.5);
}

.login-btn:hover {
  background: linear-gradient(45deg, #3375b9, #409EFF);
}

/* 注册按钮样式 */
.register-btn {
  background: linear-gradient(45deg, #67C23A, #5aad32) !important;
  border: none;
  box-shadow: 0 2px 6px rgba(103, 194, 58, 0.5);
}

.register-btn:hover {
  background: linear-gradient(45deg, #5aad32, #67C23A);
}

/* 通用按钮样式 */
.ai-login-btn {
  color: white;
  font-weight: bold;
  padding: 12px 24px;
  border-radius: 20px;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.ai-login-btn i:first-child {
  margin-right: 8px;
  font-size: 16px;
}

.ai-login-btn i:last-child {
  margin-left: 8px;
  font-size: 14px;
}
.ai-login-container {
  height: 100vh;
  position: relative;
  overflow: hidden;
  background-color: #f5f7fa;
}

.ai-background {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #e0f2ff, #f0f9ff, #ffffff);
  z-index: 0;
}

.ai-particle-effect {
  position: absolute;
  width: 100%;
  height: 100%;
  background: radial-gradient(circle, rgba(64, 158, 255, 0.1) 0%, transparent 70%);
  animation: pulse 8s infinite alternate;
}

.ai-grid-overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background-image: linear-gradient(rgba(64, 158, 255, 0.05) 1px, transparent 1px),
  linear-gradient(90deg, rgba(64, 158, 255, 0.05) 1px, transparent 1px);
  background-size: 40px 40px;
}

.ai-login-main {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  z-index: 1;
}

.ai-login-card {
  width: 400px;
  padding: 40px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(64, 158, 255, 0.15);
  backdrop-filter: blur(5px);
  border: 1px solid rgba(64, 158, 255, 0.2);
  position: relative;
  overflow: hidden;
}

.ai-login-card::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(
      to bottom right,
      transparent 45%,
      rgba(64, 158, 255, 0.08) 50%,
      transparent 55%
  );
  animation: shine 6s infinite;
}

.ai-login-header {
  text-align: center;
  margin-bottom: 30px;
}

.ai-title {
  color: #303133;
  font-size: 26px;
  font-weight: 600;
  margin-bottom: 15px;
  letter-spacing: 1px;
}

.ai-icon {
  font-size: 40px;
  color: #409EFF;
  margin-bottom: 20px;
  animation: float 3s ease-in-out infinite;
}

.ai-login-form {
  margin-top: 20px;
}

.ai-input {
  margin-bottom: 20px;
}

.ai-input >>> .el-input__inner {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #dcdfe6;
  color: #606266;
  height: 48px;
  border-radius: 8px;
  transition: all 0.3s;
}

.ai-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-input >>> .el-input__inner::placeholder {
  color: #c0c4cc;
}

.ai-input >>> .el-input-group__prepend {
  background: #f5f7fa;
  border: 1px solid #dcdfe6;
  border-right: none;
  color: #909399;
}

.ai-login-btn {
  width: 100%;
  height: 48px;
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  border-radius: 8px;
  font-weight: 500;
  font-size: 16px;
  letter-spacing: 1px;
  transition: all 0.3s;
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}

.ai-login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(64, 158, 255, 0.4);
  background: linear-gradient(90deg, #66b1ff, #409EFF);
}

.ai-footer {
  margin-top: 20px;
  text-align: center;
  font-size: 14px;
}

.ai-text {
  color: #909399;
}

.ai-link {
  color: #409EFF;
  margin-left: 5px;
  text-decoration: none;
  transition: all 0.3s;
  font-weight: 500;
}

.ai-link:hover {
  color: #66b1ff;
}

@keyframes pulse {
  0% {
    opacity: 0.3;
  }
  100% {
    opacity: 0.6;
  }
}

@keyframes shine {
  0% {
    transform: rotate(0deg) translate(-10%, -10%);
  }
  100% {
    transform: rotate(360deg) translate(-10%, -10%);
  }
}

@keyframes float {
  0% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-8px);
  }
  100% {
    transform: translateY(0px);
  }
}
</style>