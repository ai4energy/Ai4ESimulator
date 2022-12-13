<template>
  <n-card title="模型区">
    <div id="container" ref="container" class="sim-container"></div>
    <TeleportContainer />
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
import { Graph } from "@antv/x6";
// import { Scroller } from "@antv/x6-plugin-scroller";
import { Keyboard } from "@antv/x6-plugin-keyboard";
import { Selection } from "@antv/x6-plugin-selection";
import { Clipboard } from "@antv/x6-plugin-clipboard";
import { History } from "@antv/x6-plugin-history";
import { Dnd } from "@antv/x6-plugin-dnd";
import { Transform } from "@antv/x6-plugin-transform";
import { register, getTeleport } from "@antv/x6-vue-shape";
import IconWraper from "./IconWraper.vue";
import { iconList } from "@/assets/assembly.json";
import { useIconStore } from "@/stores";
const TeleportContainer = getTeleport();
const iconStore = useIconStore();
const container: Ref<HTMLDivElement | undefined> = ref();
let graph: Graph | null = null;
let dnd: Dnd | null = null;
const data = {
  // 节点
  nodes: [
    {
      id: "node1", // String，可选，节点的唯一标识
      x: 40, // Number，必选，节点位置的 x 值
      y: 40, // Number，必选，节点位置的 y 值
      width: 80, // Number，可选，节点大小的 width 值
      height: 40, // Number，可选，节点大小的 height 值
      label: "hello", // String，节点标签
    },
    {
      id: "node2", // String，节点的唯一标识
      x: 160, // Number，必选，节点位置的 x 值
      y: 180, // Number，必选，节点位置的 y 值
      width: 80, // Number，可选，节点大小的 width 值
      height: 40, // Number，可选，节点大小的 height 值
      label: "world", // String，节点标签
    },
  ],
  // 边
  edges: [
    {
      source: "node1", // String，必须，起始节点 id
      target: "node2", // String，必须，目标节点 id
    },
  ],
};
onMounted(() => {
  let width: number = container.value?.clientWidth ?? 800;
  graph = new Graph({
    container: container.value,
    width: width,
    height: (width * 9) / 16,
    panning: {
      enabled: true,
      modifiers: "alt",
    },
    mousewheel: {
      enabled: true,
      modifiers: ["ctrl", "meta"],
    },
    grid: {
      visible: true,
      type: "doubleMesh",
      args: [
        {
          color: "#545454a6", // 主网格线颜色
          thickness: 1, // 主网格线宽度
        },
        {
          color: "#5454547a", // 次网格线颜色
          thickness: 1, // 次网格线宽度
          factor: 4, // 主次网格线间隔
        },
      ],
    },
  });
  // graph.use(
  //   new Scroller({
  //     enabled: true
  //   })
  // );
  graph.use(
    new Clipboard({
      enabled: true,
    })
  );
  graph.use(
    new Transform({
      rotating: {
        enabled: true,
        grid: 15,
      },
      resizing: {
        enabled: true,
        minWidth: 1,
        maxWidth: 200,
        minHeight: 1,
        maxHeight: 200,
        orthogonal: false,
        restrict: false,
        preserveAspectRatio: false,
      },
    })
  );
  graph.use(
    new Selection({
      enabled: true,
      multiple: true,
      rubberband: true,
      movable: true,
      showNodeSelectionBox: true,
    })
  );
  graph.use(
    new Keyboard({
      enabled: true,
      global: true,
    })
  );
  graph.use(
    new History({
      enabled: true,
    })
  );
  dnd = new Dnd({
    target: graph,
  });

  graph.bindKey("ctrl+c", () => {
    if (graph) {
      const cells = graph.getSelectedCells();
      cells.length && graph.copy(cells);
      return false;
    }
  });

  graph.bindKey("ctrl+v", () => {
    if (graph) {
      if (!graph.isClipboardEmpty()) {
        const cells = graph.paste({ offset: 32 });
        graph.cleanSelection();
        graph.select(cells);
      }
      return false;
    }
  });

  graph.bindKey("delete", () => {
    if (graph) {
      const cells = graph.getSelectedCells();
      cells.length && graph.removeCells(cells);
      return false;
    }
  });
  graph.bindKey("ctrl+y", () => {
    if (graph) {
      graph.canRedo() && graph.redo();
      return false;
    }
  });
  graph.bindKey("ctrl+z", () => {
    if (graph) {
      graph.canUndo() && graph.undo();
      return false;
    }
  });
  graph.fromJSON(data);
});

const startDrag = (e: MouseEvent) => {
  const target = e.currentTarget as SVGAElement;
  const id = target.getAttribute("id");
  if (!id || !graph || !dnd) return;
  const icon = iconList.find((e) => e.properties.guid == id);
  if (!icon) return;
  iconStore.addNode(icon);
  register({
    shape: icon.properties.name,
    width: 100,
    height: 100,
    component: IconWraper,
    data: {
      name: icon.properties.name,
      id: icon.properties.guid,
      size: 100,
    },
  });
  const node = graph.createNode({
    shape: icon.properties.name,
    x: 100,
    y: 100,
  });
  dnd.start(node, e);
};

visualViewport?.addEventListener("resize", () => {
  // const ele = document.getElementsByClassName(
  //   "sim-container"
  // )[0] as HTMLDivElement;
  if (container.value?.parentElement) {
    let width: number = container.value.parentElement.clientWidth - 48;
    graph?.resize(width, (width * 9) / 16);
  }
});
</script>

<style scoped>
.sim-container {
  border: solid var(--color-border);
  border-radius: 5px;
  overflow: scroll;
  touch-action: none;
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
