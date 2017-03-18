<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<%
            String base = request.getParameter("base");
            String edicao = request.getParameter("edicao");
%>
<c:if test="${page.flipModeloPublicacaoidid_modelo.prefs.exibeTopo}">
    <div id="top">
        <div id="top_logotipo">
            <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    <a href="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.meuSite}'/>" title="<fmt:message key='site.cliquevisita'/>" target="_blank">
                </c:if>
                <img src="<%= base%><c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}'/>"  title="<c:out value='${page.flipModeloPublicacaoidid_modelo.prefs.titulo}'/>"/>
                <c:if test="${!empty page.flipModeloPublicacaoidid_modelo.prefs.meuSite && !empty page.flipModeloPublicacaoidid_modelo.prefs.logotipoPath}">
                    </a>
                </c:if>
            </c:if>
        </div>        
        <div id="top_right">           
            <c:if test="${!empty logado && logado eq 'true' && !empty username && username ne 'DEMO'}">
                <div class='central'>
                    <span class='logout_cumprimento'>
                        Olá                                
                    </span>                            
                    <span class='logout_nome'>
                        <c:choose>
                            <c:when test="${!empty user_nome}">
                                <c:out value='${user_nome}'/>
                            </c:when>
                            <c:otherwise>
                                <c:out value='${username}'/>
                            </c:otherwise>
                        </c:choose>                                
                    </span>
                    <span class='logout_icone'>
                        <c:choose>
                            <c:when test="${!empty sessionScope['backlink']}">
                                <a href="<%= base%><c:out value='${backlink}'/>">
                                    <img src='<%= base %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<%=base%>flip/jornal/logout.jsp?user=<c:out value='${username}'/>&ref=<%= base%><c:out value="${edicao_dia}"/>login.jsp?acessibilidade=S<c:if test='${!empty numero}'>&numero=<c:out value='${numero}'/></c:if>">
                                <img src='<%= base %>flip/jornal/skins/king/img/<c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.corPadrao}"/>/logout.png'  title="<fmt:message key='site.logout'/>"/>                    
                                </a>
                            </c:otherwise>
                        </c:choose>                                                        
                    </span>
                </div>
            </c:if>              
        </div>                      
        <div id="top_middle">
            <div class="navbarinterno">
                <input type="button" class="BotaoBranco firstpage" value="Primeira página" title="Abre primeira página"/>
                <input type="button" class="BotaoBranco previouspage" value="<< Página anterior" title="Abre página anterior"/>
                <span class="BotaoBranco textvalue" id="page_layer" style="width:130px"></span>
                <input type="button" class="BotaoBranco nextpage" value="Próxima página >>" title="Abre próxima página"/>
                <input type="button" class="BotaoBranco lastpage" value="Última página" title="Abre Última página"/>
            </div>
        </div>
    </div>
</c:if>
<div id="corpo">
    <style type="text/css">
        #line_rw{
            max-width:100%;
            width:100%;
            height:100%;
            background-color:white;        
            margin:10px auto;
            text-align:center;
        }
    </style>
    <div class="rowsearch">
        <label>Pesquisar por</label>
        <field> <input type="text" name="termo" id="termo" value="<c:choose><c:when test='${!empty param.termo}'><c:out value='${param.termo}' escapeXml='true'/></c:when><c:otherwise></c:otherwise></c:choose>" class="CampoTexto" size="35" placeholder="Digite aqui para pesquisar"/>
        </field>    
        <input type="button" id="botaopesquisa" value="Pesquisar termo" class="BotaoBranco" title="Clique nesse botão para pesquisar"/>
        <input type="button" value="Imprimir página" class="BotaoBranco" id="printesq"  title="Clique para imprimir a página"/>    
        &nbsp;
        <input type="checkbox" name="modotexto" id="modotexto" value="S"/> Página visual
    </div>

    <div id="line_rw"></div>

</div>
<c:if test="${!empty MESSAGE}">
    <script type="text/javascript"> alert('<c:out value="${MESSAGE}"/>');</script>
    <%session.removeAttribute("MESSAGE");%>
</c:if>
