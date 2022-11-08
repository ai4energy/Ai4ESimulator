<template>
  <div class="workspace">Workspace Board</div>
  <text-block @deprecating="hhh"></text-block>
  <simulation-block :node-list="iconList"></simulation-block>
  <n-button-group>
    <n-button v-on:click="testApi.healthTest()">Test</n-button>
    <n-button v-on:click="$emit('showing')">Show</n-button>
  </n-button-group>
</template>

<script setup lang="ts">
import testApi from "@/apis/test";
import { NButton, NButtonGroup } from "naive-ui";
import { reactive } from "vue";
import TextBlock from "./TextBlock.vue";
import SimulationBlock from "./SimulationBlock.vue";
import { AppFolder } from "@/assets/assembly.json";
defineEmits(["showing"]);
const books = reactive([]);
const hhh = () => console.log("hhh");
const iconList = reactive(AppFolder.icons)
</script>

<style scoped>
.workspace {
}
</style>
