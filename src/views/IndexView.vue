<template>
  <n-layout has-sider>
    <n-layout-sider bordered width="16rem" :native-scrollbar="false">
      <n-collapse :default-expanded-names="[0]" accordion>
        <n-collapse-item
          v-for="(item, index) in iconCategory"
          :key="index"
          :title="item.zhcn"
          :name="index"
        >
          <IconProvider
            v-for="(icon, index) in iconList.filter(
            (e) => e.properties.category == item.guid
            )"
            :key="index"
            :icon-id="icon.properties.name"
            :icon="[icon.icon]"
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
      </n-card>
        <websock />
        <n-button-group>
          <n-button v-on:click="testApi.healthTest()">测试</n-button>
          <n-button v-on:click="testApi.WebSocketsTest2()">WebSockets+logger测试</n-button>
          <n-button v-on:click="simulate">仿真</n-button>
          <n-button v-on:click="simPropPop">仿真设置</n-button>
        </n-button-group>
    </n-layout-content>
    <asm-prop-editor
      :open="propEditor"
      :comps="comps"
      :icon-attrs="selectedNodeAttrs"
      @closing="propEditor = false"
      @updating="updateProp"
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
import websock from "@/components/websock.vue";
import IconProvider from "@/components/IconProvider.vue";
import { iconList } from "@/assets/assembly.json";
interface IAttr {
  name: string;
  type: string;
  value: number | string | Array<number | string>;
  unit?: string;
  require: boolean;
  holder?: string | Array<string>;
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
let postResult: Ref<object> = ref({});
const portattr = {
  circle: {
    magnet: true,
    stroke: "#545454a6",
    r: 5,
  },
};
const comps = ref(true);
const simProp = [
  {
    name: "name",
    type: "string",
    value: "Project Name",
    unit: "",
    require: true,
    holder: "请输入项目名称",
  },
  {
    name: "u0",
    type: "tags",
    value: [],
    unit: "",
    require: true,
    holder: "请输入初值条件",
  },
  {
    name: "timespan",
    type: "multinum",
    value: [0, 10, 1],
    unit: "s",
    require: true,
    holder: ["起始", "终止", "步长"],
  },
  {
    name: "solver",
    type: "multiselection",
    value: [],
    unit: "",
    require: true,
    holder: "请选择求解器算法",
  },
];
const simulate = () => {
  let connections: Array<object> | null = [];
  let components: Array<object> | null = [];
  let simProps: Array<object> = [];

  let compAndCon: object = { connections, components };

  graph?.getNodes().forEach((element) => {
    let asmProps: object = { name: "", type: "", args: {} };
    console.log(element.getData().attrs);
    element.getData().attrs.forEach((ele) => {
      if (ele.name == "name" || ele.name == "type") {
        asmProps[ele.name] = ele.value;
      } else {
        asmProps.args[ele.name] = ele.value;
      }
    });
    components?.push(asmProps);
  });

  graph?.getEdges().forEach((item) => {
    let group: Array<string> | null = [];
    const sourcePortId = item.getSourcePortId();
    const targetPortId = item.getTargetPortId();
    if (!sourcePortId || !targetPortId) return;
    const sourcePort = item.getSourceNode()?.getPort(sourcePortId);
    const targetPort = item.getTargetNode()?.getPort(targetPortId);
    if (!sourcePort || !targetPort) return;
    const sourcePortText = sourcePort?.attrs?.text.text;
    const targetPortText = targetPort?.attrs?.text.text;
    if (!sourcePort || !targetPort) return;
    const sourceNodeName: string = item
      .getSourceNode()
      ?.getData()
      .attrs.filter((item: any) => {
        return item.name === "name";
      })[0].value;
    const targetNodeName: string = item
      .getTargetNode()
      ?.getData()
      .attrs.filter((item: any) => {
        return item.name === "name";
      })[0].value;
    const sourceInfo: string | null = sourceNodeName + "." + sourcePortText;
    const targetInfo: string | null = targetNodeName + "." + targetPortText;
    group.push(sourceInfo, targetInfo);
    connections?.push(group);
  });
  simProp.forEach((ele: object) => (simProps[ele.name] = ele.value));
  postResult.value = { ...compAndCon, ...simProps };
  testApi.jobTest(JSON.stringify(postResult.value));
  console.log(JSON.stringify(postResult.value))
};
const simPropPop = () => {
  comps.value = false;
  propEditor.value = true;
  selectedNodeAttrs.value = simProp;
};
const updateProp = (temp: { [key: string]: any } | null, comp: boolean) => {
  propEditor.value = false;
  if (!temp) return;
  if (comp) {
    const node = graph?.getSelectedCells()[0];
    const preData = node?.getData();
    let data = preData;
    for (let prop of data.attrs) {
      if (temp[prop.name]) prop.value = temp[prop.name];
    }
    node?.setData(data);
    node?.notify("change:data", {
      cell: node,
      current: data,
      previous: preData,
    });
  } else {
    for (let prop of simProp) {
      if (temp[prop.name]) prop.value = temp[prop.name];
    }
  }
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
      router: "metro",
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
          color: "#54545496", // 主网格线颜色
          thickness: 1, // 主网格线宽度
        },
        {
          color: "#5454545a", // 次网格线颜色
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
      showEdgeSelectionBox: false,
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
  Graph.registerPortLayout("stop", (portsPositionArgs, elemBBox) => {
    return portsPositionArgs.map((_, idx) => {
      return {
        position: {
          x: ((idx + 1) / (portsPositionArgs.length + 1)) * elemBBox.width,
          y: 0,
        },
        angle: 0,
      };
    });
  });
  Graph.registerPortLayout("sbottom", (portsPositionArgs, elemBBox) => {
    return portsPositionArgs.map((_, idx) => {
      return {
        position: {
          x: ((idx + 1) * elemBBox.width) / (portsPositionArgs.length + 1),
          y: elemBBox.height,
        },
        angle: 0,
      };
    });
  });
  Graph.registerPortLayout("sleft", (portsPositionArgs, elemBBox) => {
    return portsPositionArgs.map((_, idx) => {
      return {
        position: {
          x: 0,
          y: ((idx + 1) * elemBBox.height) / (portsPositionArgs.length + 1),
        },
        angle: 0,
      };
    });
  });
  Graph.registerPortLayout("sright", (portsPositionArgs, elemBBox) => {
    return portsPositionArgs.map((_, idx) => {
      return {
        position: {
          x: elemBBox.width,
          y: ((idx + 1) * elemBBox.height) / (portsPositionArgs.length + 1),
        },
        angle: 0,
      };
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
        stop: {
          position: "stop",
          attrs: portattr,
        },
        sbottom: {
          position: "sbottom",
          attrs: portattr,
        },
        sleft: {
          position: "sleft",
          attrs: portattr,
        },
        sright: {
          position: "sright",
          attrs: portattr,
        },
      },
    },
  });
  graph.on("node:dblclick", ({ node }: { node: Node }) => {
    comps.value = true;
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
    width: icon.properties.width,
    height: icon.properties.height,
    data: icon.properties,
    ports: icon.properties.ports.map((e) => {
      return {
        group: e.gp,
        attrs: {
          text: {
            text: e.lb,
            fill: e.clr,
          },
        },
        label: {
          position: e.gp.substring(1),
        },
      };
    }),
    attrs: {
      text: {
        text: "hhh",
      },
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
