<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>file converting</title>
	<script type='text/javascript'src="https://code.jquery.com/jquery.min.js"></script>
	<style>
	.grad{
		text-align: center;
		width: 100%;
		height: 24em;
		background-color:#69349c;
		-webkit-animation-name: example; /* Safari 4.0 - 8.0 */
		-webkit-animation-duration: 2.5s; /* Safari 4.0 - 8.0 */
		animation-name: example;
		animation-duration: 2s;
		animation-iteration-count: infinite;
		animation-direction: alternate;
	}
	@-webkit-keyframes example {
		from {background-color: #69349c;}
		to {background-color: #d22f7c;}
	}

	@keyframes example {
		from {background-color: #69349c;}
		to {background-color: #d22f7c;}
	}
	
	.grad2{
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
		<img id="youtUpload" src="${pageContext.servletContext.contextPath}/resources/images/youtube_uploading.gif"  style="padding-top:10em; display:none;">
	</div>
	<div>
		<img id="i" src="${pageContext.servletContext.contextPath}/resources/images/801.gif" style="padding-top:10em;">
	</div>
</div>
<div class="grad2" style="display: none;">
	<div>
		<a href="javascript:downMp4();"><img id="youtUpload" src="${pageContext.servletContext.contextPath}/resources/images/midipink2.png" alt="이미지" style="padding-top:4em; width:10em;" class="move"></a>
	</div>
	<div style="padding-top:3em; font-weight:bold;" id="youtubeTxt">
		파일 변환이 완료되었습니다<br>주사위를 클릭해주세요.<br>
		<p style="font-size: 14px;">(유투브 및 인스타그램에 동영상을 공유해보세요)</p>
	</div>
</div>
<script>
function process(){
	$("#i").css("display","none");
	$("#youtUpload").fadeIn(2000);
}

function finishConv(){
	$(".grad").css("display","none");
	$(".grad2").fadeIn(2000);
}

function downMp4(){
	window.open("../res/download2.do?m=${mus}");	
}

function uploading(){
	$.ajax({
		type : 'post',
		url : '/midi/upload.do',
		data : {
			'v' : "${mus}"			
		},
		dataType : 'json',
		success : function(data){
			console.log(data);
			if(data.code == 0){
				//alert('업로드 완료');
				location.href="youtbs?id="+data.id;
			}else{
				alert("에러가 발생하였습니다.");
				//window.close();	
			}
		},
		error : function(request,status,error){
			console.log("code:"+request.status);
			console.log("message:"+request.responseText);
			console.log("error:"+error);
		}	
	});
}

$(function(){
	$.ajax({
		type : 'post',
		url : '/midi/convert.do',
		data : {
			'i' : "${img}",
			'm' : "${mus}"			
		},
		dataType : 'json',
		success : function(data){
			console.log(data);
			if(data.code == 0){
				//process();
				finishConv();
				//uploading(); //유투브 업로드 진행
			}else{
				alert("에러가 발생하였습니다.");
				//window.close();	
			}
		},
		error : function(){
			alert("error!!!");
		}	
	});
})
</script>
</body>
</html>
