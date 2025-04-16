<template>
  <div class="app-container">
    <el-tabs v-model="queryParams.hasShare" class="demo-tabs" @tab-click="handleClick">
      <el-tab-pane label="未关联" name="false"/>
      <el-tab-pane label="已关联" name="true"/>

      <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
        <el-form-item label="关键字" prop="query">
          <el-input v-model="queryParams.query" placeholder="请输入关键字" clearable style="width: 240px"
                    @keyup.enter="handleQuery"/>
        </el-form-item>
        <el-form-item label="在线状态" prop="online">
          <el-select v-model="queryParams.online" placeholder="请选择在线状态" style="width: 250px;"
                     default-first-option>
            <el-option label="在线" value="true"></el-option>
            <el-option label="离线" value="false"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="类型" prop="channelType">
          <el-select v-model="queryParams.channelType" placeholder="请选择类型" style="width: 250px;"
                     default-first-option>
            <el-option label="国标设备" :value="1"></el-option>
            <el-option label="推流设备" :value="2"></el-option>
            <el-option label="拉流代理" :value="3"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>

      <el-row :gutter="10" class="mb8">
        <el-col :span="1.5" v-if="queryParams.hasShare !=='true'">
          <el-button type="primary"
                     plain
                     icon="Plus"
                     :disabled="multiple"
                     @click="handleAdd">新增
          </el-button>
        </el-col>
        <el-col :span="1.5" v-if="queryParams.hasShare ==='true'">
          <el-button
              type="danger"
              plain
              icon="Delete"
              :disabled="multiple"
              @click="handleDelete">
            删除
          </el-button>
        </el-col>
        <el-col :span="1.5" v-if="queryParams.hasShare !=='true'">
          <el-button type="primary"
                     plain
                     icon="Plus"
                     @click="handleAddByDevice">
            按设备添加
          </el-button>
        </el-col>
        <el-col :span="1.5" v-if="queryParams.hasShare ==='true'">
          <el-button
              type="danger"
              plain
              icon="Delete"
              @click="handleRemoveByDevice">
            按设备移除
          </el-button>
        </el-col>
        <el-col :span="1.5" v-if="queryParams.hasShare !=='true'">
          <el-button type="primary"
                     plain
                     icon="Plus"
                     @click="handleAddAll">
            添加所有通道
          </el-button>
        </el-col>
        <el-col :span="1.5" v-if="queryParams.hasShare ==='true'">
          <el-button
              type="danger"
              plain
              icon="Delete"
              @click="handleRemoveAll">
            移除所有通道
          </el-button>
        </el-col>
        <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
      </el-row>

      <el-table v-loading="loading" :data="channelList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center"/>
        <el-table-column prop="gbName" label="名称" min-width="180" align="center"/>
        <el-table-column prop="gbDeviceId" label="编号" min-width="180" align="center"/>
        <el-table-column prop="gbManufacturer" label="厂家" min-width="100" align="center"/>
        <el-table-column label="类型" min-width="100" align="center">
          <template #default="scope">
            <div slot="reference" class="name-wrapper">
              <el-tag effect="plain" v-if="scope.row.dataType === 1">国标设备</el-tag>
              <el-tag effect="plain" type="success" v-else-if="scope.row.dataType === 2">推流设备</el-tag>
              <el-tag effect="plain" type="warning" v-else-if="scope.row.dataType === 3">拉流代理</el-tag>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="状态" min-width="100" align="center">
          <template #default="scope">
            <div slot="reference" class="name-wrapper">
              <el-tag v-if="scope.row.gbStatus === 'ON'">在线</el-tag>
              <el-tag type="info" v-if="scope.row.gbStatus !== 'ON'">离线</el-tag>
            </div>
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

      <el-dialog :title="title" v-model="open" width="800px" append-to-body>
        <el-form :model="queryParamsDevice" ref="queryDeviceRef" :inline="true" v-show="showSearchDevice"
                 label-width="68px">
          <el-form-item label="设备名称" prop="name">
            <el-input
                v-model="queryParamsDevice.name"
                placeholder="请输入设备名称"
                clearable
                style="width: 240px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="地址" prop="ip">
            <el-input
                v-model="queryParamsDevice.ip"
                placeholder="请输入地址"
                clearable
                style="width: 240px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="厂家" prop="manufacturer">
            <el-input
                v-model="queryParamsDevice.manufacturer"
                placeholder="请输入厂家"
                clearable
                style="width: 240px"
                @keyup.enter="handleQuery"
            />
          </el-form-item>
          <el-form-item label="在线状态" prop="status">
            <el-select v-model="queryParamsDevice.status" placeholder="请选择在线状态" style="width: 250px;"
                       default-first-option>
              <el-option label="在线" value="true"></el-option>
              <el-option label="离线" value="false"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="Search" @click="handleDeviceQuery">搜索</el-button>
            <el-button icon="Refresh" @click="resetDeviceQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary"
                       plain
                       :disabled="multipleDevice"
                       @click="handleSure">
              确定
            </el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearchDevice" @queryTable="getDeviceList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="deviceList" @selection-change="handleSelectionDeviceChange">
          <el-table-column type="selection" width="55" align="center"/>
          <el-table-column prop="name" label="名称" align="center"/>
          <el-table-column prop="deviceId" label="设备编号" align="center"/>
          <el-table-column prop="channelCount" label="通道数" align="center"/>
          <el-table-column prop="manufacturer" label="厂家" align="center"/>
          <el-table-column label="地址" align="center">
            <template #default="scope">
              <div slot="reference" class="name-wrapper">
                <el-tag v-if="scope.row.hostAddress" size="medium">{{ scope.row.hostAddress }}</el-tag>
                <el-tag v-if="!scope.row.hostAddress" size="medium">未知</el-tag>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center">
            <template #default="scope">
              <div slot="reference" class="name-wrapper">
                <el-tag v-if="scope.row.onLine">在线</el-tag>
                <el-tag type="info" v-if="!scope.row.onLine">离线</el-tag>
              </div>
            </template>
          </el-table-column>
        </el-table>

        <pagination
            v-show="totalDevice > 0"
            :total="totalDevice"
            v-model:page="queryParamsDevice.pageNum"
            v-model:limit="queryParamsDevice.pageSize"
            @pagination="getDeviceList"
        />
      </el-dialog>
    </el-tabs>
  </div>
