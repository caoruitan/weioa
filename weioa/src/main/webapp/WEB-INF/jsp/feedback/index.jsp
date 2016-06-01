<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    request.setAttribute("basePath", basePath);
%>
<!doctype html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta charset="utf-8">
    <link href="${basePath}/css/pc/index.css" rel="stylesheet" type="text/css" />
    <script src="${basePath}/js/jquery183.js" type="text/javascript" charset="utf-8"></script>
    <script>
        var WORK = {
            ctx : "${basePath}"
        }

    </script>
    <title>工作反馈</title>
</head>

<body>
<div id="react-content" style="text-align: center;margin-top: 10px"></div>
</body>
<script src="${basePath}/js/pc/common.js"></script>
<script src="${basePath}/js/pc/index.js"></script>

</html>