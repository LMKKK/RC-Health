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
      <el-table-column prop="number" label="检查套餐编码" align="center">
      </el-table-column>
      <el-table-column prop="name" label="检查套餐名称" align="center">
      </el-table-column>
      <el-table-column prop="suitSex" label="适用性别" align="center">
      </el-table-column>
      <el-table-column prop="mnemonicCode" label="助记码" align="center">
      </el-table-column>
      <el-table-column label="操作" align="center" width="200">
        <template #default="scope">
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

    <el-dialog title="检查套餐信息" v-model="dialogVisible" style="width: 50%; margin: 0 auto 50px;">

      <el-tabs type="border-card">
        <el-tab-pane label="基本信息">
          <el-form :model="ruleForm" label-width="120px" :rules="rules" ref="ruleForm">
            <el-form-item label="检查套餐名称" prop="name">
              <el-input v-model="ruleForm.name"></el-input>
            </el-form-item>
            <el-form-item label="适用性别" prop="suitSex">
              <el-radio v-model="ruleForm.suitSex" label="男">男</el-radio>
              <el-radio v-model="ruleForm.suitSex" label="女">女</el-radio>
              <el-radio v-model="ruleForm.suitSex" label="不限">不限</el-radio>
            </el-form-item>

            <el-form-item label="助记码" prop="mnemonicCode">
              <el-input v-model="ruleForm.mnemonicCode"></el-input>
            </el-form-item>

            <el-form-item label="说明">
              <el-input type="textarea" :rows="2" placeholder="请输入检查套餐说明" v-model="ruleForm.remark"></el-input>
            </el-form-item>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="检查组信息">
          <el-table ref="multipleTable" :data="checkGroupsData" tooltip-effect="dark" style="width: 100%"
            @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center">
            </el-table-column>
            <el-table-column align="center" prop="number" label="检查组编号" width="160">

            </el-table-column>
            <el-table-column align="center" prop="name" label="检查组名称" width="180">
            </el-table-column>
            <el-table-column align="center" prop="remark" label="说明" show-overflow-tooltip>
            </el-table-column>
          </el-table>

        </el-tab-pane>

      </el-tabs>


      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="save('ruleForm')">确 定</el-button>
        </span>
      </template>
    </el-dialog>



  </div>
</template>

<script>

import request from "@/utils/request";

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
        mnemonicCode: [{ required: true, message: '请输入助记码', trigger: 'blur' }],
      },
      multipleSelection: [],
      checkGroupsData: [],
    }
  },
  created() {
    this.load()
  },
  methods: {
    filesUploadSuccess(res) {
      console.log(res)
      this.ruleForm.cover = res.data
    },
    load() {
      this.loading = true
      request.get("/checkSetMeal", {
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

      request.post("/checkGroup/getCheckGroupList", this.ruleForm).then(res => {
        console.log(res)
        this.checkGroupsData = res.data;
        console.log('所有的检查组信息', this.checkGroupsData)
      })


    },
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.ruleForm.id) {  // 更新
            console.log('这是套餐的更新操作')
            let selectData = JSON.parse(JSON.stringify(this.multipleSelection));
            // console.log("选中的检查组的id值：：", selectData);
            let groupIds = [];
            selectData.forEach(element => {
              groupIds.push(element.id);
            });
            console.log('选中的检查组的id值是', groupIds)
            this.ruleForm.groupIds = groupIds.toString();

            let params = JSON.parse(JSON.stringify(this.ruleForm));
            console.log("提交的参数信息：：", params);
            //return;
            request.post("/checkSetMeal/update", params).then(res => {
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
            console.log('这是套餐的新增操作')
            let userStr = sessionStorage.getItem("user") || "{}"
            // 获取用户信息
            let user = JSON.parse(userStr)
            // 设置 创建套餐的用户名称，就是谁创建的这个套餐
            this.ruleForm.createPeople = user.nickName

            let selectData = JSON.parse(JSON.stringify(this.multipleSelection));
            // console.log("选中的检查组的id值：：", selectData);
            let groupIds = [];
            selectData.forEach(element => {
              groupIds.push(element.id);
            });
            console.log('选中的检查组的id值是', groupIds)
            this.ruleForm.groupIds = groupIds.toString();

            let params = JSON.parse(JSON.stringify(this.ruleForm));
            console.log("提交的参数信息：：", params);

            //return;
            request.post("/checkSetMeal", params).then(res => {
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

      if (row.id == 0) {
        this.$message({
          type: "warning",
          message: '不可以对自定义套餐编辑'
        })
        this.$message({
          type: "warning",
          message: '自定义套餐应该由用户选择'
        })
        return
      }
      console.log("row::", row);
      this.ruleForm = JSON.parse(JSON.stringify(row));
      console.log("this.ruleForm::", this.ruleForm);
      this.dialogVisible = true
      request.post("/checkGroup/getCheckGroupList", this.ruleForm).then(res => {
        console.log(res)
        this.checkGroupsData = res.data;
        console.log('所有的检查组信息', this.checkGroupsData)
        let formData = JSON.parse(JSON.stringify(row));

        // 渲染选中效果
        this.$nextTick(() => {
          if (formData.groupIds) {
            // 获取该套餐的检查组id
            let ids = formData.groupIds.split(',');
            console.log("ids：：", ids)

            this.checkGroupsData.forEach((elemet, idx) => {
              const elemetData = JSON.parse(JSON.stringify(elemet));
              console.log("表格数据elemetData：：", elemetData)
              ids.forEach(id => {
                if (id == elemetData.id) {
                  console.log('初始化选中', elemetData)
                  this.$refs.multipleTable.toggleRowSelection(this.checkGroupsData[idx], true)
                }
              });
            });
          }
        });



      })


    },
    handleDelete(row) {
      console.log(row)
      request.post("/checkSetMeal/delete", row).then(res => {
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
    },
    toggleSelection(rows) {
      console.log(rows);
      if (rows) {
        rows.forEach(row => {
          this.$refs.multipleTable.toggleRowSelection(row);
        });
      } else {
        this.$refs.multipleTable.clearSelection();
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    }
  }
}
</script>