</template>

<script setup name="ChooseChannel">
import {
  addChannel,
  addChannelByDevice,
  delChannelForGB,
  queryChannelList,
  removeChannelByDevice
} from "../../../api/wvp/platform.js";
import {useRoute} from "vue-router";
import {listDevice} from "../../../api/wvp/device.js";

const {proxy} = getCurrentInstance();
const route = useRoute();

const loading = ref(false)
const channelList = ref([])
const total = ref(0);
const showSearch = ref(true);
const multiple = ref(true);
const selectionList = ref([]);
const open = ref(false);
const title = ref("");

const loadingDevice = ref(false)
const deviceList = ref([])
const totalDevice = ref(0);
const showSearchDevice = ref(true);
const multipleDevice = ref(true);
const selectionDeviceList = ref([]);
const typeDevice = ref("");

const data = reactive({
  form: {},
  queryParams: {
    page: 1,
    count: 10,
    query: undefined,
    online: undefined,
    channelType: undefined,
    hasShare: 'false',
  },
  rules: {},
  queryParamsDevice: {
    pageNum: 1,
    pageSize: 10,
    name: undefined,
    status: undefined,
    ip: undefined,
    manufacturer: undefined,
  }
});

const {queryParams, form, rules, queryParamsDevice} = toRefs(data);

function getList() {
  loading.value = true
  queryChannelList(queryParams.value).then((res) => {
    channelList.value = res.data.list
    total.value = res.data.total
    loading.value = false
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


/** 选择条数  */
function handleSelectionChange(selection) {
  selectionList.value = selection
  multiple.value = !selection.length;
}

function handleAdd() {
  let channels = []
  for (let i = 0; i < selectionList.value.length; i++) {
    channels.push(selectionList.value[i].gbId)
  }
  if (channels.length === 0) {
    proxy.$modal.msgError("请选择要关联的通道");
    return;
  }

  addChannel({
    platformId: queryParams.value.platformId,
    channelIds: channels
  }).then(() => {
    proxy.$modal.msgSuccess("关联成功");
    getList()
  })
}

function handleDelete() {
  let channels = []
  for (let i = 0; i < selectionList.value.length; i++) {
    channels.push(selectionList.value[i].gbId)
  }
  if (channels.length === 0) {
    proxy.$modal.msgError("请选择要关联的通道");
    return;
  }

  delChannelForGB({
    platformId: queryParams.value.platformId,
    channelIds: channels
  }).then(() => {
    proxy.$modal.msgSuccess("取消关联成功");
    getList()
  })

}


const handleClick = () => {
  nextTick(() => {
    getList();
  })
}

function handleAddAll() {
  proxy.$modal.confirm('添加所有通道将包括已经添加到其他计划的通道，确定添加所有通道？').then(function () {
    return addChannel({
      platformId: queryParams.value.platformId,
      all: true
    })
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("添加成功");
  }).catch(() => {
  });
}

function handleRemoveAll() {
  proxy.$modal.confirm('确定移除所有通道？').then(function () {
    return delChannelForGB({
      platformId: queryParams.value.platformId,
      all: true
    })
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("移除成功");
  }).catch(() => {
  });
}

function handleAddByDevice() {
  open.value = true
  title.value = "添加国标设备通道"
  getDeviceList()
  typeDevice.value = "addDevice"
}

function handleRemoveByDevice() {
  open.value = true
  title.value = "移除国标设备通道"
  getDeviceList()
  typeDevice.value = "removeDevice"
}

function getDeviceList() {
  loadingDevice.value = true
  listDevice(queryParamsDevice.value).then((res) => {
    deviceList.value = res.rows
    totalDevice.value = res.total
    loadingDevice.value = false
  })
}

/** 搜索按钮操作 */
function handleDeviceQuery() {
  queryParams.value.pageNum = 1;
  getDeviceList();
}

/** 重置按钮操作 */
function resetDeviceQuery() {
  proxy.resetForm("queryDeviceRef");
  handleDeviceQuery();
}

function handleSelectionDeviceChange(selection) {
  selectionDeviceList.value = selection
  multipleDevice.value = !selection.length;
}

function handleSure() {
  let deviceIds = []
  for (let i = 0; i < selectionDeviceList.value.length; i++) {
    deviceIds.push(selectionDeviceList.value[i].id)
  }
  if (typeDevice.value === "addDevice") {
    addChannelByDevice({
      platformId: queryParams.value.platformId,
      deviceIds: deviceIds
    }).then(()=>{
      proxy.$modal.msgSuccess("关联成功");
      open.value = false
      getList()
    })
  } else if (typeDevice.value === "removeDevice") {
    removeChannelByDevice({
      platformId: queryParams.value.platformId,
      deviceIds: deviceIds
    }).then(()=>{
      proxy.$modal.msgSuccess("取消关联成功");
      open.value = false
      getList()
    })
  }
}

onMounted(() => {
  queryParams.value.platformId = route.params && route.params.platformId;
  getList();
})
</script>

<style scoped>

</style>
