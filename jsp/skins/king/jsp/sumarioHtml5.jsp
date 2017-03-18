<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<div class="dockpagina">
    <li>

        <div  id="sumario_container">

            <%
                        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
                        String edicaoId = request.getParameter("idForm");
                        boolean apenasFotos = "true".equals(request.getParameter("sumarioFotos"));
                        java.util.List<br.com.maven.flip.javasql.view.SumarioBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.sumario(Integer.parseInt(edicaoId));
                        int index=0;
                        int last=list.size();
                        for (br.com.maven.flip.javasql.view.SumarioBean bean : list) {
                            String anchor = "anch" + bean.getId();
                            index++;                            
                            if(index==1 || index == last){                                
            %>
            <div class="box<%= index==1?" capa":index==last?" last":""%>" title="<fmt:message key="site.cliquevisualizar"/>" id="indice<%=anchor%>">

                 <span><a href="javascript:void(0);" onclick="gotoAnchor('<%= anchor%>',false);fechaJanela(); return false;">
                        <img src="<%= base%><%= bean.getThumb()%>" border="1" align="center"  alt="<fmt:message key="site.cliqueler"/>" title="<fmt:message key="site.cliqueler"/>"/>
                    </a>
                </span>
                <% if (!apenasFotos) {%><label class="data datatext"><%= bean.getOrdem()%> - <c:choose>
                        <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                            <%= bean.getCadernoEn()%>
                        </c:when>
                        <c:otherwise>
                            <%= bean.getCaderno()%>
                        </c:otherwise>
                    </c:choose></label> <% }else{%>
                <label class="data datatext"><%= bean.getOrdem()%></label>
                <% } %>
            </div>
            <%
                           }else{
                                if(index%2==0){
            %>
            <div class="box normal" title="<fmt:message key="site.cliquevisualizar"/>" id="indice<%=anchor%>">
                 <% } %>
                 <div class="pagesum<%= index%2==0?" esq":" dir"%>">
                    <span>
                        <a href="javascript:void(0);" onclick="gotoAnchor('<%= anchor%>',false);fechaJanela(); return false;">
                            <img src="<%= base%><%= bean.getThumb()%>" border="1" align="center"  alt="<fmt:message key="site.cliqueler"/>" title="<fmt:message key="site.cliqueler"/>"/>                        
                        </a>
                    </span>
                    <% if (!apenasFotos) {%><label class="data datatext"><%= bean.getOrdem()%> -         <c:choose>
                            <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                                <%= bean.getCadernoEn()%>
                            </c:when>
                            <c:otherwise>
                                <%= bean.getCaderno()%>
                            </c:otherwise>
                        </c:choose></label> <% }else{%>
                    <label class="data datatext"><%= bean.getOrdem()%></label>                     
                    <% } %>
                </div>
                <% if(index%2!=0){ %>
            </div>                                     
            <%}
                          }
            
                   }%>

        </div>
    </li>
</div>