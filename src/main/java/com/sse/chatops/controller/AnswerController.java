package com.sse.chatops.controller;

import com.sse.chatops.model.Answer;
import com.sse.chatops.model.Message;
import com.sse.chatops.service.AnswerService;
import com.sse.chatops.service.MessageService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class AnswerController {
    @Resource
    private AnswerService answerService;

    @RequestMapping(path = "/getAnswer")
    @ResponseBody
    Answer getAnswer(){
        Answer answer = new Answer();

        answerService.insertAnswer(answer);

        return answerService.getAnswer(1);
    }

}
