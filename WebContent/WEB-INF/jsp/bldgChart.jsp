<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <link rel='stylesheet' type='text/css' href='css/tui-chart.css' />
    <link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/codemirror.css'/>
    <link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/lint.css'/>
    <link rel='stylesheet' type='text/css' href='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/theme/neo.css'/>
    <link rel='stylesheet' type='text/css' href='css/example.css'/>
<meta charset="UTF-8">
<title>시설물 차트</title>
</head>
<body>
<div class='wrap'>
    <div class='code-html' id='code-html'>
        <div id='chart-area'></div>
    </div>
    <div class='custom-area'>
        <div id='error-dim'>
            <span id='error-text'></span>
            <div id='error-stack'></div>
            <span id='go-to-dev-tool'>For more detail, open browser's developer tool and check it out.</span>
        </div>
    </div>
</div>
<!--Import chart.js and dependencies-->
<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/core-js/2.5.7/core.js'></script>
<script type='text/javascript' src='https://uicdn.toast.com/tui.code-snippet/v1.5.0/tui-code-snippet.min.js'></script>
<script type='text/javascript' src='https://uicdn.toast.com/tui.chart/latest/raphael.js'></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script src='js/tui-chart.js'></script>

<script class='code-js' id='code-js'>
var container = document.getElementById('chart-area');
var data = {
   //categories: ['June, 2015', 'July, 2015'],
   categories: [${categories}],
    series: [
        {
            name: '공동',
            data: [${common}]
        },
        {
            name: '문화/교육',
            data: [${culturaleducation}]
        },
        {
            name: '기타',
            data: [${etc}]
        },
        {
            name: '일반',
            data: [${general}]
        },
        {
            name: '산업',
            data: [${industry}]
        },
        {
            name: '의료/복지',
            data: [${medicalwelfare}]
        },
        {
            name: '공공',
            data: [${public1}]
        },
        {
            name: '서비스',
            data: [${service}]
        }
    ]
};
var options = {
    chart: {
        width: 1000,
        height: 500,
        format: '1,000'
    },
    yAxis: {
        title: '시설물 개수',
        min: 0,
        max: 500
    },
    xAxis: {
        title: '준공년도'
    },
    legend: {
        align: 'top'
    }
};
var theme = {
    series: {
        colors: [
            '#83b14e', '#458a3f', '#295ba0', '#2a4175', '#289399',
            '#289399', '#617178', '#8a9a9a', '#516f7d', '#dddddd'
        ]
    }
};
// For apply theme
// tui.chart.registerTheme('myTheme', theme);
// options.theme = 'myTheme';
tui.chart.columnChart(container, data, options);

</script>

<!--For tutorial page-->
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/codemirror.js'></script>
<script src='https://ajax.aspnetcdn.com/ajax/jshint/r07/jshint.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/edit/matchbrackets.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/selection/active-line.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/mode/javascript/javascript.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/lint.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/javascript-lint.js'></script>
<script src='js/example.js'></script>
</body>
</html>