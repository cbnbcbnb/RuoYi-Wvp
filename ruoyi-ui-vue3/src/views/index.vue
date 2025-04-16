<template>
  <div class="app-container home">
    <div style="margin-bottom: 20px;">
      <el-alert title="静态数据展示,自行定制开发!" type="success" />
    </div>

    <!-- 顶部统计卡片 -->
    <el-row :gutter="20" class="statistics-row">
      <el-col :span="6" v-for="(item, index) in statisticsData" :key="index">
        <div class="statistics-card" :class="'card-' + index">
          <div class="card-icon">
            <el-icon :size="40">
              <component :is="item.icon" />
            </el-icon>
          </div>
          <div class="card-content">
            <div class="number">{{ item.value }}</div>
            <div class="title">{{ item.title }}</div>
          </div>
          <div class="card-footer">
            <span class="unit">{{ item.unit }}</span>
            <el-tag size="small" :type="item.trend > 0 ? 'success' : 'danger'">
              {{ item.trend > 0 ? '+' : '' }}{{ item.trend }}%
            </el-tag>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 图表区域 -->
    <el-row :gutter="20" class="chart-row">
      <el-col :span="16">
        <el-card shadow="hover" class="chart-card">
          <template #header>
            <div class="card-header">
              <span>设备在线趋势</span>
              <el-radio-group v-model="timeRange" size="small">
                <el-radio-button label="day">日</el-radio-button>
                <el-radio-button label="week">周</el-radio-button>
                <el-radio-button label="month">月</el-radio-button>
              </el-radio-group>
            </div>
          </template>
          <div class="chart-container">
            <!-- 这里可以添加echarts图表 -->
            <div class="mock-chart">
              <div class="chart-line"></div>
              <div class="chart-line"></div>
              <div class="chart-line"></div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="8">
        <el-card shadow="hover" class="chart-card">
          <template #header>
            <div class="card-header">
              <span>设备类型分布</span>
            </div>
          </template>
          <div class="chart-container">
            <!-- 这里可以添加echarts饼图 -->
            <div class="mock-pie">
              <div class="pie-slice"></div>
              <div class="pie-slice"></div>
              <div class="pie-slice"></div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 平台信息和节点信息 -->
    <el-row :gutter="20" class="info-row">
      <el-col :span="12">
        <el-card shadow="hover" class="info-card">
          <template #header>
            <div class="card-header">
              <span>国标平台信息</span>
              <el-tag :type="platformInfo.status === '在线' ? 'success' : 'danger'" effect="dark">
                {{ platformInfo.status }}
              </el-tag>
            </div>
          </template>
          <el-descriptions :column="2" border>
            <el-descriptions-item label="平台名称">
              <el-tag>{{ platformInfo.name }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="平台ID">
              <el-tag>{{ platformInfo.id }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="平台IP">
              <el-tag type="info">{{ platformInfo.ip }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="平台端口">
              <el-tag type="info">{{ platformInfo.port }}</el-tag>
            </el-descriptions-item>
            <el-descriptions-item label="最后心跳时间">
              <el-tag type="warning">{{ platformInfo.lastHeartbeat }}</el-tag>
            </el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="hover" class="info-card">
          <template #header>
            <div class="card-header">
              <span>节点信息</span>
              <el-button type="primary" size="small" plain>刷新</el-button>
            </div>
          </template>
          <el-table :data="nodeList" style="width: 100%" :row-class-name="tableRowClassName">
            <el-table-column prop="name" label="节点名称" />
            <el-table-column prop="status" label="状态">
              <template #default="scope">
                <el-tag :type="scope.row.status === '在线' ? 'success' : 'danger'" effect="dark">
                  {{ scope.row.status }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="cpu" label="CPU使用率">
              <template #default="scope">
                <el-progress :percentage="parseInt(scope.row.cpu)" :color="customColors" />
              </template>
            </el-table-column>
            <el-table-column prop="memory" label="内存使用率">
              <template #default="scope">
                <el-progress :percentage="parseInt(scope.row.memory)" :color="customColors" />
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
import { ref, onMounted } from 'vue'
import { VideoCamera, Connection, VideoPlay, VideoPause } from '@element-plus/icons-vue'

// 统计数据
const statisticsData = ref([
  { title: '国标设备在线数', value: 25, unit: '个', trend: 5.2, icon: 'VideoCamera' },
  { title: 'ONVIF在线数', value: 15, unit: '个', trend: -2.1, icon: 'Connection' },
  { title: '推流代理数', value: 8, unit: '个', trend: 3.8, icon: 'VideoPlay' },
  { title: '拉流代理数', value: 12, unit: '个', trend: 1.5, icon: 'VideoPause' }
])

// 平台信息
const platformInfo = ref({
  name: '国标平台',
  id: 'GB28181',
  ip: '192.168.1.100',
  port: '5060',
  status: '在线',
  lastHeartbeat: '2024-03-20 10:00:00'
})

// 节点列表
const nodeList = ref([
  { name: '节点1', status: '在线', cpu: '30%', memory: '45%' },
  { name: '节点2', status: '离线', cpu: '0%', memory: '0%' }
])

const timeRange = ref('day')
const customColors = [
  { color: '#67C23A', percentage: 20 },
  { color: '#E6A23C', percentage: 40 },
  { color: '#F56C6C', percentage: 60 }
]

const tableRowClassName = ({ row }) => {
  return row.status === '在线' ? 'success-row' : 'warning-row'
}

// 模拟获取数据
const fetchData = () => {
  // TODO: 这里添加实际的数据获取逻辑
}

onMounted(() => {
  fetchData()
})
</script>

<style scoped lang="scss">
.home {
  .statistics-row {
    margin-bottom: 20px;
  }

  .statistics-card {
    background: #fff;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    transition: all 0.3s;
    position: relative;
    overflow: hidden;

    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 16px 0 rgba(0, 0, 0, 0.2);
    }

    .card-icon {
      position: absolute;
      right: 20px;
      top: 20px;
      opacity: 0.1;
      transform: scale(1.5);
    }

    .card-content {
      .number {
        font-size: 28px;
        font-weight: bold;
        color: #303133;
        margin-bottom: 5px;
      }

      .title {
        font-size: 14px;
        color: #909399;
      }
    }

    .card-footer {
      margin-top: 15px;
      display: flex;
      justify-content: space-between;
      align-items: center;

      .unit {
        color: #909399;
        font-size: 12px;
      }
    }
  }

  .chart-row {
    margin-bottom: 20px;
  }

  .chart-card {
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .chart-container {
      height: 300px;
      position: relative;
    }
  }

  .info-row {
    .info-card {
      .card-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
    }
  }

  .mock-chart {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    padding: 20px;

    .chart-line {
      height: 2px;
      background: #f0f0f0;
      border-radius: 1px;
    }
  }

  .mock-pie {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    background: #f0f0f0;
    margin: 50px auto;
    position: relative;
    overflow: hidden;

    .pie-slice {
      position: absolute;
      width: 100%;
      height: 100%;
      background: #409EFF;
      clip-path: polygon(50% 50%, 50% 0%, 100% 0%);
      transform-origin: 50% 50%;
    }
  }
}

:deep(.el-table) {
  .success-row {
    --el-table-tr-bg-color: var(--el-color-success-light-9);
  }
  .warning-row {
    --el-table-tr-bg-color: var(--el-color-warning-light-9);
  }
}

// 卡片动画效果
@keyframes cardHover {
  0% {
    transform: translateY(0);
  }
  100% {
    transform: translateY(-5px);
  }
}

.card-0 {
  background: linear-gradient(45deg, #409EFF, #36cfc9);
  color: white;

  .card-icon, .number, .title, .unit {
    color: white;
  }
}

.card-1 {
  background: linear-gradient(45deg, #67C23A, #95d475);
  color: white;

  .card-icon, .number, .title, .unit {
    color: white;
  }
}

.card-2 {
  background: linear-gradient(45deg, #E6A23C, #f3d19e);
  color: white;

  .card-icon, .number, .title, .unit {
    color: white;
  }
}

.card-3 {
  background: linear-gradient(45deg, #F56C6C, #f89898);
  color: white;

  .card-icon, .number, .title, .unit {
    color: white;
  }
}
</style>

