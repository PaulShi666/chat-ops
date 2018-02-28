package com.sse.chatops.dao;

import com.sse.chatops.model.Answer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AnswerMapper {
    Answer selectAnswerByMessageId(Integer messageId);

    int insertAnswer(Answer answer);
}
