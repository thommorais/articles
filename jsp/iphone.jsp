<!DOCTYPE html><%@ page language="java" pageEncoding="iso-8859-1"%><%@ taglib uri="/WEB-INF/c" prefix="c" %><%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %><html  prefix="og: http://ogp.me/ns#" xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://ogp.me/ns/fb#" lang="<fmt:message key='site.idiomaLocal'/>">
    <%
        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
        String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);  
        String hs = "";
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
                <meta property="og:site_name" content="<c:out value='${page.ogTitle}'/>"/>
            </c:when>
            <c:when test="${!empty page.nome}">
                <meta property="og:title" content="<c:out value='${page.nome}'/>"/>
                <meta property="og:site_name" content="<c:out value='${page.nome}'/>"/>
            </c:when>
            <c:otherwise>
                <meta property="og:title" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
                <meta property="og:site_name" content="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
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
        <meta property="og:image" itemprop="image" content="<%= base%><c:out value='${page.img}' escapeXml='false'/>"/>
        <meta property="og:url" content="<%= base%><c:out value='${edicao_dia}'/>"/>                               
        <meta name="apple-mobile-web-app-capable" content="yes"/>
        <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
        <meta name="apple-touch-fullscreen" content="no"/>
        <link rel="apple-touch-startup-image" href="<%= baseweb%>flip/jornal/skins/mobile/loading.png"/>

        <c:choose>
            <c:when test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoAppPath}">
                <link rel="apple-touch-icon" href="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoAppPath}'/>"/>
            </c:when>
            <c:otherwise>
                <link rel="apple-touch-icon" href="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"/>
            </c:otherwise>
        </c:choose>     

        <link rel="image_src" href="<%= base%><c:out value='${page.img}' escapeXml='false'/>"/>    

        <!--Link do app na Apple Store-->
        <c:set value="0" var="temApp"/>
        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.urlIpad}">
            <c:set value="1" var="temApp"/>                
            <c:set value="${page.flipModeloPublicacaoidid_modelo.urlIpad}" var="linkAppStore" />
            <meta name="author" content="<br>"/>
            <meta name="apple-itunes-app" content="app-id=<c:out value="${linkAppStore}"/>"/>
            <meta name="msApplication-ID" content="App" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <link rel="stylesheet" href="<%= baseweb%>flip/jornal/skins/mobile/css/jquery.smartbanner.css" type="text/css" media="screen"/>    
            <meta name="msapplication-TileImage" content="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.logotipo}'/>" />                                                

