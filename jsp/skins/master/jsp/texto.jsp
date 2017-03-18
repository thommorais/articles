<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<style type="text/css">
    .textopagina{
        width:270px;
        height:440px;
        overflow:auto;
        text-align:left;        
        font-size:12px;
        margin: 3px;
        border:1px #777777 dotted;
        color:black;
        background-color: white;
    }
    .leftpage{
        float:left;
    }
    .rightpage{
        float:right;
    }
    .barraBaixo{
        width:270px;
        height:27px;
        overflow:hidden;
        text-align:center;
        font-size:11px;
        margin: 1px;        
    }
</style>
<div class="modal-bg"></div>
<div class="padding">
<a class="btn-fechar" href="javascript:void(0);" onClick="fecharTexto()"><i class="icon-remove"></i></a>
<p class="titulo">MODO TEXTO</p>
<br/>
<script type="text/javascript">
    jQuery(document).ready(function(){
        jQuery('.copylink').click(function(){
            var id=this.id;         
            jQuery('#'+id).copy();
            jQuery.copy("copy this text");
            return false;
        });
        jQuery('.relink').click(function(){
            var id=this.id;
            var curFontSize = jQuery('#'+id).css('font-size');
            jQuery('#'+id).css('font-size', parseInt(curFontSize)-2);
            return false;
        });
        jQuery('.inclink').click(function(){
            var id=this.id;
            var curFontSize = jQuery('#'+id).css('font-size');
            jQuery('#'+id).css('font-size', parseInt(curFontSize)+2);
            return false;
        });
    });
</script>
<%
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String anchorId = request.getParameter("idForm");
    //String indexId = request.getParameter("index");
    String edicaoId = request.getParameter("idEdicao");
    if (anchorId != null) {
        anchorId = anchorId.replaceAll("anch", "");
    }

    java.util.List<String[]> list = br.com.maven.flip.util.ExportadorTexto.readText(anchorId, edicaoId, request);
    if (list == null) {
%>
<span>Texto não encontrado!    </span>
<%} else {
    boolean first = true;
    for (String[] string : list) {
        String text = br.com.maven.flip.util.ExportadorTexto.getTexto(string[0]);
        if (text == null || "null".equals(text)) {
            text = "Texto não encontrado";
        }
        String folha = string[2];
        String folhas = string[3];
%>
<div class="textopagina <%= first ? "leftpage" : "rightpage"%>">
    <strong><%= string[4]%></strong>
    <br/>
    <i>Folha <%= folha%> de <%= folhas%></i>
    <br/><br/>
    <p id="<%= first ? "text1" : "text2"%>">
        <%= text%> 
    </p>
</div>

<%  first = false;
    }
    first = true;
    for (String[] string : list) {
        String id = first ? "text1" : "text2";
%>

<div class="barraBaixo <%= first ? "leftpage" : "rightpage"%>">

    <img src="<%= base%>flip/web/images/icons/page_copy.png"/>&nbsp;<a href="#" id="<%= id%>" class="copylink">Copiar</a>
    <img src="<%= base%>flip/web/images/icons/font_delete.png"/>&nbsp;<a href="#" id="<%= id%>" class="relink">Reduzir</a>
    <img src="<%= base%>flip/web/images/icons/font_add.png"/>&nbsp;<a href="#" id="<%= id%>" class="inclink">Aumentar</a>


</div>

<%  first = false;
        }
    }%>

</div>