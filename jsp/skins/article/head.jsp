<%
            String base = request.getParameter("base");
            String token_hash = ""+System.currentTimeMillis();
            String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);
%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlHead}" escapeXml="false"/>
<link href='//fonts.googleapis.com/css?family=Roboto:700,600,500,400,300,200' rel='stylesheet' type='text/css'>
<%-- <link rel='stylesheet prefetch' href='//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css'> --%>
<link rel='stylesheet prefetch' href='//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/reset.css">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/site.css?token=<%= token_hash %>">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/style.css?token=<%= token_hash %>">

<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/site-<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}'/>.css?token=<%= token_hash %>">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/custom_checkbox.css">
<link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/reader.css">
<link href="<%= baseweb %>flip/jornal/skins/article/flare/js/pe.flare/jquery.pixelentity.flare.min.css" rel="stylesheet"/>
<link href="<%= base %>flip/jornal/skins/article/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link type="text/css" rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/custom.css"></link>
<link href="<%= baseweb %>flip/jornal/skins/html5full/flare/darkbox.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" type="text/css" href="<%= baseweb %>flip/jornal/skins/article/css/tooltipster.bundle.min.css" >
<script type="text/javascript"  src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript"  src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/interact.min.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/jquery.touch.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/pdfjs/js/pdf.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/pdfjs/compatibility.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/pdfjs/l10n.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/reader-extensions.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/reader-objects.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/reader.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/site.js?token=<%= token_hash %>"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/magazine.js?token=<%= token_hash %>"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/article/js/tooltipster.bundle.min.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/hammer.min.js"></script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/jquery.hammer.js"></script>

<script>

  var notes = [
    {
      x: 250,
      y: 250,
      page: 61938,
      text: 'Teste de note 1'
    },
    {
      x: 350,
      y: 350,
      page: 61939,
      text: 'Domine habilidades que estão em alta. Construa e elabore projetos incríveis. Receba uma certificação valiosa. Inicie sua carreira em Ciência de Dados, Machine Learning, Android e mais. Seja requisitado.'
    },
    {
      x: 150,
      y: 150,
      page: 61938,
      text: 'teste de outra nota'
    }

  ];

</script>
<script type="text/javascript"  src="<%= baseweb %>flip/jornal/skins/article/js/new-v.js?token=<%= token_hash %>"></script>


<!--[if IE 7]>
    <link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/font-awesome-ie7.css">
    <link rel="stylesheet" href="<%= baseweb %>flip/jornal/skins/article/css/fixie7.css">
  <![endif]-->
<!--[if lt IE 9]>
    <script src="<%= baseweb %>flip/jornal/skins/article/js/html5.js"></script>
  <![endif]-->
<script type="text/javascript">var switchTo5x=true;</script>
<script type="text/javascript" src="//w.sharethis.com/button/buttons.js"></script>
<script type="text/javascript">stLight.options({publisher: "74880ac5-b595-4c2a-88de-3a23726645b3", doNotHash: false, doNotCopy: false, hashAddressBar: false});</script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/js/html5lightbox.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/plugin/videoBox<fmt:message key='site.idioma'/>.js"></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/html5full/flare/darkbox.js" ></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/article/extras/jquery.mousewheel.min.js"></script>
<script type='text/javascript' src='<%= baseweb %>flip/jornal/skins/html5full/js/shortcut.js' ></script>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/html5full/js/listeners.js" ></script>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaComments}">
    <script type="text/javascript">var COMMENT_TYPE='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.publicaCommentsTipo}"/>';</script>
    <script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/article/js/comments.js" charset="utf-8"></script>
</c:if>
<script type="text/javascript" src="<%= baseweb %>flip/jornal/skins/article/js/fullscreen/jquery.fullscreen.min.js" ></script>
