<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = request.getParameter("base");
            String edicaoId = "" + request.getAttribute("edicaoId");
%>
<div id="loading" style="display:none"><fmt:message key="site.loading"/>... <br/> <img src="<%= base%>flip/jornal/loading.gif" alt="<fmt:message key="site.loading"/>"/></div>

<div id="top">
    
    <div id="top_middle">
        <div id="basic-modal">
            <span class="menu_home" id="tooltip"> <a href="#"><span><fmt:message key="site.edicaoatual"/></span></a></span>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.impressao}">
                <span class="menu_imprimir" id="tooltip"> <a href="#" class="imprimir"><span><fmt:message key="site.imprimir"/></span></a></span>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.modoTexto}">
                <span class="menu_texto" id="tooltip"> <a href="#" class="texto"><span><fmt:message key="site.texto"/></span></a></span>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exportar}">
                <span class="menu_pdf" id="tooltip"> <a href="#" class="pdf" id="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.exportarTodos}'/>"><span><fmt:message key="site.pdf"/></span></a></span>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.pesquisa}">
                <span class="menu_procurar" id="tooltip"> <a href="#" class="procurar"><span><fmt:message key="site.procurar"/></span></a></span>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaRecomenda}">
                <span class="menu_recomendar" id="tooltip"> <a href="#" class="recomendar"><span><fmt:message key="site.recomendar"/></span></a></span>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.comentarios}">
                <span class="menu_comentar" id="tooltip"> <a href="#" class="comentar"><span><fmt:message key="site.comentar"/></span></a></span>
            </c:if>
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.faleConosco}">
                <span class="menu_contato" id="tooltip"> <a href="#" class="contato"><span><fmt:message key="site.contato"/></span></a></span>
            </c:if>
        </div> <!-- fecha div basic-modal -->
    </div>
    <div id="top_right">
        <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.facebook}">   
<div id="social-links" class="addthis_toolbox addthis_default_style">
<a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>    
<a class="addthis_button_tweet"></a>
<a class="addthis_counter addthis_pill_style" addthis:ui_hover_direction="-1"></a>
</div>
            <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4ed5898407c9b06f"></script>


        </c:if>
    </div>

</div> <!-- fecha TOP -->


<div id="content">

    <div id="multimidia">
        <div id="multimidia_left">                      
            &nbsp;
        </div>

        <div id="multimidia_middle">
            <div id="multimidia_corner_left"> </div>
            <div id="multimidia_nav">
                <div id="multimidia_box">
                    <input name="" type="button" class="multimidia_fr" title="<fmt:message key="site.primeira"/>" />
                           <input name="" type="button" class="multimidia_prev" title="<fmt:message key="site.anterior"/>" />
                </div>
                <div id="multimidia_box">
                    <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield" value="" />
                </div>
                <div id="multimidia_box">

                    <input name="" type="button" class="multimidia_next" title="<fmt:message key="site.proxima"/>" />
                           <input name="" type="button" class="multimidia_ff" title="<fmt:message key="site.ultima"/>" />
                </div>
            </div>
            <div id="multimidia_corner_right"> </div>
        </div>
        <div id="multimidia_right">
            <c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.publicaEnquete}">
                <jsp:include page="jsp/enquete.jsp" flush="true">
                    <jsp:param name="base" value="<%= base%>"/>
                    <jsp:param name="edicao" value="<%= edicaoId%>"/>
                </jsp:include>
            </c:if>
            
        </div>

    </div>

    <div id="flip">
        <div id="jornal">
            <div id="megazine" style="height:<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.pageHeight}'/>px">
                <c:out value="${page.textoPagina}"/>
                <h2><b><fmt:message key="site.flash"/></b></h2>
                <br/>
                <p>
                <fmt:message key="site.download"/>.
                </p>
                <p>
		    <a href="https://get.adobe.com/flashplayer/">
 -                        Clique aqui para baixar o plugin Flash - Mavenflip
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
</div> 


<script type="text/javascript">    
    try{ swfobject.embedSWF("<%= base%>flip/jornal/player/mavenflip.swf",
        "megazine",
        "100%",
        "100%",
        "9.0.115",
        "<%= base%>flip/jornal/swfobject/expressInstall.swf",
        {   <c:choose>
                <c:when test="${!empty HASH_MZ_KEY_REQ}" >
                xmlFile : "<%= base%>flip/jornal/megazinedata.jsp?ed=<c:out value='${HASH_MZ_KEY_REQ}'/>",
                </c:when>
                <c:otherwise>
                xmlFile : "<%= base%>flip/jornal/megazinexml.jsp",
                </c:otherwise>
                </c:choose>
                top: "0"
        },
        {
            wmode : "transparent",
            allowFullscreen : "true"
        },
        {id : "megazineScript"});
    }catch(e){}
    
                jQuery('.telacheia').click(function (e) {      
                window.open(base+linkedicao+'?numero='+getCurrentEditionNumber());
            });
            jQuery('.buttonPesquisa').click(function (e) {
                    pesquisaUnique($("#campoPesquisa").val());
            });   
            jQuery('#campoPesquisa').keyup(function(e){
                if(e.keyCode == 13) {
                    jQuery('.buttonPesquisa').click();
                }
            });
            function selectcurrentword(){    
                if(currentKeyword != null && currentKeyword != ""){                
                    //jQuery("#keywordbody").val(currentKeyword);
                    //jQuery("#searchinstant").slideDown("slow");                        
                    jQuery("#campoPesquisa").val(currentKeyword);
                    MegaZine.searchWord(currentKeyword);
                    currentKeyword=null;
                }
            }

            function pesquisaUnique(keyword){    
                if(keyword.length < 4 ){
                    alert('Deve informar uma palavra com pelo menos 4 caracteres');        
                }else{        
                    jQuery("#campoPesquisa").val(keyword);
                    var url=getSearchLinkUnique(keyword);
                    jQuery.fn.modalBox({
                        setWidthOfModalLayer : 500,
                        positionTop : "20",
                        directCall : {
                            source : url
                        }
                    });
                    _gaq.push(['_trackEvent', 'Flip', 'Pesquisa', 'Pesquisa por '+keyword]);
                }
            }
            function getSearchLinkUnique(keywords){
                var pageAnchor=getCurrentEdition();
                var url=getPagesLink('pesquisa')+'?idForm='+pageAnchor+'&acervo=false&apenasEssa=true&keywords='+keywords+'&search=true&edicao='+getCurrentEdition();
                url=url+'&linkedicao='+linkedicao;    
                return url;
            }
     
</script>


<c:if test="${!empty MESSAGE}">
    <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>'); </script>
    <%session.removeAttribute("MESSAGE");%>
</c:if>

<form action="#" method="post" name="frm" id="frm">
    <div>
        <input type="hidden" name="idForm" id="idForm" value="-1"/>
        <input type="hidden" name="idEdicao" id="idEdicao" value="-1"/>
        <input type="hidden" name="sumarioFotos" id="sumarioFotos" value="<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.sumarioFotos}"/>"/>
               <input type="hidden" name="linkedicao" id="linkedicao" value="<c:out value="${edicao_dia}"/>"/>
    </div>
</form>
