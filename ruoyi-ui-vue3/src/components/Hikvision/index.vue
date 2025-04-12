<template>
  <div>
    <el-alert title="由于海康设备有支持websocket和不支持websocket两种大家按需食用qwq" type="success" />
    <el-tabs v-model="activeName" class="demo-tabs" @tab-click="handleClick">
      <el-tab-pane label="无ws版本" name="noWs">
        <RtspVideo :rtspVideo="rtcUrl" />
      </el-tab-pane>
      <el-tab-pane label="ws版本" name="ws">
        正在开发中...
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup name="Hikvision">
import RtspVideo from '@/components/rtspVideo/index.vue';
import {defineProps} from "vue";

function handleClick(){

}

const props = defineProps({
  rtsp: {
    type: String,
    required: true,
    default: ''
  }
})

const videoError = (e) => {
  console.log("播放器错误：" + JSON.stringify(e));
}

const rtcUrl= ref("rtsp://admin:hx147258@192.168.158.189:554/Streaming/Channels/102");
const hasAudio = ref(false);

const activeName = ref('noWs');

</script>

<style scoped>

</style>
