package com.sse.chatops.dao;


import com.sse.chatops.model.Message;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MessageMapper {
    Message selectMessageByText(String text);
}
