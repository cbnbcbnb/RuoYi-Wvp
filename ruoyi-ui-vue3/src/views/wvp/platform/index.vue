<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关键字" prop="query">
        <el-input
            v-model="queryParams.query"
            placeholder="请输入关键字"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
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
            icon="Plus"
            @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="platformList" border>
      <el-table-column prop="name" label="名称" align="center"></el-table-column>
      <el-table-column prop="serverGBId" label="平台编号" min-width="200" align="center"></el-table-column>
      <el-table-column label="是否启用" min-width="80" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag v-if="scope.row.enable">已启用</el-tag>
            <el-tag type="info" v-if="!scope.row.enable">未启用</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="状态" min-width="80" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag v-if="scope.row.status">在线</el-tag>
            <el-tag type="info" v-if="!scope.row.status">离线</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="地址" min-width="160" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag>{{ scope.row.serverIp }}:{{ scope.row.serverPort }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="deviceGBId" label="设备国标编号" min-width="200" align="center"></el-table-column>
      <el-table-column prop="transport" label="信令传输模式" min-width="120" align="center"></el-table-column>
      <el-table-column prop="channelCount" label="通道数" min-width="120" align="center"></el-table-column>
      <el-table-column label="订阅信息" min-width="120" fixed="right" align="center">
        <template #default="scope">
          <i v-if="scope.row.alarmSubscribe" style="font-size: 20px" title="报警订阅"
             class="iconfont icon-gbaojings subscribe-on "></i>
          <i v-if="!scope.row.alarmSubscribe" style="font-size: 20px" title="报警订阅"
             class="iconfont icon-gbaojings subscribe-off "></i>
          <i v-if="scope.row.catalogSubscribe" title="目录订阅" class="iconfont icon-gjichus subscribe-on"></i>
          <i v-if="!scope.row.catalogSubscribe" title="目录订阅" class="iconfont icon-gjichus subscribe-off"></i>
          <i v-if="scope.row.mobilePositionSubscribe" title="位置订阅"
             class="iconfont icon-gxunjians subscribe-on"></i>
          <i v-if="!scope.row.mobilePositionSubscribe" title="位置订阅"
             class="iconfont icon-gxunjians subscribe-off"></i>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width" fixed="right">
        <template #default="scope">
          <el-button type="text" @click="handleEdit(scope.row)">
            编辑
          </el-button>
          <el-button type="text"
                     @click="chooseChannel(scope.row)">通道共享
          </el-button>
          <el-button type="text"
                     @click="pushChannelFun(scope.row)">推送通道
          </el-button>
          <el-button type="text" @click="handleDelete(scope.row)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.page"
        v-model:limit="queryParams.count"
        @pagination="getList"
    />

    <el-dialog :title="title" v-model="open" width="1000px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="130px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="名称" prop="name">
              <el-input v-model="form.name"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="SIP服务国标编码" prop="serverGBId">
              <el-input v-model="form.serverGBId" clearable @input="serverGBIdChange"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="SIP服务国标域" prop="serverGBDomain">
              <el-input v-model="form.serverGBDomain" clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="SIP服务IP" prop="serverIp">
              <el-input v-model="form.serverIp" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="SIP服务端口" prop="serverPort">
              <el-input v-model="form.serverPort" clearable type="number"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设备国标编号" prop="deviceGBId">
              <el-input v-model="form.deviceGBId" clearable @input="deviceGBIdChange"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="本地IP" prop="deviceIp">
              <el-select v-model="form.deviceIp" placeholder="请选择与上级相通的网卡" style="width: 100%">
                <el-option
                    v-for="ip in deviceIps"
                    :key="ip"
                    :label="ip"
                    :value="ip">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="本地端口" prop="devicePort">
              <el-input v-model="form.devicePort" :disabled="true" type="number"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="SIP认证用户名" prop="username">
              <el-input v-model="form.username"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="SIP认证密码" prop="password">
              <el-input v-model="form.password"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="注册周期(秒)" prop="expires">
              <el-input v-model="form.expires"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="心跳周期(秒)" prop="keepTimeout">
              <el-input v-model="form.keepTimeout"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="SDP发流IP" prop="sendStreamIp">
              <el-input v-model="form.sendStreamIp"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="信令传输" prop="transport">
              <el-select
                  v-model="form.transport"
                  style="width: 100%"
                  placeholder="请选择信令传输方式"
              >
                <el-option label="UDP" value="UDP"></el-option>
                <el-option label="TCP" value="TCP"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="保密属性">
              <el-select v-model="form.secrecy" style="width: 100%" placeholder="请选择保密属性">
                <el-option label="不涉密" :value="0"></el-option>
                <el-option label="涉密" :value="1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="目录分组" prop="catalogGroup">
              <el-select
                  v-model="form.catalogGroup"
                  style="width: 100%"
                  placeholder="请选择目录分组"
              >
                <el-option label="1" value="1"></el-option>
                <el-option label="2" value="2"></el-option>
                <el-option label="4" value="4"></el-option>
                <el-option label="8" value="8"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="字符集" prop="characterSet">
              <el-select
                  v-model="form.characterSet"
                  style="width: 100%"
                  placeholder="请选择字符集"
              >
                <el-option label="GB2312" value="GB2312"></el-option>
                <el-option label="UTF-8" value="UTF-8"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="行政区划" prop="civilCode">
              <el-input v-model="form.civilCode" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="平台厂商" prop="manufacturer">
              <el-input v-model="form.manufacturer" clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="平台型号" prop="model">
              <el-input v-model="form.model" clearable></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="平台安装地址" prop="address">
              <el-input v-model="form.address" clearable></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="其他选项">
              <div>
                <el-checkbox label="启用" v-model="form.enable" @change="checkExpires"></el-checkbox>
                <el-checkbox label="云台控制" v-model="form.ptz"></el-checkbox>
                <el-checkbox label="RTCP保活" v-model="form.rtcp" @change="rtcpCheckBoxChange"></el-checkbox>
                <el-checkbox label="消息通道" v-model="form.asMessageChannel"></el-checkbox>
                <el-checkbox label="主动推送通道" v-model="form.autoPushChannel"></el-checkbox>
                <el-checkbox label="推送平台信息" :true-label="1" :false-label="0"
                             v-model="form.catalogWithPlatform"></el-checkbox>
                <el-checkbox label="推送分组信息" :true-label="1" :false-label="0"
                             v-model="form.catalogWithGroup"></el-checkbox>
                <el-checkbox label="推送行政区划" :true-label="1" :false-label="0"
                             v-model="form.catalogWithRegion"></el-checkbox>
              </div>


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
  </div>
</template>

<script setup name="Platform">
import {
  addPlatform,
  delPlatform,
  exitPlatform,
  listPlatform,
  pushChannel,
  serverConfig,
  updatePlatform
} from "../../../api/wvp/platform.js";
import router from "@/router";

const {proxy} = getCurrentInstance();

const platformList = ref([]);
const loading = ref(false);
const total = ref(0);
const showSearch = ref(true);
const title = ref("");
const open = ref(false);
const deviceIps = ref([]);
const defaultPlatform = ref(null);

const deviceGBIdRules = async (rule, value, callback) => {
  if (value === "") {
    callback(new Error("请输入设备国标编号"));
  } else {
    const exit = await deviceGBIdExit(value);
    if (exit) {
      callback(new Error("设备国标编号格式错误或已存在"));
    } else {
      callback();
    }
  }
}

async function deviceGBIdExit(deviceGbId) {
  let result = false;
  exitPlatform(deviceGbId).then((res) => {
    result = res.data;
  })
  return result;
}

const data = reactive({
  form: {},
  queryParams: {
    page: 1,
    count: 10,
    query: undefined,
  },
  rules: {
    name: [{required: true, message: "请输入平台名称", trigger: "blur"}],
    serverGBId: [
      {required: true, message: "请输入SIP服务国标编码", trigger: "blur"},
    ],
    serverGBDomain: [
      {required: true, message: "请输入SIP服务国标域", trigger: "blur"},
    ],
    serverIp: [{required: true, message: "请输入SIP服务IP", trigger: "blur"}],
    serverPort: [{required: true, message: "请输入SIP服务端口", trigger: "blur"}],
    deviceGBId: [{validator: deviceGBIdRules, trigger: "blur"}],
    username: [{required: false, message: "请输入SIP认证用户名", trigger: "blur"}],
    password: [{required: false, message: "请输入SIP认证密码", trigger: "blur"}],
    expires: [{required: true, message: "请输入注册周期", trigger: "blur"}],
    keepTimeout: [{required: true, message: "请输入心跳周期", trigger: "blur"}],
    transport: [{required: true, message: "请选择信令传输", trigger: "blur"}],
    characterSet: [{required: true, message: "请选择编码字符集", trigger: "blur"}],
    deviceIp: [{required: true, message: "请选择本地IP", trigger: "blur"}],
  }
});

const {queryParams, form, rules} = toRefs(data);

function getList() {
  loading.value = true;
  listPlatform(queryParams.value).then(response => {
    platformList.value = response.data.list;
    total.value = response.data.total;
    loading.value = false;
  })
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.page = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

function reset() {
  form.value = JSON.parse(JSON.stringify(defaultPlatform.value));
  proxy.resetForm("formRef");
}

function handleAdd() {
  reset()
  open.value = true;
  title.value = "新增平台";
}

function serverGBIdChange() {
  if (form.value.serverGBId.length > 10) {
    form.value.serverGBDomain = form.value.serverGBId.substr(0, 10);
  }
}

function deviceGBIdChange() {
  form.value.username = form.value.deviceGBId;
}

function checkExpires() {
  if (form.value.enable && form.value.expires === "0") {
    form.value.expires = "3600";
  }
}

function rtcpCheckBoxChange(result) {
  if (result) {
    proxy.$modal.msgWarning("开启RTCP保活需要上级平台支持，可以避免无效推流");
  }
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

function handleEdit(row) {
  reset()
  form.value = JSON.parse(JSON.stringify(row));
  open.value = true;
  title.value = "修改平台";
}

function handleDelete(row) {
  proxy.$modal.confirm('确认删除？').then(function () {
    return delPlatform(row.id)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功");
    getList();
  }).catch(() => {
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["formRef"].validate(valid => {
    if (valid) {
      if (form.value.id != undefined) {
        updatePlatform(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList()
        })
      } else {
        addPlatform(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList()
        })
      }
    }
  });
}

function chooseChannel(row) {
  router.push(`/platform/chooseChannel/index/${row.id}`);
}

function pushChannelFun(row) {
  pushChannel(row.id).then((res) => {
    proxy.$modal.msgSuccess("推送成功");
    getList();
  })
}

onMounted(() => {
  serverConfig().then((res) => {
    deviceIps.value = res.data.deviceIp.split(',');
    defaultPlatform.value = {
      id: null,
      enable: true,
      ptz: true,
      rtcp: false,
      asMessageChannel: false,
      autoPushChannel: false,
      name: null,
      serverGBId: null,
      serverGBDomain: null,
      serverIp: null,
      serverPort: null,
      deviceGBId: res.data.username,
      deviceIp: deviceIps.value[0],
      devicePort: res.data.devicePort,
      username: res.data.username,
      password: res.data.password,
      expires: 3600,
      keepTimeout: 60,
      transport: "UDP",
      characterSet: "GB2312",
      startOfflinePush: false,
      customGroup: false,
      catalogWithPlatform: 0,
      catalogWithGroup: 0,
      catalogWithRegion: 0,
      manufacturer: null,
      model: null,
      address: null,
      secrecy: 1,
      catalogGroup: 1,
      civilCode: null,
      sendStreamIp: res.data.sendStreamIp,
    }
  })
  getList()
})
</script>

<style scoped>

</style>
