<template>
  <n-layout has-sider>
    <n-layout-sider bordered width="20em" :native-scrollbar="false">
      <n-collapse :default-expanded-names="[0]" accordion>
        <assem-panel
          v-for="(item, index) in panelItems"
          :key="index"
          :title="item.title.zhcn"
          :index="index"
          :icons="item.icons"
        ></assem-panel>
      </n-collapse>
    </n-layout-sider>
    <n-layout-content :native-scrollbar="false">
      <simulation-block :node-list="iconList"></simulation-block>
      <n-button-group>
        <n-button v-on:click="testApi.healthTest()">Test</n-button>
        <n-button v-on:click="propEditor = true">Show</n-button>
      </n-button-group>
    </n-layout-content>
    <asm-prop-editor
      :open="propEditor"
      @closing="propEditor = false"
    ></asm-prop-editor>
  </n-layout>
</template>

<script setup lang="ts">
import testApi from "@/apis/test";
import { reactive, ref } from "vue";
import SimulationBlock from "@/components/SimulationBlock.vue";
import type { IPanelItem } from "@/components/components";
import AssemPanel from "@/components/AssemPanel.vue";
import AsmPropEditor from "@/components/AsmPropEditor.vue";
import {
  NButton,
  NButtonGroup,
  NLayout,
  NLayoutSider,
  NCollapse,
  NLayoutContent,
} from "naive-ui";
import { AppFolder } from "@/assets/assembly.json";
const iconList = reactive(AppFolder.icons);
const panelItems: IPanelItem[] = reactive([AppFolder as IPanelItem]);
/** note for css
 * height calculation
 * <h1> height is 2em, margin is 0.67em * 2
 * header with border 1px, mpadding top 1em, bottom 0.5em
 * footer normal text size 1em, with 1.6 line height
 * footer with border 1px
 * 100% refers to parent ele heigth
 */
const propEditor = ref(false);
</script>

<style scoped>
.n-layout {
  height: calc(100% - 3.34em - 1.5em - 2px - 1.6em);
}
.n-layout-content {
  height: 100%;
}
</style>