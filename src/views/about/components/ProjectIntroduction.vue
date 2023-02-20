<template>
  <n-card title="关于" :bordered="false" size="large" class="rounded-16px shadow-sm">
    <p class="leading-32px">Ai4ESimulator是仿真平台的前端。</p>
    <p class="leading-32px">
      高可拓展的云架构流程系统仿真平台基于新一代开源科学计算编程语言Julia与Vue3前端框架，适用于复杂流程系统的云仿真平台。
    </p>
    <p class="leading-32px">
      云仿真平台采用前后端分离技术:前端为Web界面;后端为集解析器、组件库、求解器三大模块为一体的仿引擎，各模块间通过接口协同工作。仿真平台具备高度可拓展性，后端参析器可嵌入参数辨识问题、优化问题、控制问题等多种问题的代码生成工具;
    </p>
    <p class="leading-32px">组件库广泛适用于能源、化工、机器、电气等多个领域的流程系统模型。</p>
  </n-card>
</template>

<script setup lang="ts">
defineOptions({ name: 'ProjectIntroduction' });
</script>

<style scoped></style>
