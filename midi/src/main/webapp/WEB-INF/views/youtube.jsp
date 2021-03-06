<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!Doctype html>
<html><head>
<meta charset="UTF-8">
<meta name="description" content="LiST">
<!-- Mobile Specific Meta -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>midiDICE</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<style>
	.grad{
		text-align: center;
		width: 100%;
		height: 24em;
		background-color:#69349c;
	}
	.move:hover{
		transform:scale(1.1);             /*  default */
		-webkit-transform:scale(1.1);  /*  chrome */
		-moz-transform:scale(1.1);     /* FireFox */
		-o-transform:scale(1.1);        /* Opera */
	}
	</style>
</head>
<body>
	<div class="grad">
		<div>
			<a href="javascript:moveYout();"><img id="youtUpload" src="${pageContext.servletContext.contextPath}/resources/images/midipink2.png" alt="이미지" style="padding-top:4em; width:10em;" class="move"></a>
		</div>
		<div style="padding-top:3em; font-weight:bold;" id="youtubeTxt">
			유투브 영상을 처리중입니다.<br>
			<p style="font-size: 14px;">(이미지 및 음악 파일의 크기에 따라 처리 시간이 다를 수 있습니다)</p>
		</div>
	</div>
<script>
	function moveYout(){
		window.open("https://www.youtube.com/watch?v=${id}");
	}
	
	function youtb(){
		$("#youtubeTxt").html("유투브 업로드가 완료되었습니다.<br>주사위를 클릭해주세요.<br><p style='font-size: 14px;'>(이미지 및 음악 파일의 크기에 따라 처리 시간이 다를 수 있습니다)</p>");
	}
	
	$(function(){
		setTimeout(youtb,24000);

	})
</script>
</body>
</html>