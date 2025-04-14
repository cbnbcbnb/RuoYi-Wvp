<template>
  <div class="app-container">
    <el-tabs v-model="activeName" class="demo-tabs" @tab-click="handleClick">
      <el-tab-pane label="行政区划" name="region">
        <Region/>
      </el-tab-pane>
      <el-tab-pane label="业务分组" name="group">
        <Group/>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script setup name="Thoroughfare">
import Region from "./region.vue"
import Group from "./group.vue"

const activeName = ref('region')

const handleClick = () => {
  nextTick(() => {

  })
}
</script>

<style scoped>

</style>
