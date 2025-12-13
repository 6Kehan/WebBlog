<template>
  <el-container>
    <el-header style="background-color: whitesmoke">
<!--      <div style="float: left">-->
<!--        <el-button type="primary" @click="createDialog()">新增</el-button>-->
<!--      </div>-->
      <div style="float: right">
        <el-input v-model="search" placeholder="请输入内容">
          <el-button slot="append" icon="el-icon-search" @click="select"></el-button>
        </el-input>
      </div>
    </el-header>
    <el-table
        :data="data"
        height="550"
        :header-cell-style='cellStyle'
        :cell-style='cellStyle'
    >
      <el-table-column prop="id" label="id" min-width="10%" sortable>
      </el-table-column>
      <el-table-column prop="userId" label="用户ID" min-width="10%" >
      </el-table-column>
      <el-table-column prop="username" label="用户名" min-width="10%" >
      </el-table-column>
      <el-table-column prop="blogId" label="文章ID" min-width="10%" >
      </el-table-column>
      <el-table-column prop="content" label="评论内容" min-width="10%" >
      </el-table-column>
      <el-table-column align="right" label="操作" min-width="10%" fixed="right">
        <template slot-scope="scope">
          <el-button-group>
<!--            <el-button type="info" icon="el-icon-info" @click="updateDialog(scope.row)" plain>编辑</el-button>-->
            <el-button type="danger" icon="el-icon-delete-solid" @click="deleteUser(scope.row.id)"
                       plain></el-button>
          </el-button-group>
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
      data: [],
      type: {},
      dialogFormVisible: false,
      formLabelWidth: '60px',
      cellStyle:{
        'text-align':'center'
      }
    }
  },
  created: function () {
    this.getUsers()
  },
  methods: {
    filterTag(value, row) {
      return row.role === value;
    },
    getUsers(){
      this.$axios.post('http://localhost:8080/comment/list').then(resp => {
        this.data = resp.data.data
      })
    },
    select() {
      this.$axios.post('http://localhost:8080/comment/select?element='+this.search).then(resp => {
        if (resp.data.code == 200) {
          this.data = resp.data.data
          console.log(this.data)
        }
      })
    },
    deleteUser(id) {
      this.$confirm('此操作将永久删除, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$axios.delete('http://localhost:8080/comment/delete/' + id).then(resp => {
          if (resp.data.code == 200) {
            this.$message({
              type: 'success',
              message: '删除成功!'
            });
            this.$router.go(0);
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

