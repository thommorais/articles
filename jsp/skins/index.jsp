<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>
            <c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> -                            
                    MavenFlip                
        </title>
        
        <meta http-equiv="expires" content="Fri, 1 Jan 1990 00:00:00 GMT"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <meta name="revisit-after" content="5 days" />
        <meta name="resource-type" content="document" />
        <meta name="revisit" content="5 days" />
        <meta name="rating" content="General" />
        <meta name="robots" content="ALL" />
        <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate"/>
        <meta name="Description" content="Folheando revistas e publicações na internet - Mais completa plataforma multimídia interativa que combina a única experiência de folhear uma revista." />
        <meta name="Keywords" content="pageflip, revista digital, folheando revista, jornal digital, jornal virtual, documentos eletrônicos, revista em flash, papel virtual" />

        <link href="<%= base%>flip/jornal/css/boxes.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/pesquisa_flip.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/caderno_flip.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/indice_flip.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/edicoes_flip.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/tooltips.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/layout.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/modalbox.css" rel="stylesheet" type="text/css" media="screen"/>
        <link href="<%= base%>flip/jornal/css/layout_dinamic.jsp" rel="stylesheet" type="text/css" media="screen"/>
        <script type="text/javascript">
            var base='<%= base%>';
        </script>
        <script type="text/javascript" src="<%= base%>flip/jornal/swfobject/swfobject.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/player/mavenflip.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/flipsite.js" ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/prototype.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/scriptaculous.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/basic.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/modalbox.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/printPDF.js"  ></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/js/validation.js"  ></script>
        <!--[if lt IE 7]>
        <script defer type="text/javascript" src="<%= base%>flip/jornal/js/pngfix.js"  ></script>
        <![endif]-->
        <script type="text/javascript" >
            base='<%= base%>';
            online=<c:out value="${empty offline || offline eq 'false' || !empty logado}"/>;
            folder='<c:out value="${folder}"/>';
            sumarioFotos='<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>';
            zoomBlocked=<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.bloquearZoomNaoAssinantes}"/>;
            linkedicao='<c:out value="${edicao_dia}"/>';

            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}">
                <c:forEach var="item" items="${page.flipModeloPublicacaoidid_modelo.prefs.paginasEditoriasPublicasList}" varStatus="i">
                    freePagesList[<c:out value="${i.index}"/>]='<c:out value="${item}"/>';
                </c:forEach>
            </c:if>
            <c:if test="${!empty param.ipg}">
                ipg = 'anch<c:out value="${param.ipg}"/>';
            </c:if>

                function getCurrentEdition(){
                    return <c:out value="${page.id}"/>;
                }
                
        </script>        
    </head>
    <body oncontextmenu="return false" id="pageDiv" >
        <!-- carregando -->
        <div id="loading" style="display:none">Carregando... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="Carregando, aguarde ..."/></div>

        <div id="top">
            <div id="logocliente">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                        <a href="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}"/>" title="Clique para visitar o site" target="_blank">
                        </c:if>
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  alt="Clique para visitar o site" height="40px"/>
                        <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite}">
                        </a>
                    </c:if>
                </c:if>
            </div>
            <div id="data"><c:out value="${dataEdicao}"/></div>
            <div id="logomaven">

                <a href="javascript:openEditionMode();" class="btn btn-primary">
                    <img src="<%= base%>flip/jornal/images/b_outrasedicoes.png" alt="Visualizar outras edições" title="Visualizar outras edições" />
                </a>
                <a href="javascript:window.location.href='/<c:out value="${edicao_dia}"/>'" class="btn btn-primary">
                    <img src="<%= base%>flip/jornal/images/b_edicaodia.png" alt="Abrir edição do dia" title="Abrir edição do dia" />
                </a>

                &nbsp;&nbsp;
                <c:choose>
                    <c:when test="${!empty NEWS_INDICADOR && NEWS_INDICADOR eq 'NEWSFLIP'}">
                        <a href="http://www.newsflip.com.br">
                            <img src="<%= base%>flip/jornal/images/logo_newsflip.png" alt="Clique aqui e conheça o sistema" title="Clique aqui e conheça o sistema" height="30px" />
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="http://www.mavenflip.com.br">
                            <img src="<%= base%>flip/jornal/images/maven_flip.gif" alt="Clique aqui e conheça o sistema" title="Clique aqui e conheça o sistema" height="30px" />
                        </a>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
        <div id="topnav">
            <div id="tabs">

                <a href="javascript:openChapterMode();" class="tab2" title="Visualizar cadernos da edição" >
                    <br/><span><img src="<%= base%>flip/jornal/images/icon_index.gif"  alt="Visualizar cadernos da edição"/>&nbsp;<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.indiceNome}"/></span>
                </a>
                <a href="javascript:openSumaryMode();" class="tab2"  title="Sumário de páginas dessa edição">
                    <br/><span><img src="<%= base%>flip/jornal/images/gallery_icon.gif" alt="Sumário de páginas dessa edição"/>&nbsp;SUMÁRIO</span>
                </a>

            </div>
            <div id="nav">
                <div id="navcenter">
                    <div id="capa">
                        <a href="javascript:MegaZine.firstPage();"><img src="<%= base%>flip/jornal/images/b_capa.gif" alt="Ir para a capa" title="Ir para a capa"/></a> Capa
                    </div>
                    <div id="paginas">

                        <!-- paginas antes -->
                        <div style="float:left; display:inline;">
                            <a href="javascript:MegaZine.firstPage();"><img src="<%= base%>flip/jornal/images/b_first.gif" alt="Primeira página" title="Primeira página"/></a>
                            <a href="javascript:MegaZine.prevPage();"><img src="<%= base%>flip/jornal/images/b_back.gif" alt="Página anterior" title="Página anterior "style="margin-left:3px"/></a>
                        </div>
                        <!-- contador -->
                        <div style="float:left; display:inline; width:155px;" id="page_layer">

                        </div>
                        <!-- paginas depois -->
                        <div style="float:right;display:inline;">
                            <a href="javascript:MegaZine.nextPage();"><img src="<%= base%>flip/jornal/images/b_next.gif" alt="Próxima página" title="Próxima página"/></a>
                            <a href="javascript:MegaZine.lastPage();"><img src="<%= base%>flip/jornal/images/b_last.gif" alt="Ir para última página" title="Ir para a última página" style="margin-left:3px"/></a>
                        </div>
                    </div>
                    <div id="saltar">
                        Ir para
                        <input name="page" id="page" type="text" class="saltar" maxlength="3" onkeypress="if(verificaEnter(event)){ MegaZine.gotoPage($('page').value); }"/>
                        <a href="javascript:MegaZine.gotoPage($('page').value);"><img src="<%= base%>flip/jornal/images/b_saltar.gif" alt="Ir para" title="Ir para"/></a>
                    </div>
                </div>
            </div>
            <div id="tabs2">

                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
                    <a href="javascript:openCommentMode();" class="tab2"  title="Clique aqui para criar um comentário nessa página" >
                        <br/><span><img src="<%= base%>flip/jornal/images/commentBalloon.gif" alt="Clique aqui para criar um comentário nessa página"/>&nbsp;COMENTE</span>
                    </a>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.faleConosco}">
                    <a href="javascript:openContactMode();" class="tab2"  title="Clique aqui e entre em contato" >
                        <br/><span><img src="<%= base%>flip/jornal/images/icone_email.gif" alt="Clique aqui e entre em contato"/>&nbsp;CONTATO</span>
                    </a>
                </c:if>
            </div>
        </div>
        <div id="corpo">
            <div id="menu">
                <div id="zoom_layer" style="display:none">
                    <a href="#" onclick="MegaZine.zoomIn();return false;">
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeZoomInSite}'/>" alt="Ampliar" title="Ampliar zoom" width="57" height="65" />
                    </a><br />
                    <a href="#" onclick="MegaZine.zoomOut(); return false;">
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeZoomOutSite}'/>" alt="Reduzir" title="Reduzir zoom" width="57" height="65" />
                    </a><br />
                </div>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
                    <a href="javascript:openSearchMode();">
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconePesquisarSite}'/>" alt="Pesquisar conteúdo" title="Pesquisar conteúdo" width="57" height="65" />
                    </a><br/>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.impressao}">
                    <a href="javascript:openPrintMode();">
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeImprimirSite}'/>" alt="Imprimir a página" title="Imprimir a página" width="57" height="65" />
                    </a><br/>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
                    <a href="javascript:openPDFMode('<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.exportarTodos}'/>');">
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeExportarPdfSite}'/>" alt="Exportar página em PDF" title="Exportar página em pdf" width="57" height="65" />
                    </a><br/>
                </c:if>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                    <a href="javascript:openTextMode();">
                        <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeTextoSite}'/>" alt="Exibir páginas em modo texto" title="Exibir páginas em modo texto" width="57" height="65" />
                    </a><br/>
                </c:if>
                <a href="javascript:openRecomendMode();">
                    <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.iconeRecomendarSite}'/>" alt="Recomendar página para amigo" title="Recomendar página para amigo" width="57" height="65" />
                </a>
                <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.contadorVisitas}">
                    <div id="contador">
                        <b>Visitas</b>
                        <br/>
                        <c:out value="${page.visitas}"/>
                    </div>
                </c:if>
            </div>

            <div id="jornal">
                <div id="megazine">
                    <c:out value="${page.textoPagina}"/>
                    <h2><b>Você precisa do FlashPlayer 10 para visualizar</b></h2>
                    <br/>
                    <p>
                        Clique na imagem abaixo para fazer o download.
                    </p>
                    <p>

			<a href="https://get.adobe.com/flashplayer/">
                            <img src="<%= base%>flip/jornal/images/get_flash_player.gif" alt="Clique aqui para baixar o plugin Flash" title="Clique aqui para baixar o plugin Flash" />
                        </a>
                    </p>
                    <c:if test="${empty logado}">
                        <p> Navegue pelas páginas dessa edição </p>
                        <c:forEach var="pagina" items="${page.textoPaginaNumeros}">
                            <a href="<%= base%><c:out value="${edicao_dia}"/>index.jsp?ipg=<c:out value='${pagina}'/>">
                                Página <c:out value="${pagina}"/>
                            </a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            try{ swfobject.embedSWF("<%= base%>flip/jornal/player/mavenflip.swf",
                "megazine",
                "100%",
                "<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageHeight}'/>",
                "9.0.115",
                "<%= base%>flip/jornal/swfobject/expressInstall.swf",
                {
                    xmlFile : "<%= base + request.getAttribute("xml").toString()%>",
                    top: "0"
                },
                {
                    wmode : "transparent",
                    allowFullscreen : "true"
                },
                {id : "megazineScript"});
            }catch(e){}
        </script>
        <c:if test="${!empty page.orelha.nome}">

            <script src="<%= base%>flip/jornal/js/ear/AC_OETags.js" type="text/javascript"></script>
            <script src="<%= base%>flip/jornal/js/ear/pageear.js" type="text/javascript"></script>

            <script type="text/javascript" >
                pagearSmallImg = '<%= base%><c:out value="${page.orelha.bannerMenor}"/>';
                pagearBigImg  = '<%= base%><c:out value="${page.orelha.banner}"/>';
                jumpTo   = '<c:out value="${page.orelha.link}"/>';
                buildParams();
                writeObjects();
            </script>
        </c:if>
        <c:if test="${!empty MESSAGE}">
            <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>'); </script>
            <%session.removeAttribute("MESSAGE");%>
        </c:if>        
        <c:if test="${!empty logado}">
            <div id="logout_button">
                <a href="<%= base%><c:out value="${edicao_dia}"/>login.jsp">
                    <img src="<%= base%>flip/jornal/images/sair.png" alt="Logout de assinante" title="Logout de assinante"/>
                </a>
            </div>
        </c:if>
        <form action="#" method="post" name="frm" id="frm">
            <div>
                <input type="hidden" name="idForm" id="idForm" value="-1"/>
                <input type="hidden" name="idEdicao" id="idEdicao" value="-1"/>
                <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>"/>
                <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value="${edicao_dia}"/>"/>
            </div>
        </form>

    </body>
</html>
