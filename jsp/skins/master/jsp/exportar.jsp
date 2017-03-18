<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<a class="btn-fechar" href="javascript:void(0);" onClick="fecharExportar()"><i class="icon-remove"></i></a>
<p class="titulo">EXPORTAR PARA PDF</p>
<p class="pergunta">Selecione abaixo as páginas que deseja exportar</p>

<div id="scrollbar3" class="tiny-scrollbar-h">
    <form id="exporta_form" method="post">
        <div class="viewport">
            <div class="overview">

                <div class="edicoes">                        
                    <%
                        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
                        String edicaoId = request.getParameter("idEdicao");
                        boolean apenasFotos = "true".equals(request.getParameter("sumarioFotos"));
                        java.util.List<br.com.maven.flip.javasql.view.SumarioBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.sumario(Integer.parseInt(edicaoId));

                        int last = list.size();

                        for (int index = 1; index <= last; index++) {

                            br.com.maven.flip.javasql.view.SumarioBean bean = list.get(index - 1);
                            String anchor = "anch" + bean.getId();

                            if (index == 1 || index == last) {
                    %>

                    <p class="edicao simples" title="<fmt:message key='site.cliquevisualizar'/>"> 
                        <a class="btn" href="javascript:void(0);"  onClick="marcarParaExportar(this,<%= bean.getId()%>);"> 
                            <input type="checkbox" name="exportpage" id="exportpage-<%= bean.getId()%>" value="<%=  bean.getId()%>"/>
                            <i class="icon-ok"></i><img class="primeira" src="<%= base%><%= bean.getThumb()%>"  title="<fmt:message key='site.cliqueler'/>"/>
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
                            <a class="btn" href="javascript:void(0);"  onClick="marcarParaExportar(this,<%= bean2.getId()%>);">
                                <input type="checkbox" name="exportpage" id="exportpage-<%= bean2.getId()%>" value="<%=  bean2.getId()%>"/>
                                <i class="icon-ok"></i><img class="primeira" src="<%= base%><%= bean.getThumb()%>"  title="<fmt:message key='site.cliqueler'/>"/>
                            </a>
                            <a class="btn" href="javascript:void(0);"   onClick="marcarParaExportar(this,<%= bean2.getId()%>);">
                                <input type="checkbox" name="exportpage" id="exportpage-<%= bean2.getId()%>" value="<%=  bean2.getId()%>"/>
                                <i class="icon-ok"></i><img class="segunda" src="<%= base%><%= bean2.getThumb()%>"  title="<fmt:message key='site.cliqueler'/>"/>                            
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
                <input type="hidden" name="idEdicao" value="<%= edicaoId%>"/>

            </div>        
        </div>
        <div class="scrollbar">
            <div class="track">
                <div class="thumb">
                    <div class="end"></div>
                </div>
            </div>
        </div>


        <p class="custom">        
            <input class="check" type="checkbox" name="exportallpage" id="exportallpage"  value="S"/>
            <label for="check-exportar">Exportar todas as páginas</label>
            <a class="btn-modal" href="javascript:void(0);" onclick="exportaMarcadas();">Exportar</a>
        </p>            
    </form>
</div>