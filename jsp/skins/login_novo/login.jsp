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
    <meta name="description" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/> <c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.description}'/>" />
    <meta name="keywords" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>,<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.keywords}'/>" />
    <meta name="og:title" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>                
    <meta name="og:type" content="website"/>
    <c:choose>
        <c:when test="${!empty page.img}">
            <meta property="og:image" content="<%= base%><c:out value='${page.img}'/>"  itemprop="image"/>
            <meta property="og:image:type" content="image/jpeg">
            <meta itemprop="image" content="<%= base%><c:out value='${page.img}'/>">
        </c:when>
        <c:otherwise>
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                <meta property="og:image" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  itemprop="image"/>
                <meta property="og:image:type" content="image/jpeg">
            </c:if>         
        </c:otherwise>
    </c:choose>
    <c:if test="${page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'correiodopovo'}">
        <link rel="shortcut icon" type="image/x-icon" href="http://www.correiodopovo.com.br/favicon.ico"/>
    </c:if>
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
    <link rel="stylesheet" type="text/css" href="<%= base%>flip/jornal/skins/login_novo/css/normalize.css"/>
    <link rel="stylesheet" type="text/css" href="<%= base%>flip/jornal/skins/login_novo/css/skeleton.css?1=1"/>
    <!--[if IE 7]>
        <link rel="stylesheet" href="<%= base%>flip/web/css/font-awesome-ie7.min.css">
    <![endif]-->    


    <style type="text/css">        
        body {    
            margin: 0;
            padding-top:60px;
            max-height:100%;  
        }       
        .controls-row [class*="span"] + [class*="span"] {
            margin-left: 80px;
        }
        .modal-footer .btn + .btn {
            margin-bottom: 0;
            margin-left: 0px;
        }
        .modal-body {
            max-height: 350px;
        }
        #fechar, #cadastrar,#assinar,#finalizar{
            width: 200px;
            float: left;
        }
        #fechar{
            margin-left: 100px;
        }
        #assinar{
            margin-left: 10px;
        }
        .acessar{
            margin-left: 0px;
            margin-bottom: 0px;
        }
        .modal.fade.in {
            top: 3%;
        }    
        h3 {
            font-size: 2.0rem;
        }
        #background {
            text-align: center;
            width: 100%; 
            height: 100%; 
            position: fixed;
            left: 0px; 
            top: 0px; 
            z-index: -1;
        }
        .stretch {
            margin: auto;
            height:100%;
            width:100%;
        }    
        .cadastro-step2{
            padding:20px;
        }
        #myModal{
            z-index:-1;
            width:650px;
        }
        .validation-error{
            color:red;
        }
        .logoclass{
            display:block;        
            width:100%;     
            max-height:90px;
            clear:both;
            margin-bottom:10px;
        }
        .tituloclass{
            width:100%;
            clear:both;
            display:block;        
            height:35px;
        }
        .loginh1{
            text-align: left;
            font-size: 120%;
            margin-top: 15px;
            color: rgb(217, 95, 0);
            font-weight: bold;
            float:left;
            width:70px;
        }
        .topologin{

        }
        <c:if test="${page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'senai'}">
            input[type="email"], input[type="number"], input[type="search"], input[type="text"], input[type="tel"], input[type="url"], input[type="password"], textarea, select {
                background-color: #f0f0f0;
                border: 1px solid #232323;
            }
            .button, button, input[type="submit"], input[type="reset"], input[type="button"] {
                color: #fff;
                border: 1px solid #E5E5E5;
                background: #f06900;
                background: -moz-linear-gradient(top, #f06900 0%, #d15c00 100%);
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f06900), color-stop(100%,#d15c00));
                background: -webkit-linear-gradient(top, #f06900 0%,#d15c00 100%);
                background: -o-linear-gradient(top, #f06900 0%,#d15c00 100%);
                background: -ms-linear-gradient(top, #f06900 0%,#d15c00 100%);
                background: linear-gradient(to bottom, #888585 0%,#90908f 100%);
            }
            
            .login a {
                color: #8b8a89;
            }
            .login a:hover {
                color: #8b8a89;
                text-decoration: underline;
            }
        </c:if>
    </style>

    <script type="text/javascript">
        var isSenai = false;
        var assina = false;
        var model = <c:out value = "${page.flipModeloPublicacaoidid_modelo.id}"/>
        jQuery(document).ready(function () {
// <senai_temp>
            var modelo = <%= modelo%>;
            var plano = <%= plano%>;
            var modeloStr = modelo.toString();
            var planoStr = plano.toString();
            var hash = "<%= hash%>";
            hash = hash.toString();
            if(modeloStr === '6' && planoStr === '6' && hash === '219679ff68ff2e6612b79757b526e79c') {
                isSenai = true;
            }
// </senai_temp>
            jQuery("#esqueci").hide();
            jQuery(".close").click(function () {
                jQuery(".msg-login").hide();
            });
            jQuery("#esqueci-lnk").click(function () {
                jQuery("#login").hide();
                jQuery("#esqueci").show();
            });
            jQuery(".btn-voltar").click(function () {
                jQuery("#login").show();
                jQuery("#esqueci").hide();
            });
            jQuery("#forgot").click(function () {
                jQuery("#forgot-pass").submit();
            });
            jQuery(".acessacadastro").click(function () {
                jQuery("#existeassina").val("N");
                jQuery("#cadastraAssina").hide();
                jQuery("#cadastraexp").show();
                var modelo = <%= modelo%>;
                var plano = <%= plano%>;
                url = "<%= base%>flip/cadastraNovo.do?modelo=" + modelo + "&plano=" + plano;
                jQuery.post(url, function (data) {
                    jQuery("#cadastraexp").html(data);
                    jQuery("#aba1").html("");
                });
                assina = false;
                jQuery(".button-login-register").show();
                jQuery(".button-login-finaliza").hide();
                jQuery(".button-login-assina").hide();
                jQuery('.modal').css('z-index', '9999');
                jQuery('.modal').modal({backdrop: 'static', keyboard: true});
            });
            jQuery(".assinacadastro").click(function () {
                jQuery("#cadastraexp").hide();
                jQuery("#cadastraAssina").show();
                var modelo = <%= modelo%>;
                var plano = <%= plano%>;
                url = "<%= base%>flip/cadastraNovo.do?modelo=" + modelo + "&plano=" + plano;
// <senai_temp>
                if(isSenai) {
                    jQuery(".nav-tabs").hide();
                    url = url + "&senai=true";
                }
// </senai_temp>
                jQuery.post(url, function (data) {
                    jQuery("#aba1").html(data);
                    jQuery("#cadastraexp").html("");
                });
        <c:choose>
            <c:when test = "${!empty uk||!empty param.uk}">
                openSubscribeToUser();
            </c:when>
            <c:otherwise>
                assina = true;
                jQuery(".button-login-finaliza").hide();
                jQuery(".button-login-register").hide();
                jQuery(".button-login-assina").show();
                jQuery(".cadastro-step2").remove();
                jQuery(".cadastro-step1").show();
                jQuery('.modal').css('z-index', '9999');
                jQuery('.modal').modal({backdrop: 'static', keyboard: true});
            </c:otherwise>
        </c:choose>
            });
            jQuery(".button-login-assina").click(function () {
                jQuery("#flip_usuarioForm").validate();
                if (jQuery("#flip_usuarioForm").valid()) {
                    jQuery(".cadastro-step1").hide();
                    jQuery("#flip_usuarioForm .modal-footer").prepend("<div class='modal-content cadastro-step2'></div>");
                    jQuery(".cadastro-step2").html("<h3>Carregando planos...</h3>");
                    var urlplanos = '<%=base%>flip/jornal/plugin/wizard/loadPlanos.jsp';
                    jQuery.get(urlplanos, '&modelo=' + model, function (data) {
                        jQuery('.cadastro-step2').html(data);
                        jQuery(".button-login-finaliza").show();
                        jQuery(".button-login-register").hide();
                        jQuery(".button-login-assina").hide();
                        jQuery(".button-login-finaliza").click(function () {
                            try {
                                var cd = jQuery('input[name=plano]:checked').val();
                                var tipoPlano = jQuery('input[name=tipoPagamento]:checked').val();
                                var serial = jQuery("#flip_usuarioForm").serialize();
                                var form = 'modelo=' + model + '&cd=' + cd + '&tipoPlano=' + tipoPlano + '&' + serial;
                                var url = '<%= base%>flip/assinaPlano.do';
                                var ok = false;
                                jQuery.post(url, form, function (data) {
                                    jQuery(".cadastro-step2").html(data);
                                    jQuery(".button-login-finaliza").hide();
                                    ok = true;
                                });
                                return ok;
                            } catch (e) {
                                jQuery(".cadastro-step2").html(e);
                                return false;
                            }
                        });
                    });
                }
            });
            jQuery(".button-login-register").click(function () {
                jQuery("#flip_usuarioForm").submit();
            });
            jQuery(".close").click(function () {
                jQuery('.modal').modal('hide');
                jQuery('.modal').css('z-index', '-1');
                jQuery(".cadastro-step2").remove();
                jQuery(".cadastro-step1").show();
            });
        <c:if test = "${forgotpass == false || forgotpass == true || forgotusername == true}">
            jQuery("#esqueci-lnk").click();
        </c:if>
            jQuery(".btn-voltar").click(function () {
                jQuery(".msg-login").hide();
            });
        <c:if test = "${!empty uk||!empty param.uk}">
            <c:if test = "${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes || (page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L')}">
            openSubscribeToUser();
            </c:if>
        </c:if>
// <senai_temp>
        if(isSenai){
            jQuery(".assinacadastro").attr('value','Quero me cadastrar');
            jQuery("#botaoCapa").hide();
            jQuery(".capa-revista").remove();
        }
// </senai_temp>
        });
        <c:if test = "${!empty uk||!empty param.uk}">
            <c:if test = "${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes || (page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L')}">
        function openSubscribeToUser() {
            assina = true;
            jQuery(".button-login-finaliza").hide();
            jQuery(".button-login-register").hide();
            jQuery(".button-login-assina").show();
            jQuery(".cadastro-step2").remove();
            jQuery(".cadastro-step1").hide();
            jQuery("#flip_usuarioForm .modal-footer").prepend("<div class='modal-content cadastro-step2'></div>");
            jQuery(".cadastro-step2").html("<h3>Carregando planos...</h3>");
            var urlplanos = '<%=base%>flip/jornal/plugin/wizard/loadPlanos.jsp?tipo=Pagos';
            jQuery.get(urlplanos, '&modelo=' + model, function (data) {
                jQuery('.cadastro-step2').html(data);
                jQuery(".button-login-finaliza").show();
                jQuery(".button-login-register").hide();
                jQuery(".button-login-assina").hide();
                jQuery(".modal-header").hide();
                jQuery('.modal').css('z-index', '9999');
                jQuery('.modal').modal({backdrop: 'static', keyboard: true});
                jQuery(".button-login-finaliza").click(function () {
                    try {
                        var cd = jQuery('input[name=plano]:checked').val();
                        var tipoPlano = jQuery('input[name=tipoPagamento]:checked').val();
                <c:choose><c:when test = "${!empty param.uk}">var uk = "<c:out value='${param.uk}'/>"; </c:when><c:otherwise>var uk = "<c:out value='${uk}'/>";</c:otherwise></c:choose>
                                                    var form = 'modelo=' + model + '&cd=' + cd + '&tipoPlano=' + tipoPlano + '&uk=' + uk;
                                                    var url = '<%= base%>flip/assinaPlano.do';
                                                    var ok = false;
                                                    jQuery.post(url, form, function (data) {
                                                        jQuery(".cadastro-step2").html(data);
                                                        jQuery(".button-login-finaliza").hide();
                                                        ok = true;
                                                    });
                                                    return ok;
                                                } catch (e) {
                                                    jQuery(".cadastro-step2").html(e);
                                                    return false;
                                                }
                                            });
                                        });
                                    }
            </c:if>
        </c:if>
    </script>
</head>
<div class="container" style="z-index: 1">

    <div id="background" <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.background}">style="background-color:#<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.background}'/>"</c:if>>
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.backgroundImage && page.flipModeloPublicacaoidid_modelo.prefs.backgroundImage ne 'NULO'}">
            <img src="<%= br.com.maven.flip.Environment.SITE%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.backgroundImage}'/>" class="stretch"  />
        </c:if>
    </div>        

    <div class="row">           
        <div class="six columns login">

            <div class="topologin">                
                <div class="logoclass">
                    <c:choose>
                        <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoAppPath}">
                            <img src='<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoAppPath}'/>' style="max-width:120px;max-height:90px"/>
                        </c:when>
                        <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                            <img src='<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>' style="max-width:270px;max-height:90px" />
                        </c:when>
                    </c:choose>
                </div>
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.textoAssinatura}">
                    <fieldset>
                        <p>
                            <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.textoAssinatura}" escapeXml="false"/>
                        </p>
                    </fieldset>
                    <br/>
                </c:if>
            </div>
            <form action="<%= base%>flip/loginEdicaoAssina.do" method="post">
                <input type="hidden" name="existeassina" class="existeassina" value="N"/>
                <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
                <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
                <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
                <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
                <c:choose>
                    <c:when test="${!empty numero && numero ne 'null'}">
                        <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
                    </c:when>
                    <c:when test="${!empty param.numero && param.numero ne 'null'}">
                        <input type="hidden" name="numero" value="<c:out value='${param.numero}'/>"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="numero"/>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${!empty acessibilidade}">
                        <input type="hidden" name="acessibilidade" value="<c:out value='${acessibilidade}'/>"/>
                    </c:when>
                    <c:when test="${!empty param.acessibilidade}">
                        <input type="hidden" name="acessibilidade" value="<c:out value='${param.acessibilidade}'/>"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="acessibilidade"/>
                    </c:otherwise>
                </c:choose>                    
                <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
                <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>
                        <div  id="login">                    
                    <%if (msg != null) {%>
                    <span class="msg-login"><input name="Acessar" type="button" value="X" class="close"><%= msg%></span>
                        <%}%>  
                    <label><bean:message key="text.login.usuario"/></label>
                    <input name="username" type="text" id="username"  class="usuario">
                    <label><bean:message key="text.login.senha"/></label>
                    <input name="senha" type="password" id="senha" class="senha">                    
                    <input name="Acessar" type="submit" class="acessar button-login" value="Acessar" >
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.esqueciSenha}">
                        <c:choose>
                            <c:when test="${folder eq 'trisportmagazine'}">
                                <a href="http://www.trisportmag.com.br/assinante/lembrar.php" id="esqueci-lnk-trisportmagazine"  target="_blank"><bean:message key="text.login.esqueciminhasenha"/></a>
                            </c:when>
                            <c:when test="${folder eq 'febnet'}">
                                <a href="https://lojasouleitorespirita.com.br/acesso" id="esqueci-lnk-febnet"  target="_blank"><bean:message key="text.login.esqueciminhasenha"/></a>
                            </c:when>
                            <c:when test="${folder eq 'jornalcidade'}">
                                <!--<a href="http://www.jornalcidade.net/wp-login.php?action=lostpassword" id="esqueci-lnk-febnet" target="_blank"><bean:message key="text.login.esqueciminhasenha"/></a>-->
                            </c:when>
                            <c:when test="${folder eq 'gruporbs'}">
                                <style type="text/css">
                                    *{
                                        color:black;
                                    }
                                    .button, button, input[type="submit"], input[type="reset"], input[type="button"]{
                                        background:#ffd40e;
                                        color:black;
                                    }
                                    .loginh1,.login a{
                                        color:black;
                                    }
                                </style>
                                <a href="http://zerohora.clicrbs.com.br/wrs/action/signon/forgotPassword?site=409&back=false&tool=flip&previousurl=<%= base %>pub/gruporbs"><bean:message key="text.login.esqueciminhasenha"/></a>
                                <a href="http://zerohora.clicrbs.com.br/wrs/action/signon/forgotUserName?site=409&back=false&tool=flip&previousurl=<%= base %>pub/gruporbs"><bean:message key="text.login.esquecimeuusuario"/></a>
                            </c:when>
                            <c:when test="${folder eq 'grpcom'}">
                                <a href="http://www.gazetadopovo.com.br/conta/recuperar-senha/?referrer=http://www.gazetadopovo.com.br" id="esqueci-lnk-gazeta" target="_blank"><bean:message key="text.login.esqueciminhasenha"/></a>
                            </c:when>
                            <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.wizardForgot && page.flipModeloPublicacaoidid_modelo.prefs.esqueciSenha}">
                                <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.wizardForgot}'/>" id="esqueci-lnk-gazeta" target="_blank"><bean:message key="text.login.esqueciminhasenha"/></a>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.esqueciSenha}">
                                    <a href="#" id="esqueci-lnk"><bean:message key="text.login.esqueciminhasenha"/></a>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes}">
                        <hr />                    
                        <input name="Acessar" type="button" class="btn-assinar acessacadastro" value="<bean:message key='text.login.queroexperimentar'/>" />
                    </c:if>
                    <c:choose>
                        <c:when test="${folder eq 'trisportmagazine'}">
                            <a href="https://golonger.com.br/assinatrisportmagpagseguro/checkout.php?tipo=IMPRESSA" id="assinar-trisportmagazine"  target="_blank"><input name="Assinar" type="button" class="btn-assinar" value="<bean:message key='text.login.queroassinar'/>" /></a>
                        </c:when>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L' && page.flipModeloPublicacaoidid_modelo.prefs.wizard && !empty page.flipModeloPublicacaoidid_modelo.prefs.wizardRegister}">
                            <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.wizardRegister}'/>"><input name="Assinar" type="button" class="btn-assinar" value="<bean:message key='text.login.queroassinar'/>" /></a>
                        </c:when>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L'}"> 
                            <input name="Assinar" type="button" class="btn-assinar assinacadastro" value="<bean:message key='text.login.queroassinar'/>" />
                        </c:when>
                    </c:choose>
                </div>
            </form>
            <form method="post" action="<%= base%>flip/loginEdicao.do" id="forgot-pass">                                
                <c:choose>
                    <c:when test="${!empty acessibilidade}">
                        <input type="hidden" name="acessibilidade" value="<c:out value='${acessibilidade}'/>"/>
                    </c:when>
                    <c:when test="${!empty param.acessibilidade}">
                        <input type="hidden" name="acessibilidade" value="<c:out value='${param.acessibilidade}'/>"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="acessibilidade"/>
                    </c:otherwise>
                </c:choose>
                <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
                <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
                <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
                <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
                <c:choose>
                    <c:when test="${!empty numero}">
                        <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
                    </c:when>
                    <c:when test="${!empty param.numero}">
                        <input type="hidden" name="numero" value="<c:out value='${param.numero}'/>"/>
                    </c:when>
                    <c:otherwise>
                        <input type="hidden" name="numero"/>
                    </c:otherwise>
                </c:choose>                
                <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
                <input type="hidden" name="esqueci" value="S"/>
                <input type="hidden" name="date" value="<c:choose><c:when test="${!empty param.date && param.date ne 'null'}"><c:out value="${param.date}"/></c:when><c:otherwise><c:if test="${!empty date && date ne 'null'}"><c:out value="${date}"/></c:if></c:otherwise></c:choose>"/>
                        <div id="esqueci">
                            <h1>Esqueci minha senha</h1>
                    <c:choose>
                        <c:when test="${forgotpass}"><span class="msg-login"><input name="Acessar" type="button" value="X" class="close"><bean:message key="text.login.forgotpass"/></span></c:when>
                        <c:when test="${forgotusername}"><span class="msg-login"><input name="Acessar" type="button" value="X" class="close"><bean:message key="text.login.forgotusername"/></span></c:when>
                        <c:when test="${forgotpass == false}"><span class="msg-login"><input name="Acessar" type="button" value="X" class="close"><bean:message key="text.login.invalid"/></span></c:when>
                        </c:choose>
                    <label><bean:message key="text.login.email"/></label>
                    <input name="username" type="text" id="forgotpass-username" class="email">
                    <input name="forgot" id="forgot" type="button" class="acessar button-login" value="Enviar"><input name="Voltar" type="button" class="button-login btn-assinar btn-voltar" value="<bean:message key="text.login.voltar"/>">
                </div>
            </form>
            <div style="position: relative; float: left;">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.urlIpad}">
                    <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.urlIpad}'/>" target="_blank" style="float: left; position: relative; width:140px; height: 42px;"><img src="<%= base%>flip/web/images/ios-icon.png"/></a>
                    </c:if>                
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.urlAndroid}">
                    <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.urlAndroid}'/>" target="_blank" style="float: left; position: relative; width:140px; height: 42px;"><img src="<%= base%>flip/web/images/android-icon.png"/></a>
                    </c:if>            
            </div>
        </div>

        <div class="six columns capa-revista">            
            <c:if test="${!empty page.img}">
                <img src='<%= base%><c:out value="${page.img}"/>' width="344" height="452" title="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
            </c:if>
            <c:choose>
                <c:when test="${folder eq 'trisportmagazine'}">
                    <a href="https://golonger.com.br/assinatrisportmagpagseguro/checkout.php?tipo=IMPRESSA" id="assinar-trisportmagazine" class="assine" target="_blank">Assinar Agora</a>
                </c:when>
                <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L' && page.flipModeloPublicacaoidid_modelo.prefs.wizard && !empty page.flipModeloPublicacaoidid_modelo.prefs.wizardRegister}">
                    <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.wizardRegister}'/>" class="assine">Assinar Agora</a>
                </c:when>
                <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L'}">  
                    <a href="#" id="botaoCapa" class="assine assinacadastro">Assinar Agora</a>
                </c:when>
            </c:choose>
        </div>        
    </div>     
