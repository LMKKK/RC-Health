<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="20" :offset="1">
        <el-card v-for="article in articleList" :key="article.id" >

          <div slot="header">
            <router-link class="main-text" :to="{ path: '/informationDetail', query: { id: article.id } }">
              <h3>{{ article.title }}</h3>
            </router-link>
            <div class="article-info">
              <p class="text" v-html='article.content'></p>
            </div>
            <i class="el-icon-user-solid article-icon">{{ article.author }}</i>
            <i class="el-icon-date article-icon">{{ article.time }}</i>
          </div>

        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import request from "@/utils/request";
export default {
  name: 'informationShow',
  components: {},
  data() {
    return {
      loading: true,
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      articleList: [],
      vis: false,
      detail: {},
      loginUser: {},
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
      this.detail = row
      this.vis = true
    },
    load() {
      this.loading = true
      request.post("/news/getNewsList", {}).then(res => {
        console.log(res);
        this.articleList = res.data;


      })
    },

  }
}

</script>

<style scoped>
.item-box {
  position: relative;
  width: 100%;
  height: 100%;
}

.carimg {
  width: 100%;
  height: 100%;
  overflow: hidden;
  object-fit: cover;
}

.desc-box {
  position: absolute;
  bottom: 0;
  left: 50%;
  top: 50%;
  width: 500px;
  height: 40px;
  margin-left: -250px;
  margin-top: -20px;
  text-align: center;
}

.el-card {
  margin-top: 20px;
}

.article-info {
  margin-top: 10px;
  color: #909399;
  font-size: 13px;
}

.article-icon,
.article-icon .tag {
  color: #909399;
  font-size: 13px;
  margin-right: 10px;
  text-decoration: none;
}

.article-icon .tag:hover {
  color: #409eff;
  cursor: pointer;
}

.tabloid {
  color: #606266;
  font-size: 14px;
  margin-bottom: 10px;
}

.text {
  display: inline-block;
  width: 100px;
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
}</style>
