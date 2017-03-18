<%
            String base = request.getParameter("base");
            String token_hash = ""+System.currentTimeMillis();
            String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);  
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<script type="text/javascript">
    var doc_x='<c:out value="${paginaWidth}"/>';
    var doc_y='<c:out value="${paginaHeight}"/>';        
</script> 
<link href='//fonts.googleapis.com/css?family=Source+Sans+Pro:700,600,500,400,300,200' rel='stylesheet' type='text/css'>
<link rel='stylesheet prefetch' href='//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css'>
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/reset.css">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/site.css">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/site-<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/>.css">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/custom_checkbox.css">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/tiny-scrollbar.css">
<!--[if IE 7]>
    <link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/font-awesome-ie7.css">
    <link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/fixie7.css">
  <![endif]-->
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery-1.8.0.min.js" charset="utf-8"></script>
<script src="<%= baseweb %>flip/jornal/skins/master/js/jquery.tinyscrollbar.min.js"></script>
<script src="<%= baseweb %>flip/jornal/skins/master/js/site.js"></script>
<!--[if lt IE 9]>
    <script src="<%= baseweb %>flip/jornal/skins/master/js/html5.js"></script>
  <![endif]-->
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="http://w.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher: "74880ac5-b595-4c2a-88de-3a23726645b3", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script> 
<script type="text/javascript" src="<%= baseweb %>flip/jornal/js/html5lightbox.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/plugin/videoBox<fmt:message key='site.idioma'/>.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/html5full/flare/darkbox.js" ></script>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlHead}" escapeXml="false"/>


<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/extras/modernizr.2.5.3.min.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/extras/jquery.mousewheel.min.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/lib/hash.js"></script>
<script type='text/javascript' src='<%= baseweb %>flip/jornal/skins/html5full/js/shortcut.js' ></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/js/magazine.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/modalbox/js/jquery.modalbox-1.2.0-min.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/html5full/js/listeners.js" ></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
    <script type="text/javascript">var COMMENT_TYPE='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';</script>
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/js/comments.js" charset="utf-8"></script>
</c:if>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery-ui-1.8.23.custom.min.js" ></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.postit && !empty logado}">
    <link href="<%= baseweb %>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" media="screen" />
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery-ui-1.8.14.custom.min.js" ></script>    
    <link href="<%= baseweb %>flip/jornal/skins/king/css/jquery.stickynotes.css" rel="stylesheet" type="text/css" media="screen" />    
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/jquery.stickynotes.js" ></script>
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/king/js/postit.js" ></script>
</c:if>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/js/fullscreen/jquery.fullscreen.min.js" ></script>
<link href="<%= baseweb %>flip/jornal/skins/master/flare/js/pe.flare/jquery.pixelentity.flare.min.css" rel="stylesheet"/>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/flare/js/pe.flare/jquery.pixelentity.flare.min.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/master/js/jquery.rotate.1-1.js" ></script>     
<link type="text/css" rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/magazine.css"></link>
<link href="<%= baseweb %>flip/jornal/skins/king/css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%= base %>flip/jornal/skins/master/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= baseweb %>flip/jornal/skins/king/modalbox/css/jquery.modalbox.css" rel="stylesheet" type="text/css" media="all"/>
<link type="text/css" rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/master/css/custom.css"></link>
<link href="<%= baseweb %>flip/jornal/skins/html5full/flare/darkbox.css" rel="stylesheet" type="text/css" media="all">
