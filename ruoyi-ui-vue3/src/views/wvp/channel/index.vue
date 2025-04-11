<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关键字" prop="searchSrt">
        <el-input
            v-model="queryParams.searchSrt"
            placeholder="请输入设备名称"
            clearable
            style="width: 240px"
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="通道类型" prop="channelType">
        <el-select v-model="queryParams.channelType" placeholder="请选择通道类型" style="width: 250px;"
                   default-first-option>
          <el-option label="设备" value="false"></el-option>
          <el-option label="子目录" value="true"></el-option>
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
    <el-table v-loading="loading" :data="channelList" ref="channelListTable">
      <el-table-column prop="name" label="名称" min-width="180" align="center"/>
      <el-table-column prop="deviceId" label="编号" min-width="180" align="center"/>
      <el-table-column label="快照" min-width="100" align="center">
        <template #default="scope">
          <ImagePreview :src="getSnap(scope.row)"></ImagePreview>
        </template>
      </el-table-column>
      <el-table-column prop="subCount" label="子节点数" min-width="100" align="center"/>
      <el-table-column prop="manufacturer" label="厂家" min-width="100" align="center"/>
      <el-table-column label="位置信息" min-width="120" align="center">
        <template #default="scope">
          <span size="medium"
                v-if="scope.row.longitude && scope.row.latitude">{{ scope.row.longitude }}<br/>{{ scope.row.latitude }}</span>
          <span size="medium" v-if="!scope.row.longitude || !scope.row.latitude">无</span>
        </template>
      </el-table-column>
      <el-table-column prop="ptzType" label="云台类型" min-width="100" align="center">
        <template #default="scope">
          <div>{{ scope.row.ptzTypeText }}</div>
        </template>
      </el-table-column>
      <el-table-column label="开启音频" min-width="100" align="center">
        <template #default="scope">
          <el-switch @change="updateChannel(scope.row)" v-model="scope.row.hasAudio" active-color="#409EFF">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column label="码流类型" min-width="180" align="center">
        <template #default="scope">
          <el-select size="mini" style="margin-right: 1rem;" @change="channelSubStreamChange(scope.row)"
                     v-model="scope.row.streamIdentification"
                     placeholder="请选择码流类型" default-first-option>
            <el-option label="stream:0(主码流)" value="stream:0"></el-option>
            <el-option label="stream:1(子码流)" value="stream:1"></el-option>
            <el-option label="streamnumber:0(主码流-2022)" value="streamnumber:0"></el-option>
            <el-option label="streamnumber:1(子码流-2022)" value="streamnumber:1"></el-option>
            <el-option label="streamprofile:0(主码流-大华)" value="streamprofile:0"></el-option>
            <el-option label="streamprofile:1(子码流-大华)" value="streamprofile:1"></el-option>
            <el-option label="streamMode:main(主码流-水星+TP-LINK)" value="streamMode:main"></el-option>
            <el-option label="streamMode:sub(子码流-水星+TP-LINK)" value="streamMode:sub"></el-option>
          </el-select>
        </template>
      </el-table-column>
      <el-table-column label="状态" min-width="100" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag v-if="scope.row.status === 'ON'">在线</el-tag>
            <el-tag type="info" v-if="scope.row.status !== 'ON'">离线</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="150" class-name="small-padding fixed-width" fixed="right">
        <template #default="scope">
          <el-button v-bind:disabled="device == null || device.online === 0" icon="el-icon-video-play"
                     type="text" @click="start(scope.row)">播放
          </el-button>
          <el-button v-bind:disabled="device == null || device.online === 0"
                     icon="el-icon-switch-button"
                     type="text" style="color: #f56c6c" v-if="!!scope.row.streamId"
                     @click="stopDevicePush(scope.row)">停止
          </el-button>
          <el-button
              type="text"
              icon="el-icon-edit"
              @click="handleEdit(scope.row)"
          >
            编辑
          </el-button>

          <el-dropdown @command="(command)=>{moreClick(command, scope.row)}">
             <span class="el-dropdown-link">
              <el-button size="medium" type="text">
                更多
                <el-icon class="el-icon--right">
                <arrow-down/>
              </el-icon>
              </el-button>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="records" v-bind:disabled="device == null || device.online === 0">
                  设备录像
                </el-dropdown-item>
                <el-dropdown-item command="cloudRecords" v-bind:disabled="device == null || device.online === 0">
                  云端录像
                </el-dropdown-item>
                <el-dropdown-item command="record" v-bind:disabled="device == null || device.online === 0">
                  设备录像控制-开始
                </el-dropdown-item>
                <el-dropdown-item command="stopRecord" v-bind:disabled="device == null || device.online === 0">
                  设备录像控制-停止
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
        @pagination="initData"
    />

    <el-dialog title="编辑通道" v-model="open" width="1000px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="名称">
              <el-input v-model="form.gbName" placeholder="请输入通道名称"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="编码">
              <el-input v-model="form.gbDeviceId" placeholder="请输入通道编码">
                <template v-slot:append>
                  <el-button @click="buildDeviceIdCode(form.gbDeviceId)">生成</el-button>
                </template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="设备厂商">
              <el-input v-model="form.gbManufacturer" placeholder="请输入设备厂商"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设备型号">
              <el-input v-model="form.gbModel" placeholder="请输入设备型号"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="行政区域">
              <el-input v-model="form.gbCivilCode" placeholder="请输入行政区域">
                <template v-slot:append>
                  <el-button @click="chooseCivilCodeFun()">选择</el-button>
                </template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="安装地址">
              <el-input v-model="form.gbAddress" placeholder="请输入安装地址"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="子设备">
              <el-select v-model="form.gbParental" style="width: 100%" placeholder="请选择是否有子设备">
                <el-option label="有" :value="1"></el-option>
                <el-option label="无" :value="0"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="父节点编码">
              <el-input v-model="form.gbParentId" placeholder="请输入父节点编码或选择所属虚拟组织">
                <template v-slot:append>
                  <el-button @click="chooseGroupFun()">选择</el-button>
                </template>
              </el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="设备状态">
              <el-select v-model="form.gbStatus" style="width: 100%" placeholder="请选择设备状态">
                <el-option label="在线" value="ON"></el-option>
                <el-option label="离线" value="OFF"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="经度">
              <el-input v-model="form.gbLongitude" placeholder="请输入经度"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="纬度">
              <el-input v-model="form.gbLatitude" placeholder="请输入纬度"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="云台类型">
              <el-select v-model="form.gbPtzType" style="width: 100%" placeholder="请选择云台类型">
                <el-option label="球机" :value="1"></el-option>
                <el-option label="半球" :value="2"></el-option>
                <el-option label="固定枪机" :value="3"></el-option>
                <el-option label="遥控枪机" :value="4"></el-option>
                <el-option label="遥控半球" :value="5"></el-option>
                <el-option label="多目设备的全景/拼接通道" :value="6"></el-option>
                <el-option label="多目设备的分割通道" :value="7"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="警区">
              <el-input v-model="form.gbBlock" placeholder="请输入警区"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设备归属">
              <el-input v-model="form.gbOwner" placeholder="请输入设备归属"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="信令安全模式">
              <el-select v-model="form.gbSafetyWay" style="width: 100%" placeholder="请选择信令安全模式">
                <el-option label="不采用" :value="0"></el-option>
                <el-option label="S/MIME签名" :value="2"></el-option>
                <el-option label="S/MIME加密签名同时采用" :value="3"></el-option>
                <el-option label="数字摘要" :value="4"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="注册方式">
              <el-select v-model="form.gbRegisterWay" style="width: 100%" placeholder="请选择注册方式">
                <el-option label="IETFRFC3261标准" :value="1"></el-option>
                <el-option label="基于口令的双向认证" :value="2"></el-option>
                <el-option label="基于数字证书的双向认证注册" :value="3"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="证书序列号">
              <el-input type="number" v-model="form.gbCertNum" placeholder="请输入证书序列号"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="证书有效标识">
              <el-select v-model="form.gbCertifiable" style="width: 100%" placeholder="请选择证书有效标识">
                <el-option label="有效" :value="1"></el-option>
                <el-option label="无效" :value="0"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="无效原因码">
              <el-input type="errCode" v-model="form.gbCertNum" placeholder="请输入无效原因码"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="证书终止有效期">
              <el-date-picker
                  v-model="form.gbEndTime"
                  type="datetime"
                  placeholder="选择日期时间"
                  style="width: 100%">
              </el-date-picker>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="保密属性">
              <el-select v-model="form.gbSecrecy" style="width: 100%" placeholder="请选择保密属性">
                <el-option label="不涉密" :value="0"></el-option>
                <el-option label="涉密" :value="1"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="IP地址">
              <el-input v-model="form.gbIpAddress" placeholder="请输入IP地址"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="端口">
              <el-input type="number" v-model="form.gbPort" placeholder="请输入端口"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="设备口令">
              <el-input v-model="form.gbPassword" placeholder="请输入设备口令"></el-input>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="业务分组编号">
              <el-input v-model="form.gbBusinessGroupId" placeholder="请输入业务分组编号"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="位置类型">
              <el-select v-model="form.gbPositionType" style="width: 100%" placeholder="请选择位置类型">
                <el-option label="省际检查站" :value="1"></el-option>
                <el-option label="党政机关" :value="2"></el-option>
                <el-option label="车站码头" :value="3"></el-option>
                <el-option label="中心广场" :value="4"></el-option>
                <el-option label="体育场馆" :value="5"></el-option>
                <el-option label="商业中心" :value="6"></el-option>
                <el-option label="宗教场所" :value="7"></el-option>
                <el-option label="校园周边" :value="8"></el-option>
                <el-option label="治安复杂区域" :value="9"></el-option>
                <el-option label="交通干线" :value="10"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="室外/室内">
              <el-select v-model="form.gbRoomType" style="width: 100%" placeholder="请选择位置类型">
                <el-option label="室外" :value="1"></el-option>
                <el-option label="室内" :value="2"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="用途">
              <el-select v-model="form.gbUseType" style="width: 100%" placeholder="请选择位置类型">
                <el-option label="治安" :value="1"></el-option>
                <el-option label="交通" :value="2"></el-option>
                <el-option label="重点" :value="3"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="补光">
              <el-select v-model="form.gbSupplyLightType" style="width: 100%" placeholder="请选择位置类型">
                <el-option label="无补光" :value="1"></el-option>
                <el-option label="红外补光" :value="2"></el-option>
                <el-option label="白光补光" :value="3"></el-option>
                <el-option label="激光补光" :value="4"></el-option>
                <el-option label="其他" :value="9"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="监视方位">
              <el-select v-model="form.gbDirectionType" style="width: 100%" placeholder="请选择位置类型">
                <el-option label="东(西向东)" :value="1"></el-option>
                <el-option label="西(东向西)" :value="2"></el-option>
                <el-option label="南(北向南)" :value="3"></el-option>
                <el-option label="北(南向北)" :value="4"></el-option>
                <el-option label="东南(西北到东南)" :value="5"></el-option>
                <el-option label="东北(西南到东北)" :value="6"></el-option>
                <el-option label="西南(东北到西南)" :value="7"></el-option>
                <el-option label="西北(东南到西北)" :value="8"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="分辨率">
              <el-input v-model="form.gbResolution" placeholder="请输入分辨率"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="下载倍速">
              <el-select v-model="form.gbDownloadSpeedArray" multiple style="width: 100%" placeholder="请选择位置类型">
                <el-option label="1倍速" value="1"></el-option>
                <el-option label="2倍速" value="2"></el-option>
                <el-option label="4倍速" value="4"></el-option>
                <el-option label="8倍速" value="8"></el-option>
                <el-option label="16倍速" value="16"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="空域编码能力">
              <el-select v-model="form.gbSvcSpaceSupportMod" style="width: 100%" placeholder="请选择空域编码能力">
                <el-option label="1级增强" value="1"></el-option>
                <el-option label="2级增强" value="2"></el-option>
                <el-option label="3级增强" value="3"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="时域编码能力">
              <el-select v-model="form.gbSvcTimeSupportMode" style="width: 100%" placeholder="请选择空域编码能力">
                <el-option label="1级增强" value="1"></el-option>
                <el-option label="2级增强" value="2"></el-option>
                <el-option label="3级增强" value="3"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
          <el-button v-if="form.dataType === 1" @click="resetData">重置</el-button>
        </div>
      </template>
    </el-dialog>

    <ChannelCode ref="channelCode" @handleOk="handleOk"></ChannelCode>

    <ChooseCivilCode ref="chooseCivilCodeRef" @onSubmit="gbCivilCodeOnSubmit"></ChooseCivilCode>

    <ChooseGroup ref="chooseGroupRef" @onSubmit="gbParentOnSubmit"></ChooseGroup>

    <el-dialog title="播放视频" v-model="openPlay" width="1000px" append-to-body>
      <div style="width: 100%; height: 600px">
        <easy-player class="player" :video-url="vUrl" autoplay :live="true"></easy-player>
      </div>
    </el-dialog>
  </div>
