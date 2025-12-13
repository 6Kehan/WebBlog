<template>
  <el-container class="ai-layout-container">
    <!-- 头部导航栏 -->
    <el-header class="ai-header">
      <div class="ai-logo" @click="toTrading">
        <i class="el-icon-connection"></i>
        <span>博客交流平台</span>
      </div>

      <div class="ai-user-info">
        <el-tooltip
            content="点击管理个人信息"
            placement="bottom"
            effect="light"
            popper-class="ai-tooltip"
        >
          <div class="ai-avatar-wrapper" @click="toPersonal">
            <Avatar
                :username="realname"
                :src="avator || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'"
                background-color="rgba(64, 158, 255, 0.1)"
                color="#409EFF"
                :size="40"
                :inline="true"
                class="ai-avatar"
            />
            <span class="ai-username">{{ realname }}</span>
          </div>
        </el-tooltip>
      </div>
    </el-header>

    <!-- 主要内容区 -->
    <el-container class="ai-main-container">
      <router-view class="ai-router-view"></router-view>
    </el-container>

    <!-- 页脚 -->
    <el-footer class="ai-footer">
      <div class="ai-footer-content">
        <div class="ai-footer-links">
          <a href="#" class="ai-link">关于我们</a>
          <a href="#" class="ai-link">帮助中心</a>
          <a href="#" class="ai-link">服务条款</a>
          <a href="#" class="ai-link">隐私政策</a>
        </div>
        <p class="ai-copyright">
          <i class="el-icon-cpu"></i> CopyRight KehanLiu© 2025 - 用科技连接生活
        </p>
      </div>
    </el-footer>
  </el-container>
</template>

<script>
import Avatar from 'vue-avatar'

export default {
  components: {Avatar},
  data() {
    return {
      key: '',
      realname: this.$store.getters.getUser.realname,
      avator: this.$store.getters.getUser.avator,
      dialogFormVisible: false,
      feedbackForm: {
        userId: this.$store.getters.getUserId,
        type: '',
        content: '',
      },
    };
  },
  methods: {
    toTrading() {
      this.$router.push({path: '/userInterface/tradingIndex'})
    },
    toPersonal() {
      this.$router.push({path: '/personal/personalInfo'})
    },
  }
};
</script>

<style scoped>
.ai-layout-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #e6f2ff, #f0f7ff, #e6f2ff);
  color: #303133;
  position: relative;
  overflow-x: hidden;
}

.ai-layout-container::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: radial-gradient(circle at 20% 30%, rgba(64, 158, 255, 0.05) 0%, transparent 50%),
  radial-gradient(circle at 80% 70%, rgba(64, 158, 255, 0.05) 0%, transparent 50%);
  z-index: 0;
}

.ai-header {
  height: 70px !important;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(5px);
  border-bottom: 1px solid rgba(64, 158, 255, 0.2);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 5%;
  position: relative;
  z-index: 1;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.1);
}

.ai-logo {
  display: flex;
  align-items: center;
  font-size: 20px;
  color: #409EFF;
  cursor: pointer;
  transition: all 0.3s;
  font-weight: 500;
}

.ai-logo i {
  font-size: 24px;
  margin-right: 10px;
}

.ai-logo:hover {
  color: #66b1ff;
  transform: translateX(5px);
}

.ai-user-info {
  display: flex;
  align-items: center;
}

.ai-avatar-wrapper {
  display: flex;
  align-items: center;
  cursor: pointer;
  transition: all 0.3s;
  padding: 5px 10px;
  border-radius: 20px;
  background: rgba(64, 158, 255, 0.1);
}

.ai-avatar-wrapper:hover {
  background: rgba(64, 158, 255, 0.2);
  transform: translateY(-2px);
}

.ai-username {
  margin-left: 10px;
  font-size: 14px;
  color: #606266;
}

.ai-main-container {
  width: 80%;
  margin: 30px auto 0;
  position: relative;
  z-index: 1;
  min-height: calc(100vh - 290px);
}

.ai-router-view {
  width: 100%;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(64, 158, 255, 0.1);
  padding: 20px;
  border: 1px solid rgba(64, 158, 255, 0.1);
}

.ai-footer {
  height: 200px !important;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(5px);
  border-top: 1px solid rgba(64, 158, 255, 0.2);
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
  z-index: 1;
  margin-top: 50px;
}

.ai-footer-content {
  text-align: center;
  width: 100%;
  padding: 0 20px;
}

.ai-footer-links {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
}

.ai-link {
  color: #909399;
  margin: 0 15px;
  text-decoration: none;
  transition: all 0.3s;
  font-size: 14px;
}

.ai-link:hover {
  color: #409EFF;
}

.ai-copyright {
  color: #909399;
  font-size: 14px;
  margin-top: 20px;
}

.ai-copyright i {
  color: #409EFF;
  margin-right: 5px;
}
</style>

<style>
.ai-tooltip {
  background: rgba(255, 255, 255, 0.95) !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
  color: #606266 !important;
  padding: 10px 15px !important;
  border-radius: 6px !important;
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.15) !important;
}

.ai-tooltip .popper__arrow {
  border-top-color: rgba(64, 158, 255, 0.2) !important;
}
</style>