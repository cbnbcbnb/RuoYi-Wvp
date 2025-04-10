<template>
  <div>
    <el-dialog
        title="选择行政区划"
        width="30%"
        top="5rem"
        :close-on-click-modal="false"
        v-model="showDialog"
        :destroy-on-close="true"
        @close="close()"
    >
      <RegionTree ref="regionTree"
                  :clickEvent="treeNodeClickEvent"
      ></RegionTree>
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

<script setup name="ChooseCivilCode">
import RegionTree from "../../components/common/RegionTree.vue";

const showDialog = ref(false);
const endCallback = ref(false);
const regionDeviceId = ref('');

defineExpose({openDialog})

function openDialog(callback) {
  showDialog.value = true;
  endCallback.value = callback;
}

function onSubmit() {
  if (endCallback.value) {
    endCallback.value = regionDeviceId.value
  }
  close();
}

function close() {
  showDialog.value = false;
}

function treeNodeClickEvent(region) {
  regionDeviceId.value = region.deviceId;
}
</script>
