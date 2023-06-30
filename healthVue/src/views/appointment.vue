<template>
  <el-tabs type="border-card">
    <el-tab-pane label="预约规则设置">
      <el-calendar v-model="calendarDate">
        <template #dateCell="{ data }">
          <el-row :class="data.isSelected ? 'is-selected' : 'sds'">
            {{ data.day.split('-').slice(1).join('-') }}
            {{ data.isSelected ? '✔️' : '' }}
          </el-row>
          <div v-for="(item, index) in calendarData" :key="item.dayId">
            <e-row v-if="data.day == item.day && data.day >= nowDate">
              <el-col class="center">
                <el-tag type="warning" class="tag">
                  <el-row>
                    <el-col :span="6" class="tag">
                      <span>当日限约</span>
                    </el-col>
                    <el-col :span="1"></el-col>
                    <el-col :span="8" class="tag2">
                      <el-input v-model="item.limitPeople"></el-input>
                    </el-col>
                    <el-col :span="2"><span>人</span></el-col>
                    <el-col :span="6" class="tag2">
                      <el-button type="primary" @click="saveData(item)">确定</el-button>
                    </el-col>
                  </el-row>
                </el-tag>
              </el-col>
            </e-row>

          </div>

        </template>
      </el-calendar>
    </el-tab-pane>
    <el-tab-pane label="预约信息">
      <el-calendar>
        <template #dateCell="{ data }">
          <el-row :class="data.isSelected ? 'is-selected' : 'sds'">
            {{ data.day.split('-').slice(1).join('-') }}
            {{ data.isSelected ? '✔️' : '' }}
          </el-row>
          <div v-for="(item, index) in appointmentData" :key="item.id">
            <e-row v-if="data.day == item.daySelect">
              <el-col class="center">
                <el-tag type="warning" class="tag">
                  <el-row>
                    <el-col :span="14" class="tag">
                      <span>当日限约：</span>
                    </el-col>
                    <el-col :span="1"></el-col>
                    <el-col :span="8" class="tag2">
                      <span>{{ item.limitPeople }}</span>
                    </el-col>
                  </el-row>
                </el-tag>
              </el-col>
            </e-row>
            <el-row v-if="data.day == item.daySelect" style="margin-top: 10px" class="yuyue">
              <el-col :span="11" class="center">
                <span>已约</span><span class="center2" style="">{{ item.preCount }}</span></el-col>
              <el-col :span="2" class="center">|</el-col>
              <el-col :span="11" class="center">
                <span>剩余</span><span class="center2">{{ item.residue }}</span></el-col>
                <!-- <span>剩余</span><span class="center2">{{ item.limitPeople - item.preCount }}</span></el-col> -->
            </el-row>

          </div>

        </template>
      </el-calendar>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
import request from "@/utils/request";
import moment from "moment"

