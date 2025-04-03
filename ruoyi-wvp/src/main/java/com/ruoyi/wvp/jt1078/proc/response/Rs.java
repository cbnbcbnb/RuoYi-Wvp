package com.ruoyi.wvp.jt1078.proc.response;


import com.ruoyi.wvp.jt1078.proc.Header;
import io.netty.buffer.ByteBuf;


/**
 * @author QingtaiJiang
 * @date 2021/8/30 18:54
 * @email qingtaij@163.com
 */

public abstract class Rs {
    private Header header;

    public abstract ByteBuf encode();


    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }
}
