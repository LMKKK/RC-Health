<template>
  <div style="padding: 10px">
    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button style="margin-left: 5px" @click="load">查询</el-button>
      <el-button type="primary" @click="add">我要预约</el-button>
    </div>
    <el-table v-loading="loading" :data="tableData" border stripe style="width: 100%">

      <template #empty>
        <el-empty description="您还没有预约呦呦~~~" />
      </template>

      <el-table-column type="index" label="序号" sortable align="center">
      </el-table-column>
      <el-table-column prop="appointmentPeople" label="预约人" align="center">
      </el-table-column>
      <el-table-column prop="appointmentTime" label="预约时间" align="center">
      </el-table-column>
      <el-table-column prop="mealName" label="所选套餐" align="center">
      </el-table-column>
      <el-table-column prop="remark" label="说明" align="center">
      </el-table-column>

      <el-table-column label="操作" align="center" width="200">
        <template #default="scope">
          <el-button size="mini" type="primary" @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="handleDelete(scope.row)">
            <template #reference>
              <el-button size="mini" type="danger">取消</el-button>
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

    <el-dialog title="预约信息" v-model="dialogVisible" style="width: 50%; margin: 10% auto 50px;">

      <el-form :model="ruleForm" label-width="120px" :rules="rules" ref="ruleForm">
        <el-form-item label="预约体检时间" prop="appointmentTime">
          <el-date-picker v-model="ruleForm.appointmentTime" type="date" placeholder="请选择预约体检时间" @change="timeChange" />
        </el-form-item>
        <el-form-item label="体检套餐" prop="mealId">
          <el-select v-model="ruleForm.mealId" clearable placeholder="请选择体检套餐" @change="onMealChange">
            <el-option v-for="item in mealOptions" :key="item.id" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>

        <el-form-item label="检查项目有:">
          <el-table 
          ref="multipleTable"
          :data="groupsInMeal" 
          style="width: 100%" 
          @selection-change="handleSelectionChange">
            <template #empty>
              <el-empty description="你还没有选择套餐呦~~" :image-size="80" />
            </template>
            <el-table-column v-if="ruleForm.mealId === 0" type="selection" width="55" align="center">
            </el-table-column>
            <el-table-column prop="name" label="检查组" width="180" />
            <el-table-column prop="remark" label="说明" width="180" />
          </el-table>
        </el-form-item>

        <el-form-item label="说明">
          <el-input type="textarea" :rows="2" placeholder="请输入补充信息" v-model="ruleForm.remark"></el-input>
        </el-form-item>
      </el-form>


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
import moment from "moment"

