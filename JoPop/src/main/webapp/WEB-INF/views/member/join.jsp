<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>

<div class="wrapper">
    <form id="join_form" method="post">
    <div class="wrap">
            <div class="subjecet">
                <span>회원가입</span>
            </div>
            <div class="email_wrap">
                <div class="email_name">이메일</div> 
                <div class="email_input_box">
                    <input class="email_input" name="mEmail">
                </div>
                <span class="email_input_re_1">사용 가능한 이메일입니다.</span>
                <span class="email_input_re_2">이메일이 이미 존재합니다.</span>
                
                <div class="email_check_wrap">
                    <div class="email_check_input_box" id="email_check_input_box_false">
                        <input class="email_check_input" disabled="disabled">
                    </div>
                    <div class="email_check_button">
                        <span>인증번호 전송</span>
                    </div>
                    <div class="clearfix"></div>
                    <span id="email_check_input_box_warn"></span>
                </div>
            </div>
            <div class="pw_wrap">
                <div class="pw_name">비밀번호</div>
                <div class="pw_input_box">
                    <input class="pw_input" type="password" name="mPw">
                </div>
            </div>
            <div class="pwck_wrap">
                <div class="pwck_name">비밀번호 확인</div>
                <div class="pwck_input_box">
                    <input class="pwck_input" type="password">
                </div>
            </div>
            <div class="user_wrap">
                <div class="user_name">이름</div>
                <div class="user_input_box">
                    <input class="user_input" name="mName">
                </div>
            </div>
            <div class="id_wrap">
                <div class="id_name">닉네임</div>
                <div class="id_input_box">
                    <input class="id_input" name="mNick">
                </div>
            </div>
            <div class="address_wrap">
                <div class="address_name">주소</div>
                <div class="address_input_1_wrap">
                    <div class="address_input_1_box">
                        <input class="address_input_1" name="mAddr1">
                    </div>
                    <div class="address_button">
                        <span>주소 찾기</span>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class ="address_input_2_wrap">
                    <div class="address_input_2_box">
                        <input class="address_input_2" name="mAddr2">
                    </div>
                </div>
                <div class ="address_input_3_wrap">
                    <div class="address_input_3_box">
                        <input class="address_input_3" name="mAddr3">
                    </div>
                </div>
            </div>
            <div class="join_button_wrap">
                <input type="button" class="join_button" value="가입하기">
            </div>
        </div>
    </form>
</div>

<script>

var code = ""; // 이메일 전송 인증번호 저장 위한 코드

$(document).ready(function(){
    // 회원가입 버튼(회원가입 기능 작동)
    $(".join_button").click(function(){
        $("#join_form").attr("action", "/member/join");
        $("#join_form").submit();
    });
});

// 이메일 중복검사
$('.email_input').on("input", function(){
    var mEmail = $('.email_input').val(); // .email_input에 입력되는 값
    var data = { mEmail : mEmail }; // '컨트롤에 넘길 데이터 이름' : '데이터(.email_input에 입력되는 값)'
    
    $.ajax({
        type: "post",
        url: "/member/memberIdChk",
        data: data,
        success: function(result){
            if(result != 'fail'){
                $('.email_input_re_1').css("display","inline-block");
                $('.email_input_re_2').css("display", "none");				
            } else {
                $('.email_input_re_2').css("display","inline-block");
                $('.email_input_re_1').css("display", "none");				
            }
        }
    });
});

// 인증번호 이메일 전송
$(".email_check_button").click(function(){
    var mEmail = $(".email_input").val(); // 입력한 이메일
    var cehckBox = $(".email_check_input"); // 인증번호 입력란
    var boxWrap = $(".email_check_input_box"); // 인증번호 입력란 박스
    
    $.ajax({
        type: "GET",
        url: "/member/emailCheck",
        data: { mEmail: mEmail },
        success: function(data){
            cehckBox.prop("disabled", false); // 입력란 활성화
            boxWrap.attr("id", "email_check_input_box_true");
            code = data; // 서버에서 받은 인증번호 저장
        }
    });
});

// 인증번호 비교
$(".email_check_input").blur(function(){
    var inputCode = $(".email_check_input").val(); // 입력코드
    var checkResult = $("#email_check_input_box_warn"); // 비교 결과
    
    if(inputCode == code){ // 일치할 경우
        checkResult.html("인증번호가 일치합니다.");
        checkResult.attr("class", "correct");
    } else { // 일치하지 않을 경우
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
    }
});

</script>
</body>
</html>
