<template>
  <el-container class="ai-layout-container">
    <!-- 头部导航栏 -->
    <el-header class="ai-admin-header">
      <div class="ai-logo">
        <i class="el-icon-monitor"></i>
        <span>博客交流平台管理后台</span>
      </div>

      <div class="ai-user-info">
        <el-tooltip
            content="点击管理个人信息"
            placement="bottom"
            effect="light"
            popper-class="ai-tooltip"
        >
          <div class="ai-avatar-wrapper" @click="drawer = true">
            <el-avatar
                shape="circle"
                fit="cover"
                :size="40"
                src="https://img1.baidu.com/it/u=3115634316,1682765598&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"
            />
            <span class="ai-username">{{ $store.getters.getUser.realname }}</span>
          </div>
        </el-tooltip>
      </div>
    </el-header>

    <el-container class="ai-admin-container">
      <!-- 侧边导航 -->
      <el-aside class="ai-admin-sidebar">
        <el-menu
            default-active="1"
            class="ai-admin-menu"
            background-color="rgba(255,255,255,0.9)"
            text-color="#606266"
            active-text-color="#409EFF">
          <el-menu-item index="2" @click="toUserManage">
            <i class="el-icon-s-custom"></i>
            <span slot="title">用户管理</span>
          </el-menu-item>
          <el-menu-item index="7" @click="toBlog">
            <i class="el-icon-s-order"></i>
            <span slot="title">文章管理</span>
          </el-menu-item>
          <el-menu-item index="3" @click="toType">
            <i class="el-icon-news"></i>
            <span slot="title">类型管理</span>
          </el-menu-item>
          <el-menu-item index="6" @click="toComment">
            <i class="el-icon-chat-dot-square"></i>
            <span slot="title">评论管理</span>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <!-- 主要内容区 -->
      <el-main class="ai-admin-main">
        <router-view class="ai-router-view"></router-view>
      </el-main>
    </el-container>

    <!-- 个人信息抽屉 -->
    <el-drawer
        title="个人信息"
        :visible.sync="drawer"
    >
      <div style="padding: 20px">
        <el-form>
          <el-form-item>
            <el-input v-model="myData.userName" :disabled="isDisabled">
              <template slot="prepend">用户名</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.realname" :disabled="isDisabled">
              <template slot="prepend">昵称</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.email" :disabled="isDisabled">
              <template slot="prepend">账户邮箱</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.userPwd" :disabled="isDisabled">
              <template slot="prepend">账户密码</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.address" :disabled="isDisabled">
              <template slot="prepend">联系地址</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.tel" :disabled="isDisabled">
              <template slot="prepend">联系方式</template>
            </el-input>
          </el-form-item>
          <el-form-item>
            <el-input v-model="myData.createTime" disabled>
              <template slot="prepend">注册时间</template>
            </el-input>
          </el-form-item>
        </el-form>
      </div>
      <div style="text-align: center;margin-bottom: 20px;" v-show="isUpdateOn">
        <el-button type="primary" style="width:90%;" @click="updateMyInfo">确认修改</el-button>
      </div>
      <div style="text-align: center;">
        <el-button type="primary" style="width:90%;" @click="upDateOn">修改信息</el-button>
      </div>
      <div style="text-align: center;margin-top: 20px;margin-bottom: 40px">
        <el-button type="danger" style="width:90%;" @click="logout">退出登录</el-button>
      </div>
    </el-drawer>
  </el-container>
</template>

<script>
export default {
  name: "adminIndex",
  data() {
    return {
      isDisabled: true,
      isUpdateOn: false,
      myData: {},
      drawer: false,
    };
  },
  created() {
    this.getMyInfo();
  },
  methods: {
    logout() {
      this.$router.push({path: '/'})
    },
    toUserManage() {
      this.$router.push({path: '/manage/user'})
    },
    toBlog() {
      this.$router.push({path: '/manage/blog'})
    },
    toType() {
      this.$router.push({path: '/manage/type'})
    },
    toComment() {
      this.$router.push({path: '/manage/comment'})
    },
    getMyInfo() {
      this.$axios.post('http://localhost:8080/user/getUserById?id=' + this.$store.getters.getUserId).then(resp => {
        this.myData = resp.data.data
      })
    },
    updateMyInfo() {
      this.$axios.put('http://localhost:8080/user/userInfoSet', this.myData).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.$router.go(0)
        }
        this.upDateOn()
      })
    },
    upDateOn() {
      this.isDisabled = !this.isDisabled
      this.isUpdateOn = !this.isUpdateOn
    },
  }
}
</script>

<<style scoped>
.ai-layout-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #f0f7ff, #e6f2ff, #f0f7ff);
  position: relative;
  overflow-x: hidden;
}

.ai-admin-header {
  height: 70px !important;
  background: rgba(255, 255, 255, 0.95) !important;
  backdrop-filter: blur(5px);
  border-bottom: 1px solid rgba(64, 158, 255, 0.2);
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 5%;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.1);
}

.ai-admin-sidebar {
  width: 180px !important;
  background: rgba(255, 255, 255, 0.9) !important;
  backdrop-filter: blur(5px);
  border-right: 1px solid rgba(64, 158, 255, 0.1);
}

.ai-admin-menu {
  border-right: none;
  padding: 20px 10px;
}

.ai-admin-menu .el-menu-item {
  height: 50px;
  line-height: 50px;
  margin: 8px 0;
  border-radius: 8px;
  transition: all 0.3s;
}

.ai-admin-menu .el-menu-item:hover {
  background: rgba(64, 158, 255, 0.1) !important;
}

.ai-admin-menu .el-menu-item.is-active {
  background: rgba(64, 158, 255, 0.1) !important;
}

.ai-admin-main {
  padding: 30px;
  background: transparent;
}

.ai-router-view {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(64, 158, 255, 0.1);
  padding: 25px;
  min-height: calc(100vh - 140px);
}

.ai-drawer {
  --el-drawer-bg-color: rgba(255,255,255,0.95);
  backdrop-filter: blur(5px);
}

.ai-drawer /deep/ .el-drawer__header {
  margin-bottom: 20px;
  color: #303133;
  font-size: 18px;
  border-bottom: 1px solid rgba(64, 158, 255, 0.1);
  padding: 20px;
}

.ai-drawer /deep/ .el-drawer__body {
  padding: 0 20px;
}

.ai-drawer-content .el-input__inner {
  border-color: rgba(64, 158, 255, 0.2);
}

.ai-drawer-content .el-input-group__prepend {
  background: rgba(64, 158, 255, 0.05);
  border-color: rgba(64, 158, 255, 0.2);
  color: #409EFF;
}

/* 保留原有交互逻辑的样式调整 */
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
