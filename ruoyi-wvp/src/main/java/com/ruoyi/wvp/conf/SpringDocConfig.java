package com.ruoyi.wvp.conf;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springdoc.core.GroupedOpenApi;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;

/**
 * @author lin
 */
@Configuration
@Order(1)
@ConditionalOnProperty(value = "user-settings.doc-enable", havingValue = "true", matchIfMissing = true)
public class SpringDocConfig {

    /**
     * 添加分组
     * @return
     */
    @Bean
    public GroupedOpenApi publicApi() {
        return GroupedOpenApi.builder()
                .group("1. 全部")
                .packagesToScan("com.genersoft.iot.vmp")
                .build();
    }

    @Bean
    public GroupedOpenApi publicApi2() {
        return GroupedOpenApi.builder()
                .group("2. 国标28181")
                .packagesToScan("com.genersoft.iot.vmp.gb28181")
                .build();
    }

    @Bean
    public GroupedOpenApi publicApi3() {
        return GroupedOpenApi.builder()
                .group("3. 拉流转发")
                .packagesToScan("com.genersoft.iot.vmp.streamProxy")
                .build();
    }

    @Bean
    public GroupedOpenApi publicApi4() {
        return GroupedOpenApi.builder()
                .group("4. 推流管理")
                .packagesToScan("com.genersoft.iot.vmp.streamPush")
                .build();
    }

    @Bean
    public GroupedOpenApi publicApi5() {
        return GroupedOpenApi.builder()
                .group("4. 服务管理")
                .packagesToScan("com.genersoft.iot.vmp.server")
                .build();
    }

    @Bean
    public GroupedOpenApi publicApi6() {
        return GroupedOpenApi.builder()
                .group("5. 用户管理")
                .packagesToScan("com.genersoft.iot.vmp.user")
                .build();
    }
}
