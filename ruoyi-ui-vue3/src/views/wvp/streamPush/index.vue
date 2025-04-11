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
      <el-form-item label="流媒体" prop="query">
        <el-select @change="getPushList" style="width: 250px" v-model="queryParams.mediaServerId"
                   placeholder="请选择流媒体" default-first-option>
          <el-option
              v-for="item in mediaServerList"
              :key="item.id"
              :label="item.id"
              :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="推流状态" prop="query">
        <el-select @change="getPushList" style="width: 250px" v-model="queryParams.pushing"
                   placeholder="请选择推流状态" default-first-option>
          <el-option label="推流中" value="true"></el-option>
          <el-option label="已停止" value="false"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="pushList" border :row-key="(row)=> row.app + row.stream">
      <el-table-column type="selection" :reserve-selection="true" min-width="55"/>
      <el-table-column prop="gbName" label="名称" min-width="200"/>
      <el-table-column prop="app" label="应用名" min-width="100"/>
      <el-table-column prop="stream" label="流ID" min-width="200"/>
      <el-table-column label="推流状态" min-width="100">
        <template #default="scope">
          <el-tag size="medium" v-if="scope.row.pushing">推流中</el-tag>
          <el-tag size="medium" type="info" v-if="!scope.row.pushing">已停止</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="gbDeviceId" label="国标编码" min-width="200"/>
      <el-table-column label="位置信息" min-width="200">
        <template #default="scope">
          <span size="medium"
                v-if="scope.row.gbLongitude && scope.row.gbLatitude">{{ scope.row.gbLongitude }}<br/>{{ scope.row.gbLatitude }}</span>
          <span size="medium" v-if="!scope.row.gbLongitude || !scope.row.gbLatitude">无</span>
        </template>
      </el-table-column>
      <el-table-column prop="mediaServerId" label="流媒体" min-width="200"/>
      <el-table-column label="开始时间" min-width="200">
        <template #default="scope">
          <el-button-group>
            {{ scope.row.pushTime == null ? "-" : scope.row.pushTime }}
          </el-button-group>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getPushList"
    />
  </div>
</template>

<script setup name="StreamPush">

import {getOnlineMediaServerList} from "../../../api/wvp/wvpMediaServer.js";
import {listPush} from "../../../api/wvp/push.js";

const pushList = ref([]);
const mediaServerList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    query: undefined,
    mediaServerId: undefined,
    pushing: undefined,
  },
  rules: {
    deviceId: [{required: true, message: "请输入设备编号", trigger: "blur"}]
  }
});

const {queryParams, form, rules} = toRefs(data);

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getPushList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

function initData() {
  getOnlineMediaServerList().then((res) => {
    mediaServerList.value = res.data;
  })
  getPushList();
}

function getPushList() {
  loading.value = true;

  listPush(queryParams.value).then((res) => {
    total.value = res.total;
    res.rows.forEach(e => {
      e.location = ''
      if (e.gbLongitude && e.gbLatitude) {
        e.location = e.gbLongitude + "," + e.gbLatitude;
      }
    });
    pushList.value = res.rows;
    loading.value = false;
  })
}

onMounted(() => {
  initData();
})
</script>

<style scoped>

</style>
