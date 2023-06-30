<template>
  <div style="padding: 10px">
    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button style="margin-left: 5px" @click="load">查询</el-button>

    </div>
    <el-table v-loading="loading" :data="tableData" border stripe style="width: 100%">

      <template #empty>
        <el-empty description="您还没有预约体检呦~~~" />
      </template>

      <el-table-column type="index" label="序号" sortable align="center">
      </el-table-column>
      <el-table-column prop="appointmentPeople" label="预约人" align="center">
      </el-table-column>
      <el-table-column 
      prop="appointmentTime" 
      label="预约时间" 
      align="center"
      :filters="filterDate"
      :filter-method="filterHandler"
      >
      </el-table-column>
      <el-table-column prop="mealName" label="所选套餐" align="center">
      </el-table-column>
      <el-table-column prop="remark" label="说明" align="center">
      </el-table-column>

      <el-table-column label="操作" align="center" width="350">
        <template #default="scope">
          <el-button v-if="loginUser.roles[0] == 3" size="mini" type="primary"
            @click="handleEdit(scope.row)">录入/修改</el-button>
          <el-button size="mini" @click="viewReport(scope.row)">查看体检报告</el-button>
          <el-button size="mini" type="primary" @click="handlePrint(scope.row)">打印</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
        :page-sizes="[5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>

    <el-dialog title="每项体检信息" v-model="dialogVisible" style="width: 50%; margin: 0 auto 50px; top: 10vh;">

      <el-form :model="ruleForm" label-width="120px" :rules="rules" ref="ruleForm">
        <el-form-item label="体检套餐" prop="appointmentTime">
          <el-input disabled v-model="ruleForm.mealName" style="width: 40%;"></el-input>
          <label style="margin-left: 3%;">体检人：</label>
          <el-input disabled v-model="ruleForm.appointmentPeople" style="width: 40%;"></el-input>
        </el-form-item>
        <div v-for="(item, index) in itemsListData" :key="index">
          <el-form-item label="体检组" prop="groupName">
            <el-input disabled v-model="item.groupName" style="width: 30%;"></el-input>
            <label style="margin-left: 3%;">体检项：</label>
            <el-input disabled v-model="item.itemName" style="width: 20%;"></el-input>
            <label style="margin-left: 3%;">数值：</label>
            <el-input :disabled="!saveShow" v-model="item.itemValue" style="width: 20%;"></el-input>
          </el-form-item>
        </div>
      </el-form>

      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button v-show="saveShow" type="primary" @click="save('ruleForm')">确 定</el-button>
        </span>
      </template>
    </el-dialog>

    <el-dialog title.sync="title" width="1000px" :close-on-click-modal="false" :close-on-press-escape="false"
      @close="close" top="10vh" v-model="reportVisible">
      <el-form :model="reportObj" v-loading="loading" :rules="rules" ref="reportObj" label-suffix="" class="demo-ruleForm"
        label-width="160px" size="small" style="width: 100%">
        <div id="content">
          <div class="tableIndex">
            <h2>{{ reportObj.tableName }}</h2>
            <br />
            <table border="1" id="table">
              <tr>
                <th colspan="8">
                  <h3>用户体检报告</h3>
                </th>
              </tr>
              <tr>
                <th width="10%">用户姓名</th>
                <td colspan="2">{{ reportObj.userName }}</td>
                <th width="10%">性别</th>
                <td colspan="1"> {{ reportObj.sex }}</td>
                <th width="10%">年龄</th>
                <td colspan="3"> {{ reportObj.age }}</td>
              </tr>
              <tr>
                <th width="10%">检查时间</th>
                <td colspan="2">{{ reportObj.appointmentTime }}</td>
                <th width="10%">所选套餐</th>
                <td colspan="4"> {{ reportObj.mealName }}</td>

              </tr>

              <tr v-for="(checkGroup) in tableDataList" :key="checkGroup">
                <td colspan="100%">
                  <table class="childTable" border="1">
                    <tr>
                      <td width="25%">检查组名称</td>
                      <td width="25%">{{ checkGroup.groupName }}</td>
                      <td width="25%">负责医生</td>
                      <td width="25%">{{ checkGroup.docterName }}</td>
                    </tr>

                    <tr>
                      <th colspan="1">序号</th>
                      <th colspan="2">检查项</th>
                      <th colspan="6">检查结果</th>
                    </tr>
                    <tr id="list" v-for="(item, index) in checkGroup.itemsData" :key="item.id">
                      <td colspan="1">{{ index + 1 }}</td>
                      <td colspan="2">{{ item.itemName }}</td>
                      <td colspan="6">{{ item.itemValue }}</td>
                    </tr>
                  </table>
                </td>
              </tr>

            </table>
          </div>
        </div>
      </el-form>

    </el-dialog>



  </div>
</template>

