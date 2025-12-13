<template>
  <el-container class="ai-container">
    <el-header class="ai-header">
      <div class="ai-header-content">
        <el-button
            size="mini"
            icon="el-icon-arrow-left"
            @click="back"
            class="ai-back-btn"
            type="primary"
        >
          返回
        </el-button>
      </div>
    </el-header>

    <el-container class="ai-main-container">
      <el-aside class="ai-sidebar">
        <div class="ai-user-profile">
          <h3 class="ai-username">{{ realname }}</h3>
        </div>

        <el-menu
            class="ai-sidebar-menu"
            default-active="1"
            background-color="#f5f7fa"
            text-color="#606266"
            active-text-color="#409EFF"
        >
          <el-menu-item index="1" @click="toPersonalInfo">
            <i class="el-icon-user"></i>
            <span>个人信息</span>
          </el-menu-item>
          <el-menu-item index="5" @click="toTrading">
            <i class="el-icon-document"></i>
            <span>我的文章</span>
          </el-menu-item>
          <el-menu-item index="6" @click="toMyComment">
            <i class="el-icon-chat-dot-round"></i>
            <span>我的评论</span>
          </el-menu-item>
          <el-menu-item index="7" @click="toMyCollect">
            <i class="el-icon-star-off"></i>
            <span>我的收藏</span>
          </el-menu-item>
          <el-menu-item index="8" @click="toMyFollow">
            <i class="el-icon-circle-plus-outline"></i>
            <span>我的关注</span>
          </el-menu-item>
          <el-menu-item index="9" @click="toMyMessage">
            <i class="el-icon-s-promotion"></i>
            <span>我的私信</span>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <el-main class="ai-content-main">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Avatar from 'vue-avatar'

export default {
  components: { Avatar },
  data() {
    return {
      realname: this.$store.getters.getUser.realname,
      avator: this.$store.getters.getUser.avator,
    };
  },
  methods: {
    toMyComment() {
      this.$router.push({path: '/personal/myComment'})
    },
    toMyCollect() {
      this.$router.push({path: '/personal/myCollect'})
    },
    toMyFollow() {
      this.$router.push({path: '/personal/myFollow'})
    },
    toPersonalInfo(){
      this.$router.push({path: '/personal/personalInfo'})
    },
    toTrading(){
      this.$router.push({path: '/personal/myTrading'})
    },
    toMyMessage(){
      this.$router.push({path: '/personal/myMessage'})
    },

    back() {
      if(this.$store.getters.getUser.role==="普通用户") {
        this.$router.push("/userInterface/tradingIndex")
      }
    },
  }
};
</script>

<style scoped>
.ai-container {
  height: 100vh;
  background-color: #f5f7fa;
}

.ai-header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(5px);
  border-bottom: 1px solid rgba(64, 158, 255, 0.2);
  height: 60px !important;
  display: flex;
  align-items: center;
  box-shadow: 0 2px 12px 0 rgba(64, 158, 255, 0.2);
}

.ai-header-content {
  width: 100%;
  padding: 0 20px;
}

.ai-back-btn {
  background: #409EFF !important;
  border: none;
  color: white;
  font-weight: 500;
}

.ai-back-btn:hover {
  background: rgba(255, 255, 255, 0.3);
}

.ai-main-container {
  height: calc(100vh - 60px);
}

.ai-sidebar {
  width: 220px !important;
  background-color: #f5f7fa;
  border-right: 1px solid #e6e6e6;
  padding: 20px 0;
}

.ai-user-profile {
  padding: 20px;
  text-align: center;
  margin-bottom: 20px;
}

.ai-user-avatar {
  width: 80px !important;
  height: 80px !important;
  margin-bottom: 15px;
  box-shadow: 0 2px 12px 0 rgba(64, 158, 255, 0.2);
}

.ai-username {
  color: #303133;
  font-size: 18px;
  margin: 10px 0 0;
}

.ai-sidebar-menu {
  border-right: none;
}

.ai-sidebar-menu .el-menu-item {
  height: 50px;
  line-height: 50px;
  margin: 5px 0;
  transition: all 0.3s;
}

.ai-sidebar-menu .el-menu-item:hover {
  background-color: #ecf5ff !important;
}

.ai-sidebar-menu .el-menu-item.is-active {
  background-color: #ecf5ff !important;
  border-right: 3px solid #409EFF;
}

.ai-content-main {
  padding: 20px;
  background-color: white;
}
</style>