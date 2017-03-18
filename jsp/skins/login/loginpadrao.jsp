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
<c:choose>
    <c:when test="${!empty page.img}">
        <meta property="og:image" content="<%= base%><c:out value='${page.img}'/>"  itemprop="image">
        <meta itemprop="image" content="<%= base%><c:out value='${page.img}'/>">
        <meta property="og:image:type" content="image/jpeg">
    </c:when>
    <c:otherwise>
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}" >
            <meta property="og:image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  itemprop="image">
            <meta itemprop="image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>">
            <meta property="og:image:type" content="image/jpeg">
        </c:if>         
    </c:otherwise>
</c:choose>


<link href="<%= base%>flip/jornal/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<%= base%>flip/jornal/css/login.css" rel="stylesheet" type="text/css" />
<link href="<%= base%>flip/jornal/css/layout_dinamic.jsp?tok=<%= token_hash%>&px=<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.id}'/>" rel="stylesheet" type="text/css" media="screen"/>
<link href="<%= base%>flip/jornal/css/cadastra.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%= base%>flip/web/css/jquery.alerts.css" type="text/css">
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/prototype.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/scriptaculous.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/basic.js" charset="utf-8"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/js/login.js?1=1"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript">
    jQuery.noConflict();
</script>        
<script type="text/javascript" src="<%= base%>flip/web/js/jquery.alerts.js"></script>
</head>
<body oncontextmenu="return false" id="pageDiv">
    <!-- carregando -->
    <div id="loading" style="display:none;"><fmt:message key="site.loading"/>... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="<fmt:message key="site.loading"/>"/></div>

    <div id="top">
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
        <div id="data_login">
            <div id="loginForm">
                <form action="<%= base%>flip/loginEdicao.do" method="post" onsubmit="return validateForm(this);">
                    <input type="hidden" name="hash" value="<c:out value="${hash}"/>"/>
                           <input type="hidden" name="folder" value="<c:out value="${folder}"/>"/>
                           <input type="hidden" name="edicao" value="<c:out value="${page.id}"/>"/>
                           <input type="hidden" name="modelo" value="<c:out value="${modelo}"/>"/>
                           <input type="hidden" name="numero" value="<c:out value="${numero}"/>"/>
                           <input type="hidden" name="flip" value="<c:out value="${portal}"/>"/>
                           <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>
                    <fmt:message key='site.login'/>
                    &nbsp;&nbsp;&nbsp;
                    <fmt:message key='site.usuario'/> <input type="text" name="username" id="username" class="CampoTexto" />
                    <fmt:message key='site.password'/> <input type="password" name="senha" id="senha" class="CampoTexto"/>
                    <input type="image" name="loginButton" src="<%= base%>flip/jornal/images/ok.png" alt="<fmt:message key='site.cliqueacessa'/>" title="<fmt:message key='site.cliqueacessa'/>"/>
                    <!--<img src="<%= base%>flip/jornal/images/forgot.png" border="0" alt="Clique para trocar a sua senha"  onclick="document.getElementById('texto_login').style.display='none';document.getElementById('trocaSenhaForm').style.display='block'; return false;"> -->
                </form>
            </div>
        </div>
    </div>
    <div id="corpo">
        <div id="jornal_login" >
            <br/><br/>
            <div id="texto_login">
                <c:choose>
                    <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes}">
                        <form method="post" action="<%= base%>flip/loginEdicao.do"  onsubmit="return validate(this);" id="flip_usuarioForm">
                            <input type="hidden" name="hash" value="<c:out value="${hash}"/>"/>
                                   <input type="hidden" name="folder" value="<c:out value="${folder}"/>"/>
                                   <input type="hidden" name="edicao" value="<c:out value="${page.id}"/>"/>
                                   <input type="hidden" name="modelo" value="<c:out value="${modelo}"/>"/>
                                   <input type="hidden" name="flip" value="<c:out value="${portal}"/>"/>
                                   <jsp:include page="../../jsp/cadastra.jsp" flush="true">
                                       <jsp:param name="modelo" value="<%= modelo%>"/>
                                       <jsp:param name="plano" value="<%= plano%>"/>
                                   </jsp:include>
                        </form>

                        <div class="main" id="niftyforget" style="display:none">

                            <div class="box">
                                <form method="post" action="<%= base%>flip/loginEdicao.do"   id="forgot-pass" >
                                    <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
                                    <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
                                    <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
                                    <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
                                    <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
                                    <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
                                    <input type="hidden" name="esqueci" value="S"/>
                                    <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>

                                    <fieldset id="forgot-password">
                                        <legend><fmt:message key="site.label.esqueceu"/></legend>
                                        <p><fmt:message key="site.label.esqueceu.2"/></p>
                                        <fmt:message key='site.usuario'/> <fmt:message key="or"/> <fmt:message key='site.label.login.email'/>: <input class="rounded  av-text" type="text" id="forgotpass-username" name="username" value="" required style="width:180px"/>
                                        <br/><br/>
                                        <input type="submit" value="<fmt:message key='site.label.resetarSenha'/>" class="BotaoBranco" /> 
                                        <br/><br/>
                                        <p class="float-left or-block"><fmt:message key="or"/>   <a class="normal" href="javascript:voltaLogin();;"><fmt:message key="site.label.voltarLogin"/></a></p>
                                    </fieldset>
                                </form>

                            </div>    
                        </div>

                    </c:when>
                    <c:otherwise>
                        <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.textoAssinatura}" escapeXml="false"/>

                    </c:otherwise>
                </c:choose>
            </div>
            <br/>
            <div id="trocaSenhaForm" style="display:none">
                <div class="main" id="nifty1">
                    <div class="box">
                        <h1>Preenche os campos abaixo e altere a sua senha de assinante!
                        </h1>
                        <p></p>
                        <html:form method="post" action="trocaSenhaPost">
                            <label class="left">
                                <span class="normal">* Username</span>
                                <input type="text"  size='100'  maxlength='100'  name = 'usuario' id='usuario' class="input-text" />
                            </label>
                            <label class="normal">
                                <span class="normal">* Senha:</span>
                                <input type="password"  size='40'  maxlength='50'  name = 'oldPassword' id='oldPassword'  class='input-text' />
                            </label>
                            <label class="left">
                                <span class="normal">* Nova senha:</span>
                                <input type="password"  size='100'  maxlength='100'  name = 'newPassword' id='newPassword' class="input-text" />
                            </label>
                            <label class="normal">
                                <span class="normal">* Repita a nova:</span>
                                <input type="password"  size='40'  maxlength='50'  name = 'repeatNewPassword' id='repeatNewPassword'  class='input-text' />
                            </label>

                            <div class="spacer">
                                <html:submit property="saveButton" styleClass="BotaoBranco" title="Salvar"><bean:message key="button.save"/></html:submit>
                                <input type="button" name="senhabotao" value="Voltar para login" class="BotaoBranco" onclick="document.getElementById('trocaSenhaForm').style.display='none';document.getElementById('texto_login').style.display='block';"/>
                            </div>
                        </html:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%if (msg != null) {%>
    <script type="text/javascript"> alert('<%= msg%>'); </script>
    <%}%>
</body>
<script for="window" event="onload">
    $('username').focus();
</script>
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