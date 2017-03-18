<%
            String base = request.getParameter("base");
            String token_hash = "" + System.currentTimeMillis();
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<link href="<%= base%>flip/jornal/skins/embed/css/template.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/embed/css/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/><fmt:message key="site.idioma"/>.css?tok=<%= token_hash%>" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/embed/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/skins/embed/modalbox/css/jquery.modalbox.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%= base%>flip/jornal/skins/embed/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/embed/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base%>flip/jornal/skins/embed/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%= base%>flip/jornal/skins/embed/js<fmt:message key="site.idioma"/>/jquery-1.5.2.min.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/embed/js<fmt:message key="site.idioma"/>/abas.js" charset="utf-8"></script>
<script type='text/javascript' src='<%= base%>flip/jornal/skins/embed/js<fmt:message key="site.idioma"/>/basic.js' charset="utf-8"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/embed/modalbox/js/jquery.modalbox-1.2.0-min.js"></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
    <script type="text/javascript">var COMMENT_TYPE='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';</script>
    <script type="text/javascript" src="<%= base%>flip/jornal/skins/embed/js<fmt:message key="site.idioma"/>/comments.js" charset="utf-8"></script>
</c:if>
