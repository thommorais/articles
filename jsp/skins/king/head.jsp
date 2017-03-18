<%
            String base = request.getParameter("base");
            String token_hash = "091216";
            String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);  
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<link rel='stylesheet prefetch' href='//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css'>
<link href="<%= baseweb %>flip/jornal/skins/king/css/template.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= baseweb %>flip/jornal/skins/king/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= baseweb %>flip/jornal/skins/king/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= baseweb %>flip/jornal/skins/king/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen" />
<c:choose>
    <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.tema}">
        <link href="<%= baseweb %>flip/jornal/skins/king/css/temas/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.tema}'/>/tema<fmt:message key='site.idioma'/>.css" rel="stylesheet" type="text/css" media="screen" />
    </c:when>
    <c:otherwise>
        <link href="<%= baseweb %>flip/jornal/skins/king/css/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/><fmt:message key='site.idioma'/>.css" rel="stylesheet" type="text/css" media="screen" />        
    </c:otherwise>
</c:choose>
<link href="<%= base %>flip/jornal/skins/king/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= baseweb %>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js<fmt:message key='site.idioma'/>/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
            jQuery.noConflict();
</script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js<fmt:message key='site.idioma'/>/abas.js?tok=<%= token_hash%>"></script>
<script type='text/javascript' src="<%= baseweb %>flip/jornal/skins/king/js<fmt:message key='site.idioma'/>/basic.js?tok=<%= token_hash%>"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/js/html5lightbox.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/modalbox/js/jquery.modalbox-1.2.0-min.js"></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
    <script type="text/javascript">var COMMENT_TYPE = '<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';</script>
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js<fmt:message key='site.idioma'/>/comments.js?tok=<%= token_hash%>"></script>
</c:if>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery-ui-1.8.23.custom.min.js" ></script>
<link href="<%= baseweb %>flip/jornal/skins/king/modalbox/css/jquery.modalbox-basic.css" rel="stylesheet" type="text/css" media="all"/>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado}">
    <link href="<%= baseweb %>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" media="screen" />
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery-ui-1.8.14.custom.min.js" ></script>    
    <link href="<%= baseweb %>flip/jornal/skins/king/css/jquery.stickynotes.css" rel="stylesheet" type="text/css" media="screen" />    
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery.stickynotes.js" ></script>
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/postit.js" ></script>
</c:if>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/plugin/videoBox<fmt:message key='site.idioma'/>.js"></script>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlHead}" escapeXml="false"/>