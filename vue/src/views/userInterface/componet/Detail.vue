<template>
  <el-container class="ai-container">
    <div class="ai-background">
      <div class="ai-particle-effect"></div>
      <div class="ai-grid-overlay"></div>
    </div>

    <el-main class="ai-content-main">
      <el-card class="ai-content-card">


        <div class="ai-content-meta">
          <h2 class="ai-content-title">{{ blog.title }}</h2>
          <div class="ai-content-author">
            <router-link class="ai-link" :to="{ name: 'UserDetail', params: { id: blog.userId } }">
              <i class="el-icon-user"></i> {{ blog.realname }}
            </router-link>
            <span class="ai-meta-item"><i class="el-icon-time"></i> {{ blog.createTime }}</span>
            <span class="ai-meta-item"><i class="el-icon-star-off"></i> {{ blog.count }}</span>
            <span class="ai-meta-item" @click="follow(blog.userId,blog.username)"><i class="el-icon-circle-plus-outline"></i> 关注</span>
          </div>
        </div>

        <div class="ai-content-body">
          <vue-markdown :source="blog.content" class="ai-markdown-content"></vue-markdown>
        </div>
        <div v-if="combinedMedia.length > 0" class="ai-media-section">
          <div class="ai-media-grid">
            <div
                v-for="(media, index) in combinedMedia"
                :key="index"
                class="ai-media-item"
            >
              <img
                  v-if="media.type === 'image'"
                  :src="media.url"
                  class="ai-media-thumbnail"
                  @click="openGallery(index)"
              />
              <video
                  v-else
                  class="ai-media-thumbnail"
                  controls
                  preload="metadata"
              >
                <source :src="media.url" type="video/mp4">
                您的浏览器不支持视频播放
              </video>
            </div>
          </div>
        </div>

        <!-- 文档列表 -->
        <div v-if="blog.docsList && blog.docsList.length > 0" class="ai-docs-section">
          <h3 class="ai-section-title">相关文件</h3>
          <div class="ai-docs-grid">
            <div
                v-for="(doc, index) in blog.docsList"
                :key="index"
                class="ai-doc-item"
                @click="downloadFile(doc)"
            >
              <div class="ai-doc-icon">
                <i class="el-icon-document" style="font-size: 32px;"></i>
              </div>
              <div class="ai-doc-info">
              </div>
            </div>
          </div>
        </div>

        <div class="ai-comment-section">
          <h3 class="ai-section-title">评论</h3>

          <el-form :model="reply" class="ai-comment-form">
            <el-form-item prop="content">
              <el-input
                  type="textarea"
                  v-model="reply.content"
                  :rows="4"
                  placeholder="写下你的评论..."
                  class="ai-textarea"
              ></el-input>
            </el-form-item>
            <el-form-item>
              <el-button
                  type="primary"
                  class="ai-submit-btn"
                  @click="submitComment(blog.id)"
              >
                提交评论 <i class="el-icon-upload"></i>
              </el-button>
            </el-form-item>
          </el-form>

          <div class="ai-comment-list">
            <div class="ai-comment-item" v-for="comment in commentList" :key="comment.id">
              <div class="ai-comment-header">
                <img
                    :src="comment.avatar"
                    class="ai-comment-avatar"
                />
                <div class="ai-comment-meta">
                  <span class="ai-comment-author">{{ comment.username }}</span>
                  <span class="ai-comment-time">{{ comment.createTime }}</span>
                </div>
              </div>
              <div class="ai-comment-content">
                {{ comment.content }}
              </div>
            </div>
          </div>
        </div>
      </el-card>
    </el-main>
  </el-container>
</template>

<script>
import VueMarkdown from 'vue-markdown';
export default {
  components:{VueMarkdown},
  name: "trading",
  data() {
    return {
      commentList:[],
      blog: {},
      reply: {
        userId: this.$store.getters.getUserId,
        username: this.$store.getters.getUserName,
        content: '',
      },
    }
  },
  created: function () {
    this.getProblems();
    this.getComment();
  },
  computed: {
    combinedMedia() {
      const images = (this.blog.imagesList || []).map(url => ({ type: 'image', url }));
      const videos = (this.blog.videosList || []).map(url => ({ type: 'video', url }));
      return [...images, ...videos].slice(0, 8); // 最多显示8个
    }
  },
  methods: {
    // 新增方法
    downloadFile(url) {
      window.open(url, '_blank');
    },

    formatFileSize(bytes) {
      if (!bytes) return '0 Bytes';
      const k = 1024;
      const sizes = ['Bytes', 'KB', 'MB', 'GB'];
      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    },
    follow(userid,username){
      this.$axios.post('http://localhost:8080/userFollow/create',{
        followUserId:userid,
        followUserName:username,
        userId:this.reply.userId,
      }).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: "关注成功"
          });
        }
        if (resp.data.code != 200) {
          this.$message({
            type: 'error',
            message: resp.data.msg
          });
        }
      })
    },
    submitComment(id){
      this.reply.blogId=id
      this.$axios.post('http://localhost:8080/comment/create',this.reply).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: "评论成功"
          });
          this.reply.content=''
          this.getComment();
        }
      })
    },
    getProblems() {
      var id = this.$route.params.id;
      this.$axios.post('http://localhost:8080/trading/getTradingById/'+id).then(resp => {
        console.log(resp.data.data)
        this.blog = resp.data.data
      })
    },
    getComment() {
      var id = this.$route.params.id;
      this.$axios.post('http://localhost:8080/comment/getByBlogId/'+id).then(resp => {
        this.commentList = resp.data.data
      })
    }
  }
}
</script>
<style scoped>
/* 新增样式 */
.ai-media-section {
  margin-bottom: 30px;
}

