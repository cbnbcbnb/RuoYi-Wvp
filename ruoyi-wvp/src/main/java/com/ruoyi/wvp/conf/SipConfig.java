package com.ruoyi.wvp.conf;


import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "sip", ignoreInvalidFields = true)
@Order(0)
@Data
public class SipConfig {

	private String ip;

	private String showIp;

	private Integer port;

	private String domain;

	private String id;

	private String password;

	Integer ptzSpeed = 50;

	Integer registerTimeInterval = 120;

	private boolean alarm = false;

	private long timeout = 15;
}
