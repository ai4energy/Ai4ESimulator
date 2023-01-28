<template>
  <n-drawer :show="open" width="30em" @vnode-before-update="refresh">
    <n-drawer-content :native-scrollbar="false">
      <template #header> {{ title }}属性编辑 </template>
      <n-form
        v-if="iconAttrs?.length"
        ref="formRef"
        :model="asmProps"
        label-placement="left"
        label-width="auto"
        require-mark-placement="right-hanging"
      >
        <n-form-item
          v-for="(attr, idx) in iconAttrs"
          :key="idx"
          :label="attr.name"
          :path="attr.name"
        >
          <n-input-number
            v-if="attr.type == 'number'"
            v-model:value="asmProps[attr.name]"
            :placeholder="(attr.holder as string)"
            :default-value="(attr.value as number)"
          >
            <template #suffix> {{ attr.unit }} </template>
          </n-input-number>
          <n-input
            v-else-if="attr.type == 'string'"
            v-model:value="asmProps[attr.name]"
            :placeholder="(attr.holder as string)"
            :default-value="(attr.value as string)"
          ></n-input>
          <n-select
            v-else-if="attr.type == 'multiselection'"
            v-model:value="asmProps[attr.name]"
            multiple
            :options="options"
            :placeholder="(attr.holder as string)"
            :default-value="(attr.holder as string)"
          ></n-select>
          <n-input-group v-else-if="attr.type == 'multinum'">
            <n-input-number
              v-model:value="(asmProps[attr.name] as Array<number>)[0]"
              :placeholder="(attr.holder as string[])[0]"
              clearable
            />
            <n-input-number
              v-model:value="(asmProps[attr.name] as Array<number>)[1]"
              :placeholder="(attr.holder as string[])[1]"
              clearable
            />
            <n-input-number
              v-model:value="(asmProps[attr.name] as Array<number>)[2]"
              :placeholder="(attr.holder as string[])[2]"
              clearable
            />
          </n-input-group>
          <n-dynamic-tags
            v-else-if="attr.type == 'tags'"
            v-model:value="asmProps[attr.name]"
          ></n-dynamic-tags>
        </n-form-item>
        {{ asmProps }}
      </n-form>
      <h2 v-else>此组件没有可设置的属性</h2>
      <template #footer>
        <n-button-group>
          <n-button
            @click="
              $emit(
                'updating',
                iconAttrs?.length ? asmProps : null,
                $props.comps
              )
            "
            >确定</n-button
          >
          <n-button @click="$emit('closing')">放弃</n-button>
        </n-button-group>
      </template>
    </n-drawer-content>
  </n-drawer>
</template>

<script setup lang="ts">
import { computed, ref, type Ref } from "vue";
import {
  NDrawer,
  NDrawerContent,
  NButton,
  NButtonGroup,
  NSelect,
  NDynamicTags,
  NInputGroup,
  type FormInst,
  NForm,
  NInput,
  NInputNumber,
  NFormItem,
} from "naive-ui";
interface IAttr {
  name: string;
  type: string;
  value: number | string | Array<string | number>;
  unit?: string;
  require: boolean;
  holder?: string | Array<string>;
}

const props = defineProps<{
  open: boolean;
  comps: boolean;
  iconAttrs?: Array<IAttr>;
}>();

const title = computed(() => (props.comps ? "组件" : "仿真"));

defineEmits(["closing", "updating"]);
const formRef = ref<FormInst | null>(null);
const asmProps: Ref<{ [key: string]: any }> = ref({});
const refresh = () => {
  asmProps.value = {};
  props.iconAttrs?.forEach((ele) => (asmProps.value[ele.name] = ele.value));
};
const options = [
  {
    label: "ModelingToolkit",
    value: "ModelingToolkit",
    disabled: true,
  },
  {
    label: "DifferentialEquations",
    value: "DifferentialEquations",
    disabled: true,
  },
  {
    label: "Rosenbrock23",
    value: "Rosenbrock23",
    disabled: false,
  },
];
</script>
