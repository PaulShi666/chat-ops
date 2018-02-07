<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>智能运维平台</title>
    <link rel="stylesheet" href="/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet prefetch'
          href='/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css'>
    <link rel="stylesheet" href="/css/index.css">
</head>
<body>
<div class="container-fluid">
    <div class="row">

        <div class="panel panel-primary">
            <div class="panel-heading">
                <span class="glyphicon glyphicon-comment"></span> 智能运维平台
                <div class="btn-group pull-right">
                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-chevron-down"></span>
                    </button>
                    <ul class="dropdown-menu slidedown">
                        <li><a href="#"><span class="glyphicon glyphicon-refresh"></span>Refresh</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-ok-sign"></span>Available</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-remove"></span>Busy</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-time"></span>Away</a></li>
                        <li class="divider"></li>
                        <li><a href="#"><span class="glyphicon glyphicon-off"></span>Sign Out</a></li>
                    </ul>
                </div>
            </div>
            <div class="panel-body">
                <ul class="chat">
                </ul>
            </div>
            <div class="panel-footer">
                <div class="input-group">
                    <input id="btn-input" type="text" class="form-control input-sm"
                           placeholder="请输入命令"/>
                    <span class="input-group-btn">
                            <button class="btn btn-warning btn-sm" id="btn-chat">
                                发送</button>
                        </span>
                </div>
            </div>
        </div>

    </div>
</div>
<script src='/libs/jquery/3.1.0/jquery.min.js'></script>
<script src='/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js'></script>
<script>
    ws = new WebSocket("ws://localhost:8080/websocket");

    ws.onopen = function () {
        console.log('Info: connection opened.');
    };

    ws.onmessage = function (event) {
        var html = ' <li class="left clearfix">\n' +
                '                            <span class="chat-img pull-left">\n' +
                '                                <img src="http://placehold.it/50/55C1E7/fff&text=JS" alt="User Avatar"\n' +
                '                                     class="img-circle"/>\n' +
                '            </span>\n' +
                '                        <div class="chat-body clearfix">\n' +
                '                            <div class="header">\n' +
                '                                <strong class="primary-font">运维小助手</strong>\n' +
                '                                <small class="pull-right text-muted">\n' +
                '                                    <span class="glyphicon glyphicon-time"></span>12 mins ago\n' +
                '                                </small>\n' +
                '                            </div>\n' +
                '                            <p>\n' +
                                                event.data +
                '                            </p>\n' +
                '                        </div>\n' +
                '                    </li>';

        $(".chat").append(html);
        console.log('Received: ' + event.data);
    };

    ws.onclose = function (event) {
        console.log('Info: connection closed.');
    };
    $("#btn-chat").on("click",function (e) {

        var text = $("#btn-input").val();
        ws.send(text);
        var html =' <li class="right clearfix"><span class="chat-img pull-right">\n' +
                '                            <img src="http://placehold.it/50/FA6F57/fff&text=BP" alt="User Avatar" class="img-circle"/>\n' +
                '                        </span>\n' +
                '                        <div class="chat-body clearfix">\n' +
                '                            <div class="header">\n' +
                '                                <small class=" text-muted"><span class="glyphicon glyphicon-time"></span>15 mins ago\n' +
                '                                </small>\n' +
                '                                <strong class="pull-right primary-font">Bhaumik Patel</strong>\n' +
                '                            </div>\n' +
                '                            <p>\n' +
                                                text +
                '                            </p>\n' +
                '                        </div>\n' +
                '                    </li>';

        $(".chat").append(html);
    }) ;



</script>

</body>

</html>
