<template>
  <div class="ai-blog-container" style="overflow:auto;min-height: 620px">
    <div class="ai-search-container">
<!--      <el-input v-model="key" placeholder="搜索内容..."></el-input>-->
<!--      <el-button type="primary"   @click="handleSearch()">-->
<!--        搜索 <i class="el-icon-search"></i>-->
<!--      </el-button>-->

      <el-input
          v-model="key"
          placeholder="请输入关键词搜索"
          clearable
          @keyup.enter.native="handleSearch"
      >
        <template #append>
          <el-button
              icon="el-icon-search"
              @click="handleSearch"
              :loading="loading"
          />
        </template>
      </el-input>
    </div>

    <el-row class="ai-content-row">
      <el-col :span="18">
        <div class="ai-blog-list">
          <el-card
              v-for="(item, index) in tradingData"
              :key="index"
              class="ai-blog-card"
              :class="{'ai-blog-card-even': index%2===0, 'ai-blog-card-odd': index%2!==0}"
          >
            <!-- 标题部分 -->
            <div class="ai-blog-title-container">
              <router-link class="ai-blog-link" :to="{ name: 'Detail', params: { id: item.id } }">
                <h3 class="ai-blog-title">{{ item.title }}</h3>
              </router-link>
              <div class="ai-blog-meta">
                <span class="ai-blog-author">{{ item.realname }}</span>
                <label class="ai-blog-time">{{ item.createTime }}</label>
              </div>
            </div>
            <p class="ai-content-text">
              {{ truncateContent(item.content) }}
            </p>
            <!-- 多媒体展示部分 -->
            <div v-if="combinedMedia(item).length > 0" class="ai-media-grid">
              <div
                  v-for="(media, mIndex) in combinedMedia(item)"
                  :key="mIndex"
                  class="ai-media-item"
              >
                <img
                    v-if="media.type === 'image'"
                    :src="media.url"
                    class="ai-media-thumbnail"
                />
                <video
                    v-else
                    class="ai-media-thumbnail"
                    controls
                >
                  <source :src="media.url" type="video/mp4">
                  您的浏览器不支持视频播放
                </video>
              </div>
            </div>

            <!-- 内容部分 -->
            <div class="ai-content-container">


              <!-- 操作按钮 -->
              <div class="ai-blog-actions">
                <el-button size="small" type="primary" round @click="like(item.id,item.title,2)">
                  <i class="el-icon-thumb"></i> 点赞({{item.count}})
                </el-button>
                <el-button size="small" type="success" round @click="like(item.id,item.title,1)">
                  <i class="el-icon-star-off"></i> 收藏
                </el-button>
              </div>
            </div>
          </el-card>
        </div>
      </el-col>

      <el-col :span="6">
        <div class="ai-category-container">
          <el-card class="ai-category-card">
            <div slot="header" class="ai-category-header">
              <i class="el-icon-collection-tag"></i>
              <span>分类列表</span>
            </div>
            <div class="ai-tag-container">
              <el-tag
                  v-for="type in typeList"
                  @click="selectByType(type.name,'')"
                  class="ai-category-tag"
              >
                {{type.name}}
              </el-tag>
            </div>
          </el-card>
        </div>
        <div class="ai-category-container">
          <el-card class="ai-category-card">
            <div slot="header" class="ai-category-header">
              <i class="el-icon-trophy"></i>
              <span>热榜</span>
            </div>
            <div class="ai-hot-list">
              <div
                  v-for="(blog, index) in heatBlog"
                  :key="index"
                  class="ai-hot-item"
                  @click="$router.push({ name: 'Detail', params: { id: blog.id } })"
              >
                <div class="ai-hot-rank" :class="{
                  'ai-hot-rank-1': index === 0,
                  'ai-hot-rank-2': index === 1,
                  'ai-hot-rank-3': index === 2
                }">
                  {{ index + 1 }}
                </div>
                <div class="ai-hot-content">
                  <div class="ai-hot-title">{{ blog.title }}</div>
                  <div class="ai-hot-meta">
                    <span class="ai-hot-count">
                      <i class="el-icon-thumb"></i> {{ blog.count || 0 }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </el-card>
        </div>
      </el-col>
    </el-row>

    <p v-if="loading" class="ai-loading-text">
      <i class="el-icon-loading"></i> 加载中...
    </p>
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
      key:'',
      dialogFormVisible:false,
      tradingForm:{},
      replyShow: [false],
      loading: false,
      tradingTotal: "",
      tradingData: [],
      replyData: [],
      reply: {
        userId: this.$store.getters.getUserId,
        replyContent: '',
        problemId: '',
      },
      val: '',
      operation:{},
      typeList:[],
      heatBlog:[]
    }
  },
  created: function () {
    this.getProblems();
    this.getType();
    this.tradingForm={};
    this.selectHeatBlog();
  },
  computed: {
    Detail() {
      return Detail
    },
    noMore() {
      return this.tradingTotal >= this.tradingTotal
    },
  },
  mounted() {

    this.$nextTick(function () {
      this.$on('getProblems', function () {
        this.$axios.post('http://localhost:8080/trading/getTradingAll').then(resp => {
          console.log(resp.data.data)
          this.tradingData = resp.data.data
          this.tradingTotal = this.tradingData.length
        })
      });
    })
  },
  methods: {
    // 新增方法
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
      if (!text) return '';

      // 1. 去除 HTML 标签（只保留纯文本）
      const textWithoutHtml = text.replace(/<[^>]*>?/gm, '');

      // 2. 截取前 200 个字符
      const truncatedText = textWithoutHtml.slice(0, 200);

      // 3. 如果超过 200 字符，添加省略号
      return textWithoutHtml.length > 200 ? truncatedText + '...' : truncatedText;
    },
    handleSearch(){
      console.log("111")
      this.selectByType('',this.key)
    },
    like(id,title,type){
      this.operation.blogId=id
      this.operation.title=title
      this.operation.type=type
      this.operation.userId=this.$store.getters.getUserId;
      this.operation.username=this.$store.getters.getUserName;

      this.$axios.post('http://localhost:8080/operation/create', this.operation).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: type===1?"收藏成功":"点赞成功"
          });
          this.getProblems();
        }else {
          this.$message({
            type: 'error',
            message: resp.data.msg
          });
        }
      })
    },
    getProblems() {
      this.$axios.post('http://localhost:8080/trading/getTradingAll').then(resp => {
        console.log(resp.data.data)
        this.tradingData = resp.data.data
        this.tradingTotal = this.tradingData.length
      })
    },
    selectByType(type,key) {
      this.$axios.post('http://localhost:8080/trading/selectBlog?type=' + type+'&key=' + key).then(resp => {
        this.tradingData = resp.data.data;
        this.tradingTotal = this.tradingData.length;
      });
    },
    selectHeatBlog() {
      this.$axios.post('http://localhost:8080/trading/selectHeatBlog').then(resp => {
        this.heatBlog = resp.data.data;
      });
    },
    getType() {
      this.$axios.post('http://localhost:8080/type/getType').then(resp => {
        this.typeList = resp.data.data
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
/* 新增样式 */
.ai-blog-title-container {
  margin-bottom: 10px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}

.ai-blog-title {
  font-size: 22px;
  margin: 0 0 10px 0;
  color: #303133;
}

.ai-media-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin: 20px 0;
}

.ai-media-item {
  position: relative;
  padding-top: 100%; /* 保持1:1比例 */
  border-radius: 8px;
  overflow: hidden;
  background: #f5f7fa;
}
/* 更新搜索容器样式 */
.ai-search-container {
  width: 50%;
  margin: 20px auto 40px;
  position: relative;
}

/* 输入框样式优化 */
.ai-search-container >>> .el-input__inner {
  height: 46px;
  border-radius: 30px 0 0 30px;
  padding: 0 25px;
  font-size: 16px;
  border: 2px solid #e0e9f5;
  background: rgba(255, 255, 255, 0.9);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
}

.ai-search-container >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 3px rgba(64, 158, 255, 0.2);
}

.ai-search-container >>> .el-input__inner::placeholder {
  color: #a8abb2;
}

/* 搜索按钮样式重构 */
.ai-search-container >>> .el-input-group__append {
  background: linear-gradient(135deg, #66b1ff, #409EFF);
  border: none;
  border-radius: 0 30px 30px 0;
  padding: 0 25px;
  box-shadow: 2px 0 10px rgba(64, 158, 255, 0.2);
  transition: all 0.3s ease;
}

.ai-search-container >>> .el-input-group__append:hover {
  transform: translateX(2px);
  box-shadow: 4px 0 15px rgba(64, 158, 255, 0.3);
}

.ai-search-container >>> .el-button {
  height: 46px;
  color: white;
  font-size: 16px;
  border: none;
  padding: 0 20px;
}

.ai-search-container >>> .el-button:hover {
  background: transparent;
  color: rgba(255, 255, 255, 0.9);
}

/* 加载状态样式 */
.ai-search-container >>> .el-button.is-loading::before {
  background: rgba(255, 255, 255, 0.3);
}

/* 移动端适配 */
@media (max-width: 768px) {
  .ai-search-container {
    width: 90%;
    margin: 15px auto 30px;
  }

  .ai-search-container >>> .el-input__inner {
    height: 42px;
    font-size: 14px;
    padding: 0 20px;
  }

  .ai-search-container >>> .el-button {
    height: 42px;
    padding: 0 15px;
  }
}

.ai-media-thumbnail {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s;
  cursor: pointer;
}

.ai-media-thumbnail:hover {
  transform: scale(1.05);
}

.ai-content-container {
  position: relative;
  margin-top: 60px;
}

.ai-content-text {
  color: #606266;
  line-height: 1.6;
  margin-top: -30px;
  margin-bottom: 10px;
  min-height: 10px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.ai-blog-actions {
  position: absolute;
  right: 0;
  bottom: 0;
  display: flex;
  gap: 10px;
}

/* 调整原有样式 */
.ai-blog-card {
  position: relative;
  padding-bottom: 60px; /* 给操作按钮留空间 */
}

.ai-blog-meta {
  display: flex;
  align-items: center;
  color: #909399;
  font-size: 14px;
}

.ai-blog-author {
  color: #409EFF;
  margin-right: 15px;
}

/* 保持其他原有样式不变 */
</style>
<style scoped>
.ai-blog-container {
  background: linear-gradient(135deg, #e0e9f5, #e8f0fa, #e0e9f5);
  padding: 20px;
  min-height: 100vh;
}

.ai-search-container {
  width: 60%;
  margin: 0 auto 30px;
  display: flex;
  justify-content: center;
}

.ai-search-input {
  width: 400px;
}

.ai-search-input >>> .el-input__inner {
  border-radius: 20px;
  padding-left: 20px;
  height: 40px;
  border: 1px solid #dcdfe6;
  transition: all 0.3s;
}

.ai-search-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-search-btn {
  margin-left: 10px;
  border-radius: 20px;
  padding: 0 20px;
  height: 40px;
  background: linear-gradient(90deg, #409EFF, #66b1ff);
  border: none;
  box-shadow: 0 2px 10px rgba(64, 158, 255, 0.3);
  transition: all 0.3s;
}

.ai-search-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.4);
}

.ai-content-row {
  width: 90%;
  margin: 0 auto;
}

.ai-blog-list {
  margin-top: 30px;
}

.ai-blog-card {
  margin-bottom: 20px;
  border-radius: 12px;
  border: 1px solid rgba(64, 158, 255, 0.2);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
  transition: all 0.3s;

}

.ai-blog-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(64, 158, 255, 0.2);
}

.ai-image-container {
  padding: 10px;
  height: 200px;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.ai-blog-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 8px;
  transition: all 0.3s;
}

.ai-blog-image:hover {
  transform: scale(1.03);
}

.ai-content-col {
  padding: 20px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.ai-blog-link {
  text-decoration: none;
  color: inherit;
}

.ai-blog-title {
  font-size: 20px;
  font-weight: 500;
  color: #303133;
  margin-bottom: 15px;
}

.ai-blog-meta {
  display: flex;
  align-items: center;
  margin-bottom: 25px;
}

.ai-blog-author {
  font-size: 16px;
  color: #409EFF;
}

.ai-blog-time {
  color: #909399;
  font-size: 14px;
  margin-left: 20px;
}

.ai-blog-actions {
  display: flex;
  justify-content: flex-end;
  margin-top: 20px;
}

.ai-blog-actions .el-button {
  margin-left: 10px;
  padding: 8px 15px;
}

.ai-category-container {
  margin-top: 30px;
  margin-left: 20px;
}

.ai-category-card {
  border-radius: 12px;
  border: 1px solid rgba(64, 158, 255, 0.2);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.1);
  background: rgba(255, 255, 255, 0.9);
}

.ai-category-header {
  font-size: 18px;
  font-weight: 500;
  color: #409EFF;
  display: flex;
  align-items: center;
}

.ai-category-header i {
  margin-right: 10px;
  font-size: 20px;
}

.ai-tag-container {
  display: flex;
  flex-wrap: wrap;
}

.ai-category-tag {
  margin: 0 10px 10px 0;
  padding: 0 15px;
  height: 32px;
  line-height: 32px;
  font-size: 14px;
  border-radius: 16px;
  cursor: pointer;
  transition: all 0.3s;
  background: rgba(64, 158, 255, 0.1);
  border-color: rgba(64, 158, 255, 0.2);
  color: #409EFF;
}

.ai-category-tag:hover {
  background: rgba(64, 158, 255, 0.2);
  transform: translateY(-2px);
}

/* 热榜样式 */
.ai-hot-list {
  padding: 10px 0;
}

.ai-hot-item {
  display: flex;
  align-items: center;
  padding: 12px 15px;
  margin-bottom: 8px;
  border-radius: 8px;
  background-color: rgba(255, 255, 255, 0.9);
  cursor: pointer;
  transition: all 0.3s;
  border-left: 3px solid transparent;
}

.ai-hot-item:hover {
  background-color: rgba(64, 158, 255, 0.05);
  transform: translateX(5px);
  border-left-color: #409EFF;
  box-shadow: 0 2px 12px 0 rgba(64, 158, 255, 0.1);
}

.ai-hot-rank {
  width: 24px;
  height: 24px;
  line-height: 24px;
  text-align: center;
  border-radius: 4px;
  margin-right: 15px;
  font-size: 14px;
  font-weight: bold;
  color: #fff;
  background-color: #909399;
}

.ai-hot-rank-1 {
  background-color: #f56c6c;
}

.ai-hot-rank-2 {
  background-color: #e6a23c;
}

.ai-hot-rank-3 {
  background-color: #67c23a;
}

.ai-hot-content {
  flex: 1;
}

.ai-hot-title {
  font-size: 14px;
  color: #303133;
  margin-bottom: 5px;
  line-height: 1.5;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.ai-hot-meta {
  font-size: 12px;
  color: #909399;
}

.ai-hot-count {
  display: inline-flex;
  align-items: center;
}

.ai-hot-count i {
  margin-right: 3px;
  font-size: 14px;
}

.ai-loading-text {
  text-align: center;
  color: #409EFF;
  font-size: 16px;
  margin: 30px 0;
}

.ai-loading-text i {
  margin-right: 10px;
  animation: rotating 2s linear infinite;
}

@keyframes rotating {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>