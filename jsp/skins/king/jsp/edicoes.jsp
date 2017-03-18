<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<!-- Modificação fixa MAGISTER-->
<c:if test="${param.linkedicao eq 'pub/direitocivileprocessualcivil/' || param.linkedicao eq 'pub/direitoambientaleurbanistico/' || param.linkedicao eq 'pub/revistabrasileiradedireitocomercial/' || param.linkedicao eq 'pub/direitoempresarial/' || param.linkedicao eq 'pub/direitodasfamiliasesucessoes/' || param.linkedicao eq 'pub/direitodotrabalho/' || param.linkedicao eq 'pub/direitopenaleprocessualpenal/' || param.linkedicao eq 'pub/direitoprevidenciario/' || param.linkedicao eq 'pub/direitoshumanos/' || param.linkedicao eq 'pub/direitotributarioefinancaspublicas/' || param.linkedicao eq 'pub/revistabrasileiradedireitodesportivo/'}">
    <style>
        #dock > li ul {
            background: #87919a;
        }
        #edicao_container .box .datatext {
            width: 100px;
        }
    </style>    
</c:if>
<div class="dockedicao">    
    <div  id="edicao_container">
        <%

            if(br.com.maven.filter.CrawlerFilter.isBot(request)){
                response.sendRedirect("/restrito.jpg");                
            }else{
                    Integer PAGE_SIZE = 20;
                    boolean mostraFiltros=true;
                    try {
                        String edicaoId = request.getParameter("idForm");

                        String link = request.getParameter("linkedicao");
                        String pageNumber = request.getParameter("pagina");
                        String nr=request.getParameter("nr");
                        String di=request.getParameter("di");
                        String df=request.getParameter("df");
                        String tx=request.getParameter("tx");
                        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
                        if (pageNumber == null || pageNumber.trim().length() <= 0) {
                            pageNumber = "0";
                        }
                        Integer pagina = Integer.parseInt(pageNumber);
                        int[] count = new int[2];                                                    
                        Object days = request.getSession().getAttribute("SUBSCRIPTION_DAYS");
                        Object dates = request.getSession().getAttribute("SUBSCRIPTION_DATES");

                        java.util.List<br.com.maven.flip.javasql.view.EdicaoBean> list = null;

                        if(org.apache.commons.lang.StringUtils.isNotBlank(link) &&
                                org.apache.commons.lang.StringUtils.contains(link, "pub/senai")) {
                            list = br.com.maven.flip.javasql.dao.FlipEdicaoDAO.getEdicoesMesmaCategoria(edicaoId);
                            mostraFiltros = false;
                        } else {
                            list = edicaoId == null ? null : br.com.maven.flip.javasql.dao.FlipEdicaoDAO.edicoes(Integer.parseInt(edicaoId), pagina, count, PAGE_SIZE, days, dates, nr, di, df, tx);
                            mostraFiltros=count[1]==0;
                        }

                        int i = 0;
                        if (list!=null && list.size() > 0 && count[0] > PAGE_SIZE) {
                            pagina++;
                            java.math.BigDecimal big = new java.math.BigDecimal(count[0]).divide(new java.math.BigDecimal(PAGE_SIZE));
                            big = big.setScale(0, java.math.BigDecimal.ROUND_UP);

                            int paginas = big.intValue();
                            int first = (pagina - 1) * PAGE_SIZE;
                            int last = first + list.size();
        %>
        <div class="filter_box">
            <label>
                <fmt:message key="site.pagina"/> <%= pagina%> <fmt:message key="site.de"/> <%= paginas%> | <fmt:message key="site.exibindoedicoes"/> <%= first + 1%> <fmt:message key="site.ate"/> <%= last%> <fmt:message key="site.de"/> <%= count[0]%>
                &nbsp;&nbsp;&nbsp;
                <% if (pagina > 1) {%>
                <a href="#" onclick="openEditionMode(<%= pagina - 2%>);">
                    << <fmt:message key="site.anterior"/>
                </a>
                <%}%>
                <% if (pagina < paginas) {%>
                &nbsp;&nbsp;|&nbsp;&nbsp;
                <a href="#" onclick="openEditionMode(<%= pagina%>);">
                    <fmt:message key="site.proxima"/> >>
                </a>
                <%}%>
            </label>
        </div>

        <%
            }else{
               pagina=1;           
            }
            if(mostraFiltros){
        %>
        <div class="filter_fields">
            <div>
                <label><fmt:message key="site.pesquisa.nr"/>:</label>
                <field>
                    <input type="text" name="numero" id="numero" value="<%= nr!=null?nr:"" %>" size="4" max-length="5" class="CampoTexto" style='width:60px'/>
                </field>
                <label><fmt:message key="site.pesquisa.di"/>:</label>
                <field>
                    <input type="text" name="dataInicial" id="dataInicial" value="<%= di!=null?di:"" %>" size="10" max-length="10" class="CampoTexto" placeHolder=" "  style='width:100px'/>
                </field>
                <label><fmt:message key="site.pesquisa.df"/>:</label>
                <field>
                    <input type="text" name="dataFinal" id="dataFinal" value="<%= df!=null?df:"" %>" size="10"  max-length="10" class="CampoTexto" placeHolder=" "  style='width:100px'/>
                </field>  
            </div>
            <div>                
                <label><fmt:message key="site.pesquisa.tx"/>:</label>
                <field>
                    <input type="text" name="texto" id="texto" value="<%= tx!=null?tx:"" %>" size="51"  max-length=50"  class="CampoTexto" style='width:236px'/>
                </field> 
                <field>
                    <input type="button" value="<fmt:message key='site.pesquisa.buscar'/>" class="BotaoBranco" onclick="openEditionMode(<%= pagina-1 %>)"/>
                </field>
            </div>
        </div>
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

        <%          }
                                            for (br.com.maven.flip.javasql.view.EdicaoBean bean : list) {
        %>
        <div class="box" <% if (bean.getId().intValue() == Integer.parseInt(edicaoId)) {%>id="selected"<% }%>>
            <div class='boxinner'>
                <div class='boxcover'>
                    <% if(bean.isDisabled()) { %>
                    <a href="javascript:alert('Você não tem acesso a essa edição');"><img src="<%= base + bean.getPath()%>" border="1"  title="<fmt:message key='site.cliqueler'/>" class="imgdisabled"/></a>
                        <%}else{ %>
                    <a href="<%= base + link%>?<%= bean.getNr()>0?"numero="+bean.getNr()+"&":""%>edicao=<%= bean.getId()%><%=tx!=null&&tx!=""?"&keywords="+tx:"" %>">
                        <!-- Modificação fixa MAGISTER-->
                        <c:choose>
                            <c:when test="${param.linkedicao eq 'pub/direitocivileprocessualcivil/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitocivileprocessualcivil.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitoambientaleurbanistico/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitoambientaleurbanistico.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/revistabrasileiradedireitocomercial/' || param.linkedicao eq 'pub/direitoempresarial/'}">
                                <% if(bean.getDataMagister().compareTo("2014-12-31")>0){ %>
                                    <img src="<%= base %>files/flip/MAGISTER/imgs/revistabrasileiradedireitocomercial.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                                <% } else { %>
                                    <img src="<%= base %>files/flip/MAGISTER/imgs/revistabrasileiradedireitocomercial2.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                                <% } %>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitodasfamiliasesucessoes/'}">
                                <% if(bean.getDataMagister().compareTo("2013-12-31")>0){ %>
                                    <img src="<%= base %>files/flip/MAGISTER/imgs/direitodasfamiliasesucessoes.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                                <% } else { %>
                                    <img src="<%= base %>files/flip/MAGISTER/imgs/direitodasfamiliasesucessoes2.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                                <% } %>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitodotrabalho/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitodotrabalho.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitopenaleprocessualpenal/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitopenaleprocessualpenal.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitoprevidenciario/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitoprevidenciario.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitoshumanos/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitoshumanos.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/direitotributarioefinancaspublicas/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/direitotributarioefinancaspublicas.png" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:when test="${param.linkedicao eq 'pub/revistabrasileiradedireitodesportivo/'}">
                                <img src="<%= base %>files/flip/MAGISTER/imgs/revistabrasileiradedireitodesportivo.jpg" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:when>
                            <c:otherwise>
                                <img src="<%= base + bean.getPath()%>" border="1"  title="<fmt:message key='site.cliqueler'/>"/>
                            </c:otherwise>
                        </c:choose>
                    </a>
                        <% } %>
                </div>            
                <div class="boxdata">
                    <%if(bean.getNome()!=null && bean.getNome().length()>0) { %>
                    <label class="datatext"><%= bean.getNome()%></label>     
                    <%}else{ %>
                    <% if ( bean.getDataFormatada()!=null){ %>
                    <c:choose>
                        <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'es_ES_Spain'}">                    
                            <label  class="datatext dataformatada" style='width:100%'><%= bean.getDataFormatadaES()%></label>     
                        </c:when>
                        <c:otherwise>
                            <label class="datatext dataformatada" style='width:100%'><%= bean.getDataFormatada()%></label>         
                        </c:otherwise>
                    </c:choose>
                    <% }
                    if(bean.getDataExtenso()==null && bean.getNr()>0){%>
                    <label class="datatext" style='width:100%'> Nr: <%= bean.getNr()%> </label>
                    <% } 
                    if(bean.getDataExtenso()!=null){
                    %>                    
                    <label class="datatext dataextenso" style='width:100%'><%= bean.getDataExtenso()%></label>     
                    <%} }%>
                </div>            
            </div>
        </div>

        <%   }
                                if (list.size() == 0) {
        %>
        <h2> <fmt:message key="site.nenhumaedicao"/>!</h2>
        <%            }

                            } catch (Exception e) {
                                br.com.maven.flip.Logger.logStackTrace(e);
        %>
        <h2> <fmt:message key="site.erro"/> </h2>
        <%
                    }
            }
        %>
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