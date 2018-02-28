package com.sse.chatops.service;

import com.sse.chatops.dao.AnswerMapper;
import com.sse.chatops.model.Answer;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
@Service
public class AnswerService {
    @Resource
    private AnswerMapper answerMapper;

    public Answer getAnswer(Integer messageId){
        return answerMapper.selectAnswerByMessageId(messageId);
    }

    public int insertAnswer(Answer answer){
        return answerMapper.insertAnswer(answer);
    }
}
