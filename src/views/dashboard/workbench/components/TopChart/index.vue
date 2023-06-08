<template>
  <n-grid :x-gap="16" :y-gap="16" :item-responsive="true">
    <n-grid-item span="0:24 640:24 1024:24">
      <n-card :bordered="true" class="rounded-16px shadow-sm p-2px">
        <n-space vertical>
          <n-cascader v-model:value="value" multiple clearable placeholder="状态演化图（变量随时间变化）：选择绘图变量"
            max-tag-count="responsive" expand-trigger="hover" :options="solInfo.options" :show-path="false" cascade
            check-strategy="child" filterable clear-filter-after-select @update:value="handleUpdateValue" />
        </n-space>
      </n-card>
    </n-grid-item>

    <n-grid-item span="0:24 640:24 1024:24">
      <n-card :bordered="false" class="rounded-16px shadow-sm">
        <div class="flex w-full h-360px">
          <div class="flex-1-hidden h-full">
            <div ref="lineRef" class="wh-full"></div>
          </div>
        </div>
      </n-card>
    </n-grid-item>

    <n-grid-item span="0:24 640:24 1024:12">
      <n-card :bordered="true" class="rounded-16px shadow-sm p-2px">
        <n-space vertical>
          <n-cascader v-model:value="rFigValueX" clearable placeholder="变量关系散点图：选择横轴变量" max-tag-count="responsive"
            expand-trigger="hover" :options="solInfo.options" :show-path="false" cascade check-strategy="child" filterable
            clear-filter-after-select />
        </n-space>
      </n-card>
    </n-grid-item>
    <n-grid-item span="0:24 640:24 1024:12">
      <n-card :bordered="true" class="rounded-16px shadow-sm p-2px">
        <n-space vertical>
          <n-cascader v-model:value="rFigValueY" clearable placeholder="变量关系散点图：选择纵轴变量" max-tag-count="responsive"
            expand-trigger="hover" :options="solInfo.options" :show-path="false" cascade check-strategy="child" filterable
            clear-filter-after-select />
        </n-space>
      </n-card>
    </n-grid-item>
    <n-grid-item span="0:24 640:24 1024:24">
      <n-card :bordered="false" class="rounded-16px shadow-sm">
        <div class="flex w-full h-360px">
          <div class="flex-1-hidden h-full">
            <div ref="rlineRef" class="wh-full"></div>
          </div>
        </div>
      </n-card>
    </n-grid-item>
  </n-grid>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted, watch } from 'vue';
import type { Ref } from 'vue';
import type { CascaderOption } from 'naive-ui';
import axios from 'axios';
import { floor, random, round } from 'lodash';
import { type ECOption, useEcharts } from '@/composables';

defineOptions({ name: 'DashboardAnalysisTopCard' });

class SolutionInfo {
  options: CascaderOption[] = [];

  sol: object = {};

  t: number[] = [];
}

const lineOptions = ref<ECOption>({
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'cross',
      label: {
        backgroundColor: '#6a7985'
      }
    }
  },
  legend: {
    data: ['示例曲线1', '示例曲线2']
  },
  grid: {
    left: '3%',
    right: '4%',
    bottom: '3%',
    containLabel: true
  },
  xAxis: [
    {
      type: 'category',
      name: '时间',
      boundaryGap: false,
      data: ['06:00', '08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00', '24:00']
    }
  ],
  yAxis: [
    {
      type: 'value'
    }
  ],
  series: [
    {
      color: '#8e9dff',
      name: '示例曲线1',
      type: 'line',
      smooth: true,
      stack: 'Total',
      areaStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [
            {
              offset: 0.25,
              color: '#8e9dff'
            },
            {
              offset: 1,
              color: '#fff'
            }
          ]
        }
      },
      emphasis: {
        focus: 'series'
      },
      data: [4623, 6145, 6268, 6411, 1890, 4251, 2978, 3880, 3606, 4311]
    },
    {
      color: '#26deca',
      name: '示例曲线2',
      type: 'line',
      smooth: true,
      stack: 'Total',
      areaStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [
            {
              offset: 0.25,
              color: '#26deca'
            },
            {
              offset: 1,
              color: '#fff'
            }
          ]
        }
      },
      emphasis: {
        focus: 'series'
      },
      data: [2208, 2016, 2916, 4512, 8281, 2008, 1963, 2367, 2956, 678]
    }
  ]
}) as Ref<ECOption>;

