1.
AJAX都有哪些优点和缺点？
1、最大的一点是页面无刷新，用户的体验非常好。
2、使用异步方式与服务器通信，具有更加迅速的响应能力。
3、可以把以前一些服务器负担的工作转嫁到客户端，利用客户端闲置的能力来处理，减轻服务器和带宽的负担，节约空间和宽带租用成本。并且减轻服务器的负担，ajax的原则是“按需取数据”，可以最大程度的减少冗余请求，和响应对服务器造成的负担。
4、基于标准化的并被广泛支持的技术，不需要下载插件或者小程序。
ajax的缺点
1、ajax不支持浏览器back按钮。
2、安全问题 AJAX暴露了与服务器交互的细节。
3、对搜索引擎的支持比较弱。
4、破坏了程序的异常机制。
5、不容易调试。


2.

什么是AJAX，为什么要使用Ajax
AJAX是“Asynchronous JavaScript and XML”的缩写。他是指一种创建交互式网页应用的网页开发技术。、

客户端与服务器，可以在【不必刷新整个浏览器】的情况下，与服务器进行异步通讯的技术

3.

原生js ajax请求有几个步骤？分别是什么
//创建 XMLHttpRequest 对象
var ajax = new XMLHttpRequest();
//规定请求的类型、URL 以及是否异步处理请求。
ajax.open('GET',url,true);
//发送信息至服务器时内容编码类型
ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); 
//发送请求
ajax.send(null);  
//接受服务器响应数据
ajax.onreadystatechange = function () {
    if (obj.readyState == 4 && (obj.status == 200 || obj.status == 304)) { 
    }
};

4.

JS note:
if you want to define the value of one item in the form , you can just have the “value” tag, and this will be what the server receive, I mean the thing that is in the “value” tag.

padding is tianchong , if i say that padding:20px;

it means that all the four parts of the div will appear a 20px tian chong,

if i say padding-left:20pxl

it means that on the left part it will be a 20 px tianchong.

