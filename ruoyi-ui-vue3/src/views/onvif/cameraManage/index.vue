<template>
  <div class="app-container">
    <el-card>
      <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch">
        <el-form-item label="ip" prop="ip">
          <el-input
              v-model="queryParams.ip"
              placeholder="请输入ip"
              clearable
              @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item label="设备厂商" prop="firm">
          <el-input
              v-model="queryParams.firm"
              placeholder="请输入设备厂商"
              clearable
              @keyup.enter="handleQuery"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <el-card class="m-1">
      <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
          <!--          <el-button-->
          <!--              type="primary"-->
          <!--              plain-->
          <!--              icon="Plus"-->
          <!--              @click="handleAdd"-->
          <!--              v-hasPermi="['onvif:device:add']"-->
          <!--          >新增-->
          <!--          </el-button>-->
        </el-col>
        <el-col :span="1.5">
          <el-button
              type="success"
              plain
              icon="Edit"
              :disabled="single"
              @click="handleUpdate"
              v-hasPermi="['onvif:device:edit']"
          >修改
          </el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
              type="danger"
              plain
              icon="Delete"
              :disabled="multiple"
              @click="handleDelete"
              v-hasPermi="['onvif:device:remove']"
          >删除
          </el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
              type="warning"
              plain
              icon="Download"
              @click="handleExport"
              v-hasPermi="['onvif:device:export']"
          >导出
          </el-button>
        </el-col>
        <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
      </el-row>

      <el-table v-loading="loading" :data="deviceList" @selection-change="handleSelectionChange" border>
        <el-table-column type="selection" width="55" align="center"/>
        <el-table-column label="名称" align="center" prop="name" width="140" fixed/>
        <el-table-column label="ip" align="center" prop="ip" width="140" fixed/>
        <el-table-column label="设备厂商" align="center" prop="firm" width="140"/>
        <el-table-column label="设备型号" align="center" prop="model" width="300"/>
        <el-table-column label="固件版本" align="center" prop="firmwareVersion" width="300"/>
        <el-table-column label="用户名" align="center" prop="userName" width="120"/>
        <el-table-column label="密码" align="center" prop="password" width="120"/>
        <el-table-column label="默认播放地址" align="center" prop="url" width="800">
          <template #default="scope">
            <el-text style="cursor: pointer;" @click="copyToClipboard(scope.row.url)" type="primary">{{
                scope.row.url
              }}
            </el-text>
          </template>
        </el-table-column>
        <el-table-column label="全部播放地址" align="center" prop="streamUris" width="140">
          <template #default="scope">
            <el-button type="primary" text @click="viewUrls(scope.row.streamUris)">查看</el-button>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="200" fixed="right">
          <template #default="scope">
            <el-button link type="primary" icon="View" @click="handleView(scope.row)"
                       v-hasPermi="['onvif:device:view']">播放
            </el-button>
            <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)"
                       v-hasPermi="['onvif:device:edit']">修改
            </el-button>
            <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)"
                       v-hasPermi="['onvif:device:remove']">删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
          v-show="total>0"
          :total="total"
          v-model:page="queryParams.pageNum"
          v-model:limit="queryParams.pageSize"
          @pagination="getList"
      />
    </el-card>
    <!-- 添加或修改onvif 设备对话框 -->
    <el-dialog :title="title" v-model="open" width="1000px" append-to-body>
      <el-form ref="deviceRef" :model="form" :rules="rules" label-width="120px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="设备名称" prop="userName">
              <el-input v-model="form.name" placeholder="请输入设备名称"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="ip" prop="ip">
              <el-input v-model="form.ip" placeholder="请输入ip"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="用户名" prop="userName">
              <el-input v-model="form.userName" placeholder="请输入用户名"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="密码" prop="password">
              <el-input v-model="form.password" placeholder="请输入密码"/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="默认播放地址" prop="url">
              <el-select
                  v-model="form.url"
                  class="m-2"
                  placeholder="请选择直播流地址"
                  size="large"
              >
                <el-option
                    v-for="item in form.streamUris"
                    :key="item"
                    :label="item"
                    :value="item"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设备厂商" prop="firm">
              <el-input v-model="form.firm" placeholder="请输入设备厂商" disabled/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设备型号" prop="model">
              <el-input v-model="form.model" placeholder="请输入设备型号" disabled/>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="固件版本" prop="firmwareVersion">
              <el-input v-model="form.firmwareVersion" placeholder="请输入固件版本" disabled/>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"/>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 查看直播流地址 对话框 -->
    <el-dialog :title="title" v-model="showUrl" width="800px" append-to-body>
      <div v-for="item in urls" :key="item" style="margin-bottom: 10px;">
        <el-text type="primary" style="cursor: pointer;" @click="copyToClipboard(item)">{{ item }}</el-text>
      </div>
    </el-dialog>

    <!-- 播放弹窗 对话框 -->
    <el-dialog :title="title" v-model="showPaly" width="835px" @opened="openedPaly">
      <div v-if="brand === 'Dahua'">
        <DaHua :player-options="playerOptions" ref="dahuaPlayer"/>
      </div>
      <div v-if="brand === 'HIKVISION'">
        <Hikvision :rtsp="playerOptions.rtspURL" />
      </div>
    </el-dialog>


  </div>
