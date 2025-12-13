<template>
  <el-container class="ai-register-container">
    <el-main class="ai-register-main">
      <div class="ai-register-bg">
        <div class="ai-particle-effect"></div>
        <div class="ai-register-card">
          <div class="ai-register-header">
            <i class="el-icon-user-solid ai-register-icon"></i>
            <h1 class="ai-register-title">欢迎注册智能平台</h1>
          </div>

          <div class="ai-register-form">
            <el-form ref="registerForm" :model="register" class="ai-form">
              <el-form-item prop="userName" class="ai-form-item">
                <el-input
                    type="text"
                    placeholder="请输入用户名"
                    v-model="register.userName"
                    clearable
                    prefix-icon="el-icon-user"
                    class="ai-input"
                />
              </el-form-item>

              <el-form-item prop="email" class="ai-form-item">
                <el-input
                    placeholder="请输入邮箱"
                    v-model="register.email"
                    clearable
                    prefix-icon="el-icon-message"
                    class="ai-input"
                />
              </el-form-item>

              <el-form-item prop="userPwd" class="ai-form-item">
                <el-input
                    type="password"
                    placeholder="请输入密码"
                    v-model="register.userPwd"
                    show-password
                    clearable
                    prefix-icon="el-icon-lock"
                    class="ai-input"
                />
              </el-form-item>

              <el-form-item prop="checkPass" class="ai-form-item">
                <el-input
                    type="password"
                    placeholder="请再次输入密码"
                    v-model="register.checkPass"
                    autocomplete="off"
                    show-password
                    clearable
                    prefix-icon="el-icon-key"
                    class="ai-input"
                />
              </el-form-item>

              <el-form-item class="ai-form-item">
                <el-button
                    :loading="loading"
                    type="primary"
                    class="ai-register-btn"
                    @click="onSubmit('registerForm')"
                >
                  <i class="el-icon-upload2"></i>
                  创建账户
                </el-button>
              </el-form-item>

              <el-form-item class="ai-form-item">
                <el-button
                    :loading="loading"
                    class="ai-login-btn"
                    @click="returnLogin"
                >
                  <i class="el-icon-right"></i>
                  已有账号？去登录
                </el-button>
              </el-form-item>
            </el-form>
          </div>
        </div>
      </div>
    </el-main>
  </el-container>
</template>

<script>
export default {
  name: "Register",
  data() {
    const validatePass = (rule, value, callback) => {
      if (value === '') {
        callback(new Error('请再次输入密码'));
      } else if (value !== this.register.userPwd) {
        callback(new Error('两次输入密码不一致!'));
      } else {
        callback();
      }
    };
    return {
      register: {userName: null, userPwd: null, checkPass: '', email: ''},
    }
  },
  methods: {
    onSubmit(registerForm) {
      this.$refs[registerForm].validate((valid) => {
        if (valid) {
          this.$axios.post('http://localhost:8080/user/register',this.register).then(resp => {
            if (resp.data.code == 200) {
              this.$message({
                type: 'success',
                message: resp.data.msg
              })
            } else {
              this.$message({
                type: 'warning',
                message: resp.data.msg
              })
              return false;
            }
          })
        } else {
          return false;
        }
      });
    },
    returnLogin() {
      this.$router.push({path: '/login'})
    },
  }
}
</script>

<style scoped>
/* 修复居中问题的完整方案 */
.ai-register-container {
  height: 100vh;
  display: flex; /* 关键：启用flex布局 */
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
  position: relative;
  overflow: hidden;
  background-color: #f5f7fa;

}

.ai-register-main {
  width: 100%; /* 占满整个宽度 */
  height: 100%; /* 占满整个高度 */
  display: flex; /* 关键：启用flex布局 */
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
  padding: 20px; /* 添加内边距防止在小屏幕上贴边 */
  box-sizing: border-box; /* 确保padding不影响总宽度 */
}

.ai-register-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, #e0f2ff, #f0f9ff, #ffffff);
  z-index: 0;
}

/* 卡片样式 - 确保这是唯一的定位元素 */
.ai-register-card {
  width: 400px; /* 固定宽度 */
  max-width: 90%; /* 响应式：在小屏幕上不超过90%宽度 */
  padding: 40px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(64, 158, 255, 0.15);
  backdrop-filter: blur(5px);
  border: 1px solid rgba(64, 158, 255, 0.2);
  position: relative; /* 相对定位 */
  z-index: 1; /* 确保在背景之上 */
  margin: auto; /* 额外的居中保障 */
  margin-top: 5%;
}
.ai-register-card::before {
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

.ai-register-header {
  text-align: center;
  margin-bottom: 30px;
}

.ai-register-icon {
  font-size: 40px;
  color: #409EFF;
  margin-bottom: 15px;
  animation: float 3s ease-in-out infinite;
}

.ai-register-title {
  color: #303133;
  font-size: 26px;
  font-weight: 600;
  margin: 0;
  letter-spacing: 1px;
}

.ai-register-form {
  margin-top: 20px;
}

.ai-form-item {
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

.ai-register-btn {
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

.ai-register-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(64, 158, 255, 0.4);
  background: linear-gradient(90deg, #66b1ff, #409EFF);
}

.ai-login-btn {
  width: 100%;
  height: 48px;
  background: transparent;
  border: 1px solid #dcdfe6;
  color: #909399;
  border-radius: 8px;
  transition: all 0.3s;
  font-size: 16px;
}

.ai-login-btn:hover {
  background: rgba(64, 158, 255, 0.05);
  color: #409EFF;
  border-color: #409EFF;
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