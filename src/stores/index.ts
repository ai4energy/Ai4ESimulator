import { reactive } from "vue";
import { defineStore } from "pinia";

export const useIconStore = defineStore("icons", () => {
  const NodeList = reactive<Array<Record<any, any>>>([]);
  // const doubleCount = computed(() => count.value * 2);
  function addNode(node: Record<any, any>) {
    NodeList.push(node);
  }

  return { NodeList, addNode /*, increment */ };
});
