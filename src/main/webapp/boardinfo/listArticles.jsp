<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="articleList" value="${articleMap.articleList}" />
<c:set var="totArticles" value="${articleMap.totArticles}" />
<c:set var="section" value="${articleMap.section}" />
<c:set var="pageNum" value="${articleMap.pageNum}" />
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 목록창</title>
<style>
a {
   text-decoration: none;
   color: black;
}

.selPage {
   color: red;
   font-style: bold;
}

.noline {
   color: black;
   font-weight: normal;
}
</style>
</head>
<body>
   <table align="center" border="1" width="80%">
      <tr align="center" bgcolor="lightgreen">
         <th>글 번호</th>
         <th>작성자</th>
         <th>제목</th>
         <th>작성일</th>
      </tr>
      <c:choose>
         <c:when test="${empty articleList}">
            <tr>
               <td colspan="4" align="center">등록된 글이 없습니다.</td>
            </tr>
         </c:when>
         <c:when test="${!empty articleList}">
            <c:forEach var="article" items="${articleList}"
               varStatus="articleNum">
               <tr align="center">
                  <%--${article.articleNo} 계층형에서 쓰면 댓글과 게시글이 뒤죽박죽으로되서 사용x--%>
                  <td width="5%">${articleNum.count}</td>
                  <%--글번호 순서를 for문의 순서로  --%>
                  <td width="10%">${article.id}</td>
                  <td align="left" width="50%"><span style="padding-left: 10px"></span>
                     <c:choose>
                        <c:when test="${article.level > 1}">
                           <c:forEach begin="1" end="${article.level}" step="1">
                              <span style="padding-left: 20px"></span>
                           </c:forEach>
                           [답변]<a
                              href="${contextPath}/board/viewArticle.do?articleNo=${article.articleNo}">${article.title}</a>
                        </c:when>
                        <c:otherwise>
                           <a
                              href="${contextPath}/board/viewArticle.do?articleNo=${article.articleNo}">${article.title}</a>
                        </c:otherwise>
                     </c:choose></td>
                  <td width="10%">${article.writeDate}</td>
               </tr>
            </c:forEach>
         </c:when>
      </c:choose>
   </table>
   <div align="center">
      <c:if test="${totArticles != 0}">
         <c:choose>
            <c:when test="${totArticles > 100}">
               <c:forEach var="page" begin="1" end="10" step="1">
                  <c:if test="${section > 1 && page == 1}">
                     <a href="${contextPath}/board/listArticles.do?section=${section-1}&pageNum=${(section-1)*10+1}"> prev </a>
                  </c:if>
                  <a href="${contextPath}/board/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10+page}</a>
                  <c:if test="${page == 10}">
                     <a href="${contextPath}/board/listArticles.do?section=${section+1}&pageNum=${section*10+1}"> next </a>
                  </c:if>
               </c:forEach>
            </c:when>
            <%--  <c:when test="${totArticles == 100}">
               <c:forEach var="page" begin="1" end="10" step="1">
                  <a href="#">${page}</a>
               </c:forEach>
            </c:when> --%>
            <c:when test="${totArticles <= 100}">
               <c:if test="${totArticles == 100}">
                  <c:set var="totArticles" value="99" />
               </c:if>
               <c:forEach var="page" begin="1" end="${totArticles/10+1}" step="1">
                  <c:choose>
                     <c:when test="${page == pageNum}">
                        <a class="selPage"
                           href="${contextPath}/board/listArticles.do?section=${section}&pageNum=${page}">${page}</a>
                     </c:when>
                     <c:otherwise>
                        <a class="noLine"
                           href="${contextPath}/board/listArticles.do?section=${section}&pageNum=${page}">${page}</a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
            </c:when>
         </c:choose>
      </c:if>
   </div>
   <p align="center">
      <a href="${contextPath}/board/articleForm.do">글쓰기</a>
   </p>
</body>
</html>