<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome JoPoP</title>
<link rel="stylesheet" href="../resources/css/nav/search.css">
</head>
<body>
   <%@include file="../includes/header.jsp"%>
   <div class="wrapper">
      <div class="wrap">

         <div class="navi_bar_area">
            <h1>navi area</h1>
         </div>
         <div class="content_area">
         <div class="list_search_result">
               <table class="type_list">
                  <tbody id="searchList>">
                     <c:forEach items="${list}" var="list">
                        <tr class="list">
                           <td class="detail">
                              <div class="title">
                                 <a href="/goodsDetail/${list.pId}">
                                    ${list.pName}
                                 </a>
                              </div>
                              <div class=adress>
                              ${list.pAddr1}  ${list.pAddr2}
                              </div>
                              <div class="date">
                                  <fmt:formatDate value="${list.startDate}" pattern="yyyy.MM.dd"/>
                                  -
                                  <fmt:formatDate value="${list.endDate}" pattern="yyyy.MM.dd"/>
                              </div>
                           </td>
                           <td class="info">
                              <div class="rating">
                                 찜하기(추후 추가)
                              </div>
                           </td>
                           <td class="price">
                              <div class="org_price">
                                    <fmt:formatNumber value="${list.pPrice}" pattern="#,### 원" />
                              </div>
                           </td>
                           <td class="option"></td>
                        </tr>
                     </c:forEach>
                  </tbody>
               
               </table>
            </div>
      </div>
      </div>
      </div>

      
   <%@include file="../nav/nav.jsp"%>
</body>
</html>