</template>

<script setup name="Channel">
import ChannelCode from "./channelCode.vue"
import ChooseCivilCode from "./chooseCivilCode.vue"
import ChooseGroup from "../../components/dialog/chooseGroup.vue"
import {playStop} from "../../../api/wvp/play.js";
import {ElMessage, ElMessageBox} from 'element-plus'
import {
  changeAudio,
  getDeviceById,
  listDeviceChannel,
  subChannels,
  updateChannelStreamIdentification
} from "../../../api/wvp/device.js";
import {getCommonChannel, resetChannel, updateChannelData, sendDevicePush} from "../../../api/wvp/channel.js";
import {recordApi} from "../../../api/wvp/control.js";
import router from "@/router";
const route = useRoute();
const {proxy} = getCurrentInstance();
const channelList = ref([]);
const loading = ref(true);
const total = ref(0);
const deviceId = ref('');
const parentChannelId = ref('');
const device = ref({});
const showTree = ref(false);
const open = ref(false);
const openPlay = ref(false);
const deviceChannelList = ref([])
const showSearch = ref(true);
const loadSnap = ref({});
const channelListTable = ref(null);
const channelCode = ref(null);
const chooseCivilCodeRef = ref(null);
const chooseGroupRef = ref(null);
const vUrl = ref('');

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    searchSrt: undefined,
    channelType: undefined,
    online: undefined,
  },
  rules: {}
});

