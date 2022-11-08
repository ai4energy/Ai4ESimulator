<template>
  <n-collapse-item :title="title" :name="index">
    <n-space>
      <div v-for="(icon, index) in icons" :key="index">{{ icon.title }}</div>
    </n-space>
  </n-collapse-item>
</template>

<script setup lang="ts">
import { NIcon, NCollapseItem, NSpace } from "naive-ui";
import type { ISvgIcon } from "@/utils/svg";

defineProps<{
  title: string;
  index: number;
  icons: ISvgIcon[];
}>();
</script>
