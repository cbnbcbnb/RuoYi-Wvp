package com.ruoyi.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * JustAuth配置 第三方登录配置
 *
 * @author fengcheng
 */
@Component
@Configuration
public class JustAuthConfig {

    @Value("${just-auth.gitee.client-id}")
    private String giteeClientId;

    @Value("${just-auth.gitee.secret}")
    private String giteeSecret;

    @Value("${just-auth.gitee.redirect-uri}")
    private String giteeRedirectUri;

    @Value("${just-auth.gitee.front-url}")
    private String giteeFrontUrl;

    public String getGiteeClientId() {
        return giteeClientId;
    }

    public void setGiteeClientId(String giteeClientId) {
        this.giteeClientId = giteeClientId;
    }

    public String getGiteeSecret() {
        return giteeSecret;
    }

    public void setGiteeSecret(String giteeSecret) {
        this.giteeSecret = giteeSecret;
    }

    public String getGiteeRedirectUri() {
        return giteeRedirectUri;
    }

    public void setGiteeRedirectUri(String giteeRedirectUri) {
        this.giteeRedirectUri = giteeRedirectUri;
    }

    public String getGiteeFrontUrl() {
        return giteeFrontUrl;
    }

    public void setGiteeFrontUrl(String giteeFrontUrl) {
        this.giteeFrontUrl = giteeFrontUrl;
    }
}
