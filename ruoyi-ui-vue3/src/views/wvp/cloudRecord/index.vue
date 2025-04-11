<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="开始时间" prop="startTime">
        <el-date-picker
            v-model="queryParams.startTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="选择日期时间">
        </el-date-picker>
      </el-form-item>

      <el-form-item label="结束时间" prop="endTime">
        <el-date-picker
            v-model="queryParams.endTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="选择日期时间">
        </el-date-picker>
      </el-form-item>

      <el-form-item label="节点选择" prop="mediaServerId">
        <el-select style="width: 250px;"
                   v-model="queryParams.mediaServerId" placeholder="请选择节点选择">
          <el-option
              v-for="item in mediaServerList"
              :key="item.id"
              :label="item.id"
              :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table v-loading="loading" :data="recordList" border>
      <el-table-column prop="app" label="应用名" align="center"/>
      <el-table-column prop="stream" label="流ID" width="380" align="center"/>
      <el-table-column label="开始时间" align="center">
        <template #default="scope">
          {{ formatTimeStamp(scope.row.startTime) }}
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center">
        <template #default="scope">
          {{ formatTimeStamp(scope.row.endTime) }}
        </template>
      </el-table-column>
      <el-table-column label="时长" align="center">
        <template #default="scope">
          <el-tag v-if="scope.row.timeLen">{{ formatTime(scope.row.timeLen) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="fileName" label="文件名称" align="center"/>
      <el-table-column prop="mediaServerId" label="流媒体" align="center"/>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width" fixed="right">
        <template #default="scope">
          <el-button icon="el-icon-video-play" type="text" @click="play(scope.row)">播放
          </el-button>
          <el-button icon="el-icon-download" type="text" @click="downloadFile(scope.row)">下载
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getRecordList"
    />
  </div>
</template>

<script setup name="CloudRecord">
import {getOnlineMediaServerList} from "../../../api/wvp/wvpMediaServer.js";
import {getPlayUrlPath, openRtpServer} from "../../../api/wvp/record.js";
import moment from 'moment'
const {proxy} = getCurrentInstance();
const mediaServerList = ref([])
const recordList = ref([])
const loading = ref(false)
const total = ref(0);
const showSearch = ref(true);

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    startTime: undefined,
    endTime: undefined,
    mediaServerId: undefined,
    app: '',
    stream: '',
    query: '',
  },
});

const {queryParams} = toRefs(data);

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getRecordList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

function getRecordList() {
  loading.value = true
  openRtpServer(queryParams.value).then((res) => {
    loading.value = false
    recordList.value = res.rows
    total.value = res.total;
  })
}

function getMediaServerList() {
  getOnlineMediaServerList().then((res) => {
    mediaServerList.value = res.data
  })
}

function formatTimeStamp(time) {
  return moment.unix(time / 1000).format('yyyy-MM-DD HH:mm:ss')
}

function formatTime(time) {
  const h = parseInt(time / 3600 / 1000)
  const minute = parseInt((time - h * 3600 * 1000) / 60 / 1000)
  let second = Math.ceil((time - h * 3600 * 1000 - minute * 60 * 1000) / 1000)
  if (second < 0) {
    second = 0;
  }
  return (h > 0 ? h + `小时` : '') + (minute > 0 ? minute + '分' : '') + (second > 0 ? second + '秒' : '')
}

function downloadFile(file) {
  getPlayUrlPath({recordId: file.id}).then((res) => {
    const link = document.createElement('a');
    link.target = "_blank";
    if (location.protocol === "https:") {
      link.href = res.data.httpsPath + "&save_name=" + file.fileName;
    } else {
      link.href = res.data.httpPath + "&save_name=" + file.fileName;
    }
    link.click();
  })
}

function play() {

}

onMounted(() => {
  getRecordList();
  getMediaServerList();
})
</script>

<style scoped>

</style>
