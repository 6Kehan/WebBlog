<template>
  <el-container class="ai-admin-container">
    <div class="ai-login-container">
      <div class="ai-login-card">
        <h1 class="ai-login-title">管理员登录</h1>
        <el-form ref="loginForm" :model="userLogin" class="ai-login-form">
          <el-form-item label="用户名或邮箱" prop="userName" class="ai-form-item">
            <el-input
                v-model="userLogin.userName"
                placeholder="请输入账号"
                class="ai-input"
                clearable
            />
          </el-form-item>

          <el-form-item label="密码" prop="userPwd" class="ai-form-item">
            <el-input
                v-model="userLogin.userPwd"
                type="password"
                placeholder="请输入密码"
                show-password
                class="ai-input"
                clearable
            />
          </el-form-item>

          <el-form-item class="ai-form-action">
            <el-button
                type="primary"
                class="ai-login-btn"
                @click="onSubmit('loginForm')"
            >
              登录
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </el-container>
</template>

<script>
// 保持script部分不变
export default {
  name: "AdminLogin",
  data() {
    return {
      userLogin: {userName: "", userPwd: "", role: "管理员"},
    }
  },
  methods: {
    onSubmit(loginForm) {
      this.$refs[loginForm].validate((valid) => {
        if (valid) {
          this.$axios.post('http://localhost:8080/user/login', this.userLogin).then(resp => {
            if (resp.data.code === 200) {
              this.$store.commit('SET_USERINFO', resp.data.data)
              this.$message({
                type: 'success',
                message: resp.data.msg,
                customClass: 'ai-message'
              })
              this.$router.push('/dashboard/admin')
            } else {
              this.$message({
                type: 'warning',
                message: resp.data.msg,
                customClass: 'ai-message'
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
.ai-admin-container {
  background: #f5f7fa;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.ai-login-container {
  width: 100%;
  max-width: 480px;
  padding: 20px;
}

.ai-login-card {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 40px 30px;
}

.ai-login-title {
  color: #409EFF;
  margin-bottom: 30px;
  font-size: 24px;
}

.ai-login-form {
  margin-top: 20px;
}

.ai-form-item {
  margin-bottom: 25px;
}

.ai-form-item >>> .el-form-item__label {
  color: #606266;
  font-weight: 500;
}

.ai-input >>> .el-input__inner {
  border-radius: 20px;
  padding: 12px 15px;
  transition: all 0.3s;
}

.ai-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-login-btn {
  width: 100%;
  padding: 12px 20px;
  border-radius: 20px;
  font-size: 16px;
  margin-top: 15px;
  transition: all 0.3s;
}

.ai-login-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}
</style>

<style>
.ai-message {
  border-radius: 8px !important;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1) !important;
}

.ai-message .el-message__content {
  color: #409EFF;
}
</style>