// const rlineOptions = ref<ECOption>({
//   tooltip: {
//     trigger: 'axis',
//     axisPointer: {
//       type: 'cross',
//       label: {
//         backgroundColor: '#6a7985'
//       }
//     }
//   },
//   grid: {
//     left: '3%',
//     right: '4%',
//     bottom: '3%',
//     containLabel: true
//   },
//   xAxis: [
//     {
//       type: 'category',
//       boundaryGap: false,
//       data: [1, 2, 3, 4, 5]
//     }
//   ],
//   yAxis: [
//     {
//       type: 'value',
//     }
//   ],
//   series: [
//     {
//       color: '#26deca',
//       data: [1, 2, 3, 4, 5],
//       type: 'line',
//       smooth: true,
//       showSymbol: false,
//       areaStyle: {
//         color: {
//           type: 'linear',
//           x: 0,
//           y: 0,
//           x2: 0,
//           y2: 1,
//           colorStops: [
//             {
//               offset: 0.25,
//               color: '#26deca'
//             },
//             {
//               offset: 1,
//               color: '#fff'
//             }
//           ]
//         }
//       },
//     }
//   ]

// }) as Ref<ECOption>;

// echart的散点图坐标轴自适应
const scatterOption = ref<ECOption>({
  xAxis: {
    min: (value) => {
      return round(1.1 * value.min - 0.1 * value.max, 1)
    },
    max: (value) => {
      return round(1.1 * value.max - 0.1 * value.min, 1)
    }
  },
  yAxis: {
    min: (value) => {
      return round(1.1 * value.min - 0.1 * value.max, 1)
    },
    max: (value) => {
      return round(1.1 * value.max - 0.1 * value.min, 1)
    }
  },
  series: [
    {
      symbolSize: 10,
      data: [
        [10.0, 8.04],
        [8.07, 6.95],
        [13.0, 7.58],
        [9.05, 8.81],
        [11.0, 8.33],
        [14.0, 7.66],
        [13.4, 6.81],
        [10.0, 6.33],
        [14.0, 8.96],
        [12.5, 6.82],
        [9.15, 7.2],
        [11.5, 7.2],
        [3.03, 4.23],
        [12.2, 7.83],
        [2.02, 4.47],
        [1.05, 3.33],
        [4.05, 4.96],
        [6.03, 7.24],
        [12.0, 6.26],
        [12.0, 8.84],
        [7.08, 5.82],
        [5.02, 5.68]
      ],
      type: 'scatter'
    }
  ]
}) as Ref<ECOption>;


const { domRef: lineRef } = useEcharts(lineOptions);

const { domRef: rlineRef } = useEcharts(scatterOption);

function getOptionsFromJson(arr: any): CascaderOption[] {
  const options: CascaderOption[] = [];
  for (let i = 0; i < arr.length; ++i) {
    if (typeof arr[i] === 'object') {
      for (const key in arr[i]) {
        options.push({
          label: key,
          value: key,
          children: getOptionsFromJson(arr[i][key])
        });
      }
    } else {
      options.push({
        label: arr[i],
        value: arr[i]
      });
    }
  }
  return options;
}
const getExampleLine = () => {
  lineOptions.value.legend.data = ['示例曲线'];
  lineOptions.value.xAxis[0].data = solInfo.t;
  const random_data: number[] = [];
  for (let i = 0; i < solInfo.t.length; i++) {
    random_data.push(floor(random(0, 100)));
  }
  lineOptions.value.series = [
    {
      color: '#8e9dff',
      name: '示例曲线',
      type: 'line',
      smooth: true,
      showSymbol: false,
      stack: 'Total',
      areaStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [
            {
              offset: 0.25,
              color: '#8e9dff'
            },
            {
              offset: 1,
              color: '#fff'
            }
          ]
        }
      },
      emphasis: {
        focus: 'series'
      },
      data: random_data
    }
  ];
};
const value = ref(null);

