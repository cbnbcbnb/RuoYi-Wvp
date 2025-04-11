<template>
  <div>
    <el-tree
        style="max-width: 600px"
        :data="treeData"
        :props="{label: 'name', children: 'children'}"
        @node-click="handleNodeClick"
    />
  </div>
</template>

<script setup name="RegionTree">
import {queryForTree} from "../../../api/wvp/region.js";
import {defineEmits} from "vue";
const emit = defineEmits(['handleNodeClick']);
const {proxy} = getCurrentInstance();

const searchSrt = ref('');
const treeData = ref([]);

const props = defineProps({
  hasChannel: {},
});

onMounted(() => {
  queryForTree({
    query: searchSrt.value,
    parent: null,
    hasChannel: props.hasChannel
  }).then((res) => {
    let data = [
      {
        name: "根资源组",
        children: []
      }
    ]
    data[0].children = proxy.handleTree(res.data, "id")
    treeData.value = data
  })
})

function handleNodeClick(data){
  emit('handleNodeClick', data);
}
</script>