.ai-media-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 15px;
  margin-bottom: 25px;
}

.ai-media-item {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  background: #f5f7fa;
  transition: transform 0.3s;
  cursor: pointer;
}

.ai-media-thumbnail {
  width: 100%;
  height: 200px;
  object-fit: cover;
  display: block;
  transition: transform 0.3s;
}

.ai-media-item:hover .ai-media-thumbnail {
  transform: scale(1.05);
}

video.ai-media-thumbnail {
  background: #000;
}

/* 文档列表样式 */
.ai-docs-section {
  margin: 40px 0;
  padding-top: 20px;
  border-top: 1px solid #ebeef5;
}

.ai-docs-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  margin-top: 15px;
}

.ai-doc-item {
  display: flex;
  align-items: center;
  padding: 15px;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  transition: all 0.3s;
  cursor: pointer;
  background: rgba(255, 255, 255, 0.9);
}

.ai-doc-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  border-color: #409EFF;
}

.ai-doc-icon {
  margin-right: 15px;
  color: #409EFF;
}

.ai-doc-info {
  display: flex;
  flex-direction: column;
}

.ai-doc-name {
  font-weight: 500;
  color: #303133;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
}

.ai-doc-size {
  font-size: 12px;
  color: #909399;
  margin-top: 5px;
}

/* 调整原有布局 */
.ai-content-meta {
  margin-bottom: 30px;
}

.ai-content-title {
  margin-bottom: 15px;
}

/* 保持其他样式不变 */
</style>
<style scoped>


.ai-particle-effect {
  position: absolute;
  width: 100%;
  height: 100%;
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

.ai-content-main {
  display: flex;
  justify-content: center;

  z-index: 1;
}

.ai-content-card {
  width: 100%;
  padding: 30px;
  background: rgba(255, 255, 255, 0.95);


}

.ai-content-header {
  margin-bottom: 30px;
}

.ai-content-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 20px;
}

.ai-content-title {
  color: #303133;
  font-size: 28px;
  font-weight: 600;
  margin-bottom: 15px;
}

.ai-content-author {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 15px;
  color: #606266;
  font-size: 14px;
}

.ai-meta-item {
  display: flex;
  align-items: center;
  gap: 5px;
}

.ai-content-body {
  padding: 0 20px;
  margin-bottom: 40px;
}

.ai-markdown-content {
  font-size: 16px;
  line-height: 1.8;
  color: #606266;
}

.ai-comment-section {
  margin-top: 40px;
  padding-top: 30px;
  border-top: 1px solid #ebeef5;
}

.ai-section-title {
  color: #303133;
  font-size: 16px;
  margin-bottom: 20px;
}

.ai-comment-form {
  margin-bottom: 30px;
}

.ai-textarea >>> .el-textarea__inner {
  background: rgba(255, 255, 255, 0.9);
  border: 1px solid #dcdfe6;
  color: #606266;
  border-radius: 8px;
  transition: all 0.3s;
  padding: 15px;
}

.ai-textarea >>> .el-textarea__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-submit-btn {
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  border-radius: 8px;
  font-weight: 500;
  padding: 12px 24px;
  transition: all 0.3s;
  box-shadow: 0 4px 12px rgba(64, 158, 255, 0.3);
}

.ai-submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(64, 158, 255, 0.4);
  background: linear-gradient(90deg, #66b1ff, #409EFF);
}

.ai-comment-item {
  padding: 20px 0;
  border-bottom: 1px solid #f0f2f5;
}

.ai-comment-header {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.ai-comment-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-right: 15px;
}

.ai-comment-meta {
  display: flex;
  flex-direction: column;
}

.ai-comment-author {
  font-weight: 600;
  color: #303133;
  font-size: 15px;
}

.ai-comment-time {
  color: #909399;
  font-size: 12px;
  margin-top: 2px;
}

.ai-comment-content {
  padding-left: 55px;
  color: #606266;
  line-height: 1.6;
}

.ai-link {
  color: #409EFF;
  text-decoration: none;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 5px;
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
</style>