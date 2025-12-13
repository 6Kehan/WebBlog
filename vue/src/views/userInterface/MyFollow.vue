<template>
  <el-container class="ai-admin-container">
    <el-main class="ai-admin-main">
      <div class="ai-table-container">
        <el-table
            :data="tradingData.filter(data => !search || data.followUserName.toLowerCase().includes(search.toLowerCase()))"
            height="100%"
            :default-sort="{prop: 'createTime', order: 'descending'}"
            :header-cell-style='headerCellStyle'
            :cell-style='cellStyle'
            class="ai-data-table"
        >
          <el-table-column prop="id" label="ID" />
          <el-table-column prop="followUserId" label="用户ID" width="100"/>
          <el-table-column prop="followUserName" label="用户名"/>
          <el-table-column prop="createTime" label="关注时间" sortable/>
          <el-table-column align="right" label="操作" width="200" fixed="right">
            <template slot="header" slot-scope="scope">
              <el-input
                  v-model="search"
                  size="small"
                  placeholder="搜索内容"
                  class="ai-search-input">
              </el-input>
            </template>
            <template slot-scope="scope">
              <el-button
                  type="success"
                  icon="el-icon-s-promotion"
                  size="small"
                  class="ai-action-btn"
                  @click="message(scope.row)"
              >
                私信
              </el-button>
              <el-button
                  type="danger"
                  icon="el-icon-chat"
                  size="small"
                  class="ai-action-btn"
                  @click="del(scope.row.id)"
              >
                删除
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>
  </el-container>
</template>

<script>
// 保持script部分不变
export default {
  data() {
    return {
      fileList: [],
      dialogFormVisible:false,
      tradingForm: {
        images:''
      },
      search: '',
      tradingData: [],
      cellStyle: {
        'text-align': 'center',
        'padding': '8px 0'
      },
      headerCellStyle: {
        'background-color': '#f5f7fa',
        'color': '#409EFF',
        'font-weight': '500',
        'text-align': 'center'
      }
    }
  },mounted() {
    const elMain = document.querySelector('.el-main');
    if (elMain) {
      elMain.style.overflow = 'visible'; // 设置为 visible 或删除该样式
    }
  },
  methods: {
    message(row){
      this.$axios.post('http://localhost:8080/session/create', {
        user1Id: this.$store.getters.getUserId,
        user1Name: this.$store.getters.getUserName,
        user2Id: row.followUserId,
        user2Name: row.followUserName,
      }).then(resp => {
        if (resp.data.code == 200) {
          this.$message({
            type: 'success',
            message: "私信建立成功，快去我的私信进行聊天吧！"
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
    // 保持methods不变
    getRepairData() {
      this.$axios.post('http://localhost:8080/userFollow/getByUserId/'+this.$store.getters.getUserId).then(resp => {
        this.tradingData = resp.data.data
      })
    },
    del(id){
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        customClass: 'ai-confirm-dialog'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/userFollow/delete/' + id).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
            this.getRepairData();
          }
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    handleSearch() {
      // 搜索功能占位
    }
  },
  created() {
    this.getRepairData()
  }
}
</script>

<style scoped>
body .el-main {
  overflow: visible !important;
}
.ai-admin-container {
  min-height: 100vh;
  background-color: #f5f7fa;
}

.ai-admin-header {
  background-color: cadetblue;
  height: 60px;
  opacity: 0.7;
}
body .el-main {
  overflow: visible !important;
}
.ai-admin-main {
  padding: 20px;
  height: calc(100vh - 60px);
}

.ai-table-container {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  padding: 15px;
  height: 100%;
}

.ai-data-table {
  width: 100%;
  border-radius: 8px;
}

.ai-data-table::before {
  display: none;
}

.ai-search-input >>> .el-input__inner {
  border-radius: 20px;
  border-color: #dcdfe6;
  transition: all 0.3s;
}

.ai-search-input >>> .el-input__inner:focus {
  border-color: #409EFF;
  box-shadow: 0 0 0 2px rgba(64, 158, 255, 0.2);
}

.ai-action-btn {
  padding: 7px 12px;
  margin-left: 5px;
}
</style>

<style>
.ai-confirm-dialog {
  border-radius: 8px !important;
  border: 1px solid rgba(64, 158, 255, 0.2) !important;
}

.ai-confirm-dialog .el-message-box__header {
  border-bottom: 1px solid #ebeef5;
}

.ai-confirm-dialog .el-message-box__title {
  color: #409EFF;
}

.ai-confirm-dialog .el-message-box__content {
  padding: 20px 20px;
}
</style>