const {queryParams, form, rules} = toRefs(data);

async function start(itemData){
  const params = {
    deviceId: deviceId.value,
    channelId: itemData.deviceId
  }
  const res = await sendDevicePush(params);
  console.log(res);

}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  initData();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 表单重置 */
function reset() {
  form.value = {
    gbName: undefined,
    gbDeviceId: undefined,
    gbManufacturer: undefined,
    gbModel: undefined,
    gbCivilCode: undefined,
    gbAddress: undefined,
    gbParental: undefined,
    gbParentId: undefined,
    gbStatus: undefined,
    gbLongitude: undefined,
    gbLatitude: undefined,
    gbPtzType: undefined,
    gbBlock: undefined,
    gbOwner: undefined,
    gbSafetyWay: undefined,
    gbRegisterWay: undefined,
    gbCertNum: undefined,
    gbCertifiable: undefined,
    gbEndTime: undefined,
    gbSecrecy: undefined,
    gbIpAddress: undefined,
    gbPort: undefined,
    gbPassword: undefined,
    gbBusinessGroupId: undefined,
    gbPositionType: undefined,
    gbRoomType: undefined,
    gbUseType: undefined,
    gbSupplyLightType: undefined,
    gbDirectionType: undefined,
    gbResolution: undefined,
    gbDownloadSpeedArray: undefined,
    gbSvcSpaceSupportMod: undefined,
    gbSvcTimeSupportMode: undefined,
  };
  proxy.resetForm("formRef");
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["formRef"].validate(valid => {
    if (valid) {
      if (form.value.gbDownloadSpeedArray) {
        form.value.gbDownloadSpeed = form.value.gbDownloadSpeedArray.join("/")
      }
      if (form.value.gbId) {
        updateChannelData(form.value).then(() => {
          ElMessage({
            type: 'success',
            message: '保存成功',
          })
          open.value = false
        })
      }
    }
  });
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  reset();
}

