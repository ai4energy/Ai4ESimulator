<template></template>

<script setup lang="ts">
import { pkgJson } from './model';

defineOptions({ name: 'ProDependency' });

const { dependencies } = pkgJson;
</script>

<style scoped></style>
