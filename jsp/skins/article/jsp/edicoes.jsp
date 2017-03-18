<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>


<a class="btn-fechar" href="javascript:void(0);" onClick="fecharTodasEdicoes()"><i class="fa fa-times" aria-hidden="true"></i></a>

<p class="titulo">TODAS AS EDIÇÕES</p>
    <div class="viewport">
            <%
                Integer PAGE_SIZE = 20;
                boolean mostraFiltros = true;
                try {
                    String edicaoId = request.getParameter("idForm");
                    String link = request.getParameter("linkedicao");
                    String pageNumber = request.getParameter("pagina");
                    String nr = request.getParameter("nr");
                    String di = request.getParameter("di");
                    String df = request.getParameter("df");
                    String tx = request.getParameter("tx");
                    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
                    if (pageNumber == null || pageNumber.trim().length() <= 0) {
                        pageNumber = "0";
                    }

                    Integer pagina = Integer.parseInt(pageNumber);
                    int[] count = new int[2];
                    Object days = request.getSession().getAttribute("SUBSCRIPTION_DAYS");
                    Object dates = request.getSession().getAttribute("SUBSCRIPTION_DATES");
                    java.util.List<br.com.maven.flip.javasql.view.EdicaoBean> list = br.com.maven.flip.javasql.dao.FlipEdicaoDAO.edicoes(Integer.parseInt(edicaoId), pagina, count, PAGE_SIZE, days, dates, nr, di, df, tx);
                    int i = 0;
                    mostraFiltros = count[1] == 0;
                    if (list.size() > 0 && count[0] > PAGE_SIZE) {
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
                } else {
                    pagina = 1;
                }
                if (mostraFiltros) {
            %>                                           

            <div class="busca">
                <p class="col edicao"> <span><fmt:message key="site.pesquisa.nr"/></span>
                    <input type="text" name="numero" id="numero" value="<%= nr != null ? nr : ""%>" size="4" max-length="5" />
                </p>
                <p class="col data"> <span><fmt:message key="site.pesquisa.di"/></span>
                    <input type="text" name="dataInicial" id="dataInicial" value="<%= di != null ? di : ""%>" size="10" max-length="10"/>
                </p>
                <p class="col data"> <span><fmt:message key="site.pesquisa.df"/></span>
                    <input type="text" name="dataFinal" id="dataFinal" value="<%= df != null ? df : ""%>" size="10"  max-length="10"/>
                </p>
                <p class="col texto"> <span><fmt:message key="site.pesquisa.tx"/></span>
                    <input type="text" name="texto" value="<%= tx != null ? tx : ""%>" size="51"  max-length=50"/>
                </p>
                <p class="botoes"> <a class="btn-modal" href="javascript:void(0);" onclick="openEditionMode(<%= pagina - 1%>)">Pesquisar</a> </p>
            </div>
            <div class="clear"></div>            
            
                <script type="text/javascript">
                    jQuery(document).ready(function(){
                        jQuery("#numero").ForceNumericOnly();
                        jQuery('#dataInicial,#dataFinal').datepicker({ 
                            beforeShow: function() { lockdock=true; jQuery('#edicoes_barra ul').css("display","block"); jQuery('#ui-datepicker-div').maxZIndex(); },
                            onClose:function(){ lockdock=false; },
                            dateFormat : "dd/mm/yy",
                            dayNamesArrayDefault:["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"],
                            dayNamesMin:["Do", "Se", "Te", "Qu", "Qi", "Se", "Sa"],
                            monthNames: ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"],
                            nextText: "Próximo",closeText:"Fechar",currentText:"Hoje",prevText:"Anterior"
                        });                                         
                    });
                </script>

                <div class="edicoes">
                <%          }
                    for (br.com.maven.flip.javasql.view.EdicaoBean bean : list) {
                %>
                <p class="edicao">             
                    <a class="btn" href="#">

                        <% if (bean.isDisabled()) {%>
                        <a href="javascript:alert('Você não tem acesso a essa edição');"><img src="<%= base + bean.getPath()%>" border="1"  title="<fmt:message key="site.cliqueler"/>" class="edicaothumb imgdisabled"/></a>
                            <%} else {%>
                        <a href="<%= base + link%>?numero=<%= bean.getNr()%><%=tx != null && tx != "" ? "&keywords=" + tx : ""%>"><img src="<%= base + bean.getPath()%>"  border="1" title="<fmt:message key='site.cliqueler'/>" class='edicaothumb'/></a>
                            <% }%>
                        <br/>
                        <span>   
                            <%if (bean.getNome() != null && bean.getNome().length() > 0) {%>
                            <%= bean.getNome()%>
                            <%} else {%>
                            <% if (bean.getDataFormatada() != null) {%>
                            <c:choose>
                                <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'es_ES_Spain'}">                    
                                    <%= bean.getDataFormatadaES()%>
                                </c:when>
                                <c:otherwise>
                                    <%= bean.getDataFormatada()%>
                                </c:otherwise>
                            </c:choose>
                            <% }%>
                            <br/><%= bean.getNr()%>
                            <% }%>
                        </span>            
                    </a>
                </p>

                <%   }
                    if (list.size() == 0) {
                %>
                <span><a href=""> <fmt:message key="site.nenhumaedicao"/>!</a></span>
                <%            }

                } catch (Exception e) {
                    br.com.maven.flip.Logger.logStackTrace(e);
                %>
                <span><a href=""><fmt:message key="site.erro"/> </a></span>
                <%
                    }
                %>
            </div>
    </div>      