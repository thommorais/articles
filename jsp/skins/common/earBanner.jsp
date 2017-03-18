<%
            String base = request.getParameter("base");
            
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<c:if test="${!empty page.orelha.nome}">
    <script src="<%= base%>flip/jornal/js/ear/v2/AC_OETags.js" type="text/javascript"></script>    
    <script type="text/javascript" >               
        pagearSmallImg = '<%= base%><c:out value="${page.orelha.bannerMenor}"/>';
        pagearBigImg  = '<%= base%><c:out value="${page.orelha.banner}"/>';
            <c:if test="${!empty page.orelha.link}">
            jumpTo   = '<c:out value="${page.orelha.linkPublico}"/>&tp=c';
            </c:if>        
            <c:if test="${empty page.orelha.link}">
            jumpTo   = "";
            </c:if>         
    </script>
    <script src="<%= base%>flip/jornal/js/ear/v2/pageear.js" type="text/javascript"></script>
    
</c:if>