<template>
  <n-collapse-item :title="title" :name="index">
    <n-space>
      <IconProvider :icon-set-id="props.iconSetId" :icon-size="6" />
    </n-space>
  </n-collapse-item>
</template>

<script setup lang="ts">
import { NCollapseItem, NSpace } from "naive-ui";
import IconProvider from "./IconProvider.vue";

interface IAssemPanelProp {
  title: string;
  index: number;
  iconSetId: string;
}

const props = defineProps<IAssemPanelProp>();
</script>
