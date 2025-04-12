<template>
  <div>
    <video id="rtspVideo" muted playsinline controls width="800" height="457"></video>
  </div>
</template>

<script setup>
import { defineProps } from 'vue';

const props = defineProps({
  rtspVideo: {
    type: String,
    required: true,
    default: ''
  }
})

const webRtcServer = ref();
const initWebRtcServer = async () => {
  let url = "http://127.0.0.1:8005"
  nextTick(() => {
    webRtcServer.value = new WebRtcStreamer('rtspVideo', url);
    console.log(props.rtspVideo)
    webRtcServer.value.connect(props.rtspVideo)
  })
}

onUnmounted(() => {
  webRtcServer.value.disconnect()
  webRtcServer.value = null
})
initWebRtcServer();
</script>

<style scoped>

</style>
