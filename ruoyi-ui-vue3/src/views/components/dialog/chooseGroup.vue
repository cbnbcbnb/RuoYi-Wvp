<template>
  <div>
    <el-dialog
        title="选择虚拟组织"
        width="30%"
        top="5rem"
        :close-on-click-modal="false"
        v-model="showDialog"
        :destroy-on-close="true"
        @close="close()"
    >
      <GroupTree ref="groupTree" @handleNodeClick="handleNodeClick"></GroupTree>
      <el-form style="margin-top: 20px">
        <el-form-item>
          <div style="text-align: right">
            <el-button type="primary" @click="onSubmit">保存</el-button>
            <el-button @click="close">取消</el-button>
          </div>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script setup name="chooseGroup">
import GroupTree from "../common/GroupTree.vue";
import {defineEmits} from "vue";
const emit = defineEmits(['onSubmit']);
const showDialog = ref(false);
const groupDeviceId = ref('');
const businessGroup = ref('');
defineExpose({openDialog})

function openDialog() {
  showDialog.value = true;
}

function onSubmit() {
  close();

  emit('onSubmit', groupDeviceId.value, businessGroup.value);
}

function close() {
  showDialog.value = false;
}

function handleNodeClick(data) {
  groupDeviceId.value = data.deviceId;
  businessGroup.value = data.businessGroup;
}
</script>
