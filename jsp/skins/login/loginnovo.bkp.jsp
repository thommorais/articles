<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-bean-el" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html" prefix="html"%>
<%
    
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String edicao = request.getParameter("edicao");
    if (edicao == null) {
        edicao = "";
    } else {
        edicao = "?edicao=" + edicao;
    }
    Object hash = request.getAttribute("hash");
    Object modelo = request.getAttribute("modelo");
    Object plano = request.getAttribute("plano");
    Object portal = request.getAttribute("flip");
    Object msg = request.getSession().getAttribute("MESSAGE");
    request.getSession().removeAttribute("MESSAGE");
    String token_hash = "" + System.currentTimeMillis();
    if (portal == null) {
        portal = request.getParameter("flip");
    }
    if (portal == null) {
        portal = "";
    }
    request.setAttribute("portal", portal);
%>
<head>
    <title>
        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
    <meta http-equiv="expires" content="Fri, 1 Jan 1990 00:00:00 GMT"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta name="MSSmartTagsPreventParsing" content="true" />
    <meta name="revisit-after" content="5 days" />
    <meta name="resource-type" content="document" />
    <meta name="revisit" content="5 days" />
    <meta name="rating" content="General" />
    <meta name="robots" content="ALL" />
    <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate"/>
<meta name="description" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.description}"/>" />
<meta name="keywords" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>,<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.keywords}"/>" />
<meta name="og:title" content="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>"/>                
      <meta name="og:type" content="website"/>
<c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
    <meta name="og:image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"/>
</c:if> 
<link href="<%= base%>flip/jornal/css/loginnovo.css?hs=<%= token_hash%>" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%= base%>flip/jornal/skins/king/js/jquery-1.8.0.min.js"></script>   
<script type="text/javascript" src="<%= base%>flip/jornal/skins/login/js/login.js"></script>   
<style type="text/css">
    body,html {
        overflow:hidden;   
    }
    body{
        <c:choose>    
            <c:when test="${empty KEY_BACKGROUND}">
            background: #<c:out value="${prefs_temp.background}"/> <c:if test="${!empty prefs_temp.backgroundImageCss && 'NULO' ne prefs_temp.backgroundImageCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageCss}"/>)  repeat</c:if>;
        background-position: 0px 100%;
        background-size: 100%;
        </c:when>
            <c:otherwise>
            <c:out value="${KEY_BACKGROUND.css}"/>
            </c:otherwise>
            </c:choose>
            font-family:<c:out value="${prefs_temp.fonte}"/>;
        color: #<c:out value="${prefs_temp.dataColor}"/>;        
    }
    #logocliente { /* pega toda a área do topo */
        background: #<c:out value="${prefs_temp.backgroundTop}"/> <c:if test="${!empty prefs_temp.backgroundImageTopCss && 'NULO' ne prefs_temp.backgroundImageTopCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageTopCss}"/>) repeat-x </c:if>;
        color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
    }    
</style>
</head>
<body  id="pageDiv">

    <form method="post" action="<%= base%>flip/loginEdicao.do"   id="login">
        <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
        <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
        <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
        <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
        <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
        <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
        <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>

<h1><fmt:message key='site.label.login.text'/></h1>
<%if (msg != null) {%>
<p><font color="red"><%= msg%></font></p>
    <%}%>               
<fieldset id="inputs" style="width:400px;float:left;">
    <input id="username" name="username" type="text" placeholder="<fmt:message key='site.usuario'/>" autofocus required>   
    <input id="senha" name="senha" type="password" placeholder="<fmt:message key='site.password'/>" required>
</fieldset>
<fieldset id="actions" style="width:300px;">
    <input type="submit" id="submit" value="<fmt:message key='site.label.acessa'/>">
    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes}">
        <input type="button" id="submit" value="<fmt:message key='site.label.cadastro.text'/>" style="margin-left:10px;">        
    </c:if>
    <!-- <a href=""><fmt:message key="site.label.esqueceu"/></a>
    <a href=""><fmt:message key="site.label.trocar"/></a> -->
</fieldset>

<fieldset id="actions">
    <p>    
    <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.textoAssinatura}" escapeXml="false"/>
    </p>
</fieldset>    
<a href="http://www.mavenflip.com.br" id="back"><img src="<%= base%>/flip/jornal/images/icon_maven_rodape.png"/></a>

</form>

<div id="logocliente">
    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
            <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="<fmt:message key='site.cliquevisita'/>" target="_blank">
        </c:if>
        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="<fmt:message key='site.cliquevisita'/>" height="40px"/>
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
            </a>
        </c:if>
    </c:if>
</div>    
</body>
<%
    Object user = session.getAttribute("username");
    if (user != null) {
        
        br.com.maven.flip.listener.MavenflipSessionListener.removeUser(user.toString(),session.getId());
    }
    session.removeAttribute("username");
    session.removeAttribute("logado");
    session.removeAttribute("ed_id");
    session.removeAttribute("SUBSCRIPTION_DAYS");
    if (hash != null) {
        session.removeAttribute(hash.toString());
    }
%>