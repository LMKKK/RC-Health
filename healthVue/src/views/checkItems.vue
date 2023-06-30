<template>
  <div style="padding: 10px">
    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button style="margin-left: 5px" @click="load">查询</el-button>
      <el-button type="primary" @click="add">新增</el-button>
    </div>
    <el-table v-loading="loading" :data="tableData" border stripe style="width: 100%">
      <el-table-column type="index" label="序号" sortable align="center">
      </el-table-column>
      <el-table-column prop="number" label="项目编码" align="center">
      </el-table-column>
      <el-table-column prop="name" label="项目名称" align="center">
      </el-table-column>
      <el-table-column prop="suitSex" label="适用性别" align="center">
      </el-table-column>
      <el-table-column prop="suitAge" label="适用年龄" align="center">
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button size="mini" @click="handleShow(scope.row)">详情</el-button>
          <el-button size="mini" type="primary" @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button size="mini" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
        :page-sizes="[5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>

    <el-dialog title="检查项信息" v-model="dialogVisible" style="width: 50%; margin: 0 auto 50px;">
      <el-form :disabled="!saveShow" :model="ruleForm" label-width="120px" :rules="rules" ref="ruleForm">
        <el-form-item label="检查项名称" prop="name">
          <el-input v-model="ruleForm.name"></el-input>
        </el-form-item>
        <el-form-item label="适用性别" prop="suitSex">
          <el-radio v-model="ruleForm.suitSex" label="男">男</el-radio>
          <el-radio v-model="ruleForm.suitSex" label="女">女</el-radio>
          <el-radio v-model="ruleForm.suitSex" label="不限">不限</el-radio>
        </el-form-item>
        <el-form-item label="适用年龄" prop="suitAge">
          <el-radio v-model="ruleForm.suitAge" label="0-100">0-100</el-radio>
        </el-form-item>

        <el-form-item label="说明">
          <el-input type="textarea" :rows="2" placeholder="请输入检查项说明" v-model="ruleForm.remark"></el-input>
        </el-form-item>


      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button v-show="saveShow" type="primary" @click="save('ruleForm')">确 定</el-button>
        </span>
      </template>
    </el-dialog>

    

  </div>
</template>

<script>

import E from 'wangeditor'
import request from "@/utils/request";

let editor;

export default {
  name: 'checkSetMeal',
  components: {},
  data() {
    return {
      loading: true,
      ruleForm: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      vis: false,
      detail: {},
      rules: {
        name: [{ required: true, message: '请输入套餐名称', trigger: 'blur' }],
        suitSex: [{ required: true, message: '请选择适用性别', trigger: 'blur' }],
        suitAge: [{ required: true, message: '请选择适用年龄', trigger: 'blur' }],
      },
      saveShow:true,
    }
  },
  created() {
    this.load()
  },
  methods: {
    handleShow(row) {
      //this.detail = row
      //this.vis = true
      this.ruleForm = JSON.parse(JSON.stringify(row))
      this.saveShow=false;
      this.dialogVisible = true
    },
    filesUploadSuccess(res) {
      console.log(res)
      this.form.cover = res.data
    },
    load() {
      this.loading = true
      request.get("/checkItems", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    add() {
      this.dialogVisible = true
      this.ruleForm = {}
      this.saveShow=true;


    },
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.ruleForm.id) {  // 更新
            request.post("/checkItems/update", this.ruleForm).then(res => {
              console.log(res)
              if (res.code === '0') {
                this.$message({
                  type: "success",
                  message: "更新成功"
                })
              } else {
                this.$message({
                  type: "error",
                  message: res.msg
                })
              }
              this.load() // 刷新表格的数据
              this.dialogVisible = false  // 关闭弹窗
            })
          } else {  // 新增
            let userStr = sessionStorage.getItem("user") || "{}"
            let user = JSON.parse(userStr)
            this.ruleForm.createPeople = user.nickName


            console.log("this.ruleForm::", this.ruleForm);
            //return;
            request.post("/checkItems", this.ruleForm).then(res => {
              console.log(res)
              if (res.code === '0') {
                this.$message({
                  type: "success",
                  message: "新增成功"
                })
              } else {
                this.$message({
                  type: "error",
                  message: res.msg
                })
              }

              this.load() // 刷新表格的数据
              this.dialogVisible = false  // 关闭弹窗
            })
          }
        } else {
          console.log('error submit!!');
          return false;
        }
      });



    },
    handleEdit(row) {
      this.ruleForm = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.saveShow=true;
      
    },
    handleDelete(row) {
      console.log(row)
      request.post("/checkItems/delete", row).then(res => {
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "删除成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  // 删除之后重新加载表格的数据
      })
    },
    handleSizeChange(pageSize) {   // 改变当前每页的个数触发
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {  // 改变当前页码触发
      this.currentPage = pageNum
      this.load()
    }
  }
}
</script>
