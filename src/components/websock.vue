<script setup lang="ts">
import type { NButton, MessageReactive, MessageType } from 'naive-ui'
import { ref ,onBeforeUnmount ,onMounted} from 'vue'
let socket :any = null
let lockReconnect = false;
let reconnectData : any = null;
let destroy_msg : any = null;
let testdata = {"tesst":"test"};
let teststr = "test";
const types: MessageType[] = [
      'success',
      'info',
      'warning',
      'error',
      'loading'
    ]
  let msgReactive: MessageReactive | null = null
// Websoket连接成功事件
const websocketonopen = (res: any) => {
      console.log("WebSocket连接成功", res);
      window.$message.success("服务器连接成功！") 
    };
    // Websoket接收消息事件
    const websocketonmessage = (res: any) => {
      console.log("数据", res);
      handle_res(JSON.parse(res.data))
    };
    // Websoket连接错误事件
    const websocketonerror = (res: any) => {
      console.log("连接错误", res);
    };
    // Websoket断开事件
    const websocketclose = (res: any) => {
      console.log("断开连接", res);
      window.$message.error("服务器断开连接")
      reconnect()
    };
    const websocketsend = (data:any) => {
      socket.send(JSON.stringify(data));
    };
    const reconnect = ()=>{
        if(lockReconnect){       //这里很关键，因为连接失败之后之后会相继触发 连接关闭，不然会连接上两个 WebSocket
            return
        }
        lockReconnect = true;
        reconnectData && clearTimeout(reconnectData);
        reconnectData = setTimeout(()=>{
            initWebSocket();
            console.log("正在重新连接...");
            lockReconnect = false;
        },5000)
      };
      const initWebSocket = () => {
      // 创建 websocket 的实例
      const wsurl = import.meta.env.VITE_DEV_WebSockets;
      socket = new WebSocket(wsurl);
      socket.onopen = websocketonopen;
      socket.onmessage = websocketonmessage;
      socket.onerror = websocketonerror;
      socket.onclose = websocketclose;
    };
    const handle_res = (res :any) => {
      console.log("数据",res);
      
      if (res.status == "准备计算！") {
        if (msgReactive) {
          clearTimeout(destroy_msg);
          msgReactive.content = res.status
          msgReactive.type = "loading"
        }
        else{
          msgReactive = window.$message.loading(res.status, {
            duration: 0
          })  
        }
      } else if (res.status == "正在计算!") {
        if (msgReactive) {
          //将小数点后面的数字转换为百分数，并保留两位小数
          let percent = "  (" + (res.progress * 100).toFixed(2) + "%)";
          msgReactive.content = res.status + percent
        }
      } else if (res.status == "计算完成！") {
        if (msgReactive) {
          msgReactive.content = res.status
          msgReactive.type = "success"
          msgReactive.duration = 1000;
          //三秒后销毁msgReactive组件
          destroy_msg = setTimeout(() => {
            msgReactive?.destroy();
            msgReactive = null;
          }, 3000);
        }
      } else if (res.status == "计算出错！") {
        if (msgReactive) {
          msgReactive.content = res.status
          msgReactive.type = "error"
          msgReactive.duration = 1000;
          //三秒后销毁msgReactive组件
          destroy_msg = setTimeout(() => {
            msgReactive?.destroy();
            msgReactive = null;
          }, 3000);
        }
      } else {
        if (msgReactive) {
          msgReactive.content = res.status
        }
      }
    };
    onMounted(() => {
      // 创建 websocket 的实例
      initWebSocket();
    });
    onBeforeUnmount(() => {
      // 关闭连接
      websocketclose;
      lockReconnect = true;
      // 销毁 websocket 实例对象
      socket = null;
      clearTimeout(reconnectData); //离开清除 timeout
    });

</script>

<template>
</template>