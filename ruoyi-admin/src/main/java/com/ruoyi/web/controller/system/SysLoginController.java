package com.ruoyi.web.controller.system;

import cn.hutool.http.HttpUtil;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.config.JustAuthConfig;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysMenu;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginBody;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.web.service.SysLoginService;
import com.ruoyi.framework.web.service.SysPermissionService;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysMenuService;
import me.zhyd.oauth.config.AuthConfig;
import me.zhyd.oauth.model.AuthCallback;
import me.zhyd.oauth.model.AuthResponse;
import me.zhyd.oauth.model.AuthUser;
import me.zhyd.oauth.request.AuthGiteeRequest;
import me.zhyd.oauth.request.AuthRequest;
import me.zhyd.oauth.utils.AuthStateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Set;

/**
 * 登录验证
 *
 * @author ruoyi
 */
@RestController
public class SysLoginController {
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private RuoYiConfig ruoYiConfig;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private JustAuthConfig justAuthConfig;

    /**
     * 登录方法
     *
     * @return 结果
     */
    @Anonymous
    @GetMapping("/gitee-login")
    public AjaxResult giteeLogin() throws IOException {
        AuthRequest authRequest = getAuthRequest();
        return AjaxResult.success(authRequest.authorize(AuthStateUtils.createState()));
    }

    @Anonymous
    @GetMapping("/gitee-callback")
    public void login(AuthCallback callback,HttpServletResponse response) throws IOException {
        AuthRequest authRequest = getAuthRequest();
        AuthResponse<AuthUser> login = authRequest.login(callback);
        String accessToken = login.getData().getToken().getAccessToken();

        String url = "https://gitee.com/api/v5/user/starred/xiaochemgzi/RuoYi-Wvp?access_token="+accessToken;
        //get请求有参并设置超时时间 单位为毫秒
        String result = HttpUtil.get(url, 30000);
        System.out.println(result);
        if("".equals(result)){
            System.out.println("已关注");
            response.sendRedirect(justAuthConfig.getGiteeFrontUrl() + "?redirect=/index&code=true");
        }else {
            response.sendRedirect(justAuthConfig.getGiteeFrontUrl() + "?redirect=/index&code=false");
        }
    }

    private AuthRequest getAuthRequest() {
        return new AuthGiteeRequest(AuthConfig.builder()
                .clientId(justAuthConfig.getGiteeClientId())
                .clientSecret(justAuthConfig.getGiteeSecret())
                .redirectUri(justAuthConfig.getGiteeRedirectUri())
                .build());
    }

    /**
     * 登录方法
     *
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody) {
        if(Boolean.parseBoolean(configService.selectConfigByKey("sys_public_demonstrate")) && !Constants.SUPER_ADMIN.equals(loginBody.getUsername())) {
            if (!ruoYiConfig.getPublicCode().equals(loginBody.getPublicCode())) {
                return AjaxResult.error("公众号code错误，请关注ruoyi-wvp公众号获取正确的公众号code");
            }
        }

        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }

    /**
     * 获取用户信息
     *
     * @return 用户信息
     */
    @GetMapping("getInfo")
    public AjaxResult getInfo() {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        SysUser user = loginUser.getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        if (!loginUser.getPermissions().equals(permissions)) {
            loginUser.setPermissions(permissions);
            tokenService.refreshToken(loginUser);
        }
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    /**
     * 获取路由信息
     *
     * @return 路由信息
     */
    @GetMapping("getRouters")
    public AjaxResult getRouters() {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
}