</div>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.cadastroAssinantes || (page.flipModeloPublicacaoidid_modelo.prefs.wizard && page.flipModeloPublicacaoidid_modelo.prefs.tipoWizard eq 'L')}">  
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">    
        <div class="modal-dialog">
            <form method="post" action="<%= base%>flip/loginEdicaoAssina.do" id="flip_usuarioForm">
                <div class="modal-content">
                    <div class="modal-header">                        
                        <h3 class="modal-title" id="myModalLabel"><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.assinaturaTopoCadastro}"/></h3>
                    </div>
                    <div class="modal-body cadastro-step1" >                                                
                        <input type="hidden" name="hash" value="<c:out value='${hash}'/>"/>
                        <input type="hidden" name="folder" value="<c:out value='${folder}'/>"/>
                        <input type="hidden" name="edicao" value="<c:out value='${page.id}'/>"/>
                        <input type="hidden" name="modelo" value="<c:out value='${modelo}'/>"/>
                        <input type="hidden" name="flip" value="<c:out value='${portal}'/>"/>
                        <c:choose>
                            <c:when test="${!empty acessibilidade}">
                                <input type="hidden" name="acessibilidade" value="<c:out value='${acessibilidade}'/>"/>
                            </c:when>
                            <c:when test="${!empty param.acessibilidade}">
                                <input type="hidden" name="acessibilidade" value="<c:out value='${param.acessibilidade}'/>"/>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="acessibilidade"/>
                            </c:otherwise>
                        </c:choose>                        
                        <c:choose>
                            <c:when test="${!empty numero}">
                                <input type="hidden" name="numero" value="<c:out value='${numero}'/>"/>
                            </c:when>
                            <c:when test="${!empty param.numero}">
                                <input type="hidden" name="numero" value="<c:out value='${param.numero}'/>"/>
                            </c:when>
                            <c:otherwise>
                                <input type="hidden" name="numero"/>
                            </c:otherwise>
                        </c:choose>
                        <div id="cadastraexp" style="display: none;">

                        </div>
                        <div id="cadastraAssina" style="display: none;">
                            <ul class="nav nav-tabs">
                                <li class="active" id="abacad"><a href="#aba1" data-toggle="tab">Cadastre-se e assine</a></li>
                                <li id="abaass"><a href="#aba2"  data-toggle="tab">Autenticar</a></li>
                            </ul>
                            <div class="tab-content">
                                <div id="aba1" class="tab-pane active">

                                </div>
                                <div id="aba2" class="tab-pane">
                                    <div id="login">
                                        <input type="hidden" name="existeassina" class="existeassina" value="N"/>
                                        <label><bean:message key="text.login.usuario"/></label>
                                        <input name="username" type="text" id="username"  class="usuario">
                                        <label><bean:message key="text.login.senha"/></label>
                                        <input name="senha" type="password" id="senha" class="senha">                    
                                        <input name="Acessar" type="submit" class="acessar button-login" value="Acessar">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-primary" id="fechar" value="<bean:message key='text.login.fechar'/>" data-dismiss="modal"/>
                        <input type="submit" class="button-login-register btn btn-success" id="cadastrar" value="<bean:message key='text.login.cadastrar'/>"/>
                        <input type="button" class="button-login-assina btn btn-success" id="assinar" value="<bean:message key='text.login.assinar'/>"/>
                        <input type="button" class="button-login-finaliza btn btn-success" id="finalizar" value="<bean:message key='text.login.finalizar'/>"/>
                    </div>                   
                </div>
            </form>                                                             
        </div>
    </div>
</c:if>     
                            <c:out value="${page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'senai'}"/>
<a href="#" class="logo-mavenflip">MavenFlip</a>
<%
    Object user = session.getAttribute("username");
    if (user != null) {
        br.com.maven.flip.listener.MavenflipSessionListener.removeUser(user.toString(), session.getId());
    }
    br.com.maven.flip.javasql.web.servlet.FlipEdicaoAction.removeUserFromSession(session);
    session.removeAttribute("ed_id");
    session.removeAttribute("SUBSCRIPTION_DAYS");
    session.removeAttribute("SUBSCRIPTION_DATES");
    if (hash != null) {
        session.removeAttribute(hash.toString());
    }
%>
<script>
    jQuery(document).ready(function () {
        jQuery("#abacad").click(function () {
            jQuery(".existeassina").val("N");
        });
        jQuery("#abaass").click(function () {
            jQuery(".existeassina").val("S");
        });
        var cadastra = '<c:out value="${param.cadastra}"/>';        
        if (cadastra == "true") {
            jQuery(".acessacadastro").click();
        }
    });
</script>