<%@ page language="java" pageEncoding="iso-8859-1"%>
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
    <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> - MavenFlip</title>
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
        <meta property="og:image:type" content="image/jpeg">
        <meta itemprop="image" content="<%= base%><c:out value='${page.img}'/>">
    </c:when>
    <c:otherwise>
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
            <meta property="og:image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  itemprop="image">
            <meta property="og:image:type" content="image/jpeg">
        </c:if>         
    </c:otherwise>
</c:choose>
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1" />      
<style type="text/css">
    #login-image img{
        max-width:350px;        
    }
</style>
<script type="text/javascript" src="<%= base%>flip/web/js/jquery.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/jquery.alerts.js"></script> 
<script type="text/javascript" src="<%= base%>flip/web/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/additional-methods.min.js"></script>   
<script type="text/javascript" src="<%= base%>flip/web/js/messages_pt_BR.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/jquery.maskedinput.min.js"></script>    
<script type="text/javascript" src="<%= base%>flip/web/js/cpfcnpj.js"></script>    
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-modal.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-transition.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-alert.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-modal.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-dropdown.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-scrollspy.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-tab.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-tooltip.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-popover.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-button.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-collapse.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-carousel.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-typeahead.js"></script>  
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-editable.js"></script>
<script type="text/javascript" src="<%= base%>flip/web/js/bootstrap-switch.js"></script> 
<script type="text/javascript" src="<%= base%>flip/jornal/skins/login/js/login.js?hs=<%= token_hash%>"></script>   
<link href="<%= base%>flip/web/css/bootstrap.css" rel="stylesheet"/>
<link href="<%= base%>flip/web/css/bootstrap-responsive.css" rel="stylesheet"/>    
<link rel="stylesheet" href="<%= base%>flip/web/css/jquery.alerts.css" type="text/css">    
<link rel="stylesheet" href="<%= base%>flip/web/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%= base%>flip/jornal/skins/login/css/screen.css?hs=<%= token_hash%>" />
<link rel="stylesheet" type="text/css" href="<%= base%>flip/jornal/skins/login/css/logins.css?hs=<%= token_hash%>" />
<!--[if IE 7]>
    <link rel="stylesheet" href="<%= base%>flip/web/css/font-awesome-ie7.min.css">
