package com.sse.chatops.websocket;

import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.sse.chatops.shell.Shell;
import org.springframework.stereotype.Component;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint(value = "/websocket")
@Component
public class MyWebSocket {
    //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    private static int onlineCount = 0;

    //concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。
    private static CopyOnWriteArraySet<MyWebSocket> webSocketSet = new CopyOnWriteArraySet<MyWebSocket>();

    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;

    /**
     * 连接建立成功调用的方法*/
    @OnOpen
    public void onOpen(Session session) {
        this.session = session;
        webSocketSet.add(this);     //加入set中
        addOnlineCount();           //在线数加1
        System.out.println("有新连接加入！当前在线人数为" + getOnlineCount());
        try {
            sendMessage("你好，我是运维机器人");

            sendMessage(
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看CPU</a></p>" +
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看磁盘信息</a></p>"+
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看网络负载</a></p>"+
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看内存</a></p>" +
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看进程总数</a></p>" +
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看IP地址</a></p>"+
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看当前NGINX监控数据</a></p>" +
                     "<p><a class=\"J_SendText\" href=\"javascript:;\">查看昨日NGINX监控数据</a></p>"

            );
            //sendMessage(CommonConstant.CURRENT_WANGING_NUMBER.toString());

//            "<p><a href=\"http://10.112.2.109/report.html\">查看当前NGINX监控数据</a></p>" +
//                    "<p><a href=\"http://10.112.2.109/report.html\">查看昨日监控数据</p>"
        } catch (IOException e) {
            System.out.println("IO异常");
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose() {
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1
        System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息*/
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("来自客户端的消息:" + message);

//        String res = "";
//
//        switch (message){
//
//            case "查看昨天":
//                res = "<a href=\"http://10.112.2.109/test.html\">点击查看昨天NGINX监控数据";
//                break;
//                default:
//                    res = "无法查询到该命令";
//
//        }
        Shell shell = new Shell("10.112.2.109", "root", "Dcp@Admin");
        shell.execute(message);
        //shell.execute("ps -e  -o \"%C  : %p : %z : %a\"|sort -k5 -nr");

        ArrayList<String> stdout = shell.getStandardOutput();


        String res = JSON.toJSONString(stdout);

        //群发消息
        for (MyWebSocket item : webSocketSet) {
            try {
                item.sendMessage(res);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 发生错误时调用
     @OnError
      * */
     public void onError(Session session, Throwable error) {
     System.out.println("发生错误");
     error.printStackTrace();
     }


     public void sendMessage(String message) throws IOException {
     this.session.getBasicRemote().sendText(message);
     //this.session.getAsyncRemote().sendText(message);
     }


     /**
      * 群发自定义消息
      * */
    public static void sendInfo(String message) throws IOException {
        for (MyWebSocket item : webSocketSet) {
            try {
                item.sendMessage(message);
            } catch (IOException e) {
                continue;
            }
        }
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        MyWebSocket.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        MyWebSocket.onlineCount--;
    }
}