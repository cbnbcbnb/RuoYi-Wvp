package com.ruoyi.wvp.service;

import com.github.pagehelper.PageInfo;
import com.ruoyi.wvp.storager.dao.dto.UserApiKey;

public interface IUserApiKeyService {
    int addApiKey(UserApiKey userApiKey);

    boolean isApiKeyExists(String apiKey);

    PageInfo<UserApiKey> getUserApiKeys(int page, int count);

    int enable(Integer id);

    int disable(Integer id);

    int remark(Integer id, String remark);

    int delete(Integer id);

    UserApiKey getUserApiKeyById(Integer id);

    int reset(Integer id, String apiKey);

}