function buildDeviceIdCode(deviceId) {
  channelCode.value.openDialog(code => {

  }, deviceId);
}

function handleOk(code) {
  form.value.gbDeviceId = code
}

function chooseCivilCodeFun() {
  chooseCivilCodeRef.value.openDialog(code => {

  });
}

function gbCivilCodeOnSubmit(data) {
  form.value.gbCivilCode = data;
}

function chooseGroupFun() {
  chooseGroupRef.value.openDialog((deviceId, businessGroupId) => {

  });
}

function gbParentOnSubmit(deviceId, businessGroupId) {
  form.value.gbBusinessGroupId = businessGroupId;
  form.value.gbParentId = deviceId;
}

/**
 * 初始化数据
 */
function initData() {
  if (typeof (parentChannelId.value) == "undefined" || parentChannelId.value === '0') {
    getDeviceChannelList();
  } else {
    showSubchannels();
  }
}

/**
 * 显示子通道
 */
function showSubchannels() {
  if (!showTree.value) {
    subChannels({
      pageNum: queryParams.value.pageNum,
      pageSize: queryParams.value.pageSize,
      query: queryParams.value.searchSrt,
      online: queryParams.value.online,
      channelType: queryParams.value.channelType
    }).then((res) => {
      total.value = res.total;
      deviceChannelList.value = res.rows;
      deviceChannelList.value.forEach(e => {
        e.ptzType = e.ptzType + "";
      });

      // 防止出现表格错位
      nextTick(() => {
        channelListTable.value.doLayout();
      })
    })
  } else {

  }
}

