<template>

  
  
  <div style="padding: 10px">
    <div id="myChart" :style="{width: '600px', height: '500px'}"></div>

  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Statistics",
  data() {
    return {}
  },
  mounted() {
    this.drawLine();
  },
  methods: {
    drawLine() {
      // 基于准备好的dom，初始化echarts实例
      let myChart = this.$root.echarts.init(document.getElementById('myChart'))
      let option = {
        title: {
          text: '用户地区统计图',
          left: 'left'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          trigger: 'item',
          left: 'center'
        },
        toolbox: {
          show: true,
          feature: {
            mark: {show: true},
            dataView: {show: true, readOnly: false},
            restore: {show: true},
            saveAsImage: {show: true}
          }
        },
        series: [
          {
            name: '用户比例',
            type: 'pie',
            radius: [50, 150],
            center: ['50%', '60%'],
            roseType: 'area',
            itemStyle: {
              borderRadius: 8
            },
            data: []
          }
        ]
      }
      
      request.get("/user/count").then(res => {
        if (res.code === '0') {
          console.log('统计结果是',res.data)
          // res.data.forEach(item => {
          //   option.series[0].data.push({name: item.address, value: item.count})
          // })
          let data = res.data 
          for(let key in data){
            option.series[0].data.push({name: key, value: data[key]})
          }
          // 绘制图表
          myChart.setOption(option);
        }
      })

    }
  }
}
</script>

<style scoped>

</style>
