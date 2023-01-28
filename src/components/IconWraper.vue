<template>
  <div class="icon-wraper">
    <svg-render :eleList="icon" />
    <p>
      {{ label }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { h, inject, onMounted, reactive, ref, type VNode } from "vue";
import type { Node } from "@antv/x6";
import { iconList } from "@/assets/assembly.json";

interface IAttr {
  name: string;
  type: string;
  value: number | string | Array<number | string>;
  unit?: string;
  require: boolean;
  holder?: string;
}
interface ISvgJson {
  name: string;
  attrs?: { [key: string]: any };
  children?: Array<ISvgJson> | null;
}
interface IProps {
  name: string;
  label: string;
  category: string;
  width: number;
  height: number;
  attrs?: Array<IAttr>;
}

const getNode: (() => Node) | undefined = inject("getNode");
const props = reactive<IProps>({
  name: "",
  label: "",
  category: "",
  width: 0,
  height: 0,
});

const icon = reactive<ISvgJson[]>([]);

const label = ref("");

onMounted(() => {
  if (getNode) {
    const node = getNode();
    props.name = node.getData().name;
    props.label = node.getData().label;
    props.width = node.getData().width;
    props.height = node.getData().height;
    props.category = node.getData().category;
    props.attrs = node.getData().attrs;
    node.on("change:data", ({ current }) => {
      const { attrs } = current;
      props.attrs = attrs;
      label.value =
        (props.attrs?.find((e) => e.name == "name")?.value as string) ?? "";
    });
    label.value =
      (props.attrs?.find((e) => e.name == "name")?.value as string) ?? "";
    const temp = iconList.filter((e) => e.properties.name == props.name)?.[0]
      .icon;
    if (!icon.length && temp) icon.push(temp);
  }
});

const SvgRender = (propsCom: { eleList: Array<ISvgJson> }) => {
  const renderResult: Array<VNode> = propsCom.eleList.map((ele) => {
    if (ele.name == "svg") {
      if (ele.attrs) {
        ele.attrs["width"] = props.width;
        ele.attrs["height"] = props.height;
        ele.attrs["class"] = undefined;
      } else {
        ele.attrs = {
          class: undefined,
          width: props.width,
          height: props.height,
        };
      }
    }
    if (ele.children)
      return h(ele.name, ele.attrs, SvgRender({ eleList: ele.children }));
    else return h(ele.name, ele.attrs);
  });
  return renderResult;
};
</script>

<style>
.icon-wraper {
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 0.8rem;
}
</style>
