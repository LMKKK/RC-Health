<template>
  <div>
    <el-card style="width: 40%; margin: 10px">
      <el-form ref="form" :model="form" label-width="100px">
        <el-form-item style="text-align: center" label-width="0">
          <el-upload class="avatar-uploader" action="http://localhost:9090/files/upload" :show-file-list="false"
            :on-success="handleAvatarSuccess">
            <img v-if="form.avatar" :src="form.avatar" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>
        <el-form-item label="用户名">
          <el-input v-model="form.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickName"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model="form.age"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-radio-group v-model="form.sex">
            <el-radio label="男" value="男" />
            <el-radio label="女" value="女" />
          </el-radio-group>
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
      <div style="text-align: center">
        <el-button type="primary" @click="update">保存</el-button>
      </div>
    </el-card>

  </div>
</template>

<script>
import request from "@/utils/request";
import rcVillages from '@/assets/rcVillages.json'
import rcStreets from '@/assets/rcStreets.json'


export default {
  name: "Person",
  data() {
    return {
      form: {},
      rcVillages,
      rcStreets,
      address: {
        area: '荣成市',
        selectedStreet: {},
        selectedVillage: {},
        detail: '',
        nextVillages: []
      }
    }
  },
  created() {
    // 从浏览器缓存中加载信息到model中
    let str = sessionStorage.getItem("user") || "{}"
    str = JSON.parse(str)
    this.form = str
    this.loadAddress(str.address)
  },
  methods: {
    // 从缓存中的地址，转换到响应式的地址
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
    handleAvatarSuccess(res) {
      this.form.avatar = res.data
      this.$message.success("上传成功")
      // this.update()
    },
    update() {
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
      request.put("/user", this.form).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "更新成功"
          })
          sessionStorage.setItem("user", JSON.stringify(this.form))
          // 触发Layout更新用户信息
          this.$emit("userInfo")
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
      })
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
    }
  }
}
</script>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  line-height: 120px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
