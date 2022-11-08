<template>
  <n-config-provider
    abstract
    :theme="theme"
    :locale="zhCN"
    :date-locale="dateZhCN"
  >
    <n-message-provider>
      <n-dialog-provider>
        <layout></layout>
      </n-dialog-provider>
    </n-message-provider>
  </n-config-provider>
</template>

<script setup lang="ts">
import { computed } from "vue";
import Layout from "@/components/LayoutFrame.vue";
import {
  useOsTheme,
  darkTheme,
  NConfigProvider,
  zhCN,
  dateZhCN,
  NMessageProvider,
  NDialogProvider,
} from "naive-ui";
const osThemeRef = useOsTheme();
const theme = computed(() => (osThemeRef.value === "dark" ? darkTheme : null));
</script>

<style scoped>
#app > .n-layout {
  height: 100vh;
}
</style>
