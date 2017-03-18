<%
            String base = request.getParameter("base");
            String token_hash = "" + System.currentTimeMillis();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<link href="<%= base%>flip/jornal/skins/catalogue/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/catalogue/modalbox/css/jquery.modalbox.css" rel="stylesheet" type="text/css" media="all"/>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/catalogue/js<fmt:message key="site.idioma"/>/jquery-1.6.1.js"></script>
<script type='text/javascript' src='<%= base%>flip/jornal/skins/catalogue/js<fmt:message key="site.idioma"/>/basic.js' charset="utf-8"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/catalogue/modalbox/js/jquery.modalbox-1.2.0-min.js"></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
    <script type="text/javascript">var COMMENT_TYPE='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';</script>
    <script type="text/javascript" src="<%= base%>flip/jornal/skins/catalogue/js<fmt:message key="site.idioma"/>/comments.js" charset="utf-8"></script>
</c:if>
