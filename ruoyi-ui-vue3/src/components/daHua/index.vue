<template>
    <div>
      <canvas ref="canvasElement" style="background-color:#000;width: 800px;height: 450px;"></canvas>
    </div>
    <div class="button">
      <el-button type="primary" @click="playerPlay" :icon="VideoPause">播放</el-button>
      <el-button type="primary" @click="playerStop" :icon="VideoPlay">关闭</el-button>
    </div>

</template>

<script setup name="DaHua">
import { VideoPause, VideoPlay } from '@element-plus/icons-vue';
import { ref, defineExpose } from 'vue';

const props = defineProps({
  playerOptions: {
    type: Object,
    required: true,
    default: () => ({
      ip: '',
      rtspURL: '',
      username: '',
      password: ''
    })
  }
});

const emit = defineEmits(['player-stop', 'player-pause', 'player-play']);

const canvasElement = ref();
const videoElement = ref();

const channel = ref(0);

let player;

function playerStop() {
  player?.close();
}

function playerPause() {
  player?.pause();
}

function playerContinue() {
  player?.play();
}

function playerCapture() {
  player?.capture('test');
}


function playerPlay() {
  const options = {
    wsURL: `ws://${props.playerOptions.ip}/rtspoverwebsocket`,
    rtspURL: props.playerOptions.rtspURL,
    username: props.playerOptions.username,
    password: props.playerOptions.password
  };
  player = new window.PlayerControl(options);
  player.on('WorkerReady', function(){
    player.connect();
  });
  player.on('DecodeStart', function(rs){
    // console.log('start decode');
    // console.log(rs);
  });
  player.on('PlayStart', function(rs){
    // console.log('play');
    // console.log(rs);
  });
  player.on('Error', function(rs){
    // console.log('error');
    // console.log(rs);
  });
  player.on('FileOver', function(rs){
    // console.log('recorder play over');
    // console.log(rs);
  });
  player.on('MSEResolutionChanged', function(rs){
    // console.log('resolution  changed');
    // console.log(rs);
  });
  player.on('FrameTypeChange', function(rs){
    // console.log('video encode mode changed');
    // console.log(rs);
  });
  player.on('audioChange', function(rs){
    // console.log('audio encode changed');
    // console.log(rs);
  });
  player.init(canvasElement.value, videoElement.value);
  window.__player = player;
}

// 暴露方法给父组件
defineExpose({
  playerPlay,
  playerStop,
  playerPause,
  playerContinue,
  playerCapture
});

</script>

<style scoped>
.button{
  margin-top: 20px;
  display: flex;
  justify-content: center;
}
</style>
