<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关键字" prop="query">
        <el-input
            v-model="queryParams.query"
            placeholder="请输入关键字"
            clearable
            style="width: 240px"

        />
      </el-form-item>

      <el-form-item label="流媒体" prop="mediaServerId">
        <el-select style="width: 250px;" v-model="queryParams.mediaServerId"
                   placeholder="请选择流媒体" default-first-option>
          <el-option
              v-for="item in mediaServerList"
              :key="item.id"
              :label="item.id"
              :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="拉流状态" prop="pulling">
        <el-select style="width: 250px;" v-model="queryParams.pulling" placeholder="请选择拉流状态"
                   default-first-option>
          <el-option label="正在拉流" value="true"></el-option>
          <el-option label="尚未拉流" value="false"></el-option>
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
            icon="Plus"
            @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getStreamProxyList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="streamProxyList" border>
      <el-table-column prop="app" label="流应用名" min-width="120" show-overflow-tooltip align="center" fixed/>
      <el-table-column prop="stream" label="流ID" min-width="120" show-overflow-tooltip align="center" fixed/>
      <el-table-column label="流地址" min-width="200" align="center" show-overflow-tooltip>
        <template #default="scope">
          {{ scope.row.srcUrl }}
        </template>
      </el-table-column>
      <el-table-column prop="mediaServerId" label="流媒体" min-width="150" align="center"/>
      <el-table-column label="代理方式" width="100" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            {{ scope.row.type === "default" ? "默认" : "FFMPEG代理" }}
          </div>
        </template>
      </el-table-column>

      <el-table-column prop="gbDeviceId" label="国标编码" min-width="120" show-overflow-tooltip align="center"/>
      <el-table-column label="拉流状态" min-width="120" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag v-if="scope.row.pulling">正在拉流</el-tag>
            <el-tag type="info" v-if="!scope.row.pulling">尚未拉流</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="启用" min-width="120" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag v-if="scope.row.enable">已启用</el-tag>
            <el-tag type="info" v-if="!scope.row.enable">未启用</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" min-width="150" show-overflow-tooltip align="center"/>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width" fixed="right">
        <template #default="scope">
          <el-button @click="playPush(scope.row)" type="text" :loading="scope.row.playLoading">
            播放
          </el-button>
          <el-button size="medium" icon="el-icon-switch-button" style="color: #f56c6c"  type="text" v-if="scope.row.pulling" @click="onStopPlay(scope.row)">
            停止
          </el-button>
          <el-button type="text" @click="handleChannelConfiguration(scope.row)">
            通道配置
          </el-button>
          <el-button type="text" @click="handleEdit(scope.row)">
            编辑
          </el-button>
          <el-button type="text" @click="handleDelete(scope.row)">
            删除
          </el-button>
          <!--          <el-button type="text" @click="queryCloudRecords(scope.row)">云端录像-->
          <!--          </el-button>-->
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getStreamProxyList"
    />

    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="类型" prop="type">
          <el-select
              v-model="form.type"
              placeholder="请选择代理类型"
          >
            <el-option key="默认" label="默认" value="default"></el-option>
            <el-option key="FFmpeg" label="FFmpeg" value="ffmpeg"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="应用名" prop="app">
          <el-input v-model="form.app" clearable placeholder="请选择应用名"></el-input>
        </el-form-item>
        <el-form-item label="流ID" prop="stream">
          <el-input v-model="form.stream" clearable placeholder="请选择流ID"></el-input>
        </el-form-item>
        <el-form-item label="拉流地址" prop="url">
          <el-input v-model="form.srcUrl" clearable placeholder="请选择拉流地址"></el-input>
        </el-form-item>
        <el-form-item label="超时时间(秒)" prop="timeoutMs">
          <el-input v-model="form.timeout" clearable placeholder="请选择超时时间(秒)"></el-input>
        </el-form-item>
        <el-form-item label="节点选择" prop="rtpType">
          <el-select
              v-model="form.relatesMediaServerId"
              @change="mediaServerIdChange"
              style="width: 100%"
              placeholder="请选择拉流节点"
          >
            <el-option key="auto" label="自动选择" value="auto"></el-option>
            <el-option
                v-for="item in mediaServerList"
                :key="item.id"
                :label="item.id"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="FFmpeg命令模板" prop="ffmpegCmdKey" v-if="form.type=='ffmpeg'">
          <el-select
              v-model="form.ffmpegCmdKey"
              style="width: 100%"
              placeholder="请选择FFmpeg命令模板"
          >
            <el-option
                v-for="item in Object.keys(ffmpegCmdList)"
                :key="item"
                :label="ffmpegCmdList[item]"
                :value="item">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="拉流方式(RTSP)" prop="rtspType">
          <el-select
              v-model="form.rtspType"
              style="width: 100%"
              placeholder="请选择拉流方式"
          >
            <el-option label="TCP" value="0"></el-option>
            <el-option label="UDP" value="1"></el-option>
            <el-option label="组播" value="2"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="无人观看" prop="noneReader">
          <el-radio-group v-model="form.noneReader">
            <el-radio :label="0">不做处理</el-radio>
            <el-radio :label="1">停用</el-radio>
            <el-radio :label="2">移除</el-radio>
          </el-radio-group>

        </el-form-item>
        <el-form-item label="其他选项">
          <div style="float: left;">
            <el-checkbox label="启用" v-model="form.enable"></el-checkbox>
            <el-checkbox label="开启音频" v-model="form.enableAudio"></el-checkbox>
            <el-checkbox label="录制" v-model="form.enableMp4"></el-checkbox>
          </div>

        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="编辑通道" v-model="openChannel" width="1000px" append-to-body>
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
          <el-button type="primary" @click="submitFormChannel">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <ChannelCode ref="channelCode" @handleOk="handleOk"></ChannelCode>

    <ChooseCivilCode ref="chooseCivilCodeRef" @onSubmit="gbCivilCodeOnSubmit"></ChooseCivilCode>

    <ChooseGroup ref="chooseGroupRef" @onSubmit="gbParentOnSubmit"></ChooseGroup>

    <el-dialog :title="title" v-model="openView" width="835px" append-to-body>
      <div class="player">
        <easy-player class="player" :video-url="rtcUrl" autoplay :live="true" :close="getStreamProxyList()"></easy-player>
      </div>
    </el-dialog>
  </div>
