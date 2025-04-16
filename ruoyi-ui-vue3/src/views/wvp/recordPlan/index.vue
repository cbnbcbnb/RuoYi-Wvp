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

    <el-table v-loading="loading" :data="recordList" border>
      <el-table-column prop="name" label="名称" align="center"/>
      <el-table-column prop="channelCount" label="关联通道" align="center"/>
      <el-table-column prop="updateTime" label="更新时间" align="center"/>
      <el-table-column prop="createTime" label="创建时间" align="center"/>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width" fixed="right">
        <template #default="scope">
          <el-button type="text" @click="handleLink(scope.row)">关联通道</el-button>
          <el-button type="text" @click="handleEdit(scope.row)">编辑</el-button>
          <el-button type="text" @click="handleDelete(scope.row)">删除</el-button>
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

    <el-dialog :title="title" v-model="open" width="800px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="50px">
        <el-form-item label="名称" prop="name">
          <el-input type="text" v-model="form.name" placeholder="请输入名称"></el-input>
        </el-form-item>
        <el-form-item>
          <ByteWeekTimePicker v-if="open" v-model="byteTime" name="name"/>
        </el-form-item>
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

<script setup name="RecordPlan">
import {addRecord, deleteRecord, getRecord, listRecord, updateRecord} from "../../../api/wvp/record.js";
import ByteWeekTimePicker from "./byteWeekTimePicker.vue";
import {ElMessage} from "element-plus";
import router from "@/router";
const {proxy} = getCurrentInstance();

const loading = ref(false);
const total = ref(0);
const recordList = ref([]);
const showSearch = ref(true);
const title = ref("");
const open = ref(false);
const byteTime = ref("");
const id = ref(null);

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    query: undefined,
  },
  rules: {
    name: [{required: true, message: "请输入名称", trigger: "blur"}],
  }
});

const {queryParams, form, rules} = toRefs(data);

function getList() {
  loading.value = true;
  listRecord(queryParams.value).then(res => {
    total.value = res.total;
    recordList.value = res.rows;
    loading.value = false;
  })
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

/** 表单重置 */
function reset() {
  form.value = {
    id: undefined,
    planItemList: undefined,
  };
  proxy.resetForm("formRef");
}

function handleAdd() {
  reset()
  open.value = true
  byteTime.value = "";
  title.value = "新增录像计划"
}

function cancel() {
  reset()
  byteTime.value = ""
  open.value = false
}

function handleEdit(row) {
  reset()
  open.value = true
  byteTime.value = "";
  title.value = "修改录像计划"
  getRecord(row.id).then(res => {
    byteTime.value = plan2Byte(res.data.planItemList)
    form.value.name = res.data.name
    form.value.id = res.data.id
  })
}

function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除该录制计划？').then(function () {
    deleteRecord(row.id).then(() => {
      ElMessage({
        type: 'success',
        message: '删除成功',
      })
      getList();
    })
  })
}

function handleLink(row){
  router.push(`/recordPlan/associatedChannel/index/${row.id}`);
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["formRef"].validate(valid => {
    if (valid) {
      form.value.planItemList = byteTime2PlanList()
      if (form.value.id != undefined) {
        updateRecord(form.value).then(() => {
          open.value = false;
          getList();
          proxy.$modal.msgSuccess("修改成功");
        })
      } else {
        addRecord(form.value).then(() => {
          open.value = false
          getList()
          proxy.$modal.msgSuccess("新增成功");
        })
      }
    }
  })
}


const byteTime2PlanList = () => {
  if (byteTime.value.length === 0) {
    return;
  }

  const DayTimes = 24 * 2;
  let planList = [];
  let week = 1;

  // 把 336 长度的 list 分成 7 组，每组 48 个
  for (let i = 0; i < byteTime.value.length; i += DayTimes) {
    let planArray = byteTime2Plan(byteTime.value.slice(i, i + DayTimes));
    if (!planArray || planArray.length === 0) {
      week++;
      continue;
    }
    for (let j = 0; j < planArray.length; j++) {
      planList.push({
        planId: id.value,
        start: planArray[j].start,
        stop: planArray[j].stop,
        weekDay: week,
      });
    }
    week++;
  }
  return planList;
};

const byteTime2Plan = (weekItem) => {
  let start = null;
  let stop = null;
  let result = [];

  for (let i = 0; i < weekItem.length; i++) {
    let item = weekItem[i];
    if (item === '1') { // 表示选中
      stop = i;
      if (start === null) {
        start = i;
      }
      if (i === weekItem.length - 1 && start != null && stop != null) {
        result.push({
          start: start,
          stop: stop,
        });
      }
    } else {
      if (stop !== null) {
        result.push({
          start: start,
          stop: stop,
        });
        start = null;
        stop = null;
      }
    }
  }
  return result;
};

const plan2Byte = (planList) => {
  let byte = "";
  let indexArray = {};

  for (let i = 0; i < planList.length; i++) {
    let weekDay = planList[i].weekDay;
    let index = planList[i].start;
    let endIndex = planList[i].stop;
    for (let j = index; j <= endIndex; j++) {
      indexArray["key_" + (j + (weekDay - 1) * 48)] = 1;
    }
  }

  for (let i = 0; i < 336; i++) {
    if (indexArray["key_" + i]) {
      byte += "1";
    } else {
      byte += "0";
    }
  }
  return byte;
};

getList()
</script>

<style scoped>

</style>
