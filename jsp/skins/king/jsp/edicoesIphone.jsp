<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<div class="dockedicao">
<li>
    <div  id="edicao_container">
        <%
                    String n=request.getParameter("n");
                    Integer PAGE_SIZE = n==null||n.length()==0?8:Integer.parseInt(n);
                    try {
                        String edicaoId = request.getParameter("idForm");
                        String link = request.getParameter("linkedicao");
                        String pageNumber = request.getParameter("pagina");
                        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
                        if (pageNumber == null || pageNumber.trim().length() <= 0) {
                            pageNumber = "0";
                        }

                        Integer pagina = Integer.parseInt(pageNumber);
                        int[] count = new int[2];                        
                        Object days = request.getSession().getAttribute("SUBSCRIPTION_DAYS");
                        Object dates = request.getSession().getAttribute("SUBSCRIPTION_DATES");
                        java.util.List<br.com.maven.flip.javasql.view.EdicaoBean> list = br.com.maven.flip.javasql.dao.FlipEdicaoDAO.edicoes(Integer.parseInt(edicaoId), pagina, count, PAGE_SIZE,days,dates);
                        int i = 0;
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
                <br/>
                &nbsp;&nbsp;&nbsp;                
                <% if (pagina > 1) {%>                
                <a href="#" onclick="openEditionMode(<%= pagina - 2%>);">
                    << <fmt:message key="site.anterior"/>
                </a>
                <%}%>
                <% if (pagina < paginas) {%>
                <% if (pagina > 1) {%>               
                &nbsp;&nbsp;|&nbsp;&nbsp;
                <%}%>
                <a href="#" onclick="openEditionMode(<%= pagina%>);">
                    <fmt:message key="site.proxima"/> >>
                </a>
                <%}%>
            </label>
        </div>        
        <%
                                }
                                for (br.com.maven.flip.javasql.view.EdicaoBean bean : list) {
        %>
        <div class="box" <% if (bean.getId().intValue() == Integer.parseInt(edicaoId)) {%>id="selected"<% }%>>
            <span>
                <% if(bean.isDisabled()) { %>
                <a href="javascript:alert('Você não tem acesso a essa edição');"><img src="<%= base + bean.getPath()%>" border="1" alt="<fmt:message key="site.cliqueler"/>" title="<fmt:message key="site.cliqueler"/>" class="imgdisabled"/></a>
                <%}else{ %>
                <a href="<%= base + link%>/index.jsp?edicao=<%= bean.getId()%>"><img src="<%= base + bean.getPath()%>" border="1" alt="<fmt:message key="site.cliqueler"/>" title="<fmt:message key="site.cliqueler"/>"/></a>
                <% } %>
            </span>            
            <label class="data">   
                <% if (bean.getDataFormatada()!=null){ %>
                <c:choose>
                <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'es_ES_Spain'}">                    
                <label class="datatext"><%= bean.getDataFormatadaES()%></label>     
                </c:when>
                <c:otherwise>
                <label class="datatext"><%= bean.getDataFormatada()%></label>         
                </c:otherwise>
                </c:choose>
                <% } %>
                <label class="numero"> <%= bean.getNr()%> </label>
            </label>            
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
        %>
    </div>
</li>
</div>