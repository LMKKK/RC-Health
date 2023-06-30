<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="20" :offset="1">
        <el-card>
          <div slot="header">
            <div class="article-info">
                <p class="text" v-html='articleInfo.content'></p>
            </div>
          <i class="el-icon-user-solid article-icon">{{articleInfo.author}}</i>
          <i class="el-icon-date article-icon">{{articleInfo.time}}</i>
          </div>
          
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import request from "@/utils/request";
export default {
  name: 'informationDetail',
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
      articleInfo: {},
      vis: false,
      detail: {},
      loginUser:{},
      articleId:0,
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    this.loginUser = JSON.parse(userStr)
    console.log("当前登陆者信息：",this.loginUser);
    let id= this.$route.query.id;
    console.log("传递过来的参数：",id);
    this.articleId=id;
    this.load()
  },
  methods: {
    details(row) {
      this.detail = row
      this.vis = true
    },
    load() {
      request.get("/news/" + this.articleId).then(res => {
        console.log(res);
        this.articleInfo=res.data;
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


</style>
