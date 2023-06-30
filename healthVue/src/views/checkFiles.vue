<template>
  <div style="padding: 10px">
    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入姓名进行查询" style="width: 20%" clearable></el-input>
      <el-button style="margin-left: 5px" @click="load" >查询</el-button>
      <el-button type="primary" @click="add" v-if="loginUser.roles[0] == 2">新增</el-button>
    </div>
    <el-table v-loading="loading" :data="tableData" border stripe style="width: 100%">

      <template #empty>
        <el-empty description="您还没有建立健康档案呦~~~" />
      </template>

      <el-table-column type="index" label="序号" sortable align="center">
      </el-table-column>
      <el-table-column prop="userName" label="姓名" align="center">
      </el-table-column>
      <el-table-column prop="age" label="年龄" align="center">
      </el-table-column>
      <el-table-column prop="sex" label="性别" align="center">
      </el-table-column>
      <el-table-column prop="cardNumber" label="身份证号" align="center">
      </el-table-column>
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button size="mini" @click="details(scope.row)">查看健康档案</el-button>
          <el-button size="mini" type="primary" @click="handleEdit(scope.row)"
            v-if="loginUser.roles[0] == 2">编辑</el-button>
          <!-- <el-popconfirm title="确定删除吗？" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button size="mini" type="danger">删除</el-button>
            </template>
          </el-popconfirm> -->
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
        :page-sizes="[5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>

    <el-dialog title="健康档案信息" v-model="dialogVisible" style="width: 50%; margin: 0 auto 50px;">
      <el-form :disabled="formDisabled" :model="ruleForm" label-width="120px" :rules="rules" ref="formRef">
        <el-form-item label="姓名">
          <el-input v-model="ruleForm.userName" style="width: 15%;"></el-input>
          <label style="margin-left: 3%;">年龄：</label>
          <el-input v-model="ruleForm.age" style="width: 6%;"></el-input>&nbsp;&nbsp;<span>岁</span>
          <label style="margin-left: 3%;">性别：</label>
          <el-radio style="width: 7%;" v-model="ruleForm.sex" label="男">男</el-radio>
          <el-radio style="width: 7%;" v-model="ruleForm.sex" label="女">女</el-radio>
        </el-form-item>

        <el-form-item label="联系方式" prop="phone">
          <el-input v-model="ruleForm.phone" style="width: 25%;"></el-input>
        </el-form-item>
        <el-form-item label="身份证号码" prop="cardNumber">
          <el-input v-model="ruleForm.cardNumber" style="width: 45%;"></el-input>
        </el-form-item>

        <el-form-item label="血型">
          <el-select v-model="ruleForm.bloodType" style="width: 18%;" placeholder="请选择">
            <el-option label="A型" value="A" />
            <el-option label="B型" value="B" />
            <el-option label="O型" value="O" />
            <el-option label="AB型" value="AB" />
            <el-option label="RH型" value="RH" />
          </el-select>
        </el-form-item>

        <el-form-item label="身高">
          <el-input v-model="ruleForm.height" style="width: 10%;"></el-input>&nbsp;&nbsp;<span>cm</span>
          <label style="margin-left: 3%;">体重：</label>
          <el-input v-model="ruleForm.weight" style="width: 10%;"></el-input>&nbsp;&nbsp;<span>kg</span>
        </el-form-item>

        <el-form-item label="既往病史">
          <el-input type="textarea" :rows="3" placeholder="请输入既往病史" v-model="ruleForm.medicalHistory"></el-input>
        </el-form-item>

        <el-form-item label="补充说明">
          <el-input type="textarea" :rows="2" placeholder="补充信息" v-model="ruleForm.remark"></el-input>
        </el-form-item>


      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisibleClose">取 消</el-button>
          <el-button v-show="!formDisabled" type="primary" @click="save('formRef')">确 定</el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog title="详情" v-model="vis" width="50%">
      <el-card>
        <div v-html="detail.content" style="min-height: 100px"></div>
      </el-card>
    </el-dialog>

  </div>
</template>

<script>

import request from "@/utils/request";

export default {
  name: 'checkFiles',
  components: {},
  data() {

    // 自定义校验规则
    // 手机号校验
    let checkPhone = (rule, value, callback) => {
      // 校验不通过
      if (!/^1[3|4|5|7|8][0-9]{9}$/.test(value)) {
        return callback(new Error('请检查手机号是否正确'));
      }
      // 校验通过
      return callback()
    }

    // 身份证校验
    let checkCardNumber = (rule, value, callback) => {
      if( !/^([1-6][1-9]|50)\d{4}(18|19|20)\d{2}((0[1-9])|10|11|12)(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/.test(value)){
        // 校验不通过
        return callback(new Error('请输入正确格式的身份证号'))
      }
      // 校验通过
      return callback()
    }
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
      loginUser: {},
      formDisabled: false,
      rules: {
        phone: [
          { required: true, message: '请输入电话号', trigger: 'blur' },
          { validator: checkPhone, trigger: 'blur' }
        ],
        cardNumber: [
          { required: true, message: '请输入身份证号', trigger: 'blur' },
          { validator: checkCardNumber, trigger: 'blur' }
        ]

      }
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    this.loginUser = JSON.parse(userStr)
    console.log("当前登陆者信息：", this.loginUser);
    this.load()
  },
  methods: {
    details(row) {
      this.ruleForm = row
      // this.detail.userName=this.loginUser.nickName;
      // this.detail.userId=this.loginUser.id;
      // this.detail.sex=this.loginUser.sex;
      // this.detail.age=this.loginUser.age;
      this.dialogVisible = true;
      this.formDisabled = true;
    },
    dialogVisibleClose(res) {
      this.dialogVisible = false;
      this.load();
    },
    load() {
      this.loading = true
      let params = {
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        search: this.search
      };
      if (this.loginUser.roles[0] == 2) {
        params.userId = this.loginUser.id;
      }
      console.log("params：：", params);
      request.get("/checkFiles", {
        params: params
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total
      })
    },
    add() {
      this.dialogVisible = true
      this.formDisabled = false
      this.ruleForm = {}
      this.ruleForm.userName = this.loginUser.nickName;
      this.ruleForm.userId = this.loginUser.id;
      this.ruleForm.sex = this.loginUser.sex;
      this.ruleForm.age = this.loginUser.age;
    },
    save(formName) {
      console.log('表单引用名称是', formName)
      console.log('点击了保存按钮')
      console.log('表单数据',this.ruleForm)
      console.log('ref引用对象',this.$refs[formName])
      // 触发统一的校验
      this.$refs[formName].validate((valid) => {
        console.log('正在统一校验')
        console.log('校验结果',valid)
        if (valid) {
          console.log('校验通过，可以提交了')
          if (this.ruleForm.id) {  // 更新
            this.ruleForm.address = this.loginUser.address

            console.log('修改健康档案', this.ruleForm)
            request.put("/checkFiles", this.ruleForm).then(res => {
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
            this.ruleForm.address = this.loginUser.address

            console.log('你要新增健康档案')
            console.log("this.ruleForm::", this.ruleForm);
            //return;
            request.post("/checkFiles", this.ruleForm).then(res => {
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
      // 显示模态框
      this.dialogVisible = true
      // 表单解禁
      this.formDisabled = false
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/checkItems/" + id).then(res => {
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
