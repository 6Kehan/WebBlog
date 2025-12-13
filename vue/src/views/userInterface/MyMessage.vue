<template>
  <el-container class="ai-chat-container">
    <!-- 左侧聊天列表 -->
    <el-aside width="280px" class="ai-chat-list">
      <el-scrollbar class="ai-scrollbar">
        <el-menu
            :default-active="activeSession"
            class="ai-contact-menu"
            @select="handleSelectSession"
        >
          <el-menu-item
              v-for="session in sessions"
              :key="session.sessionId"
              :index="session.sessionId"
              class="ai-contact-item"
          >
            <div class="ai-contact-avatar">
              <el-avatar :size="40" :src="session.avatar || defaultAvatar" />
            </div>
            <div class="ai-contact-info">
              <div class="ai-contact-name">{{ session.username }}</div>

            </div>
          </el-menu-item>
        </el-menu>
      </el-scrollbar>
    </el-aside>

    <!-- 右侧聊天区域 -->
    <el-main class="ai-chat-main">
      <div v-if="activeSession" class="ai-chat-area">
        <div class="ai-chat-title">
          <el-avatar :size="40" :src="currentContact.avatar || defaultAvatar" />
          <span>{{ currentContact.username }}</span>
        </div>

        <el-scrollbar ref="messageScroll" class="ai-message-scrollbar">
          <div class="ai-messages">
            <div
                v-for="(message, index) in messages"
                :key="index"
                :class="['ai-message', message.sender === currentUserId ? 'ai-message-sent' : 'ai-message-received']"
            >
              <!-- 接收消息时显示对方头像 -->
              <el-avatar
                  :size="36"
                  :src="message.avatar || defaultAvatar"
                  class="ai-message-avatar"
              />
              <div class="ai-message-content-wrapper">
                <div class="ai-message-content">
                  {{ message.content }}
                </div>
              </div>
            </div>
          </div>
        </el-scrollbar>

        <div class="ai-message-input">
          <el-input
              v-model="newMessage"
              type="textarea"
              :rows="3"
              placeholder="输入消息..."
              resize="none"
              @keyup.enter.native="sendMessage"
          />
          <div class="ai-message-actions">
            <el-button type="primary" size="small" @click="sendMessage">发送</el-button>
          </div>
        </div>
      </div>

      <div v-else class="ai-chat-empty">
        <el-empty description="请从左侧选择聊天"></el-empty>
      </div>
    </el-main>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      defaultAvatar: 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png',
      activeSession: null,
      newMessage: '',
      currentUserId: this.$store.getters.getUserId,
      userId: this.$store.getters.getUserId,
      sessions: [],
      messages: [],
      pollInterval: null ,// 用于存储轮询定时器
      sessionListInterval: null // 新增一个定时器用于会话列表轮询
    }
  },
  computed: {
    currentContact() {
      if (!this.activeSession) return { username: '', avatar: '' };
      const session = this.sessions.find(s => s.sessionId === this.activeSession);
      return session || { username: '', avatar: '' };
    }
  },
  methods: {
    startPolling(sessionId) {
      this.stopPolling();
      this.fetchMessages(sessionId);
      this.pollInterval = setInterval(() => {
        this.fetchMessages(sessionId);
      }, 1000);
    },
    startSessionListPolling() {
      // 先停止之前的轮询
      if (this.sessionListInterval) {
        clearInterval(this.sessionListInterval);
      }

      // 立即执行一次获取会话列表
      this.getSessionList();

      // 设置定时器每秒执行
      this.sessionListInterval = setInterval(() => {
        this.getSessionList();
      }, 1000);
    },
    stopPolling() {
      if (this.pollInterval) {
        clearInterval(this.pollInterval);
        this.pollInterval = null;
      }
    },
    stopSessionListPolling() {
      if (this.sessionListInterval) {
        clearInterval(this.sessionListInterval);
        this.sessionListInterval = null;
      }
    },
    fetchMessages(sessionId) {
      this.$axios.post('http://localhost:8080/message/getById/' + sessionId).then(resp => {
        if (resp.data.code == 200) {
          this.messages = resp.data.data;
          this.$nextTick(() => {
            this.scrollToBottom();
          });
        }
      }).catch(error => {
        console.error('获取消息失败:', error);
      });
    },
    getSessionList() {
      this.$axios.post('http://localhost:8080/session/getByUserId/' + this.userId).then(resp => {
        if (resp.data.code == 200) {
          this.sessions = resp.data.data;
        }
      }).catch(error => {
        console.error('获取会话列表失败:', error);
      });
    },
    handleSelectSession(sessionId) {
      this.activeSession = sessionId;
      // // 开始轮询当前会话
      this.startPolling(sessionId);
    },
    sendMessage() {
      if (!this.newMessage.trim()) return;

      this.$axios.post('http://localhost:8080/message/create', {
        sessionId: this.activeSession,
        messageUserId: this.currentUserId,
        content: this.newMessage,
      }).then(resp => {
        if (resp.data.code == 200) {
          // 发送成功后，重新获取消息列表
          this.fetchMessages(this.activeSession);
          this.newMessage = '';

          this.$nextTick(() => {
            this.scrollToBottom();
          });
        }
      }).catch(error => {
        console.error('发送消息失败:', error);
      });
    },
    scrollToBottom() {
      const scrollbar = this.$refs.messageScroll;
      if (scrollbar) {
        scrollbar.wrap.scrollTop = scrollbar.wrap.scrollHeight;
      }
    }
  },
  beforeDestroy() {
    // 组件销毁前清除所有定时器
    this.stopPolling();
    this.stopSessionListPolling();
  },
  mounted() {
    // 启动会话列表轮询
    this.startSessionListPolling();

    const elMain = document.querySelector('.el-main');
    if (elMain) {
      elMain.style.overflow = 'visible';
    }
  }
}
</script>

