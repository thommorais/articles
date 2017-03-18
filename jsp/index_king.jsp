<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<%
            response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String head = "skins/king/head.jsp";
            String body = "skins/king/body.jsp";
            String link_edicao = base + request.getAttribute("edicao_dia");
            String edicaoId = "" + request.getAttribute("edicaoId");            
             String temp = "" + System.currentTimeMillis();
            String effects="effects/"+request.getAttribute("effect")+"/plugin.jsp";           

%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://ogp.me/ns/fb#"  lang="<fmt:message key='site.idiomaLocal'/>">
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <c:choose>
            <c:when test="${!empty page.ogTitle}">
                <title><c:out value="${page.ogTitle}"/> - <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip </title>
            </c:when>
            <c:when test="${!empty page.nome}">
                <title><c:out value="${page.nome}"/> - <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip </title>
            </c:when>
            <c:otherwise>
                <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip </title>        
            </c:otherwise>
        </c:choose>                
        <meta http-equiv="P3P" content="CP='CAO PSA OUR'">
        <meta http-equiv="expires" content="Fri, 1 Jan 1990 00:00:00 GMT">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="X-UA-Compatible" content="IE=EDGE;IE=10;IE=9;chrome=1">
        <meta name="MSSmartTagsPreventParsing" content="true">
        <meta name="revisit-after" content="1 days">
        <meta name="resource-type" content="document">
        <meta name="revisit" content="1 days">        
        <meta name="rating" content="General">
        <meta name="robots" content="ALL">
        <meta name="language" content="<fmt:message key='site.idiomaLocal'/>">
        <c:choose>
            <c:when test="${empty page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}">
                <meta name="author" content="www.mavenapp.com.br" />                
            </c:when>
            <c:otherwise>
                <meta name="author" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.facebookPage}'/>" />                
            </c:otherwise>
        </c:choose>
        <meta name="keywords" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>" />

        <c:choose>
            <c:when test="${!empty page.ogTitle}">
                <meta name="og:title" content="<c:out value='${page.ogTitle}'/>"/>
            </c:when>
            <c:when test="${!empty page.nome}">
                <meta name="og:title" content="<c:out value='${page.nome}'/>"/>
            </c:when>
            <c:otherwise>
                <meta name="og:title" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>                
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${!empty page.ogDescription}">
                <meta name="og:description" content="<c:out value='${page.ogDescription}'/>"/>
                <meta name="description" content="<c:out value='${page.ogDescription}'/>"/>
            </c:when>
            <c:when test="${!empty page.nome}">
                <meta name="og:description" content="<c:out value='${page.sobre}'/>"/>
                <meta name="description" content="<c:out value='${page.sobre}'/>"/>
            </c:when>
            <c:otherwise>
                <meta name="og:description" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
                <meta name="description" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
            </c:otherwise>
        </c:choose>            
        <meta name="og:type" content="website"/>
        <meta name="og:image" content="<%= base%><c:out value='${page.img}'/>"/>
        <script type="text/javascript">
                    var base = '<%= base%>';
                    var dataAnalytics = '<c:out value="${page.dataAnalytics}"/>';
                    var gaPrefix = '';
                    var myUser='<c:out value="${username}"/>';
                    var kiss = null;
                    var online = <c:out value = "${empty offline || offline eq 'false' || (!empty logado && logado eq 'true')}"/>;
                    var flashbased = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.paginasFlash && page.flipModeloPublicacaoidid_modelo.prefs.pesquisaInstantanea}"/>;
                    var sigla = '<c:out value="${page.flipModeloPublicacaoidid_modelo.sigla}"/>';
                    var folder = '<c:out value="${folder}"/>';
                    var sumarioFotos = '<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>';
                    var zoomBlocked = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.bloquearZoomNaoAssinantes && empty username && empty session.username && (empty logado or logado eq 'false')}"/>;
                    var linkedicao = '<c:out value="${edicao_dia}"/>';
                    var keywords = "<c:out value='${param.keywords}' escapeXml='false'/>";
                    var pageHeightSpace = <c:choose><c:when test = "${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao eq 'modern'}">123</c:when><c:otherwise>40</c:otherwise></c:choose>;
                    var acervo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.pesquisaHistorico}"/>;
                    var mid = <c:out value = "${page.flipModeloPublicacaoidid_modelo.id}"/>;
                    var facebookshare = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.shareFacebook}"/>;
                    var hasAttached = <c:out value = '${!empty anexos}'/>;                    
                    var filtroAbaEdicao = <c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.filtroAbaEdicao}'/>;    
                    <c:if test = "${!empty page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}">
                    <c:forEach var = "item" items = "${page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}" varStatus = "i">
                    freePagesList.push('<c:out value="${item}"/>');
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
                    function getCurrentEdition() {
                    return <c:out value = "${page.id}"/>;
                    }
            function getCurrentEditionNumber() {
            return <c:out value = "${page.nrFixo}"/>;
            }
        </script>
        <c:choose>
            <c:when test = "${!empty page.flipModeloPublicacaoidid_modelo.prefs.googleTagManager}">
                <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.googleTagManager}" escapeXml = "false"/>
                <script type="text/javascript">
                    var _gaq = null;
                            dataLayer.push({'event':'pageviewTracking', 'screenName':'flip '+sigla});                </script>
            </c:when>
            <c:otherwise>
                <script type="text/javascript">
                            var _gaq = _gaq||[];
                            var dataLayer = null;
                            <c:if test = "${!page.flipModeloPublicacaoidid_modelo.prefs.analytics}">
                            _gaq.push([gaPrefix+'_setAccount', 'UA-31102692-1']);
                            _gaq.push([gaPrefix+'_trackPageview', '/'+linkedicao+'edicao='+getCurrentEdition()]);
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
         <script type="text/javascript" src="<%= base%>flip/jornal/skins/common/kissmetrics/kissmetrics.js?1=2"></script>         
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
        <script type="text/javascript" src="<%= base%>flip/jornal/swfobject/swfobject.js"></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/player/mavenflip.js"></script>
        <c:if test="${page.encarte}">
            <script type="text/javascript"> jQuery.noConflict();</script>
            <script type="text/javascript" src="<%= base%>flip/jornal/js/popup.js"></script>
            <link href="<%= base%>flip/jornal/css/popup.css" rel="stylesheet" type="text/css" media="screen" />
        </c:if>
        <jsp:include page="<%= head %>" flush="true">
            <jsp:param name="base" value="<%= base %>"/>
        </jsp:include>
    </head>
    <body  id="pageDiv" >

        <c:if test="${wizard eq 'true' && !(!empty logado && logado eq 'true' && !empty username && username ne 'DEMO') }">
            <jsp:include page="plugin/wizard/assine.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
                <jsp:param name="edicao" value="<%= edicaoId %>"/>                                                                                
            </jsp:include>   
        </c:if>


        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlTopo}" escapeXml="false"/>

        <jsp:include page="skins/common/topBanner.jsp" flush="true"/>
        <jsp:include page="<%= body %>" flush="true">
            <jsp:param name="base" value="<%= base %>"/>
            <jsp:param name="edicao" value="<%= edicaoId %>"/>
        </jsp:include>

        <c:if test="${page.encarte}">
            <jsp:include page="skins/common/encarte.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
            </jsp:include>
        </c:if>                                    
        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.analytics && empty page.flipModeloPublicacaoidid_modelo.prefs.googleTagManager}">
            <script type='text/javascript'>
                            gaPrefix = 'maven.';
                            _gaq.push([gaPrefix+'_setAccount', 'UA-31102692-1']);
                            _gaq.push([gaPrefix+'_trackPageview', '/'+linkedicao+'edicao='+getCurrentEdition()]);
                            <c:if test = "${page.flipModeloPublicacaoidid_modelo.prefs.analyticsJavascript}">
                            (function() {
                            var ga = document.createElement('script');
                                    ga.type = 'text/javascript';
                                    ga.async = true;
                                    ga.src = ('https:'==document.location.protocol ? 'https://ssl' : 'http://www')+'.google-analytics.com/ga.js';
                                    (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(ga);
                            })();
                            </c:if>
            </script>
        </c:if>

        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.effects||!empty param.effect}">                                        
            <c:if test="${!empty param.effect}">
                <%
                    effects="effects/"+request.getParameter("effect")+"/plugin.jsp";
                %>
            </c:if>                                            
            <jsp:include page="<%= effects %>" flush="true">
                <jsp:param name="base" value="<%= base %>"/>                            
            </jsp:include>                                                                                                       
        </c:if>                                
        <c:if test="${page.flipModeloPublicacaoidid_modelo.sigla eq 'papel'}">
            <!-- REGRA ESPECIFICA DO SEBRAE - PROJETO ESPECIAL -->    
            <jsp:include page="jsp/customs/papel/icons.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
                <jsp:param name="edicao" value="<%= edicaoId %>"/>                                                                                
            </jsp:include> 
        </c:if>    
    </body>
</html>