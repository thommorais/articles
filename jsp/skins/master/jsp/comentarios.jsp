<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String anchorId = request.getParameter("pagina");
    anchorId = anchorId.replaceAll("anch", "");
    String edicao = request.getParameter("edicao");

    java.util.List<br.com.maven.flip.util.comments.CommentsBean> list = br.com.maven.flip.util.comments.CommentsUtil.getListComments(anchorId, edicao, request);
    request.setAttribute("comments", list);
%>
<div class="modal-bg"></div>
<div class="padding"> 
    <a class="btn-fechar" href="javascript:void(0);" onClick="fecharComentar()"><i class="icon-remove"></i></a>
    <p class="titulo">COMENTÁRIOS</p>

    <c:choose>
        <c:when test="${!empty comments}">
            <span> <a href="javascript:openCommentMode();">Faça o seu comentário também!  Clique aqui!</a> </span>
            <br/>
            <div id="scrollbar5" class="tiny-scrollbar-v">
                <div class="scrollbar">
                    <div class="track">
                        <div class="thumb">
                            <div class="end"></div>
                        </div>
                    </div>
                </div>
                <div class="viewport">
                    <div class="overview">
                        <div class="clear"></div>
                            <div class="edicoes" id="result"> 
                        <c:forEach var="comment" items="${comments}">
                            <a class="btn edicao" href="javascript:void(0);" > 
                                <span class="esquerda">
                                    <img src="<%= base%><c:out value='${comment.thumb}'/>" border="1"  width="68px" height="93px"/>                                        
                                </span>
                                <span class="direita">
                                    <span class="numero">Nome:<c:out value="${comment.remetente}"/></span> 
                                    <span class="data"><c:out value="${comment.data}"/></span> 
                                    <span class="texto"><c:out value="${comment.comentario}" escapeXml="false"/></span> 
                                </span> 
                            </a>
                            <div class="clear"></div>                                               
                        </c:forEach>
                            </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <br/><br/>
            <span>  <a href="javascript:openCommentMode();"> Nenhum comentário realizado. Seja o primeiro, clique aqui!</a> </span>
        </c:otherwise>
    </c:choose>
    <div class="clear"></div>
</div>
<div class="clear"></div>
