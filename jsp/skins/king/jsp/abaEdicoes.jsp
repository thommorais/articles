<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String link = request.getParameter("linkedicao");
%>
<script type="text/javascript">
            jQuery(document).ready(function () {
                jQuery("#numero").ForceNumericOnly();
                jQuery('#dataInicial,#dataFinal').datepicker({
                    beforeShow: function () {
                        lockdock = true;
                        jQuery('#edicoes_barra ul').css("display", "block");
                        jQuery('#ui-datepicker-div').maxZIndex();
                    },
                    onClose: function () {
                        lockdock = false;
                    },
                    dateFormat: "dd/mm/yy",
                    dayNamesArrayDefault: ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"],
                    dayNamesMin: ["Do", "Se", "Te", "Qu", "Qi", "Se", "Sa"],
                    monthNames: ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"],
                    nextText: "Próximo", closeText: "Fechar", currentText: "Hoje", prevText: "Anterior"
                });
            });
        </script>
<link rel='stylesheet prefetch' href='//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.min.css'>
<div class="dockedicao">    
    <div  id="edicao_container">
        <div class="filter_box">
            <label>
                <fmt:message key="site.pagina"/> <c:out value="${pagina}"/> <fmt:message key="site.de"/> <c:choose><c:when test="${!empty paginas}"><c:out value="${paginas}"/></c:when><c:otherwise>1</c:otherwise></c:choose> | <fmt:message key="site.exibindoedicoes"/> <c:out value="${first + 1}"/> <fmt:message key="site.ate"/> <c:out value="${last}"/> <fmt:message key="site.de"/> <c:out value="${total}"/>
                &nbsp;&nbsp;&nbsp;
                <c:if test="${pagina > 1}">
                <a href="#" onclick="openEditionMode(<c:out value='${pagina - 2}'/>);">
                    << <fmt:message key="site.anterior"/>
                </a>
                </c:if>
                <c:if test="${pagina < paginas}">
                &nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="#" onclick="openEditionMode(<c:out value='${pagina}'/>);">
                    <fmt:message key="site.proxima"/> >>
                </a>
                </c:if>
            </label>
        </div>
                <c:if test="${mostraFiltros}">
                    
        <div class="filter_fields">
            <div>
                <label><fmt:message key="site.pesquisa.nr"/>:</label>
                <field>
                    <input type="text" name="numero" id="numero" value="<c:out value='${nr}'/>" size="4" max-length="5" class="CampoTexto" style='width:60px'/>
                </field>
                <label><fmt:message key="site.pesquisa.di"/>:</label>
                <field>
                    <input type="text" name="dataInicial" id="dataInicial" value="<c:out value='${di}'/>" size="10" max-length="10" class="CampoTexto" placeHolder=" "  style='width:100px'/>
                </field>
                <label><fmt:message key="site.pesquisa.df"/>:</label>
                <field>
                    <input type="text" name="dataFinal" id="dataFinal" value="<c:out value='${df}'/>" size="10"  max-length="10" class="CampoTexto" placeHolder=" "  style='width:100px'/>
                </field>  
            </div>
            <div>                
                <label><fmt:message key="site.pesquisa.tx"/>:</label>
                <field>
                    <input type="text" name="texto" id="texto" value="<c:out value='${tx}'/>" size="51"  max-length=50"  class="CampoTexto" style='width:236px'/>
                </field> 
                <field>
                    <input type="button" value="<fmt:message key='site.pesquisa.buscar'/>" class="BotaoBranco" onclick="openEditionMode(<c:out value='${pagina - 1}'/>)"/>
                </field>
            </div>
        </div>
</c:if>
                <c:choose>
                    <c:when test="${!empty list}">
                
        <c:forEach var="bean" items="${list}" varStatus="i">
            <div class="box" <c:if test='${bean.id == edicaoId}'>id="selected"</c:if>>
            <div class='boxinner'>
                <div class='boxcover'>
                    <c:choose>
                    <c:when test="${bean.disabled}">
                    <a href="javascript:alert('Você não tem acesso a essa edição');"><img src="<%= base%><c:out value='${bean.path}'/>" border="1"  title="<fmt:message key='site.cliqueler'/>" class="imgdisabled"/></a>
                    </c:when>    
                    <c:otherwise>
                    <a href="<%=base + link%>?<c:if test='${bean.nr > 0}'>numero=<c:out value='${bean.nr}'/>&</c:if>edicao=<c:out value='${bean.id}'/>"><img src="<%= base%><c:out value='${bean.path}'/>" border="1"  title="<fmt:message key='site.cliqueler'/>"/></a>
                    </c:otherwise>
                    </c:choose>
                </div>            
                <div class="boxdata">
                    <c:choose>
                        <c:when test="${!empty bean.nome}">
                    <label class="datatext"><c:out value="${bean.nome}"/></label>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${!empty bean.dataFormatada}">
                    <c:choose>
                        <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'es_ES_Spain'}">                    
                            <label  class="datatext dataformatada" style='width:100%'><c:out value="${bean.dataFormatadaES}"/></label>     
                        </c:when>
                        <c:otherwise>
                            <label class="datatext dataformatada" style='width:100%'><c:out value="${bean.dataFormatada}"/></label>         
                        </c:otherwise>
                    </c:choose>
                        </c:if>
                            <c:if test="${!empty bean.dataExtenso && bean.nr > 0}">
                    <label class="datatext" style='width:100%'> Nr: <c:out value="${bean.nr}"/> </label>
                    </c:if>
                    <c:if test="${!empty bean.dataExtenso}">
                    <label class="datatext dataextenso" style='width:100%'><c:out value="${bean.dataExtenso}"/></label>     
                    </c:if>
                    <c:if test="${!empty bean.nr}">
                    <label class="datatext" style='width:100%'>Nr: <c:out value="${bean.nr}"/></label>     
                    </c:if>
                    </c:otherwise>
                    </c:choose>
                </div>            
            </div>
        </div>
</c:forEach>
                    </c:when>
                    <c:otherwise>
        <h2> <fmt:message key="site.nenhumaedicao"/>!</h2>
                    </c:otherwise>
        </c:choose>
    </div>

</div>
<script type="text/javascript">
    try {
        if (filtroAbaEdicao == false) {
            jQuery(".filter_fields").hide();
        }
    } catch (err) {
    }
</script>