export default {
  name: 'checkSetMeal',
  components: {},
  data() {
    return {
      loading: true,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      vis: false,
      detail: {},
      multipleSelection: [],
      checkItemsData: [],
      loginUser: {},
      dateValue: new Date(),
      ruleEditVisible: false,
      selectDays: [],
      timeValue: "",
      calendarDate: new Date(),
      tableData: [],
      calendarData: [],
      appointmentData: [{ day: '2023-06-21', limitPeople: 78, }],
      nowDate: moment(new Date()).format("YYYY-MM-DD"),


    }
  },
  watch: {
    // 用watch监听calendarDate
    // 1. 我自己项目中用到的较为简单的逻辑：
    // 即不管点击了上月还是下月，只要时间改变，就执行函数initFormData，调用接口，将请求到的新数据重新渲染在el-calendar组件的内容上
    calendarDate(val, oldVal) {
      console.log("新的：：", moment(val).format("YYYY-MM"));
      console.log("旧的：：", moment(oldVal).format("YYYY-MM"));
      this.load(moment(val).format("YYYY-MM"));
    },


  },
  created() {
    this.load();
    let userStr = sessionStorage.getItem("user") || "{}"
    let user = JSON.parse(userStr)
    console.log("当前登陆者信息user：：", user);
    this.loginUser = user;
    this.getDayAppointment();
  },
  methods: {
    load(month) {
      let days = 0;

      if (!month) {
        console.log('指定月份为空，自动获取系统时间')
        month = moment(new Date()).format("YYYY-MM");
        days = this.getCountDays(new Date());
      } else {
        days = this.getCountDays(month);
      }
      console.log("加载时月份共有：：", days, "天");
      let params = { month: month };
      console.log("加载时月份：：", month);
      this.loading = true
      let selectDays = [];
      // 发起请求,获取本月份预约设置信息
      console.log('获取预约设置信息,查询参数是', params)
      request.post("/appointment/getAppointmentRuleList", params).then(res => {
        console.log(res)

        for (let i = 0; i < days; i++) {
          let day = "";
          if (i < 9) {
            day = month + '-0' + (i + 1);
          } else {
            day = month + '-' + (i + 1);
          }
          res.data.forEach(element => {
            if (element.day == day) {
              element.dayId = i;
              selectDays.push(element);
            }
          });
          selectDays.push({ day: day, dayId: i, month: month });
        }

        this.calendarData = this.unique(selectDays);
        console.log("新的集合信息：：", this.calendarData);
      })
    },
    //数组去重复
    unique(arr) {
      const res = new Map();
      return arr.filter((arr) => !res.has(arr.dayId) && res.set(arr.dayId, 1))
    },
    // 获取一个月有多少天，curDate是开始日期，获取这个日期的月份的天数
    getCountDays(curDate) {
      const d = new Date(curDate)
      const y = d.getFullYear()
      //获取本月的下一个月
      const m = d.getMonth() + 1
      // 下一个月的第0天就是这个月的天数
      const days = new Date(y, m, 0).getDate()
      return days
    },
    // 保存设置
    saveData(item) {

      let params = JSON.parse(JSON.stringify(item));
      params.createPeople = this.loginUser.nickName;
      console.log("保存时的参数", params);
      //return
      request.post("/appointment/saveAppointmentRule", params).then(res => {
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "保存成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }

        this.load() // 刷新表格的数据

      })
    },
    viewDayWork(data) {
      console.log("点击时的事件值：：", data);
      let month22 = moment(new Date()).format("YYYY-MM");
      console.log("当前月份：：", month22);

    },
    // 获取每日预约信息
    getDayAppointment(month) {
      if (!month) {
        console.log('未指定月份,已自动获取系统时间')
        month = moment(new Date()).format("YYYY-MM");
      } else {
        month = moment(month).format("YYYY-MM");
      }
      let params = { appointmentMonth: month };
      console.log('获取每日预约信息,请求参数是:', params)
      request.post("/appointment/getDayAppointment", params).then(res => {
        console.log('获取每日预约信息',res)
        this.appointmentData = res.data;

        //console.log("新的集合信息：：", this.calendarData);
      }).catch(err => {
        console.log('请求每日预约信息失败，请稍后重试')
        console.log(err)
      })
    }


  }
}
</script>

<style>
.is-selected {
  color: #1989fa;
}
</style>

<style scoped >
:deep .el-calendar__body {
  padding: 4px 20px 35px;
}

:deep .el-calendar-table thead th {
  color: #ffab11;
  font-weight: bold;
  font-size: 25px;
}

.tag {
  display: flex;
  align-items: center;
  height: 2.5vh;
  justify-content: center;
}

.tag2 {
  display: flex;
  align-items: center;
  height: 2.5vh;
  justify-content: center;
  font-size: 18px;
}

.aaa .is-selected .yuyue {
  color: #ffab11;
}

.aaa .datastyle {
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 3rem;
  color: #353636;
  font-weight: 600;
}

:deep .el-calendar-table .el-calendar-day:hover {
  background-color: #faecd8;
}

:deep .el-calendar {
  --el-calendar-selected-bg-color: #faecd8;
}

.aaa .is-selected .datastyle {
  color: #ffab11;
}

.aaa .prev .datastyle {
  color: #c4c5c8;
}

.aaa .next .datastyle {
  color: #c4c5c8;
}

:deep .el-calendar {
  --el-calendar-cell-width: 130px;
}

.center {
  display: flex;
  justify-content: center;
  align-items: center;
}

.center2 {
  display: flex;
  justify-content: center;
  align-items: center;
  color: #ffab11;
  margin-left: 5px;
  font-size: 20px;
}

:deep .el-calendar__header {
  justify-content: center;
}
</style>



