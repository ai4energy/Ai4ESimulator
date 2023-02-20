<template></template>

<script setup lang="ts">
import { pkgJson } from './model';

defineOptions({ name: 'DevDependency' });

const { devDependencies } = pkgJson;
</script>

<style scoped></style>
