<template>
  <n-config-provider :theme="theme.naiveTheme" :theme-overrides="theme.naiveThemeOverrides" :locale="zhCN"
    :date-locale="dateZhCN" class="h-full">
    <naive-provider>
      <router-view />
    </naive-provider>
  </n-config-provider>
</template>

<script setup lang="ts">
import { dateZhCN, zhCN } from 'naive-ui';
import { subscribeStore, useThemeStore } from '@/store';
import { useGlobalEvents } from '@/composables';
import { Graph } from '@antv/x6';
import IconWraper from "@/components/IconWraper.vue";
import { register } from "@antv/x6-vue-shape";
const portattr = {
  circle: {
    magnet: true,
    stroke: "#545454a6",
    r: 5,
  },
};
const theme = useThemeStore();
Graph.registerPortLayout("stop", (portsPositionArgs, elemBBox) => {
  return portsPositionArgs.map((_, idx) => {
    return {
      position: {
        x: ((idx + 1) / (portsPositionArgs.length + 1)) * elemBBox.width,
        y: 0,
      },
      angle: 0,
    };
  });
});
Graph.registerPortLayout("sbottom", (portsPositionArgs, elemBBox) => {
  return portsPositionArgs.map((_, idx) => {
    return {
      position: {
        x: ((idx + 1) * elemBBox.width) / (portsPositionArgs.length + 1),
        y: elemBBox.height,
      },
      angle: 0,
    };
  });
});
Graph.registerPortLayout("sleft", (portsPositionArgs, elemBBox) => {
  return portsPositionArgs.map((_, idx) => {
    return {
      position: {
        x: 0,
        y: ((idx + 1) * elemBBox.height) / (portsPositionArgs.length + 1),
      },
      angle: 0,
    };
  });
});
Graph.registerPortLayout("sright", (portsPositionArgs, elemBBox) => {
  return portsPositionArgs.map((_, idx) => {
    return {
      position: {
        x: elemBBox.width,
        y: ((idx + 1) * elemBBox.height) / (portsPositionArgs.length + 1),
      },
      angle: 0,
    };
  });
});
register({
  shape: "inner shape",
  width: 100,
  height: 100,
  component: IconWraper,
  data: {
    name: "",
    label: "",
    category: "",
    size: 0,
  },
  ports: {
    groups: {
      stop: {
        position: "stop",
        attrs: portattr,
      },
      sbottom: {
        position: "sbottom",
        attrs: portattr,
      },
      sleft: {
        position: "sleft",
        attrs: portattr,
      },
      sright: {
        position: "sright",
        attrs: portattr,
      },
    },
  },
});
subscribeStore();
useGlobalEvents();
</script>

<style scoped>

</style>
