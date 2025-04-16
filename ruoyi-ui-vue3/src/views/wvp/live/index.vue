<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card>
          <div class="top">
            <div>通道列表</div>
            <div>
              <el-switch
                  v-model="activeValue"
                  active-text="行政区划"
                  inactive-text="业务分组"
                  @change="onSwitch"
              />
            </div>
          </div>
          <div>
            <el-tree
                :data="treeData"
                :props="defaultProps"
                lazy
                :load="loadNode"
                @node-click="handleNodeClick"/>
          </div>
        </el-card>
      </el-col>
      <el-col :span="18">
        <el-card>
          <div class="flex">
            分屏:
            <svg-icon :class="['flex-icon', { active: model === 1 }]"
                icon-class="splitOne" @click="spiltIndex(1)" class="flex-icon" />
            <svg-icon :class="['flex-icon', { active: model === 4 }]"
                icon-class="splitFour" @click="spiltIndex(4)" class="flex-icon" />
            <svg-icon :class="['flex-icon', { active: model === 6 }]"
                icon-class="splitSix" @click="spiltIndex(6)" class="flex-icon" />
            <svg-icon :class="['flex-icon', { active: model === 9 }]"
                icon-class="splitNine" @click="spiltIndex(9)" class="flex-icon" />
          </div>

          <div style="display: flex; flex-wrap: wrap; margin-top: 20px;">
            <div
                v-for="(item, index) in splitLayouts[splitShow]"
                :key="index"
                :style="getCellStyle(splitShow)"
                :class="['player-cell', { active: activePlayerIndex === index }]"
                @click="setActivePlayer(index)">
              <CusPlayer :ref="'video' + index" />
            </div>
          </div>

        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="WVPLive">
import {queryForTree} from "@/api/wvp/region";
import {queryListByCivilCode, queryListByParentId, sendDevicePush} from "@/api/wvp/channel.js";
import {queryForTree as groupQueryForTree} from "@/api/wvp/group.js";
import CusPlayer from "@/components/flv/CusPlayer.vue";

const {proxy} = getCurrentInstance();

const queryParams = ref({
  pageNum: 1,
  pageSize: 200,
})

const video = ref(null);

const treeData = ref([]);

const defaultProps = {
  children: 'children',
  label: 'name',
  isLeaf: 'leaf'
};

const splitLayouts = {
  1: [1],
  4: [1, 2, 3, 4],
  6: [1, 2, 3, 4, 5, 6],
  9: [1, 2, 3, 4, 5, 6, 7, 8, 9],
};

async function onSwitch(e) {
  if (activeValue.value) {
    await getTreeData();
  } else {
    await getGroupQueryForTree();
  }
}

const loadNode = async (node, resolve) => {
  if (node.level === 0) {
    return resolve(treeData.value);
  } else if (node.level === 1) {
    return resolve(treeData.value[node.level - 1].children);
  } else if (node.level === 2) {
    if (activeValue.value) {
      queryParams.value.civilCode = node.data.deviceId;
      const response = await queryListByCivilCode(queryParams.value);
      const children = response.rows.map(item => ({
        ...item,
        leaf: true,
        name: item.gbName
      }));
      resolve(children);
    } else {
      queryParams.value.groupDeviceId = node.data.deviceId;
      const response = await queryListByParentId(queryParams.value);
      const children = response.rows.map(item => ({
        ...item,
        leaf: true,
        name: item.gbName
      }));
      resolve(children);
    }
  }
};

const handleNodeClick = async (data) => {
  if (data.gbDeviceId && data.gbParentId) {
    const params = {
      deviceId: data.gbParentId,
      channelId: data.gbDeviceId
    }
    const res = await sendDevicePush(params);
    const videoRef = proxy.$refs[`video${activePlayerIndex.value}`];
    if (videoRef && videoRef[0]) {
      videoRef[0].createPlayer(res.data.flv, 0);
    } else {
      proxy.$modal.msgError("请选择播放器");
    }
  }
};

const splitShow = ref(1)
const borderWidth = ref(2)
const activePlayerIndex = ref(null);
const model = ref(1);
const activeValue = ref(true);

function getCellStyle(splitMode) {
  model.value = splitMode;
  const style = {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#000000",
    boxSizing: "border-box",
  };

  if (splitMode === 1) {
    style.width = "100%";
    style.height = "600px";
    style.border  = `${borderWidth.value}px solid #409EFF`;
  } else if (splitMode === 4) {
    style.width = "50%";
    style.height = "400px";
    style.border  = `${borderWidth.value}px solid #409EFF`;
    style.margin = "-2px";
  } else if (splitMode === 6) {
    style.width = "50%";
    style.height = "300px";
    style.border  = `${borderWidth.value}px solid #409EFF`;
    style.margin = "-2px";
  } else if (splitMode === 9) {
    style.width = "33.33%";
    style.height = "280px";
    style.border  = `${borderWidth.value}px solid #409EFF`;
    style.margin = "-2px";
  }

  return style;
}

function setActivePlayer(index) {
  activePlayerIndex.value = index;
}

async function getTreeData() {
  const res = await queryForTree();
  let data = [
    {
      name: "根资源组",
      children: []
    }
  ]
  data[0].children = proxy.handleTree(res.data, "id")
  treeData.value = data;
}

async function getGroupQueryForTree() {
  const res = await groupQueryForTree();
  let data = [
    {
      name: "根资源组",
      children: []
    }
  ]
  data[0].children = proxy.handleTree(res.data, "id")
  treeData.value = data;
}

function spiltIndex(index){
  splitShow.value = index;
  activePlayerIndex.value = null;
}

onMounted(async () => {
  await getTreeData();
});

</script>

<style scoped>
.top {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.flex {
  width: 100%;
  display: flex;
  align-items: center;
}

.player-cell {
  position: relative;
  transition: border-color 0.3s ease;
}

.player-cell:hover {
  cursor: pointer;
}

.player-cell.active {
  border-color: #67C23A !important;
  z-index: 999;
  boxSizing: "border-box"
}

.flex-icon {
  margin-left: 10px;
}

.flex-icon {
  margin-left: 10px;
  cursor: pointer;
  font-size: 20px;
  transition: color 0.3s ease, transform 0.3s ease;
}

.flex-icon.active {
  color: #409EFF;
  transform: scale(1.2);
}
</style>


