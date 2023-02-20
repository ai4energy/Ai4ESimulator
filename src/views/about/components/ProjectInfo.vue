<template>
  <n-card title="项目信息" :bordered="false" size="small" class="rounded-16px shadow-sm">
    <n-descriptions label-placement="left" bordered size="small" :column="2">
      <n-descriptions-item label="Ai4Energy仓库">
        <a class="text-primary" href="https://github.com/ai4energy" target="_blank">Github地址</a>
      </n-descriptions-item>
    </n-descriptions>
  </n-card>
</template>

<script setup lang="ts">
import { pkgJson } from './model';

defineOptions({ name: 'ProjectInfo' });

const { version } = pkgJson;
const latestBuildTime = PROJECT_BUILD_TIME;
</script>

<style scoped></style>
