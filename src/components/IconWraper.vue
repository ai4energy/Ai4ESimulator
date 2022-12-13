<template>
  <Icomoon
    :iconSet="{ icons: iconList, ...baseInfo }"
    :key="props.name"
    :name="props.name"
    :size="props.size"
  />
</template>

<script setup lang="ts">
import { Icomoon } from "vue-icomoon";
import { inject, onMounted, reactive } from "vue";
import type { Node } from "@antv/x6";
import { iconList, baseInfo } from "@/assets/assembly.json";

interface IAttr {
  name: string;
  type: string;
  value: number;
  unit: string;
  require: boolean;
  holder: string;
}
interface IProps {
  name: string;
  label: string;
  category: string;
  size: number;
  attrs?: Array<IAttr>;
}

const getNode: (() => Node) | undefined = inject("getNode");
let props = reactive<IProps>({
  name: "",
  label: "",
  category: "",
  size: 0,
});
onMounted(() => {
  if (getNode) {
    const node = getNode();
    props.name = node.getData().name;
    props.label = node.getData().label;
    props.size = node.getData().size;
    props.category = node.getData().category;
    props.attrs = node.getData().attrs;
  }
});
</script>