</template>

<script setup name="Device">
import {listDevice, getDevice, delDevice, addDevice, updateDevice} from "@/api/onvif/device";
import DaHua from "@/components/daHua/index.vue";
import Hikvision from "@/components/Hikvision/index.vue";

const {proxy} = getCurrentInstance();

const deviceList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");
const brand = ref("");
const urls = ref({});
const showUrl = ref(false);
const showPaly = ref(false);
const video = ref(null);
const playerOptions = ref({});
const dahuaPlayer = ref(null);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    ip: null,
    userName: null,
    password: null,
    url: null,
    firm: null,
    model: null,
    firmwareVersion: null,
    streamUris: null,
  },
  rules: {}
});

const {queryParams, form, rules} = toRefs(data);

function handleView(row) {
  brand.value = row.firm;
  playerOptions.value.ip = row.ip;
  playerOptions.value.rtspURL = row.url;
  playerOptions.value.username = row.userName;
  playerOptions.value.password = row.password;

  title.value = "视频播放";
  showPaly.value = true;
  console.log(playerOptions.value.rtspURL)
}

function openedPaly() {
  if(brand.value === 'Dahua'){
    if(dahuaPlayer.value){
      dahuaPlayer.value.playerPlay();
    }
  }
}


function copyToClipboard(text) {
  navigator.clipboard.writeText(text).then(() => {
    proxy.$modal.msgSuccess("复制成功！");
  }).catch((err) => {
    proxy.$modal.msgError("复制失败，请重试！");
  });
}

function viewUrls(row) {
  title.value = "查看直播流地址";
  urls.value = JSON.parse(row);
  showUrl.value = true;
  console.log(JSON.parse(row))
}

/** 查询onvif 设备列表 */
function getList() {
  loading.value = true;
  listDevice(queryParams.value).then(response => {
    deviceList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    ip: null,
    userName: null,
    password: null,
    url: null,
    firm: null,
    model: null,
    firmwareVersion: null,
    streamUris: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null,
    remark: null
  };
  proxy.resetForm("deviceRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加onvif 设备";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value
  getDevice(_id).then(response => {

    form.value = response.data;
    form.value.streamUris = JSON.parse(response.data.streamUris);
    console.log(form.value)
    open.value = true;
    title.value = "修改onvif 设备";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["deviceRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateDevice(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addDevice(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除onvif 设备编号为"' + _ids + '"的数据项？').then(function () {
    return delDevice(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('onvif /device/export', {
    ...queryParams.value
  }, `device_${new Date().getTime()}.xlsx`)
}

getList();
</script>

<style scoped>
.selectVideo {
  height: 600px;
  width: 800px;
}
</style>
