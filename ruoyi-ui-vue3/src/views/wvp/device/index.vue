<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="设备名称" prop="name">
        <el-input
            v-model="queryParams.name"
            placeholder="请输入设备名称"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="地址" prop="ip">
        <el-input
            v-model="queryParams.ip"
            placeholder="请输入地址"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="厂家" prop="manufacturer">
        <el-input
            v-model="queryParams.manufacturer"
            placeholder="请输入厂家"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="在线状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择在线状态" style="width: 250px;"
                   default-first-option>
          <el-option label="在线" value="true"></el-option>
          <el-option label="离线" value="false"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="InfoFilled"
            @click="showInfo"
        >平台信息
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="deviceList" border>
      <el-table-column type="index" label="编号" width="80" align="center" fixed/>
      <el-table-column prop="name" label="名称" width="100" align="center" fixed>
      </el-table-column>
      <el-table-column prop="deviceId" label="设备编号" align="center" width="150">
      </el-table-column>
      <el-table-column label="IP地址" width="160" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag v-if="scope.row.hostAddress" size="medium">{{ scope.row.hostAddress }}</el-tag>
            <el-tag v-if="!scope.row.hostAddress" size="medium">未知</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="manufacturer" label="厂家" width="80" align="center">
      </el-table-column>
      <el-table-column prop="transport" label="信令传输模式" width="120" align="center">
      </el-table-column>
      <el-table-column label="流传输模式" width="160" align="center">
        <template #default="scope">
          <el-select size="mini" @change="transportChange(scope.row)" v-model="scope.row.streamMode"
                     placeholder="请选择" style="width: 120px">
            <el-option key="UDP" label="UDP" value="UDP"></el-option>
            <el-option key="TCP-ACTIVE" label="TCP主动模式" value="TCP-ACTIVE"></el-option>
            <el-option key="TCP-PASSIVE" label="TCP被动模式" value="TCP-PASSIVE"></el-option>
          </el-select>
        </template>
      </el-table-column>
      <el-table-column label="通道数" min-width="80" align="center">
        <template #default="scope">
          <span style="font-size: 1rem">{{ scope.row.channelCount }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" min-width="80" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium" v-if="scope.row.onLine">在线</el-tag>
            <el-tag size="medium" type="info" v-if="!scope.row.onLine">离线</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="订阅" min-width="250" align="center">
        <template #default="scope">
          <el-checkbox label="目录" :checked="scope.row.subscribeCycleForCatalog > 0"
                       @change="(e)=>subscribeForCatalog(scope.row.id, e)"></el-checkbox>
          <el-checkbox label="位置" :checked="scope.row.subscribeCycleForMobilePosition > 0"
                       @change="(e)=>subscribeForMobilePosition(scope.row.id, e)"></el-checkbox>
          <el-checkbox label="报警" disabled :checked="scope.row.subscribeCycleForAlarm > 0"></el-checkbox>
        </template>
      </el-table-column>
      <el-table-column prop="keepaliveTime" label="最近心跳" width="150" align="center">
      </el-table-column>
      <el-table-column prop="registerTime" label="最近注册" width="150" align="center">
      </el-table-column>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width" fixed="right">
        <template #default="scope">
          <el-button link type="primary" :disabled="scope.row.online===0"
                     @click="refDevice(scope.row)">刷新
          </el-button>
          <el-button type="text"
                     @click="showChannelList(scope.row)">通道
          </el-button>

          <el-button link type="primary" @click="handleUpdate(scope.row)">修改
          </el-button>

          <el-dropdown @command="(command)=>{moreClick(command, scope.row)}">
             <span class="el-dropdown-link">
              <el-button size="medium" type="text">
                更多
                <el-icon>
                  <arrow-down/>
                </el-icon>
              </el-button>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="delete" style="color: #f56c6c">
                  删除
                </el-dropdown-item>
                <el-dropdown-item command="setGuard" v-bind:disabled="!scope.row.onLine">
                  布防
                </el-dropdown-item>
                <el-dropdown-item command="resetGuard" v-bind:disabled="!scope.row.onLine">
                  撤防
                </el-dropdown-item>
                <el-dropdown-item command="syncBasicParam" v-bind:disabled="!scope.row.onLine">
                  基础配置同步
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改参数配置对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="设备编号" prop="deviceId">
          <el-input v-model="form.deviceId" disabled></el-input>
        </el-form-item>

        <el-form-item label="设备名称" prop="name">
          <el-input v-model="form.name" clearable></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="form.password" clearable></el-input>
        </el-form-item>
        <el-form-item label="收流IP" prop="sdpIp">
          <el-input type="sdpIp" v-model="form.sdpIp" clearable></el-input>
        </el-form-item>
        <el-form-item label="流媒体ID" prop="mediaServerId">
          <el-select v-model="form.mediaServerId" style="float: left; width: 100%">
            <el-option key="auto" label="自动负载最小" value="auto"></el-option>
            <el-option
                v-for="item in mediaServerList"
                :key="item.id"
                :label="item.id"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="字符集" prop="charset">
          <el-select v-model="form.charset" style="float: left; width: 100%">
            <el-option key="GB2312" label="GB2312" value="gb2312"></el-option>
            <el-option key="UTF-8" label="UTF-8" value="utf-8"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="其他选项">
          <el-checkbox label="SSRC校验" v-model="form.ssrcCheck" style="float: left"></el-checkbox>
          <el-checkbox label="作为消息通道" v-model="form.asMessageChannel" style="float: left"></el-checkbox>
          <el-checkbox label="收到ACK后发流" v-model="form.broadcastPushAfterAck" style="float: left"></el-checkbox>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog
        title="国标服务信息"
        width="1000px"
        v-model="showDialog"
        append-to-body
    >
      <div id="shared" style="margin-top: 1rem;margin-right: 100px;">
        <el-descriptions v-if="configInfoData.sip" :span="2" border>
          <el-descriptions-item label="编号">{{ configInfoData.sip.id }}</el-descriptions-item>
          <el-descriptions-item label="域">{{ configInfoData.sip.domain }}</el-descriptions-item>
          <el-descriptions-item label="IP">{{ configInfoData.sip.showIp }}</el-descriptions-item>
          <el-descriptions-item label="端口">{{ configInfoData.sip.port }}</el-descriptions-item>
          <el-descriptions-item label="密码">
            <el-tag size="small">{{ configInfoData.sip.password }}</el-tag>
          </el-descriptions-item>
        </el-descriptions>
      </div>
    </el-dialog>

    <el-dialog
        title="刷新设备"
        width="250px"
        v-model="showProgress"
        append-to-body
    >
      <div style="display:flex;align-items: center;justify-content: center">
        <el-progress type="dashboard" :percentage="percentage" :color="colors"/>
      </div>
      <div style="display:flex;align-items: center;justify-content: center">
        {{ msg }}
      </div>
    </el-dialog>
  </div>
</template>

<script setup name="Device">
import {
  deleteDevice,
  devicesSync,
  getDeviceById,
  listDevice,
  subscribeCatalog,
  subscribeMobilePosition, syncStatus,
  updateDevice,
  updateTransport,
} from "../../../api/wvp/device.js";
import {configInfo, getOnlineMediaServerList} from "../../../api/wvp/wvpMediaServer.js";
import router from "@/router";
import {guardApi} from "../../../api/wvp/control.js";
import {ElMessage} from 'element-plus'
import {configDownloadApi} from "../../../api/wvp/config.js";

const {proxy} = getCurrentInstance();

const deviceList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const total = ref(0);
const title = ref("");
const msg = ref("");
const configInfoData = ref({});
const percentage = ref(0)

const showDialog = ref(false);
const showProgress = ref(false);

const colors = [
  {color: '#f56c6c', percentage: 20},
  {color: '#e6a23c', percentage: 40},
  {color: '#5cb87a', percentage: 60},
  {color: '#1989fa', percentage: 80},
  {color: '#6f7ad3', percentage: 100},
]

const mediaServerList = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    name: undefined,
    status: undefined,
    ip: undefined,
    manufacturer: undefined,
  },
  rules: {
    deviceId: [{required: true, message: "请输入设备编号", trigger: "blur"}]
  }
});

