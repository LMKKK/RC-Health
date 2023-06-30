<template>
  <div style="padding: 10px">
    <!--    功能区域-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add">新增</el-button>
      <el-upload action="http://localhost:9090/user/import" :on-success="handleUploadSuccess" :show-file-list=false
        :limit="1" accept='.xlsx' style="display: inline-block; margin: 0 10px">
        <el-button type="primary">导入</el-button>
      </el-upload>
      <el-button type="primary" @click="exportUser">导出</el-button>
    </div>

    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="请输入关键字" style="width: 20%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
    </div>

    <!-- 用户数据表格 -->
    <el-table v-loading="loading" :data="tableData" border stripe style="width: 100%">
      <template #empty>
        <el-empty description="暂无数据" />
      </template>
      <el-table-column prop="id" label="ID" sortable>
      </el-table-column>
      <el-table-column prop="username" label="用户名">
      </el-table-column>
      <el-table-column prop="nickName" label="昵称">
      </el-table-column>
      <el-table-column prop="age" label="年龄">
      </el-table-column>
      <el-table-column prop="sex" label="性别">
      </el-table-column>
      <el-table-column prop="address" label="地址">
      </el-table-column>
      <el-table-column 
      label="角色列表" 
      width="300"
      :filters="[
        { text: '医生', value: '3' },
        { text: '用户', value: '2' },
      ]"
      :filter-method="filterHandler"
      prop="role"
      >
        <template #default="scope">
          <el-select v-model="scope.row.roles" multiple placeholder="请选择" style="width: 80%">
            <el-option v-for="item in roles" :key="item.id" :label="item.comment" :value="item.id"></el-option>
          </el-select>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="400">
        <template #default="scope">
          <el-button size="mini" type="primary" @click="handleChange(scope.row)">保存角色信息</el-button>
          <!-- <el-button size="mini" type="success" plain @click="showBooks(scope.row.bookList)">查看图书列表</el-button> -->
          <el-button size="mini" type="primary" plain @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button size="mini" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页器 -->
    <div style="margin: 10px 0">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="currentPage"
        :page-sizes="[5, 10, 20]" :page-size="pageSize" layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>

    <!-- 模态框 -->
    <el-dialog title="提示" v-model="dialogVisible" width="30%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="用户名">
          <el-input v-model="form.username" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickName" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model="form.age" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-radio v-model="form.sex" label="男">男</el-radio>
          <el-radio v-model="form.sex" label="女">女</el-radio>
          <el-radio v-model="form.sex" label="未知">未知</el-radio>
        </el-form-item>
      </el-form>
      <el-form :model="address" label-width="100px">
        <el-form-item label="地址">
          <el-select v-model="address.area" placeholder="荣成市" disabled>
          </el-select>
          <el-select v-model="address.selectedStreet" placeholder="请选择乡镇/街道" @change="onStreetChange" value-key="code"
            :clearable="true">
            <el-option v-for="(item) in rcStreets" :key="item" :value="item" :label="item.name" />
          </el-select>
          <el-select v-model="address.selectedVillage" placeholder="村委会(非必选)" value-key="code" :clearable="true">
            <el-option v-for="(item) in address.nextVillages" :key="item" :value="item" :label="item.name"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="详细地址">
          <el-input v-model="address.detail" type="textarea" :clearable="true" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </span>
      </template>
    </el-dialog>
    <el-row>
      <Statistics></Statistics>
      <RCMap/>
    </el-row>
  </div>
</template>

<script>
import Statistics from '@/views/Statistics.vue'
import rcVillages from '@/assets/rcVillages.json'
import rcStreets from '@/assets/rcStreets.json'
import request from "@/utils/request";
import RCMap from "@/views/RCMap.vue"

export default {
  name: 'User',
  components: { Statistics ,RCMap},
  data() {
    return {
      loading: true,
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      bookList: [],
      roles: [],
      address: {
        area: '荣成市',
        selectedStreet: {},
        selectedVillage: {},
        detail: '',
        nextVillages: []
      },
      rcVillages,
      rcStreets
    }
  },
  created() {
    this.load()
  },
  methods: {
    handleChange(row) {
      request.put("/user/changeRole", row).then(res => {
        if (res.code === '0') {
          this.$message.success("更新成功")
          if (res.data) {
            this.$router.push("/login")
          }
        }
      })
    },
    load() {
      this.loading = true
      request.get("/user", {
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

      request.get("/role/all").then(res => {
        this.roles = res.data
      })
    },
    handleUploadSuccess(res) {
      if (res.code === "0") {
        this.$message.success("导入成功")
        this.load()
      }
    },
    exportUser() {
      location.href = "http://" + window.server.filesUploadUrl + ":9090/user/export";
    },
    add() {
      this.dialogVisible = true
      this.form = {},
      this.address.selectedStreet = {}
      this.address.selectedVillage = {}
    },
    saveAddress() {
      // 地址转字符串
      let newAddress = this.address.area
      if (Object.keys(this.address.selectedStreet).length === 0) {
        console.log('街道未选择，初始化为空串')
        newAddress += '- '
      } else {
        console.log('街道已选择，不为空')
        newAddress += '-' + this.address.selectedStreet.name
      }

      if (Object.keys(this.address.selectedVillage).length === 0) {
        console.log('村委会未选择，初始化为空串')
        newAddress += '- '
      } else {
        console.log('村委会已选择')
        newAddress += '-' + this.address.selectedVillage.name
      }
      if (this.address.detail === '') {
        console.log('详细地址未填写,初始化为空串')
        newAddress += '- '
      } else {
        console.log('详细地址已填写')
        newAddress += '-' + this.address.detail
      }
      console.log('新地址', newAddress)
      this.form.address = newAddress
    },
    save() {
      this.saveAddress()
      if (this.form.id) {  // 更新
        console.log(this.form)
        request.put("/user", this.form).then(res => {
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
        console.log(this.form)
        request.post("/user", this.form).then(res => {
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

    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.loadAddress(row.address)
      this.dialogVisible = true
    },
    loadAddress(address) {
      let addStr = address.split('-')
      // 街道/镇 为空
      if (addStr[1] === ' ') {
        this.address.selectedStreet = {}
      } else {
        rcStreets.forEach(ele => {
          if (ele.name === addStr[1]) {
            this.address.selectedStreet = ele
            // 刷新nextVillages
            this.onStreetChange()
          }
        })
      }

      // 村委会
      if (addStr[2] === ' ') {
        this.address.selectedVillage = {}
      } else {
        rcVillages.forEach(ele => {
          if (ele.name === addStr[2]) {
            this.address.selectedVillage = ele
          }
        })
      }

      // 详细地址
      if (addStr[3] === ' ') {
        this.address.detail = ''
      } else {
        this.address.detail = addStr[3]
      }
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/user/" + id).then(res => {
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
    // 当选择了 街道/镇 后，自动刷新后面的村的列表
    onStreetChange() {
      console.log('当前选择的街道/镇 是', this.address.selectedStreet)
      this.rcVillages.forEach((element, idx) => {
        if (element.streetCode == this.address.selectedStreet.code) {
          this.address.nextVillages.push(element)
        }
      })
      console.log('已加载此街道所有的村', this.form.nextVillages)
    },
    filterHandler(value,row,column){
      let flag = false
      row.roles.forEach((ele) => {
        if(ele == value || ele === value){
          flag = true
        }
      })
      return flag
    }
  }
}

</script>