<![endif]-->    
</head>
<body id="login" class="new_teal">
    <div id="login-box">
        <div id="outer-content">
            <div id="inner-content">
                <div id="av-flash-block">    </div>                
                <div id="ie6-warning" class="warning" style="display: none; margin-top: 30px; text-shadow:none;"> Internet Explorer 6 ou mais antigos <strong> não funcionarão</strong>. Recomendamos atualizar para Google Chrome ou Firefox.</a> </div>
                <div id="opera-warning" class="warning" style="display: none; margin-top: 30px; text-shadow:none;"> Você precisará de Opera 10.5 ou superior   </div>
                <div id="no-cookies" class="warning" style="display: none; margin-top: 30px;"> Parece que você está com cookies desabilitados. Precisamos que habilite os cookies no seu navegador para o login funcionar. </div>
                <div id="content">
                    <div id="login-image">
                        <img src='<%= base %><c:out value="${page.img}"/>'/>
                    </div>
                    <div id="login-form-wrap">

                        <h1><fmt:message key='site.label.login.text'/></h1>                                                
                        <div id="page-heading"></div>
                        <div id="av-content">
                            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.textoAssinatura}">
                                <fieldset>
                                    <p>
                                    <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.textoAssinatura}" escapeXml="false"/>
                                    </p>
                                </fieldset>
                                <br/>
                            </c:if>

                            <form method="post" action="<%= base%>flip/loginEdicao.do"   id="login-form">                                
                                <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
                                <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
                                <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
                                <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
                                <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
                                <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
                                <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>

                                <fieldset>
                                    <legend><fmt:message key='site.label.login.text'/></legend>
                                    <div class="login-field above-below15 above30 clear"> 
                                        <label for="username"><fmt:message key='site.usuario'/></label> 
                                        <input type="text" name="username" tabindex="1" class="av-text" value="" id="username" autofocus required style="height:35px"/> 
                                        <c:choose>
                                            <c:when test="${folder eq 'grpcom'}">
                                                <a href="http://www.gazetadopovo.com.br/assinaturas/sou-assinante" class="login-forgot-toggle" target="_blank"><img src="<%= base%>flip/web/images/icons/help.png"/>&nbsp;&nbsp;Cadastre-se!</a> 
                                            </c:when>
                                            <c:when test="${folder eq 'folhadamanha'}">
                                                <a href="http://www.fmanha.com.br/faleconosco" class="login-forgot-toggle" target="_blank"><img src="<%= base%>flip/web/images/icons/help.png"/>&nbsp;&nbsp;Cadastre-se!</a> 
                                            </c:when>                                            
                                            <c:otherwise>
                                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.esqueciSenha}">
                                                    <a href="#" class="login-forgot-toggle show-forgot-user" style="margin-top:20px"><img src="<%= base%>flip/web/images/icons/help.png"/>&nbsp;&nbsp;<fmt:message key="site.label.esqueci"/></a> 
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>                                        
                                    </div>
                                    <div class="show-pass-wrap">
                                        <div class="login-field above-below15 clear"> 
                                            <label for="password" ><fmt:message key='site.password'/></label> 
                                            <input type="password" name="senha" tabindex="1" class="av-password" value="" id="password" required style="height:35px" autocomplete="off"/>                                         
                                            <c:choose>
                                                <c:when test="${folder eq 'grpcom'}">
                                                    <a href="http://www.gazetadopovo.com.br/conta/recuperar-senha/?referrer=http://www.gazetadopovo.com.br" class="login-forgot-toggle" target="_blank"><img src="<%= base%>flip/web/images/icons/help.png"/>&nbsp;&nbsp;Esqueci!</a>                                                 
                                                </c:when>
                                                <c:when test="${folder eq 'folhadamanha'}">
                                                    <a href="http://www.fmanha.com.br/faleconosco" class="login-forgot-toggle" target="_blank"><img src="<%= base%>flip/web/images/icons/help.png"/>&nbsp;&nbsp;Cadastre-se!</a> 
                                                </c:when>                                                                                            
                                                <c:otherwise>
                                                    <a href="#" class="login-forgot-toggle show-forgot-pass"  style="margin-top:20px"><img src="<%= base%>flip/web/images/icons/help.png"/>&nbsp;&nbsp;<fmt:message key="site.label.esqueci"/></a> 
                                                </c:otherwise>
                                            </c:choose>                                        
                                        </div>
                                    </div>
                                    <input type="submit" value="<fmt:message key='site.label.acessa'/>" class="btn btn-success acessalogin" tabindex="3" />
                                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes}">
                                        <input type="button" value="Cadastre-se!" class="btn btn-success acessacadastro" tabindex="4" />
                                    </c:if>
                                </fieldset>
                            </form>
                            <form method="post" action="<%= base%>flip/loginEdicao.do"   id="forgot-user"  style="display:none">                                
                                <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
                                <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
                                <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
                                <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
                                <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
                                <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
                                <input type="hidden" name="esqueci" value="S"/>
                                <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>

                                <fieldset id="forgot-username">
                                    <legend><fmt:message key="site.label.esqueceu.4"/></legend>
                                    <p><fmt:message key="site.label.esqueceu.3"/></p>
                                    <div class="login-field above-below15"> 
                                        <label for="email"><fmt:message key="site.label.login.email"/></label> 
                                        <input class="rounded  av-text" type="text" name="email" value="" id="email" required style="height:35px"/> 
                                    </div>
                                    <input type="submit" value="<fmt:message key='site.label.enviarUsuario'/>" class="btn btn-success acessauser" /> 
                                    <p class="float-left or-block"><fmt:message key="or"/> <a class="login-forgot-toggle show-login" href="#"><fmt:message key="site.label.voltarLogin"/></a></p>
                                </fieldset>
                            </form>
                            <form method="post" action="<%= base%>flip/loginEdicao.do"   id="forgot-pass"  style="display:none">
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
                                    <div class="login-field above-below15"> <label for="forgotpass-username"><fmt:message key='site.usuario'/></label> 
                                        <input class="rounded  av-text" type="text" id="forgotpass-username" name="username" value="" required style="height:35px"/> 
                                    </div>
                                    <input type="submit" value="<fmt:message key='site.label.resetarSenha'/>" class="btn btn-success acessapass" /> 
                                    <p class="float-left or-block"><fmt:message key="or"/>   <a class="login-forgot-toggle show-login" href="#"><fmt:message key="site.label.voltarLogin"/></a></p>
                                </fieldset>
                            </form>
                            <fieldset id="messages">
                                <p class="above30 clear" id="error">
                                    <%if (msg != null) {%>
                                    <font color="red"><%= msg%></font>
                                    <%}%>   
                                </p>
                            </fieldset>
                            <script type="text/javascript">
                                document.getElementsByTagName('html')[0].className += " new_teal";
                            </script> 
                        </div>
                        <br class="clear" /> 
                    </div>
                    <br class="clear" /> 
                </div>
            </div>
        </div>
    </div>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes}">  
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form method="post" action="<%= base%>flip/loginEdicao.do" id="flip_usuarioForm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h3 class="modal-title" id="myModalLabel"><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.assinaturaTopoCadastro}"/></h3>
                    </div>
                    <div class="modal-body">                                                
                        <input type="hidden" name="hash" value="<c:out value="${hash}"/>"/>
                        <input type="hidden" name="folder" value="<c:out value="${folder}"/>"/>
                        <input type="hidden" name="edicao" value="<c:out value="${page.id}"/>"/>
                        <input type="hidden" name="modelo" value="<c:out value="${modelo}"/>"/>
                        <input type="hidden" name="flip" value="<c:out value="${portal}"/>"/>
                        <jsp:include page="../../jsp/cadastraNovo.jsp" flush="true">
                            <jsp:param name="modelo" value="<%= modelo%>"/>
                            <jsp:param name="plano" value="<%= plano%>"/>
                        </jsp:include>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-primary" value="Fechar" data-dismiss="modal"/>
                        <input type="submit" class="btn btn-success" value="Cadastrar"/>                                        
                    </div>                   
                </div>
            </form>                                                             
        </div>
    </div>
</c:if>     

</body>
<%
    Object user = session.getAttribute("username");
    if (user != null) {
        br.com.maven.flip.listener.MavenflipSessionListener.removeUser(user.toString(), session.getId());
    }
    session.removeAttribute("username");
    session.removeAttribute("logado");
    session.removeAttribute("ed_id");
    session.removeAttribute("SUBSCRIPTION_DAYS");
    session.removeAttribute("SUBSCRIPTION_DATES");
    if (hash != null) {
        session.removeAttribute(hash.toString());
    }
%>
<script>
    jQuery(document).ready(function () {
        var cadastra = '<c:out value="${param.cadastra}"/>';
        console.log(cadastra);
        if (cadastra == "true") {
            jQuery(".acessacadastro").click();
        }
    });
</script>