</template>

<script setup name="StreamProxy">
import ChannelCode from "../../components/common/channelCode.vue"
import ChooseCivilCode from "../../components/common/chooseCivilCode.vue"
import ChooseGroup from "../../components/dialog/chooseGroup.vue"
import {getOnlineMediaServerList} from "../../../api/wvp/wvpMediaServer.js";
import {addProxy, deleteProxy, getFFmpegCMDs, listProxy, stopProxy, updateProxy, start} from "../../../api/wvp/proxy.js";
import {ElMessage} from "element-plus";
import {addChannelData, updateChannelData} from "../../../api/wvp/channel.js";


const {proxy} = getCurrentInstance();

const streamProxyList = ref([]);
const mediaServerList = ref([]);
const loading = ref(false);
const showSearch = ref(true);
const total = ref(0);
const title = ref("");
const rtcUrl = ref("");
const open = ref(false);
const openView = ref(false);
const openChannel = ref(false);
const channelCode = ref(null);
const chooseCivilCodeRef = ref(null);
const chooseGroupRef = ref(null);
const ffmpegCmdList = ref({});
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
    app: [{required: true, message: "请输入应用名", trigger: "blur"}],
    stream: [{required: true, message: "请输入流ID", trigger: "blur"}],
  }
});

const {queryParams, form, rules} = toRefs(data);
const streamInfo = ref();
async function playPush(row){
  row.playLoading = true;
  streamInfo.value = row;
  try {
    const ans = await start({id: row.id});
    rtcUrl.value = ans.fmp4;
    row.playLoading = false;
    title.value = "播放视频";
    openView.value = true;
  } catch (e) {
    row.playLoading = false;
  }

}

function getStreamProxyList() {
  loading.value = true
  listProxy(queryParams.value).then((res) => {
    total.value = res.total;
    for (let i = 0; i < res.rows.length; i++) {
      res.rows[i]["startBtnLoading"] = false;
    }
    streamProxyList.value = res.rows;
    loading.value = false
  })
}

function initData() {
  getStreamProxyList();
  getOnlineMediaServerList().then((res) => {
    mediaServerList.value = res.data;
  })
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getStreamProxyList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 表单重置 */
function reset() {
  form.value = {
    type: undefined,
    app: undefined,
    stream: undefined,
    srcUrl: undefined,
    timeout: undefined,
    relatesMediaServerId: undefined,
    ffmpegCmdKey: undefined,
    rtspType: undefined,
    noneReader: undefined,
    enable: undefined,
    enableAudio: undefined,
    enableMp4: undefined,
  };
  proxy.resetForm("formRef");
}


function handleAdd() {
  reset()
  open.value = true;
  title.value = "新增拉流";

  form.value = {
    type: "default",
    dataType: 3,
    noneReader: 1,
    enable: true,
    enableAudio: true,
    mediaServerId: "",
    timeout: 10,
  }
}

function handleEdit(row) {
  reset()
  open.value = true;
  title.value = "修改拉流";
  form.value = JSON.parse(JSON.stringify(row))
}

function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除该拉流？').then(function () {
    return deleteProxy(row.id)
  }).then(() => {
    getStreamProxyList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {
  });


}

function mediaServerIdChange() {
  console.log(form.value.relatesMediaServerId)
  if (form.value.relatesMediaServerId !== "auto") {
    getFFmpegCMDs({mediaServerId: form.value.relatesMediaServerId}).then((res) => {
      ffmpegCmdList.value = res.data;
      form.value.ffmpegCmdKey = Object.keys(res.data)[0];
    })
  }
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  openChannel.value = false;
  reset();
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["formRef"].validate(valid => {
    if (valid) {
      noneReaderHandler()
      if (form.value.id != undefined) {
        updateProxy(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getStreamProxyList()
        })
      } else {
        addProxy(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getStreamProxyList()
        })
      }
    }
  });
}

function noneReaderHandler() {
  if (!form.value.noneReader || form.value.noneReader === 0) {
    form.value.enableDisableNoneReader = false;
    form.value.enableRemoveNoneReader = false;
  } else if (form.value.noneReader === 1) {
    form.value.enableDisableNoneReader = true;
    form.value.enableRemoveNoneReader = false;
  } else if (form.value.noneReader === 2) {
    form.value.enableDisableNoneReader = false;
    form.value.enableRemoveNoneReader = true;
  }
}

function onStopPlay(row) {
  stopProxy(row.id).then(() => {
    proxy.$modal.msgSuccess("停止成功");
    getStreamProxyList()
  })
}

function handleChannelConfiguration(row) {
  openChannel.value = true
  form.value = JSON.parse(JSON.stringify(row))
  form.value.gbDeviceId = ""
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

/** 编辑通道按钮 */
function submitFormChannel() {
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
          openChannel.value = false
          getStreamProxyList()
        })
      } else {
        addChannelData(form.value).then(() => {
          ElMessage({
            type: 'success',
            message: '保存成功',
          })
          openChannel.value = false
          getStreamProxyList()
        })
      }
    }
  })
}

onMounted(() => {
  initData();
})
</script>

<style scoped>
.player {
  width: 100%;
  height: 600px;
}
</style>
