<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String anchorId = request.getParameter("pagina");
            anchorId = anchorId.replaceAll("anch", "");
            String edicao = request.getParameter("edicao");

            java.util.List<br.com.maven.flip.util.comments.CommentsBean> list = br.com.maven.flip.util.comments.CommentsUtil.getListComments(anchorId, edicao, request);
            request.setAttribute("comments", list);            
%>
<div class='modalboxheader'><fmt:message key='label.title.comentarios'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    
<div id="box650_440">
    <div id="pesquisa_div" >

        <c:choose>
            <c:when test="${!empty comments}">
                <h2 class="TextoPreto"> Faça o seu comentário também!  <a href="javascript:openCommentMode();">Clique aqui!</a> </h2>
                
                <c:forEach var="comment" items="${comments}">
                    <div id="item_pesquisa">
                        <div id="item_pesquisa_conteudo">
                            <div id="item_pesquisa_header">
                                <strong> Nome: <c:out value="${comment.remetente}"/> </strong>
                                &nbsp;&nbsp;&nbsp;
                                <c:out value="${comment.data}"/>
                            </div>
                            <div id="item_pesquisa_texto">
                                <div id="item_pesquisa_foto">
                                    <img src="<%= base%><c:out value='${comment.thumb}'/>" border="1" alt="Clique para visualizar a página" width="110px"/>
                                </div>
                                <c:out value="${comment.comentario}" escapeXml="false"/>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <h2 class="TextoPreto"> Nenhum comentário realizado! <a href="javascript:openCommentMode();">Seja o primeiro, clique aqui!</a> </h2>

            </c:otherwise>
        </c:choose>
    </div>
</div>
