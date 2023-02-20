<template>
  <div class="h-full">
    <iframe class="wh-full" :src="src"></iframe>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

const src = ref('https://ai4energy.github.io/Ai4EComponentLib.jl/dev/');
</script>

<style scoped></style>
