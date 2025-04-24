package com.ruoyi;

import com.alibaba.fastjson2.support.spring.data.redis.GenericFastJsonRedisSerializer;
import com.ruoyi.wvp.gb28181.bean.MobilePosition;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.scheduling.annotation.EnableScheduling;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.SessionCookieConfig;
import javax.servlet.SessionTrackingMode;
import java.util.Collections;

/**
 * 启动程序
 *
 * @author ruoyi
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@ServletComponentScan("com.ruoyi.wvp.conf")
@EnableScheduling
@EnableCaching
public class RuoYiApplication extends SpringBootServletInitializer {
    private static ConfigurableApplicationContext context;

    public static void main(String[] args) {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(RuoYiApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  ruoyi-wvp启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                "\n" +
                "                         _                              \n" +
                "                        (_)                             \n" +
                "  _ __ _   _  ___  _   _ _ ________      ____   ___ __  \n" +
                " | '__| | | |/ _ \\| | | | |______\\ \\ /\\ / /\\ \\ / / '_ \\ \n" +
                " | |  | |_| | (_) | |_| | |       \\ V  V /  \\ V /| |_) |\n" +
                " |_|   \\__,_|\\___/ \\__, |_|        \\_/\\_/    \\_/ | .__/ \n" +
                "                    __/ |                        | |    \n" +
                "                   |___/                         |_|    \n");
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(RuoYiApplication.class);
    }

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        super.onStartup(servletContext);

        servletContext.setSessionTrackingModes(
                Collections.singleton(SessionTrackingMode.COOKIE)
        );
        SessionCookieConfig sessionCookieConfig = servletContext.getSessionCookieConfig();
        sessionCookieConfig.setHttpOnly(true);

    }

    @Bean
    public RedisTemplate<String, MobilePosition> getRedisTemplateForMobilePosition(RedisConnectionFactory redisConnectionFactory) {
        RedisTemplate<String, MobilePosition> redisTemplate = new RedisTemplate<>();
        // 使用fastJson序列化
        GenericFastJsonRedisSerializer fastJsonRedisSerializer = new GenericFastJsonRedisSerializer();
        // value值的序列化采用fastJsonRedisSerializer
        redisTemplate.setValueSerializer(fastJsonRedisSerializer);
        redisTemplate.setHashValueSerializer(fastJsonRedisSerializer);

        // key的序列化采用StringRedisSerializer
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.setHashKeySerializer(new StringRedisSerializer());
        redisTemplate.setConnectionFactory(redisConnectionFactory);
        return redisTemplate;
    }
}
