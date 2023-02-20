<template>
  <svg-render :eleList="icon"/>
</template>

<script setup lang="ts">
import { h, onMounted, type VNode } from "vue";
interface IIconProbviderProp {
  icon: Array<ISvgJson>;
  iconId: string;
  iconSize: number;
  callback: (e: MouseEvent) => any;
}
interface ISvgJson {
  name: string;
  attrs?: { [key: string]: any };
  children?: Array<ISvgJson> | null;
}
const propsO = defineProps<IIconProbviderProp>();

const SvgRender = (props: { eleList: Array<ISvgJson> }) => {
  const renderResult: Array<VNode> = props.eleList.map((ele) => {
    if (ele.name == "svg") {
      if (ele.attrs) {
        ele.attrs["id"] = propsO.iconId;
        ele.attrs["class"] = "side-icon";
        ele.attrs["width"] = propsO.iconSize + "em";
        ele.attrs["height"] = propsO.iconSize + "em";
      } else {
        ele.attrs = {
          id: propsO.iconId,
          class: "side-icon",
          width: propsO.iconSize + "em",
          height: propsO.iconSize + "em",
        };
      }
    }
    if (ele.children)
      return h(ele.name, ele.attrs, SvgRender({ eleList: ele.children }));
    else return h(ele.name, ele.attrs);
  });
  return renderResult;
};

onMounted(() => {
  const eles = document.getElementsByClassName("side-icon");
  for (let i = 0; i != eles.length; i++) {
    (eles[i] as SVGElement).addEventListener("mousedown", propsO.callback);
  }
});
</script>

<style>
.side-icon {
  cursor: move;
  display: inline-block;
  margin: 0.3rem;
}
</style>
