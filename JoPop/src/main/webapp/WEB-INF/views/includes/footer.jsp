<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .footer {
        background-color: #343a40;
        color: #fff;
        padding-top: 30px;
        padding-left: 100px;
        height: 250px;
    }

    .footer_container {
        width: 80%;
        max-width: 1080px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .footer_left img {
        height: 50px;
    }

    .footer_right {
        font-size: 14px;
        line-height: 1.5;
    }

    .footer_right p {
        margin: 5px 0;
    }
</style>

<div class="footer">
    <div class="footer_container">
        <div class="footer_left">
            <img src="/resources/img/logo.png" alt="Logo">
        </div>
        <div class="footer_right">
            <p>(주) JoPoP 대표이사 : OOO</p>
            <p>사업자등록번호 : ooo-oo-ooooo</p>
            <p>대표전화 : oooo-oooo(발신자 부담전화)</p>
            <p>COPYRIGHT(C) ALL RIGHTS RESERVED.</p>
        </div>
        <div class="clearfix"></div>
    </div>
</div> <!-- class="footer" -->
