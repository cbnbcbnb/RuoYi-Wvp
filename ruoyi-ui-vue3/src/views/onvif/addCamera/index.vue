<template>
  <div class="app-container">
    <el-card header="添加设备">
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form ref="probeRef" :model="probeForm" :rules="rules" label-width="120px">
            <el-form-item label="设备名称" prop="name">
              <el-input v-model="probeForm.name" placeholder="请输入设备名称"/>
            </el-form-item>
            <el-form-item label="ONVIF IP" prop="ip">
              <el-input v-model="probeForm.ip" placeholder="请输入ONVIF IP"/>
            </el-form-item>
            <el-form-item label="ONVIF用户名" prop="username">
              <el-input v-model="probeForm.username" placeholder="请输入ONVIF用户名"/>
            </el-form-item>
            <el-form-item label="ONVIF密码" prop="password">
              <el-input v-model="probeForm.password" placeholder="请输入ONVIF密码"/>
            </el-form-item>
          </el-form>
          <div style="display: flex; justify-content: space-around;">
            <el-button type="primary" @click="submitForm">探 测</el-button>
          </div>
        </el-col>
        <el-col :span="12">
          <el-form ref="resultRef" :model="resultForm" :rules="rulesResult" label-width="120px">
            <el-form-item label="厂商" prop="firm">
              <el-input v-model="resultForm.firm" placeholder="请输入厂商" disabled/>
            </el-form-item>
            <el-form-item label="型号" prop="model">
              <el-input v-model="resultForm.model" placeholder="请输入型号" disabled/>
            </el-form-item>
            <el-form-item label="固件版本" prop="firmwareVersion">
              <el-input v-model="resultForm.firmwareVersion" placeholder="请输入固件版本" disabled/>
            </el-form-item>
            <el-form-item label="直播流地址" prop="url">
              <el-select
                  v-model="resultForm.url"
                  class="m-2"
                  placeholder="请选择直播流地址"
                  size="large"
                  :disabled="disabledAdd"
              >
                <el-option
                    v-for="item in resultForm.streamUris"
                    :key="item"
                    :label="item"
                    :value="item"
                />
              </el-select>
            </el-form-item>
            <div style="display: flex; justify-content: space-around;">
              <el-button type="primary" @click="submitResultForm" :disabled="disabledAdd">添 加</el-button>
            </div>
          </el-form>
        </el-col>
      </el-row>

    </el-card>
  </div>
</template>

<script setup name="addCamera">
import {probe} from '@/api/onvif/addCamera';
import { addDevice } from "@/api/onvif/device";
import {ref} from 'vue';

const {proxy} = getCurrentInstance();

const url = ref('');
const disabledAdd = ref(true);
const probeForm = ref({
  name: '球机',
  ip: '192.168.158.63',
  username: 'admin',
  password: 'admin123',
});
const resultForm = ref({});
const rules = ref({
  id: [{required: true, message: "编号不能为空", trigger: "blur"}],
  ip: [{required: true, message: "ip不能为空", trigger: "blur"}],
  username: [{required: true, message: "用户名不能为空", trigger: "blur"}],
  password: [{required: true, message: "密码不能为空", trigger: "blur"}],
});
const rulesResult = ref({
  firm: [{required: true, message: "设备厂商不能为空", trigger: "blur"}],
  model: [{required: true, message: "设备型号不能为空", trigger: "blur"}],
  firmwareVersion: [{required: true, message: "固件版本不能为空", trigger: "blur"}],
  url: [{required: true, message: "直播流地址不能为空", trigger: "blur"}],
});

const submitForm = () => {
  proxy.$refs["probeRef"].validate(async valid => {
    if (valid) {
      const query = {
        ip: probeForm.value.ip,
        username: probeForm.value.username,
        password: probeForm.value.password,
      };
      resultForm.value = {};
      const res = await probe(query);
      resultForm.value.firm = res.data.firm;
      resultForm.value.model = res.data.model;
      resultForm.value.firmwareVersion = res.data.firmwareVersion;
      resultForm.value.streamUris = res.data.streamUris;
      disabledAdd.value = false;
      proxy.$modal.msgSuccess("操作成功");
    }
  });
};

const submitResultForm = () => {
  proxy.$refs["resultRef"].validate(async valid => {
    if (valid) {
      const data = {
        id: null,
        name: probeForm.value.name,
        ip: probeForm.value.ip,
        userName: probeForm.value.username,
        password: probeForm.value.password,
        firm: resultForm.value.firm,
        url: resultForm.value.url,
        model: resultForm.value.model,
        firmwareVersion: resultForm.value.firmwareVersion,
        streamUris: resultForm.value.streamUris,
      };
      await addDevice(data);
      proxy.$modal.msgSuccess("操作成功");
      probeForm.value = {};
      resultForm.value = {};
    }
  });
}

</script>

<style scoped>
</style>
