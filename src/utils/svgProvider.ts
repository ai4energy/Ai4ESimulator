import { h, type VNode } from "vue";
import type { ISvgElement } from "@/utils/svg";

export function SvgRender(eleList: Array<ISvgElement>) {
  const renderResult: Array<VNode> = eleList.map((ele) => {
    if (ele.childern) return h(ele.tag, ele.props, SvgRender(ele.childern));
    else return h(ele.tag, ele.props);
  });
  return renderResult;
}
