<template>
  <n-card title="卡片" closable @close="handleClose">
    <template #header>
      <n-switch v-model:value="preview">
        <template #checked> 预览 </template>
        <template #unchecked> 代码 </template>
      </n-switch>
    </template>
    <template v-if="preview">
      <n-skeleton v-if="loading" text :width="6" />
      <div v-html="rendered" v-else></div>
    </template>
    <n-input
      v-else
      v-model:value="raw"
      type="textarea"
      placeholder="请输入内容"
      :autosize="{ minRows: 6 }"
    />
  </n-card>
</template>

<script setup lang="ts">
import { NCard, NSwitch, NInput, NSkeleton, useDialog } from "naive-ui";
import { ref, watch } from "vue";
import { marked } from "marked";
import Dompurify from "dompurify";

const emit = defineEmits(["deprecating"]);
const raw = ref("");
const rendered = ref("");
const loading = ref(true);
const preview = ref(false);
const diaglog = useDialog();
const handleClose = () => {
  diaglog.warning({
    title: "警告",
    content: "确定要删除文本段落吗？",
    positiveText: "确定",
    negativeText: "放弃",
    onPositiveClick: () => emit("deprecating"),
  });
};

const render = async (text: string): Promise<string> =>
  new Promise((resolve, reject) => {
    marked.parse(text, (error, parseResult) => {
      if (error) reject(error);
      else resolve(Dompurify.sanitize(parseResult));
    });
  });

watch(preview, (newValue) => {
  if (newValue) loading.value = true;
  render(raw.value)
    .then((res) => {
      rendered.value = res;
      loading.value = false;
    })
    .catch((err) => {
      window.$msg.error("Sorry, sth wrong with Markdown rendering!");
      if (import.meta.env.DEV) console.error(err.toString());
    });
});
</script>
