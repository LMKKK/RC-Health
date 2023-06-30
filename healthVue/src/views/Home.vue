<template>
  <div>
    <el-row justify="center">
      <el-col :span="6">
        <h1>欢迎来到荣成市健康管理平台!</h1>
      </el-col>
    </el-row>
<br/>
<br/>
    <!-- 轮播图 -->
    <el-carousel :interval="2000" type="card" height="500px">
      <!-- 每个轮播项目 -->
      <el-carousel-item v-for="item in imgs" :key="item" :label="item.label">

        <div class="lb-item">
          <h3>{{ item.title }}</h3>
          <img :src="item.img" />
        </div>

      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script setup>
import { ref } from 'vue'
let imgs = ref([{
  title: '随时随地浏览健康资讯,快速获取健康指导',
  label: '健康资讯',
  img: 'https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/20230625221517.png',
}, {
  label: '预约体检',
  title: '在线预约，无需排队,多种套餐供您选择',
  img: 'https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/20230625221554.png'
}, {
  label: '体检报告',
  title: '快速出体检报告,无需等待，线上一键查看',
  img: 'https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/20230625222913.png'
}, {
  label: '专业设备',
  title: '专业设备,采购自日本、德国等高科技最新设备',
  img: 'https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/20230625223020.png'
}, {
  label: '专业医生',
  title: '专业医生,拥有数十年就诊经验',
  img: 'https://kkbank.oss-cn-qingdao.aliyuncs.com/note-img/20230625224450.png'
}
])

</script>

<style scoped>
.lb-item {
  position: relative;
  display: block;
  width: 750px;
  height: 450px;
}

.lb-item img {
  width: 100%;
  height: 100%;
  margin: 0;
}

.lb-item h3 {
  width: 100%;
  margin: 0;
  line-height: 3.6em;
  background-color: rgba(164, 170, 162, 0.8);
  text-align: center;
  display: block;
  position: absolute;
  bottom: 0px;
}
</style>
