<template>
  <div>
    <el-row :gutter="20">
      <el-col :span="4">
        <div class="head-container">
          <el-input v-model="regionName" placeholder="请输入区域名称" clearable prefix-icon="Search"
                    style="margin-bottom: 20px"/>
        </div>
        <div class="head-container">
          <el-tree :data="regionOptions"
                   :props="{label: 'name', children: 'children'}"
                   :expand-on-click-node="false"
                   :filter-node-method="filterNode"
                   ref="regionTreeRef"
                   node-key="id"
                   highlight-current
                   default-expand-all
                   @node-click="handleNodeClick"/>
        </div>
      </el-col>
      <el-col :span="20">
        <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
          <el-form-item label="关键字" prop="query">
            <el-input v-model="queryParams.query" placeholder="请输入关键字" clearable style="width: 240px"
                      @keyup.enter="handleQuery"/>
          </el-form-item>
          <el-form-item label="类型" prop="channelType">
            <el-select v-model="queryParams.channelType" placeholder="请选择类型" style="width: 250px;"
                       default-first-option>
              <el-option label="国标设备" :value="1"></el-option>
              <el-option label="推流设备" :value="2"></el-option>
              <el-option label="拉流代理" :value="3"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="在线状态" prop="online">
            <el-select v-model="queryParams.online" placeholder="请选择在线状态" style="width: 250px;"
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
            <el-button type="primary"
                       plain
                       icon="Plus"
                       @click="handleAdd">新增
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
                type="danger"
                plain
                icon="Delete"
                :disabled="multiple"
                @click="handleDelete">
              删除
            </el-button>
          </el-col>
          <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="channelList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center"/>
          <el-table-column prop="gbName" label="名称" align="center"/>
          <el-table-column prop="gbDeviceId" label="编号" align="center"/>
          <el-table-column prop="gbManufacturer" label="厂家" align="center"/>
          <el-table-column label="类型" align="center">
            <template #default="scope">
              <div slot="reference" class="name-wrapper">
                <el-tag effect="plain" v-if="scope.row.dataType === 1">国标设备</el-tag>
                <el-tag effect="plain" type="success" v-else-if="scope.row.dataType === 2">推流设备</el-tag>
                <el-tag effect="plain" type="warning" v-else-if="scope.row.dataType === 3">拉流代理</el-tag>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="状态" align="center">
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
            v-model:page="queryParams.pageNum"
            v-model:limit="queryParams.pageSize"
            @pagination="getList"
        />

        <el-dialog :title="title" v-model="open" width="1100px" append-to-body>
          <el-form :model="queryParamsSelect" ref="querySelectRef" :inline="true" v-show="showSearchSelect"
                   label-width="68px">
            <el-form-item label="关键字" prop="query">
              <el-input v-model="queryParamsSelect.query" placeholder="请输入关键字" clearable style="width: 240px"
                        @keyup.enter="handleSelectQuery"/>
            </el-form-item>
            <el-form-item label="类型" prop="channelType">
              <el-select v-model="queryParamsSelect.channelType" placeholder="请选择类型" style="width: 250px;"
                         default-first-option>
                <el-option label="国标设备" :value="1"></el-option>
                <el-option label="推流设备" :value="2"></el-option>
                <el-option label="拉流代理" :value="3"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="在线状态" prop="online">
              <el-select v-model="queryParamsSelect.online" placeholder="请选择在线状态" style="width: 250px;"
                         default-first-option>
                <el-option label="在线" value="true"></el-option>
                <el-option label="离线" value="false"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="Search" @click="handleSelectQuery">搜索</el-button>
              <el-button icon="Refresh" @click="resetSelectQuery">重置</el-button>
            </el-form-item>
          </el-form>

          <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
              <el-button type="primary"
                         plain
                         icon="Select"
                         :disabled="multipleSelect"
                         @click="handleSelect">
                选择
              </el-button>
            </el-col>
            <right-toolbar v-model:showSearch="showSearchSelect" @queryTable="getChannelList"></right-toolbar>
          </el-row>

          <el-table v-loading="loadingSelect" :data="channelSelectList" @selection-change="handleSelectionSelectChange">
            <el-table-column type="selection" width="55" align="center"/>
            <el-table-column prop="gbName" label="名称" align="center"/>
            <el-table-column prop="gbDeviceId" label="编号" align="center"/>
            <el-table-column prop="gbManufacturer" label="厂家" align="center"/>
            <el-table-column label="类型" align="center">
              <template #default="scope">
                <div slot="reference" class="name-wrapper">
                  <el-tag effect="plain" v-if="scope.row.dataType === 1">国标设备</el-tag>
                  <el-tag effect="plain" type="success" v-else-if="scope.row.dataType === 2">推流设备</el-tag>
                  <el-tag effect="plain" type="warning" v-else-if="scope.row.dataType === 3">拉流代理</el-tag>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="状态" align="center">
              <template #default="scope">
                <div slot="reference" class="name-wrapper">
                  <el-tag v-if="scope.row.gbStatus === 'ON'">在线</el-tag>
                  <el-tag type="info" v-if="scope.row.gbStatus !== 'ON'">离线</el-tag>
                </div>
              </template>
            </el-table-column>
          </el-table>

          <pagination
              v-show="totalSelect > 0"
              :total="totalSelect"
              v-model:page="queryParamsSelect.pageNum"
              v-model:limit="queryParamsSelect.pageSize"
              @pagination="getChannelList"
          />
        </el-dialog>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Region">
