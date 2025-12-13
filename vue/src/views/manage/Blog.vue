<template>
  <el-container>
    <el-header style="background-color: whitesmoke">

    </el-header>
    <el-table
        :data="tradingData.filter(data => !search || data.content.toLowerCase().includes(search.toLowerCase()))"
        height="100%"
        :default-sort="{prop: 'createTime', order: 'descending'}"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'>
      <el-table-column prop="id" label="ID" width="80px"/>
      <el-table-column prop="title" label="标题" width="100px"/>
      <el-table-column label="图片/视频" width="200px">
        <template slot-scope="scope">
          <!-- 1. 如果有图片，循环展示所有图片 -->
          <template v-if="scope.row.imagesList?.length > 0">
            <img
                v-for="(img, index) in scope.row.imagesList"
                :key="'img-' + index"
                :src="img"
                style="max-width: 50px; max-height: 100px; margin-right: 5px;"
            >
          </template>

          <!-- 2. 如果没有图片但有视频，展示视频（图标或封面） -->
          <template v-else-if="scope.row.videosList?.length > 0">

              <!-- 方式1：显示视频封面（如果有） -->
              <video
                  :src="scope.row.videosList[0]"
                  style="max-width: 50px; max-height: 100px;"
              ></video>

          </template>

          <!-- 3. 如果既没有图片也没有视频 -->
          <span v-else>无内容</span>
        </template>
      </el-table-column>
      <el-table-column prop="content" label="内容"  :show-overflow-tooltip="true"/>
      <el-table-column prop="userId" label="发布人ID" width="100px"/>
      <el-table-column prop="username" label="发布人名称" width="100px"/>
      <el-table-column prop="createTime" label="发布时间" width="100px" sortable/>
      <el-table-column align="right" label="操作" width="200px" fixed="right">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入内容关键字">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </template>
        <template slot-scope="scope">
            <el-button type="danger" icon="el-icon-chat" plain @click="del(scope.row.id)">删除
            </el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-container>
</template>

<script>
export default {
  data() {
    return {
      search: '',
      tradingData: [],
      replyFeedback:{},
      cellStyle: {
        'text-align': 'center'
      },
      dialogFormVisible: false
    }
  },
  created: function () {
    this.getFeedbacks()
  },
  methods: {
    filterTag(value, row) {
      return row.type === value;
    },
    getFeedbacks() {
      this.$axios.post('http://localhost:8080/trading/getTrading').then(resp => {
        this.tradingData = resp.data.data
      })
    },del(id){
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/trading/delete/' + id).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
             this.getFeedbacks();
          }
        })

      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    }
  }
}
</script>

<style>
</style>
