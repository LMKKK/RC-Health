<script setup>
import * as echarts from 'echarts'
import request from '@/utils/request.js'
import rcJson from '@/assets/RCMap.json'
import { onMounted } from 'vue'

echarts.registerMap('RC', rcJson, {})

let option = {
  title: {
    text: '荣成市各乡镇用户分布图',
  },
  tooltip: {
    trigger: 'item',
    // formatter: '{b}<br/>{c} (p / km2)'
    formatter: function (params) {
      if (params.value) {
        return params.seriesName + '<br/>' + params.name + ' : ' + params.value;
      } else {
        return params.seriesName + '<br/>' + params.name + ' : ' + '0';
      }
    }
  },
  toolbox: {
    show: true,
    orient: 'vertical',
    left: 'right',
    top: 'center',
    feature: {
      dataView: { readOnly: false },
      restore: {},
      saveAsImage: {}
    }
  },
  visualMap: {
    min: 1,
    max: 5,
    text: ['High', 'Low'],
    realtime: false,
    calculable: true,
    inRange: {
      color: ['lightskyblue', 'yellow', 'orangered']
    }
  },
  series: [
    {
      name: '荣成市用户分布图',
      type: 'map',
      map: 'RC',
      label: {
        show: true
      },
      data: [
      ],
      // 自定义名称映射
      nameMap: {
        '成山镇2': '成山镇',
        '港西镇1': '港西镇',
        '城西街道1': '城西街道',
        '宁津街道1': '宁津街道',
        '人和镇8': '人和镇',
        '港湾街道1': '港湾街道',
        '崂山街道1': '崂山街道',
        '俚岛镇4': '俚岛镇'
      }
    }
  ]
}

onMounted(() => {
  
  async function xr() {

    var myChart = echarts.init(document.getElementById('RCMap'));

    // 使用刚指定的配置项和数据显示图表。
    const res = await request.get('http://localhost:9090/user/count')

    const townData = res.data

    let data = []
    for (let key in townData) {
      data.push({ name: key, value: townData[key] })
    }

    option.series[0].data = data
    console.log('目前的数据配置项是', option)

    myChart.setOption(option);
  }

  xr()
})


</script>

<template>
  <div id="RCMap"></div>
</template>

<style scoped>
#RCMap {
  height: 700px;
  width: 700px;
}
</style>
