<template>
  <div class="app-container">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
            v-hasPermi="['wvp:wvpMediaServer:add']"
        >新增
        </el-button>
      </el-col>
      <right-toolbar :search="false" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-row :gutter="12">
      <el-col :span="6" v-for="item in wvpMediaServerList" :key="item.id">
        <el-card shadow="hover" class="server-card">
          <div v-if="item.type === 'zlm'" class="card-img-zlm"></div>
          <div v-if="item.type === 'abl'" class="card-img-abl"></div>
          <div style="padding: 10px;display: flex;justify-content: space-between;align-items: center">
            <div>
              <div style="font-size: 16px">{{ item.id }}</div>
              <div style="font-size: 14px; color: #999; margin-top: 5px; ">{{ item.ip }}</div>
              <div style="font-size: 14px; color: #999; margin-top: 5px;">{{ item.createTime }}</div>
            </div>

            <div>
              <!--            v-if="!item.defaultServer"-->
              <el-button type="text"
                         @click="handleUpdate(item)">编辑
              </el-button>
              <el-button v-if="item.defaultServer" type="text"
                         @click="handleView(item)" v-hasPermi="['wvp:wvpMediaServer:view']">查看
              </el-button>
              <el-button type="text" @click="handleDelete(item)">移除
              </el-button>
            </div>
          </div>
          <el-icon v-if="item.status" class="server-card-status-online" color="#F56C6C">
            <WarningFilled/>
          </el-icon>
          <el-icon v-if="!item.status" class="server-card-status-offline" color="#67C23A">
            <SuccessFilled/>
          </el-icon>
          <i v-if="item.defaultServer" class="server-card-default">默认</i>
        </el-card>
      </el-col>
    </el-row>

    <!-- 添加或修改媒体服务器对话框 -->
    <el-dialog :title="title" v-model="open" width="800px" append-to-body>
      <el-form ref="wvpMediaServerRef" :model="form" :rules="rules" label-width="50px">
        <el-form-item label="IP" prop="ip">
          <el-input v-model="form.ip" placeholder="请输入服务器绑定的 IP 地址"/>
        </el-form-item>
        <el-form-item label="HTTP" prop="httpPort">
          <el-input v-model="form.httpPort" placeholder="请输入HTTP 协议端口"/>
        </el-form-item>
        <el-form-item label="密钥" prop="secret">
          <el-input v-model="form.secret" placeholder="请输入密钥"/>
        </el-form-item>
        <el-form-item label="类型" prop="type">
          <el-select v-model="form.type">
            <el-option key="zlm" label="ZLMediaKit" value="zlm"></el-option>
            <el-option key="abl" label="ABLMediaServer" value="abl"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">测 试</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="媒体节点" v-model="openView" width="1000px" append-to-body>
      <el-descriptions border>
        <el-descriptions-item label="媒体服务IP">
          {{ rowData.ip }}
        </el-descriptions-item>
        <el-descriptions-item label="HTTP端口">
          {{ rowData.httpPort }}
        </el-descriptions-item>
        <el-descriptions-item label="SECRET">
          {{ rowData.secret }}
        </el-descriptions-item>
        <el-descriptions-item label="类型">
          <el-tag type="primary" v-if="rowData.type === 'zlm'">ZLMediaKit</el-tag>
          <el-tag type="primary" v-if="rowData.type === 'abl'">ABLMediaServer</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务RTMP_PORT">
          {{ rowData.rtmpPort }}
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务RTMPS_PORT">
          {{ rowData.rtmpSSlPort }}
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务HOOK_IP">
          {{ rowData.hookIp }}
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务SDP_IP">
          {{ rowData.sdpIp }}
        </el-descriptions-item>
        <el-descriptions-item label="自动配置媒体服务">
          <el-tag type="primary" v-if="rowData.autoConfig === 1">是</el-tag>
          <el-tag type="primary" v-if="rowData.autoConfig === 0">否</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务流IP">
          {{ rowData.streamIp }}
        </el-descriptions-item>
        <el-descriptions-item label="收流端口模式">
          <el-tag type="primary" v-if="rowData.rtpEnable === 1">多端口</el-tag>
          <el-tag type="primary" v-if="rowData.rtpEnable === 0">单端口</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务HTTPS_PORT">
          {{ rowData.httpSSlPort }}
        </el-descriptions-item>
        <el-descriptions-item label="收流端口">
          {{ rowData.rtpPortRange }}
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务RTSP_PORT">
          {{ rowData.rtspPort }}
        </el-descriptions-item>
        <el-descriptions-item label="录像管理服务端口">
          {{ rowData.recordAssistPort }}
        </el-descriptions-item>
        <el-descriptions-item label="媒体服务RTSPS_PORT">
          {{ rowData.rtspSSLPort }}
        </el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </div>
</template>

<script setup name="WvpMediaServer">
import {checkMediaServer, delWvpMediaServer, getWvpMediaServer, listWvpMediaServer} from "@/api/wvp/wvpMediaServer";

const {proxy} = getCurrentInstance();

const wvpMediaServerList = ref([]);
const open = ref(false);
const openView = ref(false);

const loading = ref(true);
const title = ref("");

const rowData = ref({});

const data = reactive({
  form: {},
  rules: {
    ip: [
      {required: true, message: "服务器绑定的 IP 地址不能为空", trigger: "blur"}
    ],
    httpPort: [
      {required: true, message: "HTTP 协议端口不能为空", trigger: "blur"}
    ],
    secret: [
      {required: true, message: "密钥不能为空", trigger: "blur"}
    ],
  }
});

const {form, rules} = toRefs(data);

/** 查询媒体服务器列表 */
function getList() {
  loading.value = true;
  listWvpMediaServer().then(response => {
    wvpMediaServerList.value = response.data;
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
    httpPort: null,
    secret: null,
    type: 'zlm',
  };
  proxy.resetForm("wvpMediaServerRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加媒体服务器";
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["wvpMediaServerRef"].validate(valid => {
    if (valid) {
      checkMediaServer(form.value).then(response => {
        console.log(response)
      });
    }
  });
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id
  getWvpMediaServer(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改媒体服务器";
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id
  proxy.$modal.confirm('确认删除此节点？').then(function () {
    return delWvpMediaServer(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/**
 * 查看按钮操作
 *
 * @param row
 */
function handleView(row) {
  openView.value = true
  rowData.value = row;
}

getList();
</script>

<style lang="scss" scoped>
.server-card {
  position: relative;
  margin-bottom: 20px;
}

.card-img-zlm {
  width: 200px;
  height: 200px;
  background: url('../../../assets/images/zlm-log.png') no-repeat center;
  background-position: center;
  background-size: contain;
  margin: 0 auto;
}

.card-img-abl {
  width: 200px;
  height: 200px;
  background: url('../../../assets/images/zlm-log.png') no-repeat center;
  background-position: center;
  background-size: contain;
  margin: 0 auto;
}

.server-card-status-online {
  position: absolute;
  right: 20px;
  top: 20px;
  font-size: 18px;
}

.server-card-status-offline {
  position: absolute;
  right: 20px;
  top: 20px;
  font-size: 18px;
}

.server-card-default {
  position: absolute;
  left: 20px;
  top: 20px;
  color: #808080;
  font-size: 18px;
}

.server-card:hover {
  border: 1px solid #adadad;
}
</style>
