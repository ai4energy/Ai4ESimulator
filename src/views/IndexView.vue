<template>
  <n-layout has-sider>
    <n-layout-sider bordered width="16em" :native-scrollbar="false">
      <n-collapse :default-expanded-names="[0]" accordion>
        <n-collapse-item
          v-for="(item, index) in iconCategory"
          :key="index"
          :title="item.zhcn"
          :name="index"
        >
          <IconProvider
            :icon-set-id="item.guid"
            :icon-size="4"
            :callback="startDrag"
          />
        </n-collapse-item>
      </n-collapse>
    </n-layout-sider>
    <n-layout-content :native-scrollbar="false">
      <n-card title="模型区">
        <div id="container" ref="container" class="sim-container"></div>
        <TeleportContainer />
        <n-collapse>
          <n-collapse-item title="仿真选项" name="1">
            <div>待定</div>
          </n-collapse-item>
        </n-collapse>
      </n-card>
      <n-button-group>
        <n-button v-on:click="testApi.healthTest()">Test</n-button>
        <n-button v-on:click="propEditor = true">Show</n-button>
      </n-button-group>
    </n-layout-content>
    <asm-prop-editor
      :open="propEditor"
      :icon-attrs="selectedNodeAttrs"
      @closing="propEditor = false"
      @updating="updateNode"
    ></asm-prop-editor>
  </n-layout>
</template>

<script setup lang="ts">
import testApi from "@/apis/test";
import AsmPropEditor from "@/components/AsmPropEditor.vue";
import {
  NCard,
  NButton,
  NButtonGroup,
  NLayout,
  NLayoutSider,
  NCollapse,
  NCollapseItem,
  NLayoutContent,
} from "naive-ui";
import { iconCategory } from "@/assets/assembly.json";
import { ref, onMounted, type Ref } from "vue";
import { Graph } from "@antv/x6";
import type { Node } from "@antv/x6";
// import { Scroller } from "@antv/x6-plugin-scroller";
import { Keyboard } from "@antv/x6-plugin-keyboard";
import { Selection } from "@antv/x6-plugin-selection";
import { Clipboard } from "@antv/x6-plugin-clipboard";
import { History } from "@antv/x6-plugin-history";
import { Dnd } from "@antv/x6-plugin-dnd";
// import { Transform } from "@antv/x6-plugin-transform";
import { register, getTeleport } from "@antv/x6-vue-shape";
import IconWraper from "@/components/IconWraper.vue";
import IconProvider from "@/components/IconProvider.vue";
import { iconList } from "@/assets/assembly.json";
import { Edge } from "@antv/x6";
interface IAttr {
  name: string;
  type: string;
  value: number | string;
  unit?: string;
  require: boolean;
  holder?: string;
}
// import { v4 as uuidv4 } from "uuid";

/** note for css
 * height calculation
 * <h1> height is 2em, margin is 0.67em * 2
 * header with border 1px, mpadding top 1em, bottom 0.5em
 * footer normal text size 1em, with 1.6 line height
 * footer with border 1px
 * 100% refers to parent ele heigth
 */
const propEditor = ref(false);
const TeleportContainer = getTeleport();
const container: Ref<HTMLDivElement | undefined> = ref();
let graph: Graph | null = null;
let dnd: Dnd | null = null;
const selectedNodeAttrs: Ref<Array<IAttr>> = ref([]);
const portattr = {
  circle: {
    magnet: true,
    stroke: "#545454a6",
    r: 5,
  },
};
const updateNode = (temp: { [key: string]: any }) => {
  propEditor.value = false;
  const node = graph?.getSelectedCells()[0];
  let data = node?.getData();
  for (let prop of data.attrs) {
    if (temp[prop.name]) prop.value = temp[prop.name];
  }
  node?.setData(data);
  console.log(node?.getData());
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
    connecting: {
      router: "orth",
      connector: "rounded",
      createEdge() {
        return this.createEdge({
          shape: "edge",
          attrs: {
            line: {
              stroke: "#8f8f8f",
              strokeWidth: 1,
            },
          },
        });
      },
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
  // graph.use(
  //   new Transform({
  //     rotating: {
  //       enabled: true,
  //       grid: 15,
  //     },
  //     resizing: {
  //       enabled: true,
  //       minWidth: 1,
  //       maxWidth: 200,
  //       minHeight: 1,
  //       maxHeight: 200,
  //       orthogonal: false,
  //       restrict: false,
  //       preserveAspectRatio: false,
  //     },
  //   })
  // );
  graph.use(
    new Selection({
      enabled: true,
      multiple: true,
      rubberband: true,
      movable: true,
      showNodeSelectionBox: true,
      showEdgeSelectionBox: true,
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
    }
    return false;
  });

  graph.bindKey("ctrl+v", () => {
    if (graph) {
      if (!graph.isClipboardEmpty()) {
        const cells = graph.paste({ offset: 32 });
        graph.cleanSelection();
        graph.select(cells);
      }
    }
    return false;
  });

  graph.bindKey("delete", () => {
    if (graph) {
      const cells = graph.getSelectedCells();
      cells.length && graph.removeCells(cells);
    }
    return false;
  });

  graph.bindKey("ctrl+y", () => {
    if (graph) graph.canRedo() && graph.redo();
    return false;
  });
  graph.bindKey("ctrl+z", () => {
    if (graph) graph.canUndo() && graph.undo();
    return false;
  });
  Graph.registerPortLayout("self", (portsPositionArgs, elemBBox) => {
    return portsPositionArgs.map((val) => {
      switch (val["pos"] as string) {
        case "left":
          return {
            position: {
              x: 0,
              y: elemBBox.height / 2,
            },
            angle: 0,
          };
        case "right":
          return {
            position: {
              x: elemBBox.width,
              y: elemBBox.height / 2,
            },
            angle: 0,
          };
        case "top":
          return {
            position: {
              x: elemBBox.width / 2,
              y: 0,
            },
            angle: 0,
          };
        case "buttom":
          return {
            position: {
              x: elemBBox.width / 2,
              y: elemBBox.height,
            },
            angle: 0,
          };

        default:
          return {
            position: {
              x: 0,
              y: elemBBox.height / 2,
            },
            angle: 0,
          };
      }
    });
  });
  register({
    shape: "inner shape",
    width: 100,
    height: 100,
    component: IconWraper,
    data: {
      name: "",
      label: "",
      category: "",
      size: 0,
    },
    ports: {
      groups: {
        self: {
          position: "self",
          attrs: portattr,
        },
      },
    },
  });
  graph.on("node:dblclick", ({ node }: { node: Node }) => {
    propEditor.value = true;
    selectedNodeAttrs.value = node.getData()?.attrs ?? [];
  });
});

const startDrag = (e: MouseEvent) => {
  const target = e.currentTarget as SVGAElement;
  const id = target.getAttribute("id");
  if (!id || !graph || !dnd) return;
  const icon = iconList.find((e) => e.properties.name == id);
  if (!icon) return;
  const node = graph.createNode({
    shape: "inner shape",
    x: 100,
    y: 100,
    data: icon.properties,
    ports: {
      items: [
        { group: "self", args: { pos: "top" } },
        { group: "self", args: { pos: "right" } },
        { group: "self", args: { pos: "buttom" } },
        { group: "self", args: { pos: "left" } },
      ],
    },
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
.n-layout {
  height: calc(100% - 3.34em - 1.5em - 2px - 1.6em);
}
.n-layout-content {
  height: 100%;
}
</style>
