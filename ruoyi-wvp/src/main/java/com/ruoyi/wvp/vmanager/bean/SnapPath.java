package com.ruoyi.wvp.vmanager.bean;

/**
 * 截图地址信息
 */
public class SnapPath {

    /**
     * 相对地址
     */
    private String path;

    /**
     * 绝对地址
     */
    private String absoluteFilePath;

    /**
     * 请求地址
     */
    private String url;


    public static SnapPath getInstance(String path, String absoluteFilePath, String url) {
        SnapPath snapPath = new SnapPath();
        snapPath.setPath(path);
        snapPath.setAbsoluteFilePath(absoluteFilePath);
        snapPath.setUrl(url);
        return snapPath;
    }


    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getAbsoluteFilePath() {
        return absoluteFilePath;
    }

    public void setAbsoluteFilePath(String absoluteFilePath) {
        this.absoluteFilePath = absoluteFilePath;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