<script>
import request from "@/utils/request";
import axios from "axios";
import moment from "moment"

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
        // appointmentTime: [{ required: true, message: '请选择预约体检时间', trigger: 'blur' }],
        // mealId: [{ required: true, message: '请选择体检套餐', trigger: 'blur' }],
      },
      multipleSelection: [],
      itemsListData: [],
      mealOptions: [],
      loginUser: {},
      saveShow: true,
      reportObj: {},
      tableDataList: [],
      reportVisible: false,
      filterDate:[]
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    this.loginUser = JSON.parse(userStr)
    console.log("当前登陆者信息：", this.loginUser);
    this.load();

  },
  methods: {

    filesUploadSuccess(res) {
      console.log(res)
      this.ruleForm.cover = res.data
    },
    load() {
      this.loading = true;
      let params = {
        pageNum: this.currentPage,
        pageSize: this.pageSize,
        search: this.search
      };
      if (this.loginUser.roles[0] == 2) {
        params.userId = this.loginUser.id;
      }
      request.get("/appointment", {
        params: params
      }).then(res => {
        this.loading = false
        this.tableData = res.data.records
        this.total = res.data.total

        this.filterDate = []
        // 统计所有的日期
        this.tableData.forEach(row => {
          let flag = false
          this.filterDate.forEach(date => {
            if(date.value === row.appointmentTime){
              flag = true
            }
          })

          if(!flag){
            this.filterDate.push({
              value: row.appointmentTime,
              text: row.appointmentTime
            })
          }

        })
      })

      
    },
    add() {
      this.dialogVisible = true
      this.ruleForm = {}
    },
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.ruleForm.id) {  // 更新
            let params = JSON.parse(JSON.stringify(this.ruleForm));
            params.checkItemsListData = this.itemsListData;
            console.log("this.itemsListData::", this.itemsListData);
            console.log("提交的参数信息：：", params);
            params.createPeople = this.loginUser.nickName
            params.createTime = moment().format('YYYY-MM-DD HH:mm:ss')
            //return;
            request.post("/checkItemsData/batchSaveCheckItemsData", params).then(res => {
              console.log(res)
              if (res.code === '0') {
                this.$message({
                  type: "success",
                  message: "操作成功"
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
      console.log('医生录入体检项数据')
      // 首先判断是否可以继续操作：只能操作此日的预约
      let now = moment(moment().format('YYYY-MM-DD'))

      if(moment('2023-06-28') == now){
        console.log('对了，就是今天')
      }
      let appointmentDate = moment(row.appointmentTime)
      if(now > appointmentDate){
        this.$message({
          type: "warning",
          message: "此人体检日期已过，不可以继续修改体检数据"
        })
        return
      }else if(now < appointmentDate){
        this.$message({
          type: "warning",
          message: "用户体检日期不是今天呦，不可以操作"
        })
        return
      }

      console.log()
      this.saveShow = true;
      this.ruleForm = JSON.parse(JSON.stringify(row));
      this.ruleForm.dutyDoctorId = this.loginUser.id;
      this.ruleForm.appointmentId = row.id;

      console.log("this.ruleForm::", this.ruleForm);
      this.dialogVisible = true
      request.post("/checkItemsData/getItemsListByPre", this.ruleForm).then(res => {
        console.log(res)
        //return
        this.itemsListData = res.data;
      })
    },
    handleShow(row) {
      this.saveShow = false;
      console.log("row::", row);
      this.ruleForm = JSON.parse(JSON.stringify(row));
      this.ruleForm.dutyDoctorId = this.loginUser.id;
      this.ruleForm.appointmentId = row.id;

      console.log("this.ruleForm::", this.ruleForm);
      this.dialogVisible = true
      request.post("/checkItemsData/getItemsListByPre", this.ruleForm).then(res => {
        console.log(res)
        //return
        this.itemsListData = res.data;
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
    },
    viewReport(row) {
      console.log("报告信息：：", row);
      //this.reportObj=row;
      request.post("/checkItemsData/getCheckReportByUser", row).then(res => {

        console.log('体检报告数据', res)
        //return
        //this.itemsListData = res.data;
        if (res.data.user) {
          this.reportObj.userName = res.data.user.nickName;
          this.reportObj.sex = res.data.user.sex;
          this.reportObj.age = res.data.user.age;
        }
        this.reportObj.appointmentTime = row.appointmentTime;
        this.reportObj.mealName = row.mealName;
        this.tableDataList = res.data.resMap;
        this.reportVisible = true;
      })
    },
    handlePrint(row) {
      console.log("待打印的人的预约体检信息是：：", row);
      // 加载遮罩层,文件下载遮罩层
      const loading = this.$loading({
        lock: true,
        text: '您的体检报告正在打印中,请稍候....',
        // spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.7)'
      });

      // 文件下载行为是浏览器的，所以要通过location对象触发浏览器的下载事件
      location.href = "http://" + window.server.filesUploadUrl + ":9090/checkItemsData/export?appointmentId=" + row.id;

      setTimeout(() => {
        // 关闭加载层
        loading.close()
        this.$message({
          type: "success",
          message: "体检报告打印完成，请注意查收...."
        })
      }, 3500)

      axios.get()
    },
    // 日期过滤
    filterHandler(value,row,column){
      return value === row.appointmentTime
    }
  }
}
</script>
<style type="text/css" scoped>
.childTable {
  width: 100%;
  border-collapse: collapse;
  border-spacing: 10px 20px;
  caption-side: bottom;
  margin: 0 auto;
  padding: 0;
  table-layout: auto;
}

#content {
  margin: 0 auto;
  padding: 0;
  text-align: center;
  width: 100%;
  color: black;
}

.tableIndex {
  width: 100%;
  margin: 0 auto;
  padding: 0;
}

#table {
  width: 90%;
  border-collapse: collapse;
  border-spacing: 10px 20px;
  caption-side: bottom;
  margin: 0 auto;
  padding: 0;
  table-layout: auto;
}

#biaozhu {
  text-decoration: none;
  width: 1000px;
  height: 10.4px;
  float: right;
  text-align: left;
  margin: 0px;
}

#biaozhu ul {
  padding-left: 40px;
  margin-top: 5px;
}

#biaozhu ul li {
  list-style: none;
  width: 240px;
  float: left;
  line-height: 10.4px;
}

table tr td {
  height: 30px;
  line-height: 30px;
}
</style>
