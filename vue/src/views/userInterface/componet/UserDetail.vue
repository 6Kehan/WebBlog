<template>
  <div class="user-profile-container">
    <!-- 用户信息卡片 -->
    <el-card class="user-info-card">
      <el-descriptions title="用户信息" :column="3" border>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            用户名
          </template>
          {{user.userName}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-user"></i>
            昵称
          </template>
          {{user.realname}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-mobile-phone"></i>
            手机号
          </template>
          {{user.tel}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-s-comment"></i>
            邮箱
          </template>
          {{user.email}}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label">
            <i class="el-icon-office-building"></i>
            联系地址
          </template>
          {{user.address}}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>
    <!-- 用户交易列表 -->
    <div class="trading-list-container">
      <h3 class="trading-list-title">文章列表</h3>
      <div class="trading-list">
        <el-card
            v-for="(item, index) in tradingData"
            :key="index"
            class="trading-card"
            shadow="hover"
        >
          <div class="trading-content-wrapper">
            <!-- 标题和元信息 -->
            <div class="trading-header">
              <router-link :to="{ name: 'Detail', params: { id: item.id } }" class="trading-title-link">
                <h3 class="trading-title">{{ item.title }}</h3>
              </router-link>
              <div class="trading-meta">
                <span class="trading-author">{{ item.username }}</span>
                <span class="trading-time">{{ item.createTime }}</span>
              </div>
            </div>

            <!-- 内容预览 -->
            <p class="trading-content-preview">
              {{ truncateContent(item.content) }}
            </p>

            <!-- 多媒体展示 -->
            <div v-if="combinedMedia(item).length > 0" class="trading-media-grid">
              <div
                  v-for="(media, mIndex) in combinedMedia(item)"
                  :key="mIndex"
                  class="trading-media-item"
              >
                <img
                    v-if="media.type === 'image'"
                    :src="media.url"
                    class="trading-media-thumbnail"
                />
                <video
                    v-else
                    class="trading-media-thumbnail"
                    controls
                >
                  <source :src="media.url" type="video/mp4">
                  您的浏览器不支持视频播放
                </video>
              </div>
            </div>

            <!-- 操作按钮 -->
            <div class="trading-actions">
              <el-button size="small" type="primary" plain @click="like(item.id,item.title,2)">
                <i class="el-icon-thumb"></i> 点赞({{item.count}})
              </el-button>
              <el-button size="small" type="success" plain @click="like(item.id,item.title,1)">
                <i class="el-icon-star-off"></i> 收藏
              </el-button>
            </div>
          </div>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
import Avatar from 'vue-avatar'
import Detail from "@/views/userInterface/componet/Detail.vue";

export default {
  components:{Avatar},
  name: "trading",
  data() {
    return {
      user:{},
      replyShow: [false], //默认内容不显示
      tradingData: [],
    }
  },
  created: function () {
    this.getProblems();
    this.tradingForm={};
  },
  computed: {
    Detail() {
      return Detail
    },
  },
  methods: {
    combinedMedia(item) {
      const images = item.imagesList || []
      const videos = item.videosList || []
      const remaining = 6 - images.length
      return [
        ...images.slice(0,6).map(url => ({ type: 'image', url })),
        ...(remaining > 0 ? videos.slice(0, remaining).map(url => ({ type: 'video', url })) : [])
      ]
    },
    truncateContent(text) {
      if (!text) return ''

      const chineseChars = text.match(/[\u4e00-\u9fa5]/g);

      if (!chineseChars) return text;

      const truncatedText = chineseChars.slice(0, 200).join('');

      return chineseChars.length > 200 ? truncatedText + '...' : truncatedText;
    },
    getProblems() {
      var id = this.$route.params.id;
      this.$axios.post('http://localhost:8080/trading/getTradingByUserId/'+id).then(resp => {
        console.log(resp.data.data)
        this.tradingData = resp.data.data
        this.tradingTotal = this.tradingData.length
      })

      this.$axios.post('http://localhost:8080/user/getUserById/'+id).then(resp => {
        this.user = resp.data.data
      })
    },
    load() {
      this.loading = true
      setTimeout(() => {
        this.count += 2
        this.loading = false
      }, 2000)
    },
  }
}
</script>

<style scoped>
/* 主容器样式 */
.user-profile-container {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

/* 用户信息卡片样式 */
.user-info-card {
  margin-bottom: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.08);
}

.user-info-card >>> .el-card__body {
  padding: 20px;
}

/* 交易列表容器 */
.trading-list-container {
  margin-top: 30px;
}

.trading-list-title {
  font-size: 20px;
  color: #303133;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid #eee;
}

/* 交易卡片样式 */
.trading-card {
  margin-bottom: 20px;
  border-radius: 8px;
  transition: all 0.3s;
}

.trading-card >>> .el-card__body {
  padding: 0;
}

.trading-content-wrapper {
  padding: 20px;
}

/* 交易标题和元信息 */
.trading-header {
  margin-bottom: 15px;
}

.trading-title-link {
  text-decoration: none;
  color: inherit;
}

.trading-title {
  font-size: 18px;
  color: #303133;
  margin: 0 0 10px 0;
  transition: color 0.3s;
}

.trading-title:hover {
  color: #409EFF;
}

.trading-meta {
  font-size: 14px;
  color: #909399;
}

.trading-author {
  color: #409EFF;
  margin-right: 15px;
}

.trading-time {
  color: #909399;
}

/* 内容预览 */
.trading-content-preview {
  color: #606266;
  line-height: 1.6;
  margin-bottom: 15px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

/* 多媒体网格 */
.trading-media-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin: 20px 0;
}

.trading-media-item {
  position: relative;
  padding-top: 100%; /* 保持1:1比例 */
  border-radius: 4px;
  overflow: hidden;
  background: #f5f7fa;
}

.trading-media-thumbnail {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
  cursor: pointer;
}

.trading-media-thumbnail:hover {
  transform: scale(1.05);
}

/* 操作按钮 */
.trading-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 15px;
}

.trading-actions .el-button {
  margin-left: 10px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .user-profile-container {
    padding: 0 15px;
  }

  .trading-media-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .trading-content-wrapper {
    padding: 15px;
  }
}

@media (max-width: 480px) {
  .trading-media-grid {
    grid-template-columns: 1fr;
  }

  .trading-actions {
    justify-content: space-between;
  }

  .trading-actions .el-button {
    margin-left: 0;
    flex: 1;
    margin: 0 5px;
  }
}
</style>