const rFigValueX = ref(null);
const rFigValueY = ref(null);

const solInfo = reactive(new SolutionInfo());
const getSolutionInfo = () => {
  axios.get('http://123.60.88.27:8081/api/getResult').then(
  // axios.get('https://www.fastmock.site/mock/c1520107474435ccf66bdaa7781568a8/api/getResult').then(
    res => {
      solInfo.options = getOptionsFromJson(res.data.data.varinfo);
      solInfo.sol = res.data.data.sol;
      solInfo.t = res.data.data.t;
      getExampleLine();
    },
    error => {
      console.log('@@@Error:', error.message)
    });
};
const col: string[] = [
  '#5470c6',
  '#91cc75',
  '#fac858',
  '#ee6666',
  '#73c0de',
  '#3ba272',
  '#fc8452',
  '#9a60b4',
  '#ea7ccc'
];

watch(value, newvalue => {

  const v: string[] = newvalue === null ? [] : newvalue;
  const colors: string[] = [];
  for (let i = 0; i < floor(v.length / 9 + 1); ++i) {
    colors.push(...col);
  }
  const series: object[] = [];
  for (let i = 0; i < v.length; i++) {
    series.push({
      color: colors[i],
      name: v[i],
      type: 'line',
      smooth: true,
      showSymbol: false,
      stack: 'Total',
      areaStyle: {
        color: {
          type: 'linear',
          x: 0,
          y: 0,
          x2: 0,
          y2: 1,
          colorStops: [
            {
              offset: 0.25,
              color: colors[i]
            },
            {
              offset: 1,
              color: '#fff'
            }
          ]
        }
      },
      emphasis: {
        focus: 'series'
      },
      data: solInfo.sol[newvalue[i]]
    });
  }
  lineOptions.value.series = series;
  lineOptions.value.legend.data = v;
  lineOptions.value.xAxis[0].data = solInfo.t;
}, { deep: true });

// watch([rFigValueX, rFigValueY], newvalue => {
//   //
//   if (newvalue[0] !== null && newvalue[1] !== null) {
//     var xdata: Array<number> = solInfo.sol[newvalue[0]];
//     var ydata: Array<number> = solInfo.sol[newvalue[1]];
//     for (let i = 0; i < xdata.length; i++) {
//       xdata[i] = round(xdata[i], 8)
//       ydata[i] = round(ydata[i], 8)
//     }
//     rlineOptions.value.xAxis[0].data = xdata;
//     rlineOptions.value.series[0].data = ydata;
//     console.log("newvalue",newvalue);
//     console.log("xdata",xdata);
//     console.log("ydata",ydata);
//   }
//   else{
//     rlineOptions.value.xAxis[0].data = [];
//     rlineOptions.value.series[0].data = [];
//   }
// });

watch([rFigValueX, rFigValueY], newvalue => {
  //
  if (newvalue[0] !== null && newvalue[1] !== null) {
    var xdata: Array<number> = solInfo.sol[newvalue[0]];
    var ydata: Array<number> = solInfo.sol[newvalue[1]];
    // 合并xdata与ydata
    var data: Array<Array<number>> = [];
    for (let i = 0; i < xdata.length; i++) {
      data.push([xdata[i], ydata[i]]);
    }
    scatterOption.value.series[0].data = data;
    console.log("newvalue", newvalue);
  }
  else {
    scatterOption.value.series[0].data = [];
  }
});

onMounted(() => {
  getSolutionInfo(); // 获取变量信息
});

function handleUpdateValue(value: string[], options: CascaderOption[]) {
  // console.log(value, options)
}

// toRefs(options)
</script>

<style scoped></style>