<style scoped>
body .el-main {
  overflow: visible !important;
}
.ai-chat-container {
  height: 100vh;
  background-color: #f5f7fa;
}

.ai-chat-list {
  background-color: white;
  border-right: 1px solid #e6e6e6;
  height: 90%;
  display: flex;
  flex-direction: column;
}

.ai-chat-header {
  padding: 15px;
  border-bottom: 1px solid #e6e6e6;
  text-align: center;
}

.ai-chat-header h3 {
  margin: 0;
  color: #333;
  font-size: 18px;
}

.ai-scrollbar {
  flex: 1;
  height: 0;
}

.ai-contact-menu {
  border-right: none;
}

.ai-contact-item {
  height: 70px;
  display: flex;
  align-items: center;
  padding: 0 15px;
  transition: background-color 0.3s;
}

.ai-contact-item:hover {
  background-color: #f5f7fa;
}

.ai-contact-item.is-active {
  background-color: #ecf5ff;
}

.ai-contact-avatar {
  margin-right: 12px;
}

.ai-contact-info {
  flex: 1;
  overflow: hidden;
}

.ai-contact-name {
  font-size: 14px;
  color: #333;
  margin-bottom: 4px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.ai-contact-preview {
  font-size: 12px;
  color: #999;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.ai-chat-main {
  padding: 0;
  background-color: white;
}

.ai-chat-area {
  height: 90%;
  display: flex;
  flex-direction: column;
}

.ai-chat-title {
  padding: 15px;
  border-bottom: 1px solid #e6e6e6;
  display: flex;
  align-items: center;
  font-size: 16px;
  font-weight: 500;
}

.ai-chat-title .el-avatar {
  margin-right: 10px;
}

.ai-message-scrollbar {
  flex: 1;
  padding: 20px;
  background-color: #f9f9f9;
}

.ai-messages {
  display: flex;
  flex-direction: column;
}

.ai-message {
  display: flex;
  margin-bottom: 16px;
  max-width: 80%;
}

.ai-message-sent {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.ai-message-received {
  align-self: flex-start;
}

.ai-message-avatar {
  margin-right: 10px;
  margin-left: 10px;
  align-self: flex-end;
}

.ai-message-content-wrapper {
  display: flex;
  flex-direction: column;

}

.ai-message-content {
  padding: 12px 16px;
  border-radius: 5px;
  font-size: 14px;
  line-height: 1.5;
  word-wrap: break-word;
  position: relative;
}

.ai-message-sent .ai-message-content {
  background-color: #409EFF;
  color: white;
  border-top-right-radius: 0;
}

.ai-message-received .ai-message-content {
  background-color: #c0c4cc;
  color: #333;
  border: 1px solid #e6e6e6;
  border-top-left-radius: 0;
}

.ai-message-input {
  border-top: 1px solid #e6e6e6;
  padding: 15px;
  background-color: white;
}

.ai-message-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
}

.ai-chat-empty {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f9f9f9;
}
</style>