const {queryParams, form, rules} = toRefs(data);

/** 查询列表 */
function getList() {
  loading.value = true;
  listDevice(queryParams.value).then(response => {
    deviceList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

/** 表单重置 */
function reset() {
  form.value = {
    deviceId: undefined,
    name: undefined,
    password: undefined,
    sdpIp: undefined,
    mediaServerId: undefined,
    charset: undefined,
    ssrcCheck: undefined,
    asMessageChannel: undefined,
    broadcastPushAfterAck: undefined,
  };
  proxy.resetForm("formRef");
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

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  getMediaServerList()
  getDeviceById(row.deviceId).then(response => {
    form.value = response.data
    title.value = "修改设备";
    open.value = true;
  })
}

/**
 * 获取流媒体服务列表
 */
function getMediaServerList() {
  getOnlineMediaServerList().then(response => {
    mediaServerList.value = response.data;
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["formRef"].validate(valid => {
    if (valid) {
      updateDevice(form.value).then(response => {
        getList();
        proxy.$modal.msgSuccess("修改成功");
        open.value = false;
      })
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  let msg = "确定删除此设备？"
  if (row.online !== 0) {
    msg = "在线设备删除后仍可通过注册再次上线。如需彻底删除请先将设备离线。确定删除此设备？"
  }
  const deviceId = row.deviceId;
  proxy.$modal.confirm(msg).then(function () {
    return deleteDevice(deviceId);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/**
 * 修改传输方式
 *
 * @param row
 */
function transportChange(row) {
  updateTransport({deviceId: row.deviceId, streamMode: row.streamMode}).then(response => {
    console.log(`修改传输方式为 ${row.streamMode}：${row.deviceId} 成功`);
  });
}

/**
 * 开启/关闭目录订阅
 *
 * @param data
 * @param value
 */
function subscribeForCatalog(data, value) {
  subscribeCatalog({id: data, cycle: value ? 60 : 0}).then(response => {

  })
}

/**
 * 开启/关闭移动位置订阅
 *
 * @param data
 * @param value
 */
function subscribeForMobilePosition(data, value) {
  subscribeMobilePosition({id: data, cycle: value ? 60 : 0, interval: value ? 5 : 0}).then(response => {

  })
}

/**
 * 获取平台配置信息
 */
function showInfo() {
  configInfo().then(response => {
    showDialog.value = true
    configInfoData.value = response.data
  })
}

/**
 * 刷新对应设备 percentage
 *
 * @param itemData
 */
async function refDevice(itemData) {
  let intervalId = null;
  const res = await devicesSync(itemData.deviceId);
  showProgress.value = true;
  msg.value = res.msg;
  percentage.value = 0;
  intervalId = setInterval(async () => {
    try {
      const ans = await syncStatus(itemData.deviceId);
      if (ans.msg === '成功') {
        clearInterval(intervalId);
        let progressIntervalId = null;
        progressIntervalId = setInterval(() => {
          if (percentage.value < 100) {
            percentage.value += 20;
          } else {
            clearInterval(progressIntervalId);
            msg.value = ans.msg;
          }
        }, 300);
      }
    } catch (e) {
      clearInterval(intervalId);
      msg.value = "同步通道失败";
    }
  }, 500);

}

/**
 * 设备国标编号
 *
 * @param deviceId
 * @returns {Promise<void>}
 */
async function getTooltipContent(deviceId) {

  // syncStatus(deviceId).then(response => {
  //
  // })
}

function moreClick(command, itemData) {
  if (command === "setGuard") {
    setGuard(itemData)
  } else if (command === "resetGuard") {
    resetGuard(itemData)
  } else if (command === "delete") {
    handleDelete(itemData)
  } else if (command === "syncBasicParam") {
    syncBasicParam(itemData)
  }
}

/**
 * 显示通道列表
 *
 * @param row
 */
function showChannelList(row) {
  router.push(`/channel/list/index/${row.deviceId}/0`);
}

function setGuard(row) {
  guardApi({
    deviceId: row.deviceId,
    guardCmdStr: 'SetGuard',
  }).then(() => {
    ElMessage({
      message: '布防成功',
      type: 'success',
    })
  })
}

function resetGuard(row) {
  guardApi({
    deviceId: row.deviceId,
    guardCmdStr: 'ResetGuard',
  }).then(() => {
    ElMessage({
      message: '撤防成功',
      type: 'success',
    })
  })
}

function syncBasicParam(row) {
  configDownloadApi({
    deviceId: row.deviceId,
    configType: "BasicParam",
  }).then((res) => {
    ElMessage({
      message: `配置已同步，当前心跳间隔： ${res.BasicParam.HeartBeatInterval} 心跳间隔:${res.BasicParam.HeartBeatCount}`,
      type: 'success',
    })
  })
}

getList();
</script>

<style scoped>
.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}
</style>
