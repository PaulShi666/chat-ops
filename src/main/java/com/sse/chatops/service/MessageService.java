package com.sse.chatops.service;

import com.sse.chatops.dao.MessageMapper;
import com.sse.chatops.model.Message;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
@Service
public class MessageService {
    @Resource
    private MessageMapper messageMapper;

    public Message getMessage(String text){
        return messageMapper.selectMessageByText(text);
    }
}
