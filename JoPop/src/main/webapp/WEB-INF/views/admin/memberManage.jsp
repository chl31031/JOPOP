<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝업/전시 정보 관리자 페이지</title>
<link rel="stylesheet" href="../resources/css/admin/popsManage.css">

<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
</head>
<body>
	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_subject">
			<span>회원 관리</span>
		</div>
		<div class="members_table_wrap">


			<!-- 회원 리스트 O -->
			<c:if test="${memberCheck != 'empty'}">
				<table class="members_table">
					<thead>
						<tr>
							<td class="th_column_1">No.</td>
							<td class="th_column_2">아이디</td>
							<td class="th_column_3">이름(닉네임)</td>
							<td class="th_column_4">주소</td>
							<td class="th_column_5">종류</td>
							<td class="th_column_6">멤버십</td>
							<td class="th_column_7">포인트</td>
						</tr>
					</thead>
					<c:forEach items="${list}" var="list">
						<tr>
							<td><c:out value="${list.mId}"></c:out></td>

							<td><a class="move" href='<c:out value="${list.mId}"/>'>
									<c:out value="${list.mEmail}"></c:out>
							</a></td>

							<td><c:out value="${list.mName}"></c:out>(<c:out value="${list.mNick}">)</c:out></td>

							<td><c:out value="${list.mAddr1}"></c:out> <c:out
									value="${list.mAddr2}"></c:out> <c:out value="${list.mAddr3}"></c:out></td>

							<td calss=""><c:choose>
									<c:when test="${vo.memberShip== 1}">신규</c:when>
									<c:when test="${vo.memberShip== 2}">실버</c:when>
									<c:when test="${vo.memberShip== 3}">골드</c:when>
									<c:when test="${vo.memberShip== 4}">VIP</c:when>
								</c:choose></td>

							<td><c:out value="${list.money}"></c:out></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			</table>


			<!--원래 footer 있었음-->
</body>
</html>