<%
            String base = request.getParameter("base");
            String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);  
            String token_hash = "";
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<link rel='stylesheet prefetch' href='//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css'>
<script src="//code.jquery.com/jquery-1.8.1.js"></script>
<script type="text/javascript">
    var doc_x='<c:out value="${paginaWidth}"/>';
    var doc_y='<c:out value="${paginaHeight}"/>';        
</script>    
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/extras/modernizr.2.5.3.min.js"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/extras/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/lib/hash.js"></script>
<script type='text/javascript' src='<%= baseweb%>flip/jornal/skins/html5full/js/shortcut.js' ></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/js/magazine.js" charset="iso-8859-1"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js<fmt:message key='site.idioma'/>/abas.js?tok=<%= token_hash%>"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/modalbox/js/jquery.modalbox-1.2.0-min.js"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/js/listeners.js" ></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
    <script type="text/javascript">var COMMENT_TYPE='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';</script>
    <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js<fmt:message key="site.idioma"/>/comments.js"></script>
</c:if>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js/jquery-ui-1.8.23.custom.min.js" ></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado}">
    <link href="<%= baseweb%>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" media="screen" />
    <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js/jquery-ui-1.8.14.custom.min.js" ></script>    
    <link href="<%= baseweb%>flip/jornal/skins/king/css/jquery.stickynotes.css" rel="stylesheet" type="text/css" media="screen" />    
    <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js/jquery.stickynotes.js" ></script>
    <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js/postit.js" ></script>
</c:if>
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link href="<%= baseweb%>flip/jornal/skins/html5full/css/bootstrap.vertical-tabs.css" rel="stylesheet" type="text/css" media="all">
<link href="<%= baseweb%>flip/jornal/skins/html5full/css/bootstrap-v3.3.0-min.css" rel="stylesheet" type="text/css" media="all">
<link href="<%= baseweb%>flip/jornal/skins/html5full/css/bootstrap.vertical-tabs.css" rel="stylesheet" type="text/css" media="all">
<script type="text/javascript" src="<%= baseweb%>flip/jornal/js/html5lightbox.js"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/js/jquery.rotate.1-1.js" ></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/plugin/videoBox<fmt:message key='site.idioma'/>.js"></script>
<script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/flare/darkbox.js" ></script>
<script type="text/javascript" src="<%=baseweb %>flip/jornal/skins/html5full/js/fullscreen/jquery.fullscreen.min.js" ></script>
<link href="<%= baseweb %>flip/jornal/skins/king/css/template.css" rel="stylesheet" type="text/css" media="screen" >
<link href="<%= baseweb%>flip/jornal/skins/king/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen" >
<link href="<%= baseweb%>flip/jornal/skins/king/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen" >
<link href="<%= baseweb%>flip/jornal/skins/king/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen" >
<link href="<%= baseweb%>flip/jornal/skins/king/css/<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/><fmt:message key="site.idioma"/>.css?tok=<%= token_hash%>" rel="stylesheet" type="text/css" media="screen" >
<link href="<%= base%>flip/jornal/skins/king/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen">
<link href="<%= baseweb%>flip/jornal/skins/html5full/css/magazine.css" type="text/css" rel="stylesheet">
<link href="<%= baseweb%>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" type="text/css" media="screen">
<link href="<%= baseweb%>flip/jornal/skins/king/modalbox/css/jquery.modalbox-basic.css" rel="stylesheet" type="text/css" media="all">
<link href="<%= baseweb%>flip/jornal/skins/king/modalbox/css/jquery.modalbox.css" rel="stylesheet" type="text/css" media="all">
<link href="<%= baseweb%>flip/jornal/skins/html5full/flare/darkbox.css" rel="stylesheet" type="text/css" media="all">
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlHead}" escapeXml="false"/>