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

	<div class="member_list">
		<table class="admin_board_wrap" id="user-admin">
			<thead class="admin_boardList">
				<th class="admin_board_head">이름</th>
				<th class="admin_board_head">아이디</th>
				<th class="admin_board_head">현재상태</th>
				<th class="admin_board_head">가입일</th>
				<th class="admin_board_head">게시글수</th>
				<th class="admin_board_head">댓글수</th>
				<th class="admin_board_head">가입승인</th>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${userInfo}">
					<tr class="admin_board_content">
						<td class="admin_board_content_nm"><a
							class="mypageModal user_id" value="${vo.userId}">${vo.userId}</a>
						</td>
						<td class="admin_board_content_nm">${vo.userName}</td>
						<td class="admin_board_content_nm"><c:choose>
								<c:when test="${vo.userStatus== 0}">취업준비생</c:when>
								<c:when test="${vo.userStatus== 1}">직장인</c:when>
							</c:choose></td>
						<td class="admin_board_content_nm">${vo.userDate}</td>
						<td class="admin_board_content_nm"><a href="#"
							class="modal_boardList_admin" data-user-id="${vo.userId}">${vo.boardCnt}</a></td>
						<td class="admin_board_content_nm"><a href="#"
							class="modal_reply_admin" data-user-id="${vo.userId}">${vo.commentCnt}</a></td>
						<c:choose>
							<c:when test="${vo.userPass == 0}">
								<td class="admin_board_content_nm">
									<button data-user-id="${vo.userId}" type="button" value="승인"
										class="appro">승인</button>
									<button data-user-id="${vo.userId}" type="button" value="거부"
										class="deni">거부</button>
								</td>
							</c:when>
							<c:when test="${vo.userPass == 1}">
								<td class="admin_board_content_nm">
									<button data-user-id="${vo.userId}" type="button" value="승인"
										class="userDrop">회원 추방</button>
								</td>
							</c:when>
							<c:when test="${vo.userPass == 3}">
								<td>추방회원</td>
							</c:when>
							<c:when test="${vo.userPass == 2 }">
								<td>승인거절회원</td>
							</c:when>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<%@include file="../admin/nav.jsp"%>
</body>
</html>