export default {
  name: 'appointmentUser',
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
        appointmentTime: [{ required: true, message: '请选择预约体检时间', trigger: 'blur' }],
        mealId: [{ required: true, message: '请选择体检套餐', trigger: 'blur' }],
      },
      multipleSelection: [],
      checkItemsData: [],
      mealOptions: [],
      loginUser: {},
      groupsInMeal: [],
      checkGroupsData: []

    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    this.loginUser = JSON.parse(userStr)
    this.load();
    this.getMealList();
  },
  methods: {
    filesUploadSuccess(res) {
      console.log(res)
      this.ruleForm.cover = res.data
    },
    load() {
      this.loading = true
      request.get("/appointment", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search,
          userId: this.loginUser.id
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

    },
    save(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          if (this.ruleForm.id) {  // 更新
            this.mealOptions.forEach(element => {
              if (this.ruleForm.mealId == element.id) {
                this.ruleForm.mealName = element.name;
              }
            });
            console.log(this.ruleForm);

            // 特判是否是自定义套餐
            if (this.ruleForm.mealId === 0) {
              console.log('你选择的套餐是自定义')
              console.log('你选择的检查组有', this.multipleSelection)
              // 获取所有选择的检查组的id
              let selectData = JSON.parse(JSON.stringify(this.multipleSelection));
              // console.log("选中的检查组的id值：：", selectData);
              let groupIds = [];
              selectData.forEach(element => {
                groupIds.push(element.id);
              });

              console.log('选中的检查组的id值是', groupIds)
              this.ruleForm.groupIds = groupIds.toString();
              console.log('要提交的检查组id有',this.ruleForm.groupIds)
            }


            //return
            request.put("/appointment", this.ruleForm).then(res => {
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


            // 初始化预约基本信息
            let userStr = sessionStorage.getItem("user") || "{}"
            let user = JSON.parse(userStr)
            this.mealOptions.forEach(element => {
              if (this.ruleForm.mealId == element.id) {
                this.ruleForm.mealName = element.name;
              }
            });
            this.ruleForm.createPeople = user.nickName;
            this.ruleForm.appointmentPeople = user.nickName
            // 格式化日期，因为 日期选择框的值是Date对象，需要格式化为字符串
            this.ruleForm.appointmentTime = moment(this.ruleForm.appointmentTime).format('YYYY-MM-DD HH:mm:ss');
            this.ruleForm.appointmentPeopleId = user.id;

            // 特判是否是自定义套餐
            if (this.ruleForm.mealId === 0) {
              console.log('你选择的套餐是自定义')
              console.log('你选择的检查组有', this.multipleSelection)
              // 获取所有选择的检查组的id
              let selectData = JSON.parse(JSON.stringify(this.multipleSelection));
              // console.log("选中的检查组的id值：：", selectData);
              let groupIds = [];
              selectData.forEach(element => {
                groupIds.push(element.id);
              });

              console.log('选中的检查组的id值是', groupIds)
              this.ruleForm.groupIds = groupIds.toString();
              console.log('要提交的检查组id有',this.ruleForm.groupIds)
            }

            console.log("this.ruleForm::", this.ruleForm);
            // return;
            request.post("/appointment", this.ruleForm).then(res => {
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
      //console.log("row::", row);
      let now = moment(moment().format('YYYY-MM-DD'))
      if(moment(row.appointmentTime) < now ){
        this.$message({
            type: "warning",
            message: "体检时间已过，不可以编辑了呦~~~"
          })
          return 
      }
      this.dialogVisible = true
      this.onMealChange()
      this.ruleForm = JSON.parse(JSON.stringify(row));
      // 如果是自定义套餐，那么检查组需要回显勾选
      if(this.ruleForm.mealId === 0){
        console.log('勾选回显')
        let formData = JSON.parse(JSON.stringify(row));
        // 渲染选中效果
        this.$nextTick(() => {
            if (formData.groupIds) {
              // 获取该套餐的检查组id
              let ids = formData.groupIds.split(',');
              console.log("ids：：", ids)

              this.groupsInMeal.forEach((elemet,idx) => {
                const elemetData = JSON.parse(JSON.stringify(elemet));
                console.log("表格数据elemetData：：", elemetData)
                ids.forEach(id => {
                  if (id == elemetData.id) {
                    console.log('初始化选中', elemetData)
                    this.$refs.multipleTable.toggleRowSelection(this.groupsInMeal[idx], true)
                  }
                });
              });
            }
        });

      }
      
    },
    handleDelete(row) {
      console.log(row)
      let now = moment(moment().format('YYYY-MM-DD'))
      if(moment(row.appointmentTime) < now ){
        this.$message({
            type: "warning",
            message: "体检时间已过，不可以取消了呦~~~"
          })
          return 
      }

      row.isDel = 1;
      request.put("/appointment", row).then(res => {
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
    },
    getMealList() {
      request.post("/checkSetMeal/getMealList", {}).then(res => {
        console.log(res)
        res.data.forEach(element => {
          element.label = element.name;
          element.value = element.id;
        });
        this.mealOptions = res.data;
        console.log("新的下拉选信息：：", this.mealOptions);
      })
    },
    timeChange() {
      console.log('用户选择时间', this.ruleForm.appointmentTime);
      // 用户预约时间校验
      // 1. 选择的时间必须是今天及以后的
      // 2. 如果1 成立，那么向服务器发送请求，查看当天预约是否已满

      let now = moment(moment().format('YYYY-MM-DD'))
      if (moment(this.ruleForm.appointmentTime) < now) {
        this.$message({ type: "error", message: '预约时间必须是今日或将来的日期' })
        this.ruleForm.appointmentTime = null
        return
      }

      let params = { appointmentDay: moment(this.ruleForm.appointmentTime).format('YYYY-MM-DD') };
      console.log("校验时的时间参数：：", params);

      request.post("/appointment/validateCount", params).then(res => {
        console.log(res)
        if (res.code == 0) {
          this.$message({ type: "success", message: res.data })
        } else {
          this.ruleForm.appointmentTime = null
          this.$message({ type: "error", message: res.msg })
        }
      })
    },
    onMealChange() {

      if (this.ruleForm.mealId === 0) {
        console.log('你选择了自定义套餐')

        // 获取所有的检查组
        request.post("/checkGroup/getCheckGroupList", this.ruleForm).then(res => {
          console.log(res)
          this.checkGroupsData = res.data;
          this.groupsInMeal = this.checkGroupsData
          console.log('所有的检查组信息', this.checkGroupsData)
        })

        return
      }

      console.log('你选择了套餐,套餐id为', this.ruleForm.mealId)

      request.get('/checkGroup/byMealId', {
        params: {
          mealId: this.ruleForm.mealId
        }
      }).then(res => {
        console.log('该套餐所有的检查组有:', res.data)
        if (res.code === '-1') {
          this.$message({
            type: "warning",
            message: res.msg
          })
          return
        }
        this.groupsInMeal = res.data
      })

    }
  }
}
</script>