/** 获取设备通道列表 */
function getDeviceChannelList() {
  loading.value = true;
  listDeviceChannel(
      {
        pageNum: queryParams.value.pageNum,
        pageSize: queryParams.value.pageSize,
        deviceId: deviceId.value,
        query: queryParams.value.searchSrt,
        online: queryParams.value.online,
        channelType: queryParams.value.channelType,
      }
  ).then(response => {
    channelList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  })
}

function getSnap(row) {
  return '/api/device/query/snap/' + deviceId.value + '/' + row.deviceId;
}

/**
 * 开启音频
 *
 * @param row
 */
function updateChannel(row) {
  changeAudio({
    channelId: row.id,
    audio: row.hasAudio
  }).then((res) => {
    console.log(res)
  })
}

/**
 * 码流类型
 *
 * @param row
 */
function channelSubStreamChange(row) {
  updateChannelStreamIdentification({
    deviceDbId: row.deviceDbId,
    id: row.id,
    streamIdentification: row.streamIdentification
  }).then((res) => {
    console.log(res)
  })
}

/**
 * 停止设备推流
 *
 * @param itemData
 */
function stopDevicePush(itemData) {
  playStop(deviceId.value, itemData.deviceId).then(() => {
    initData();
  }).catch(function (error) {
    initData();
  });
}

function resetData() {
  ElMessageBox.confirm(
      '确定重置为默认内容?',
      '提示',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      }
  )
      .then(() => {
        resetChannel(form.value.gbId).then((res) => {
          ElMessage({
            type: 'success',
            message: '重置成功 已保存',
          })
        })
        getCommonChannelFun(form.value.gbId)
      })
      .catch(() => {

      })
}

// 编辑
function handleEdit(row) {
  getCommonChannelFun(row.id)
}

function getCommonChannelFun(id) {
  getCommonChannel(id).then((res) => {
    if (res.data.gbDownloadSpeed) {
      res.data.gbDownloadSpeedArray = res.data.gbDownloadSpeed.split("/")
    }
    form.value = res.data;
    open.value = true
  })
}

function moreClick(command, itemData) {
  if (command === "records") {
    queryRecords(itemData)
  } else if (command === "cloudRecords") {
    queryCloudRecords(itemData)
  } else if (command === "record") {
    startRecord(itemData)
  } else if (command === "stopRecord") {
    stopRecord(itemData)
  }
}

function queryRecords(itemData) {
  router.push(`/channel/gbRecordDetail/index/${deviceId.value}/${itemData.deviceId}`);
}

function queryCloudRecords(itemData) {
  router.push(`/channel/cloudRecordDetail/index/${deviceId.value}_${itemData.deviceId}`);
}

function startRecord(itemData) {
  recordApi({
    deviceId: deviceId.value,
    recordCmdStr: "Record",
    channelId: itemData.deviceId,
  }).then(() => {
    ElMessage({
      type: 'success',
      message: '开始录像成功',
    })
  })
}

function stopRecord(itemData) {
  recordApi({
    deviceId: deviceId.value,
    recordCmdStr: "StopRecord",
    channelId: itemData.deviceId,
  }).then(() => {
    ElMessage({
      type: 'success',
      message: '停止录像成功',
    })
  })
}

onMounted(() => {
  deviceId.value = route.params && route.params.deviceId;
  parentChannelId.value = route.params && route.params.parentChannelId;
  if (deviceId.value) {
    getDeviceById(deviceId.value).then(response => {
      device.value = response.data;
    })
  }
  initData()
})
</script>

<style scoped>
.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}

.player {
  width: 1000px;
  height: 600px;
}
</style>
