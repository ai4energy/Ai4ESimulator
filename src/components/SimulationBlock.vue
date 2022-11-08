<template>
  <n-card title="模型区">
    <div ref="container" class="sim-container">
      <div ref="outside" class="sim-outside" @mousewheel.ctrl="svgScale">
        <svg
          version="1.1"
          xmlns="http://www.w3.org/2000/svg"
          ref="svgcanvas"
          class="svg-canvas"
        >
          <g ref="svgrid">
            <line
              v-for="n in 605 / 5"
              :key="n"
              x1="00"
              x2="800"
              :y1="5 * n - 5"
              :y2="5 * n - 5"
              stroke="rgba(84, 84, 84, 0.48)"
              stroke-width="1"
            />
            <line
              v-for="n in 800 / 5"
              :key="n"
              :x1="5 * n - 5"
              :x2="5 * n - 5"
              y1="0"
              y2="600"
              stroke="rgba(84, 84, 84, 0.48)"
              stroke-width="1"
            />
          </g>
          <g ref="svgactea">
            <node-out-layer
              v-for="(node, id) in $props.nodeList"
              :key="id"
              :node="node"
            ></node-out-layer>
          </g>
        </svg>
      </div>
    </div>
    <n-collapse>
      <n-collapse-item title="仿真选项" name="1">
        <div>待定</div>
      </n-collapse-item>
    </n-collapse>
  </n-card>
</template>

<script setup lang="ts">
import { NCard, NCollapse, NCollapseItem } from "naive-ui";
import { ref, onMounted, type Ref } from "vue";
import type { ISvgIcon } from "@/utils/svg";
import NodeOutLayer from "./NodeOutlayer.vue";
defineProps<{ nodeList: Array<ISvgIcon> }>();

const container: Ref<HTMLDivElement | undefined> = ref();
const outside: Ref<HTMLDivElement | undefined> = ref();
const svgcanvas: Ref<SVGElement | undefined> = ref();
const svgrid: Ref<SVGGElement | undefined> = ref(); // current not used
const svgactea: Ref<SVGGElement | undefined> = ref();

onMounted(() => {
  if (container.value) {
    let width: number = container.value?.clientWidth;
    container.value.style.height = 0.618 * width + "px";
    if (outside.value) {
      outside.value.style["minHeight"] = 0.618 * width + "px";
      outside.value.style["minWidth"] = width + "px";
    }
  }
});

visualViewport?.addEventListener("resize", () => {
  if (container.value) {
    let width: number = container.value.clientWidth;
    container.value.style.height = 0.618 * width + "px";
    if (outside.value) {
      outside.value.style["minHeight"] = 0.618 * width + "px";
      outside.value.style["minWidth"] = width + "px";
    }
  }
});

const svgScale = (e: WheelEvent) => {
  e.preventDefault();
  let zoomVal = Number(svgcanvas.value?.style.getPropertyValue("zoom"));
  zoomVal = zoomVal != 0 ? zoomVal : 1;
  zoomVal -= e.deltaY / 2000;
  if (zoomVal < 1 || zoomVal > 10) return;
  svgcanvas.value?.style.setProperty("zoom", "" + zoomVal);
  outside.value?.style.setProperty("height", zoomVal * 600 + "px");
  outside.value?.style.setProperty("width", zoomVal * 800 + "px");
};
</script>

<style scoped>
.sim-container {
  border: solid var(--color-border);
  border-radius: 5px;
  overflow: scroll;
  touch-action: none;
}

.sim-outside {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 50px;
}

.svg-canvas {
  min-width: 800px;
  min-height: 600px;
  display: block;
  background-image: none;
}

.sim-container::-webkit-scrollbar {
  width: 10px;
  height: 10px;
}
.sim-container::-webkit-scrollbar-corner {
  background-color: transparent;
}
.sim-container::-webkit-scrollbar-thumb {
  background-color: transparent;
  background-clip: padding-box;
  border: solid transparent;
  border-radius: 5px;
}

.sim-container::-webkit-scrollbar-track {
  background-clip: padding-box;
  border: solid transparent;
  border-width: 1px;
}
.sim-container:hover::-webkit-scrollbar-thumb {
  background-color: var(--color-text);
}
</style>
