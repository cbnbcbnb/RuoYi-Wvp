<template>
  <div class="app-container">
    <DaHua :player-options="playerOptions" ref="dahuaPlayer"/>
  </div>
</template>

<script setup name="DaHuaPlay">
import DaHua from "@/components/daHua/index.vue";
import { onMounted } from "vue";

const dahuaPlayer = ref(null);
const playerOptions = ref({
  ip: '192.168.158.63',
  rtspURL: 'rtsp://192.168.158.63:554/cam/realmonitor?channel=1&subtype=1&unicast=true&proto=Onvif',
  username: 'admin',
  password: 'admin123'
});

onMounted(() => {
  if(dahuaPlayer.value){
    dahuaPlayer.value.playerPlay();
  }
});

</script>


<style scoped>

</style>
