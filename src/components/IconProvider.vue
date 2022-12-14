<template>
  <Icomoon
    v-for="item in iconUnderSelected"
    :id="item"
    :iconSet="{ icons: iconList, ...baseInfo }"
    :name="item"
    :key="item"
    :size="'' + iconSize + 'em'"
    class="side-icon"
  />
</template>

<script setup lang="ts">
import { onMounted } from "vue";
import { Icomoon } from "vue-icomoon";
import { iconList, baseInfo } from "@/assets/assembly.json";
interface IIconProbviderProp {
  iconSetId: string;
  iconSize: number;
  callback: (e: MouseEvent) => any;
}
const props = defineProps<IIconProbviderProp>();
const iconUnderSelected = iconList
  .filter((e) => e.properties.category == props.iconSetId)
  .map((e) => e.properties.name);
onMounted(() => {
  const eles = document.getElementsByClassName("side-icon");
  for (let i = 0; i != eles.length; i++) {
    (eles[i] as SVGElement).addEventListener("mousedown", props.callback);
  }
});
</script>

<style scoped>
.side-icon {
  cursor: move;
}
</style>
