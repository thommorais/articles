<html  prefix="og: http://ogp.me/ns#" xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://ogp.me/ns/fb#">
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-bean-el" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html" prefix="html"%>
<%        
    String edicao = request.getParameter("edicao");
    if (edicao == null) {
        edicao = "";
    } else {
        edicao = "?edicao=" + edicao;
    }
    Object portal = request.getAttribute("flip");
    if (portal == null) {
        portal = request.getParameter("flip");
    }
    if (portal == null) {
        portal = "";
    }
    request.setAttribute("portal", portal);
%>
<c:set var="prefs_temp" value="${page.flipModeloPublicacaoidid_modelo.prefs}" scope="session"/>
    <c:choose>
        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.skinLogin eq 'novo'}">
            <jsp:include page="skins/login/loginnovo.jsp">
                <jsp:param name="edicao" value="<%=edicao%>"/>
            </jsp:include>
        </c:when>
        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.skinLogin eq 'new'}">
            <jsp:include page="skins/login_novo/login.jsp">
                <jsp:param name="edicao" value="<%=edicao%>"/>
            </jsp:include>
        </c:when>
        <c:otherwise>
            <jsp:include page="skins/login/loginpadrao.jsp">
                <jsp:param name="edicao" value="<%=edicao%>"/>
            </jsp:include>
        </c:otherwise>
    </c:choose>    
</html>