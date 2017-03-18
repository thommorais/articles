<!DOCTYPE html><%@ page language="java" pageEncoding="iso-8859-1"%><%@ taglib uri="/WEB-INF/c" prefix="c" %><%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %><html  prefix="og: http://ogp.me/ns#" xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://ogp.me/ns/fb#" lang="<fmt:message key='site.idiomaLocal'/>">
<%
    response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);  
    String head = "skins/html5full/head.jsp";
    String body = "skins/html5full/body.jsp";
    String link_edicao = base + request.getAttribute("edicao_dia");
    String edicaoId = "" + request.getAttribute("edicaoId");    

%>
    <head>
        <meta charset="ISO-8859-1"/>
        <meta http-equiv="content-type" content="text/html;charset=iso-8859-1"/>    
       <c:choose>
        <c:when test="${!empty page.ogTitle}">
            <title><c:out value="${page.ogTitle}" escapeXml="false"/> - <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" escapeXml="false"/> - MavenFlip </title>
        </c:when>
        <c:when test="${!empty page.nome}">
            <title><c:out value="${page.nome}" escapeXml="false"/> - <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" escapeXml="false"/> - MavenFlip </title>
        </c:when>
        <c:otherwise>
            <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}" escapeXml="false"/> - MavenFlip </title>        
        </c:otherwise>
    </c:choose> 
        
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
        <meta http-equiv="Content-Style-Type" content="text/css"/>
        <meta http-equiv="Content-Script-Type" content="text/javascript"/>
        <meta http-equiv="X-UA-Compatible" content="IE=EDGE;IE=10;IE=9"/>
        

    <meta name="keywords" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>,<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.keywords}'/>"/>
    <meta property="og:type" content="website"/>
    <meta property="fb:app_id" content="357758654351603" />
    <c:choose>
        <c:when test="${!empty page.ogTitle}">
            <meta property="og:title" content="<c:out value='${page.ogTitle}'/>"/>
        </c:when>
        <c:when test="${!empty page.nome}">
            <meta property="og:title" content="<c:out value='${page.nome}'/>"/>
        </c:when>
        <c:otherwise>
            <meta property="og:title" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${!empty page.ogDescription}">
            <meta property="og:description" content="<c:out value='${page.ogDescription}'/>"/>
            <meta name="description" content="<c:out value='${page.ogDescription}'/>"/>
        </c:when>
        <c:when test="${!empty page.nome}">
            <meta property="og:description" content="<c:out value='${page.sobre}'/>"/>
            <meta name="description" content="<c:out value='${page.sobre}'/>"/>
        </c:when>
        <c:otherwise>
            <meta property="og:description" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
            <meta name="description" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
        </c:otherwise>
    </c:choose>            
    <meta property="og:image:type" content="image/jpeg"/>    
    <meta property="og:image" content="<%= base%><c:out value='${page.img}' escapeXml='false'/>"/>
    <meta property="og:url" content="<%= base%><c:out value='${edicao_dia}'/>"/>
    <script type="text/javascript">
                var base = '<%= base%>';
                var basestatic = '<%= baseweb%>';
                var gaPrefix = '';
                var kiss = null;
                var dataAnalytics = '<c:out value="${page.dataAnalytics}"/>';
                var linkedicao = '<c:out value="${edicao_dia}"/>';
                var myUser='<c:out value="${username}"/>';
                //todo remover
                var tituloAbaProdutos = '<c:out value="${page.flipModeloPublicacaoidid_modelo.tituloAbaProdutos}"/>';
                var sigla = '<c:out value="${page.flipModeloPublicacaoidid_modelo.sigla}"/>';
                var acervo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.pesquisaHistorico}"/>;
                var pageWheel =<c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.pageWheel}"/>;
                var doubleClickZoom=<c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.doubleClickZoom}"/>;
                var pageHeightSpace = <c:choose><c:when test = "${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao eq 'modern'}">123</c:when><c:otherwise>40</c:otherwise></c:choose>;
                var online = <c:out value = "${empty offline || offline eq 'false' || !empty logado}"/>;
                var flashbased = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash && page.flipModeloPublicacaoidid_modelo.prefs.pesquisaInstantanea}"/>;
                var folder = '<c:out value="${folder}"/>';                
                var flipenabled = <c:out value="${wizard ne 'true' || (!empty user_nome||!empty username) || page.publico }"/>;               
                var teste='<c:out value="${wizard}"/>'+'<c:out value="${user_nome}"/>'+'<c:out value="${username}"/>'+'<c:out value="${page.publico}"/>';
                var sumarioFotos = '<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>';
                var facebookshare = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.shareFacebook}"/>;
                var zoomBlocked = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.bloquearZoomNaoAssinantes && empty username}"/>;
                var keywords = "<c:out value='${param.keywords}'/>";
                var soundEnabled=<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.habilitaSom}"/>;
                var filtroAbaEdicao = <c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.filtroAbaEdicao}'/>;    
                var mid = <c:out value = "${page.flipModeloPublicacaoidid_modelo.id}"/>;                
                <c:if test = "${!empty page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}">
                <c:forEach var = "item" items = "${page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}" varStatus = "i">
                freePagesList[<c:out value = "${i.index}"/>] = '<c:out value="${item}"/>';
                </c:forEach>
                </c:if>
                var ipg = null, pg = null;
                <c:if test = "${!empty param.ipg}">
        <%if (request.getParameter("ipg").startsWith("anch")) {%>
        ipg = '<c:out value="${param.ipg}"/>';
        <%} else {%>
        ipg = 'anch<c:out value="${param.ipg}"/>';
        <% }%>
        </c:if>  
                <c:if test = "${!empty param.pg}">
                    pg = '<c:out value="${param.pg}"/>';
                    </c:if>

                function getCurrentEdition(){
                    return <c:out value = "${page.id}"/>;
                }       
                function getCurrentEditionNumber() {
                    return <c:out value = "${page.nrFixo}" /> ;
                } 
                var _gaq = _gaq||[];                
                 </script>
                
    <c:if test = "${!empty page.flipModeloPublicacaoidid_modelo.prefs.kissmetrics}">                        
        <script type="text/javascript">
                var numeroEdicao = '<c:out value="${page.nrFixo}"/>';
                var titleEdicao = '<c:out value="${page.nome}"/>';
                var dataEdicao = '<c:out value="${page.dataPub_date}"/>';
                var dataExtenso = '<c:out value="${page.dataExtenso}"/>';
                var nomeUsuario='<c:out value="${user_nome}"/>';
                var emailUsuario='<c:out value="${user_email}"/>';
         </script>
         <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.kissmetrics}" escapeXml = "false"/>
         <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/common/kissmetrics/kissmetrics.js"></script>         
         <c:choose>
             <c:when test="${!empty username}">
                 <script type="text/javascript">kiss=new Kiss();kiss.kissIdentify(emailUsuario);</script>
                 <c:if test="${empty kissUserChanged}">
                     <script type="text/javascript">kiss.realizouLogin();</script>
                     <c:set var="kissUserChanged" value="true" scope="session"/>
                 </c:if>
             </c:when>
             <c:otherwise>
                 <script type="text/javascript">kiss=new Kiss();kiss.kissIdentify('<%= session.getId() %>');</script>
             </c:otherwise>
         </c:choose>
    </c:if>
             
    <jsp:include page="<%= head%>" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
    </jsp:include>              
                 
    <c:choose>
        <c:when test = "${!empty page.flipModeloPublicacaoidid_modelo.prefs.googleTagManager}">
            <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.googleTagManager}" escapeXml = "false"/>
            <script type="text/javascript">                                                                
                        dataLayer.push({'event':'pageviewTracking', 'screenName':'flip '+sigla});               
            </script>
        </c:when>
        <c:otherwise>
            
            <script type="text/javascript">                        
                        var dataLayer=null;
                        <c:if test = "${!page.flipModeloPublicacaoidid_modelo.prefs.analytics}">
                        _gaq.push([gaPrefix+'_setAccount', 'UA-31102692-1']);
                        _gaq.push([gaPrefix+'_trackPageview'], '/'+linkedicao+'edicao='+getCurrentEdition());
                        (function() {
                        var ga = document.createElement('script');
                                ga.type = 'text/javascript';
                                ga.async = true;
                                ga.src = ('https:'==document.location.protocol ? 'https://ssl' : 'http://www')+'.google-analytics.com/ga.js';
                                (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(ga);
                        })();
                        </c:if>
            </script>
        </c:otherwise>
    </c:choose>  
                        
    <c:if test = "${page.encarte}">
        <script type = "text/javascript">jQuery.noConflict();</script>
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/js/popup.js"></script>
        <link href="<%= baseweb%>flip/jornal/css/popup.css" rel="stylesheet" type="text/css" media="screen" />
    </c:if>            
</head>

<body id="pageDiv" >
    
        <c:if test="${wizard eq 'true' && !page.publico}">
            <jsp:include page="plugin/wizard/assine.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
                <jsp:param name="edicao" value="<%= edicaoId %>"/>                                                                                
            </jsp:include>   
        </c:if>    
    
<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlTopo}" escapeXml="false"/>

<jsp:include page="skins/common/topBanner.jsp" flush="true"/>
<jsp:include page="<%= body%>" flush="true">
    <jsp:param name="base" value="<%= base%>"/>
    <jsp:param name="baseweb" value="<%= baseweb%>"/>
    <jsp:param name="edicao" value="<%= edicaoId%>"/>
</jsp:include>

<c:if test="${page.encarte}">
    <jsp:include page="skins/common/encarte.jsp" flush="true">
        <jsp:param name="base" value="<%= base%>"/>
    </jsp:include>
</c:if>    

<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>
<c:if test="${page.flipModeloPublicacaoidid_modelo.sigla eq 'papel'}"> 
            <jsp:include page="jsp/customs/papel/icons.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
                <jsp:param name="edicao" value="<%= edicaoId %>"/>                                                                                
            </jsp:include> 
        </c:if>
</body>
</html>
