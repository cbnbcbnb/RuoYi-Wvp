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
            <svg-icon icon-class="github" @click="spiltIndex(0)" class="flex-icon" />
            <svg-icon icon-class="github" @click="spiltIndex(4)" class="flex-icon" />
            <svg-icon icon-class="github" @click="spiltIndex(6)" class="flex-icon" />
            <svg-icon icon-class="github" @click="spiltIndex(9)" class="flex-icon" />
          </div>
          <div style="width: 100%; height: 600px; margin-top: 20px;">
            <el-row>
              <el-col :span="24">
                <div class="player">
                  <CusPlayer ref="video"></CusPlayer>
                </div>
              </el-col>
            </el-row>
          </div>

          <div style="display: flex; flex-wrap: wrap; margin-top: 10px;">
            <div style="width: 50%; height: 400px;">
              <el-row>
                <el-col :span="24">
                  <div style="width: 100%; height: 400px; background-color: #000000; border: 4px solid rgb(0, 198, 255) !important;">
                    <CusPlayer ref="video"></CusPlayer>
                  </div>
                </el-col>
              </el-row>
            </div>

            <div style="width: 50%; height: 400px;">
              <el-row>
                <el-col :span="24">
                  <div style="width: 100%; height: 400px; background-color: #000000; border: 4px solid rgb(0, 198, 255) !important;">
                    <CusPlayer ref="video"></CusPlayer>
                  </div>
                </el-col>
              </el-row>
            </div>

            <div style="width: 50%; height: 400px;">
              <el-row>
                <el-col :span="24">
                  <div style="width: 100%; height: 400px; background-color: #000000; border: 4px solid rgb(0, 198, 255) !important;">
                    <CusPlayer ref="video"></CusPlayer>
                  </div>
                </el-col>
              </el-row>
            </div>

            <div style="width: 50%; height: 400px;">
              <el-row>
                <el-col :span="24">
                  <div style="width: 100%; height: 400px; background-color: #000000; border: 4px solid rgb(0, 198, 255) !important;">
                    <CusPlayer ref="video"></CusPlayer>
                  </div>
                </el-col>
              </el-row>
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
  civilCode: "",
})

const queryParamsGroup = ref({
  pageNum: 1,
  pageSize: 200,
  groupDeviceId: "",
})

const video = ref(null);

const treeData = ref([]);
const defaultProps = {
  children: 'children',
  label: 'name',
  isLeaf: 'leaf'
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
      queryParamsGroup.value.groupDeviceId = node.data.deviceId;
      const response = await queryListByParentId(queryParamsGroup.value);
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
    console.log("1111", res);
    video.value.createPlayer(res.data.flv, 0)
    // vUrl.value = res.data.flv;
    // openPlay.value = true;
  }
};

const activeValue = ref(true);

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
  console.log("index", index);
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

.player {
  width: 100%;
  height: 600px;
  background-color: #000000;
}

.flex-icon {
  margin-left: 10px;
}
</style>


