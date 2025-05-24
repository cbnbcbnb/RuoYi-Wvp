package com.ruoyi.wvp.controller;

import com.ruoyi.common.exception.ControllerException;
import com.ruoyi.wvp.service.ILogService;
import com.ruoyi.wvp.service.bean.LogFileInfo;
import com.ruoyi.common.enums.ErrorCode;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.List;

/**
 * 日志文件查询接口
 */
@SuppressWarnings("rawtypes")
@Slf4j
@RestController
@RequestMapping("/api/log")
public class LogController {

    @Autowired
    private ILogService logService;

    /**
     * 查询日志文件列表
     *
     * @param query 检索内容
     * @param startTime 开始时间(yyyy-MM-dd HH:mm:ss)
     * @param endTime 结束时间(yyyy-MM-dd HH:mm:ss)
     * @return
     */
    @ResponseBody
    @GetMapping("/list")
    public List<LogFileInfo> queryList(@RequestParam(required = false) String query, @RequestParam(required = false) String startTime, @RequestParam(required = false) String endTime

    ) {
        if (ObjectUtils.isEmpty(query)) {
            query = null;
        }
        if (ObjectUtils.isEmpty(startTime)) {
            startTime = null;
        }
        if (ObjectUtils.isEmpty(endTime)) {
            endTime = null;
        }
        return logService.queryList(query, startTime, endTime);
    }

    /**
     * 下载指定日志文件
     */
    @ResponseBody
    @GetMapping("/file/{fileName}")
    public void downloadFile(HttpServletResponse response, @PathVariable  String fileName) {
        try {
            File file = logService.getFileByName(fileName);
            if (file == null || !file.exists() || !file.isFile()) {
                throw new ControllerException(ErrorCode.ERROR400);
            }
            final InputStream in = Files.newInputStream(file.toPath());
            response.setContentType(MediaType.TEXT_PLAIN_VALUE);
            ServletOutputStream outputStream = response.getOutputStream();
            IOUtils.copy(in, response.getOutputStream());
            in.close();
            outputStream.close();
        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
        }
    }

}