<!--<c:out value="${linkAppStore}"/>-->

            <link rel="stylesheet" type="text/css" href="<%= baseweb%>flip/jornal/skins/mobile/css/jquery.smartbanner.css"/>                   
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>
            <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/mobile/js/jquery.smartbanner.js"></script>  
            <script>
                $(function() {
                $.smartbanner({ daysHidden: 0, daysReminder: 0, force:'ios', title:'<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/>' });
                $('#ext-comp-1013').hide();
                $('.sb-close, .sb-button').click(function(){
                $('#ext-comp-1013').show();
                $('#smartbanner').hide();
                $('#whats').removeClass('botaowhatswithapp');
                $('#whats').addClass('botaowhats');
                });
                });
            </script>
        </c:if>

        <script type="text/javascript">
            var base = '<%= base%>';
            var linkedicao = '<c:out value="${edicao_dia}"/>';
            var myUser = '<c:out value="${username}"/>';
            function getCurrentEdition(){
            return <c:out value = "${page.id}" /> ;
            }
            var index = 0, indexlinks = 0, indexvideos = 0, indexpic = 0;
            var pfpages = new Array();
            var pflinks = new Array();
            var pfvideos = new Array();
            var pfmediaspics = new Array();
            <c:forEach var = "pag" items = "${paginaslist}" varStatus = "i" >
                    pfpages[index++] = ["<c:out value='${pag.ordem}'/>", "<c:out value='${pag.pathNormal}'/>", "<c:out value='${pag.pathImage}'/>", "<c:out value='${pag.id}'/>"];
            <c:if test = "${!empty pag.links}" > <c:forEach var = "link" items = "${pag.links}" >
                    pflinks[indexlinks++] = ["<c:out value='${pag.ordem}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", <c:choose > <c:when test = "${!link.anchor}" > base + "flip/jornal/link.jsp?id=<c:out value="${link.id}"/>" </c:when><c:otherwise>"<c:out value="${link.link}"/> "</c:otherwise></c:choose>," <c:out value = "${link.percentualX}" /> "," <c:out value = "${link.percentualY}" /> "," <c:out value = "${link.id}" /> "," <c:out value = "${link.pagina.width}" /> "," <c:out value = "${link.pagina.height}" /> "," <c:out value = "${link.tipo}" /> "," <c:out value = "${link.tamanho}" /> "," <c:out value = "${link.popup}" /> "," <c:out value = '${link.icone}' /> "];            
                    </c:forEach></c:if > <c:if test = "${!empty pag.videos}" >
                    <c:forEach var = "link" items = "${pag.videos}" > <c:if test = "${!link.flash}" >
                    pfvideos[indexvideos++] = ["<c:out value='${pag.ordem}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.video.video}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.icone}'/>"];
            </c:if></c:forEach > </c:if>
                    <c:if test = "${!empty pag.galerias}" > <c:forEach var = "link" items = "${pag.galerias}" >
                    <c:if test = "${!empty link.galeria.galeria}" >
                    pflinks[indexlinks++] = ["<c:out value='${pag.ordem}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value='${link.galeria.cd}'/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "G", "", "true", "<c:out value='${link.icone}'/>"];
            <c:forEach var = "pic" items = "${link.galeria.galeria}" >
                    pfmediaspics[indexpic++] = ['pic', '<c:out value="${link.galeria.cd}"/>', '<c:out value="${pic.media}"/>', '<c:out value="${pic.nome}"/>']
                    </c:forEach>
                    </c:if>
                    </c:forEach></c:if >
                    </c:forEach>

                    var ipg = null;
            <c:if test = "${!empty param.ipg}" >
                    ipg = '<c:out value="${param.ipg}"/>';
            </c:if>        
                    <c:if test = "${!empty param.pg}" >
                    page = '<c:out value="${param.pg}"/>';
            </c:if>       


                    var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-31102692-1']);
            _gaq.push(['_trackPageview']);
            (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            //ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            })();
        </script>
        <link rel="stylesheet" media="all" href="<%= baseweb%>flip/jornal/skins/mobile/css/sencha-touch.css"/>
        <link rel="stylesheet" media="all" href="<%= baseweb%>flip/jornal/skins/mobile/css/iphone.css" id="size-stylesheet"/>   
        <link href="<%= baseweb%>flip/jornal/skins/html5full/flare/darkbox.css" rel="stylesheet" type="text/css" media="all"/>
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/mobile/js/iscroll.js"></script>
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/king/js/jquery-1.8.0.min.js"></script>
        <script type="text/javascript">
            jQuery.noConflict();
        </script>    
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/mobile/js/iphone.js" charset="utf-8"></script>
        <link rel="stylesheet" href="<%= baseweb%>flip/jornal/skins/mobile/css/add2home.css"/>    
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/mobile/js/add2home.js"></script>    
        <link rel="stylesheet" type="text/css" href="<%= baseweb%>flip/jornal/js/shadowbox/shadowbox.css"/>
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/js/shadowbox/shadowbox.js"></script>
        <script type="text/javascript" src="<%= baseweb%>flip/jornal/skins/html5full/flare/darkbox.js" ></script>
        <script type="text/javascript">
            Shadowbox.init({
            skipSetup: true,
                    modal: true
            });
            <c:choose >
                    <c:when test = "${page.flipModeloPublicacaoidid_modelo.prefs.linkMobile eq 'transparent'}" >
                    var linkcolor = 'transparent';
            </c:when>
                    <c:otherwise >
                    var linkcolor = '#<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.linkMobile}"/>';
            </c:otherwise>
                    </c:choose>         
        </script>    
        <c:choose>
            <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.linkMobile eq 'transparent'}">
                <style type="text/css">   
                    .overlay{
                        background-color: transparent;
                    }
                </style>
            </c:when>
            <c:otherwise>
                <style type="text/css">   
                    .overlay{
                        background-color: #<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.linkMobile}"/>;
                    }
                </style>
            </c:otherwise>
        </c:choose>       
    </head>
    <body class="x-iphone x-ios">   

            <link itemprop="thumbnailUrl" href="<%= base%><c:out value='${page.img}' escapeXml='false'/>"> 
            <span itemprop="thumbnail" itemscope itemtype="http://schema.org/ImageObject"> 
                <link itemprop="url" href="<%= base%><c:out value='${page.img}' escapeXml='false'/>"> 
            </span>        
  
        <c:if test="${wizard eq 'true' && !(!empty logado && logado eq 'true' && !empty username && username ne 'DEMO') }">
            <jsp:include page="plugin/wizard/assine.jsp" flush="true">
                <jsp:param name="base" value="<%= base %>"/>
                <jsp:param name="edicao" value="<%= edicaoId %>"/>                                                                                
                <jsp:param name="mobile" value="true"/>
            </jsp:include>   
        </c:if>    

        <div id="zoomarea">    
        </div>    
        <div id="rotacionando" >    
            <h1> Atualizando... </h1>
            <img src='<%=baseweb%>flip/jornal/skins/mobile/load.gif' id='loader' align='center' style='margin:0 auto;'/>
        </div>    
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">          

            <div id="toposistema">    
                <jsp:include page="skins/common/topMobileBanner.jsp" flush="true"/>        
            </div>

            <div id="ext-comp-1013" class="x-toolbar x-toolbar-dark" style="width:100%;max-width:100%;height: 30px; ">
                <div class="x-layout-box-inner x-layout-box" id="ext-gen1024" style="-webkit-box-orient: horizontal; -webkit-box-direction: normal; -webkit-box-pack: start; -webkit-box-align: center;height: 30px; ">
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                            <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
                        </c:if>
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="<fmt:message key='site.cliquevisita'/>" class="logoempresa"/>
                        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                            </a>
                        </c:if>
                    </c:if>

                    <div class="x-button x-button-menu" style="font-size: 11pt; text-align:center;"  id="sepmenu">
                        <span class="x-button-label multimidia_fr" id="ext-gen1033">&nbsp;</span>
                    </div>
                    <div  class="x-button x-button-menu" style="font-size: 11pt; ">
                        <span class="x-button-label multimidia_prev" id="ext-gen1035">&nbsp;</span>
                    </div>
                    <div  class="x-field x-field-normal" style="text-align: center; font-size: 10pt;" id="camponumero">                
                        <input id="multimidia_textfield" name="ext-comp-1024" class="x-input-number"/>                
                    </div>
                    <div  class="x-button x-button-menu" style="font-size: 11pt; ">
                        <span class="x-button-label multimidia_next" id="ext-gen1040">&nbsp;</span>
                    </div>
                    <div class="x-button x-button-menu" style="font-size: 11pt; ">
                        <span class="x-button-label multimidia_ff" id="ext-gen1042">&nbsp;</span>
                    </div>
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">                    
                        <div  class="x-button x-button-menu" style="font-size: 11pt;margin-left:1px; ">
                            <img src="<%= baseweb%>flip/jornal/images/pdf.png" alt="Exportar para PDF" title="Exportar para PDF" style="width:23px;height:23px;" id="exportarpdf"/>
                        </div>
                    </c:if>
                    <c:if test="${!empty logado && logado eq 'true' && !empty username && DEMO ne 'S'}">
                        <div class="botaosair">
                            <a href="<%= base%><c:out value="${edicao_dia}"/>login.jsp">
                            <img src="<%= baseweb%>flip/jornal/images/sair.png" alt="Sair do sistema" title="Sair do sistema" style="width:19px;height:19px;"/>
                            </a>
                        </div>
                    </c:if>
                    <div  class=" x-component" style="-webkit-box-flex: 1; width:auto; ">
                    </div>                                           
                </div>
            </div>  
        </c:if>
        <div id="menufechar" class="x-toolbar x-toolbar-dark" style="height: 40px; ">
            <img src="<%=baseweb%>flip/jornal/skins/mobile/zoom.png" width="25px"/> Fechar zoom                   
        </div>   
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes || page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice || page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos}">            
            <div id="tab_left">
                <ul id="dock">
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeEdicoes && DEMO ne 'S'}">
                        <li id="edicoes_barra" title="Edições">
                            <ul class="free" ></ul>
                        </li>
                    </c:if>   
                    <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeIndice}">    
                        <li id="indice_barra" title="Índice">
                            <ul class="free" ></ul>
                        </li>
                    </c:if>
                    <!-- <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeSumario}">
                        <li id="sumario_barra" title="Sumário">
                            <ul class="free" ></ul>
                        </li>
                    </c:if>                    --->
                    <c:choose>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos && page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'acriticaam'}">
                            <li id="produtos_barra" style="background-image: url(/flip/jornal/skins/king/img/azul/abas_cadernos.png);" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                                <ul class="free" ></ul>
                            </li>
                        </c:when>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos && page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'correiodoestado'}">
                            <li id="produtos_barra" style="background-image: url(/flip/jornal/skins/king/img/azul/abas_suplementos.png);" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                                <ul class="free" ></ul>
                            </li>
                        </c:when>
                        <c:when test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos && page.flipModeloPublicacaoidid_modelo.flipUsuarioidid_publicador.flipEmpresaidid_empresa.pasta eq 'oliberaldigital'}">
                            <li id="produtos_barra" style="background-image: url(/flip/jornal/skins/king/img/azul/abas_especiais.png);" title="<fmt:message key='site.produto'/>"  class="dock_tab_hover">
                                <ul class="free" ></ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeProdutos}">
                                <li id="produtos_barra" title="Produtos">
                                    <ul class="free" ></ul>
                                </li>  
                            </c:if>            
                        </c:otherwise>
                    </c:choose>            
                </ul>
            </div>
        </c:if>                
        <div id="imagegallery">            
            <div id="scroller">
                <ul id="thelist">
                    <c:forEach var="pag" items="${paginaslist}" varStatus="i">
                        <li id="pag<c:out value='${pag.ordem}'/>" class="anch<c:out value='${pag.id}'/>">
                            <span id="empty" class="loadimg"></span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

        <style type="text/css">
            @media all and (orientation:portrait) {
                .botaowhats{
                    position: absolute;
                    right:10px;
                    top:40px;                                   
                }
            }
            @media all and (orientation:landscape) {
                .botaowhats{
                    position: absolute;
                    right:10px;
                    top:5px;                                   
                }
            }
            @media all and (orientation:portrait) {
                .botaowhatswithapp{
                    position: absolute;
                    right:10px;
                    top:80px;                                   
                }
            }
            @media all and (orientation:landscape) {
                .botaowhatswithapp{
                    position: absolute;
                    right:10px;
                    top:80px;                                   
                }
            }
        </style>
        <% 
            String userAgent = request.getHeader("User-Agent");
            if(!userAgent.toLowerCase().contains("whatsapp")){
        %>
        <div id="whats" 
             <c:choose>
                <c:when test="${temApp == 1}">
                    class="botaowhatswithapp"
                </c:when>
                <c:otherwise>
                    class="botaowhats"
                </c:otherwise>
            </c:choose>
            <c:if test="${!page.flipModeloPublicacaoidid_modelo.prefs.mobileShareWhatsapp}">
                style="display:none" 
            </c:if>
            >
            <a href="whatsapp://send" data-text="Edição recomendada" data-href="" class="wa_btn wa_btn_s" style="display:none">Compartilhar</a>
            <script type="text/javascript">if (typeof wabtn4fg === "undefined"){wabtn4fg = 1; h = document.head || document.getElementsByTagName("head")[0], s = document.createElement("script"); s.type = "text/javascript"; s.src = "<%= base%>flip/jornal/js/whatsapp-button.js"; h.appendChild(s); }</script>                                    
        </div>                 
        <%
            }
        %>
        <div id="basesistema">                
            <jsp:include page="skins/common/baseMobileBanner.jsp" flush="true"/>                                
            <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.htmlAdicional}" escapeXml="false"/>
        </div>
        <script>
            jQuery(document).ready(function() {
            var pg = getUrlParameter('page');
            var data = window.location.href;
            var arr = data.split('#page/');
            if (pg || arr) {
            if (pg) {
            gotoAnchor(pg);
            } else {
            gotoAnchor(arr[1]);
            }
            }
            });
        </script>
    </body>
</html>
<c:set value="N" var="DEMO" scope="session"/>