import {queryForTree} from "../../../api/wvp/region.js";
import {
  addChannelToRegion,
  deleteChannelToRegion,
  queryListByCivilCode,
  queryListByParentId
} from "../../../api/wvp/channel.js";

const {proxy} = getCurrentInstance();

const regionName = ref('')
const regionOptions = ref([]);
const channelList = ref([]);
const loading = ref(true);
const total = ref(0);
const showSearch = ref(true);
const regionDeviceId = ref('');
const selectionList = ref([]);
const multiple = ref(true);
const open = ref(false);
const title = ref("");
const dataType = ref('civilCode');

const channelSelectList = ref([]);
const loadingSelect = ref(true);
const totalSelect = ref(0);
const showSearchSelect = ref(true);
const multipleSelect = ref(true);
const selectionSelectList = ref([]);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    query: undefined,
    online: undefined,
    channelType: undefined,
    civilCode: ' ',
  },
  rules: {},

  queryParamsSelect: {
    pageNum: 1,
    pageSize: 10,
    query: undefined,
    online: undefined,
    channelType: undefined,
    civilCode: undefined,
  }
});

const {queryParams, form, rules, queryParamsSelect} = toRefs(data);


function getList() {
  loading.value = true
  queryListByCivilCode(queryParams.value).then((res) => {
    channelList.value = res.rows
    total.value = res.total
    loading.value = false
  })
}

/** 根据名称筛选树 */
watch(regionName, val => {
  proxy.$refs["regionTreeRef"].filter(val);
});

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

/** 选择条数  */
function handleSelectionChange(selection) {
  selectionList.value = selection
  multiple.value = !selection.length;
}

function handleDelete() {
  let channels = []
  for (let i = 0; i < selectionList.value.length; i++) {
    channels.push(selectionList.value[i].gbId)
  }
  proxy.$modal.confirm('是否删除选择的数据？').then(function () {
    return deleteChannelToRegion({channelIds: channels});
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });
}

/** 通过条件过滤节点  */
const filterNode = (value, data) => {
  if (!value) return true;
  return data.name.indexOf(value) !== -1;
};

/** 节点单击事件 */
function handleNodeClick(data) {
  if (data.deviceId) {
    queryParams.value.civilCode = data.deviceId;
  } else {
    queryParams.value.civilCode = ' ';
  }

  regionDeviceId.value = queryParams.value.civilCode;
  handleQuery();
}

/** 新增按钮操作 */
function handleAdd() {
  if (regionDeviceId.value === "" || regionDeviceId.value === ' ') {
    proxy.$modal.msgError("请选择左侧行政区划");
    return;
  }

  title.value = "添加国标通道";
  open.value = true;

  getChannelList()
}

function getChannelList() {
  if (dataType.value === "civilCode") {
    loadingSelect.value = true
    queryListByCivilCode(queryParamsSelect.value).then((res) => {
      channelSelectList.value = res.rows
      totalSelect.value = res.total
      loadingSelect.value = false
    })
  } else {
    loadingSelect.value = true
    queryListByParentId(queryParamsSelect.value).then((res) => {
      channelSelectList.value = res.rows
      totalSelect.value = res.total
      loadingSelect.value = false
    })
  }
}

/** 搜索按钮操作 */
function handleSelectQuery() {
  queryParams.value.pageNum = 1;
  getChannelList();
}

/** 重置按钮操作 */
function resetSelectQuery() {
  proxy.resetForm("querySelectRef");
  handleSelectQuery();
}

function handleSelectionSelectChange(selection) {
  selectionSelectList.value = selection;
  multipleSelect.value = !selection.length;
}

function handleSelect() {
  proxy.$modal.msgSuccess("选择成功");
  open.value = false;
  addChannelToCivilCode(regionDeviceId.value, selectionSelectList.value)
}

function addChannelToCivilCode(regionDeviceId, data) {
  let channels = []
  for (let i = 0; i < data.length; i++) {
    channels.push(data[i].gbId)
  }
  addChannelToRegion({civilCode: regionDeviceId, channelIds: channels}).then(() => {
    getList()
  })
}

onMounted(() => {
  queryForTree({}).then((res) => {
    let data = [
      {
        name: "根资源组",
        children: []
      }
    ]
    data[0].children = proxy.handleTree(res.data, "id")
    regionOptions.value = data
  })

  getList()
})
</script>

<style scoped>

</style>
