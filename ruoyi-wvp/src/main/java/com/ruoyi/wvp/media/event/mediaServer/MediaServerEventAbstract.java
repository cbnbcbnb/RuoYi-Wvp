package com.ruoyi.wvp.media.event.mediaServer;

import com.ruoyi.wvp.media.bean.MediaServer;
import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;


public abstract class MediaServerEventAbstract extends ApplicationEvent {


    private static final long serialVersionUID = 1L;

    @Getter
    @Setter
    private MediaServer mediaServer;


    public MediaServerEventAbstract(Object source) {
        super(source);
    }

}
