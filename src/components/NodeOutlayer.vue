<template>
  <my-icon />
</template>
<script setup lang="ts">
import type { ISvgIcon } from "@/utils/svg";
import { SvgRender } from "@/utils/svgProvider";
import { h } from "vue";
const props = defineProps<{ node: ISvgIcon }>();
const MyIcon = () =>
  h(
    "g",
    {
      class: "node-container",
      title: props.node.title.zhcn,
      fill: props.node.color.fill,
      stroke: props.node.color.edge,
      transform: `rotate(${props.node.angle}) scale(${props.node.size.width} ${props.node.size.height}) translate(${props.node.position.x} ${props.node.position.y})`,
    },
    SvgRender(props.node.icon)
  );
</script>

<style>
.node-container {
  cursor: move;
}
</style>
