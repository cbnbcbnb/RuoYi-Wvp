<template>
  <div>
    <el-alert title="由于海康设备有支持websocket和不支持websocket两种大家按需食用qwq" type="success" />
    <el-tabs v-model="activeName" class="demo-tabs" @tab-click="handleClick">
      <el-tab-pane label="无ws版本" name="noWs">

      </el-tab-pane>
      <el-tab-pane label="ws版本" name="ws">
        正在开发中...
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup name="Hikvision">

function handleClick(){

}

const activeName = ref('noWs');

</script>

<style scoped>

</style>
