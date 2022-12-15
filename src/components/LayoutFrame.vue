<template>
  <n-layout>
    <n-layout-header bordered> <h1>Ai4ESimulator</h1> </n-layout-header>
    <RouterView />
    <n-layout-footer bordered> Ai4ESimulator &copy; 2022 </n-layout-footer>
  </n-layout>
</template>

<script setup lang="ts">
import { NLayout, NLayoutHeader, NLayoutFooter, useMessage } from "naive-ui";
window.$msg = useMessage();
</script>

<style scoped>
.n-layout-footer {
  text-align: center;
}
.n-layout-header {
  padding: 1em 2em 0.5em 2em;
}
</style>
