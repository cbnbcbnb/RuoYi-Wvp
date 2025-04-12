<template>
  <div class="app-container">
    <el-card>
      <el-row :gutter="1" type="flex" align="middle">
        <el-col :span="4">
          <el-text class="mx-1" type="primary">设备名称：{{ name }}</el-text>
        </el-col>
        <el-col :span="10">
          <div style="display: flex;">
            <el-text class="mx-1" type="primary">播放地址：</el-text>
            <el-input v-model="playUrl" placeholder="播放地址" disabled style="width: 85%"></el-input>
          </div>
        </el-col>
        <el-col :span="10">
          <el-button @click="handlePlay" type="primary">播放</el-button>
        </el-col>
      </el-row>
    </el-card>
    <div style="height: 20px;"></div>
    <el-card>
      <div style="width: 800px; height: 600px;">
        <el-row>
          <el-col :span="24">
            <div class="selectVideo">
              <CusPlayer ref="video"></CusPlayer>
            </div>
          </el-col>
        </el-row>
      </div>
      <div style="height: 20px;"></div>
    </el-card>
  </div>
</template>

<script setup name="PalyOnvif">
import CusPlayer from "@/components/flv/CusPlayer.vue";

const {proxy} = getCurrentInstance();

const name = ref(proxy.$route.query.name);
const playUrl = ref(proxy.$route.query.url);
const video = ref(null);

const handlePlay = () => {
  // 后续修改
  const prefix = "http://localhost:8866/live?url=";
  if (playUrl.value) {
    if (!playUrl.value.startsWith(prefix)) {
      playUrl.value = prefix + playUrl.value;
    }
    video.value.createPlayer(playUrl.value, 0)
  } else {
    alert('请填写播放地址');
  }
};


</script>

<style scoped>
.selectVideo {
  height: 600px;
  width: 800px;
}
</style>
