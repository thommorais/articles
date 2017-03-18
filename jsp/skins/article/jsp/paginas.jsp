<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<a class="btn-fechar" href="javascript:void(0);" onClick="fecharPaginas()"><i class="fa fa-times" aria-hidden="true"></i></a>
<p class="titulo"><fmt:message key='site.sumario'/></p>

    <div class="viewport">        
            <div class="edicoes">                        
                <%
                    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
                    String edicaoId = request.getParameter("idForm");
                    boolean apenasFotos = "true".equals(request.getParameter("sumarioFotos"));
                    java.util.List<br.com.maven.flip.javasql.view.SumarioBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.sumario(Integer.parseInt(edicaoId));

                    int last = list.size();

                    for (int index = 1; index <= last; index++) {

                        br.com.maven.flip.javasql.view.SumarioBean bean = list.get(index - 1);
                        String anchor = "anch" + bean.getId();

                        if (index == 1 || index == last) {
                %>

                <p class="edicao simples" title="<fmt:message key='site.cliquevisualizar'/>"> 
                    <a class="btn" href="javascript:void(0);" onclick="gotoAnchor('<%= anchor%>',false);fechaJanela(); return false;"> 
                        <img class="primeira" src="<%= base%><%= bean.getThumb()%>"  title="<fmt:message key='site.cliqueler'/>"/>
                        <% if (!apenasFotos) {%>
                        <br/>
                        <span><%= bean.getOrdem()%> - <c:choose>
                                <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                                    <%= bean.getCadernoEn()%>
                                </c:when>
                                <c:otherwise>
                                    <%= bean.getCaderno()%>
                                </c:otherwise>
                            </c:choose></span> 
                            <% }%>
                    </a> 
                </p>                            
                <%
                } else {
                    if (index % 2 == 0) {
                        br.com.maven.flip.javasql.view.SumarioBean bean2 = list.get(index);
                        String anchor2 = "anch" + bean2.getId();
                        index++;
                %>

                <p class="edicao duplo" title="<fmt:message key='site.cliquevisualizar'/>"> 

                    <span class="duplo"> 
                        <a class="btn" href="javascript:void(0);" onclick="gotoAnchor('<%= anchor%>',false);fechaJanela(); return false;">
                            <img class="primeira" src="<%= base%><%= bean.getThumb()%>"  title="<fmt:message key='site.cliqueler'/>"/>
                        </a>
                        <a class="btn" href="javascript:void(0);" onclick="gotoAnchor('<%= anchor2%>',false);fechaJanela(); return false;">
                            <img class="segunda" src="<%= base%><%= bean2.getThumb()%>"  title="<fmt:message key='site.cliqueler'/>"/>                            
                        </a>
                    </span> 
                    <% if (!apenasFotos) {%>
                    <br/>   
                    <a class="btn">
                        <span class="desc"> 
                            <span class="desc1"><%= bean.getOrdem()%> - <c:choose>
                                    <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                                        <%= bean.getCadernoEn()%>
                                    </c:when>
                                    <c:otherwise>
                                        <%= bean.getCaderno()%>
                                    </c:otherwise>
                                </c:choose></span> 
                            <span class="desc2"><%= bean2.getOrdem()%> - <c:choose>
                                    <c:when test="${sessionScope['javax.servlet.jsp.jstl.fmt.locale.session'] eq 'en'}">
                                        <%= bean2.getCadernoEn()%>
                                    </c:when>
                                    <c:otherwise>
                                        <%= bean2.getCaderno()%>
                                    </c:otherwise>
                                </c:choose></span> 
                        </span> 
                    </a>
                    <% }%>

                </p>

                <%
                            }
                        }
                    }%>
            </div>
        </div>            