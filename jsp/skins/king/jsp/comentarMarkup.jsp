<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String anchorId = request.getParameter("idForm");
            anchorId = anchorId.replaceAll("anch", "");
            String edicao = request.getParameter("idEdicao");
            String pagina = request.getParameter("pagina");
            String[] img = br.com.maven.flip.util.ImpressaoPaginas.readImage(pagina, request);
%>
<style>
    #formulario{
        overflow:auto;
    }    
</style>
<form method="POST" action="#" name="faleConoscoForm" id="faleConoscoForm"  style="margin:0px">
    <div id="formulario">
        <input type="hidden" name="coord" id="coord" value=""/>
        <input type="hidden" name="edicao" value="<%= anchorId%>"/>
        <input type="hidden" name="pagina_anchor" id="pagina_anchor" value="<%= pagina%>"/>
        <table width="<%= Integer.parseInt(img[1]) + 100%>px" align="center" border="0" cellpadding="0px" cellspacing="0px">
            <tr>
                <td class="TextoPreto" valign="top">
                    <div id="Canvas" style="width:<%=img[1]%>px;height:<%=img[2]%>px;border:solid black;">
                        <img src="<%= base%><%= img[0]%>" name="testImage" id="testImage" align="center"/>
                        <DIV ID="rubberBand"></DIV>
                    </div>
                </td>
                <td valign="top" align="center">
                    <input type="submit"  value="Salvar" size="" class="BotaoBranco" onclick="comentaPaginaMarkup();" style="width:90px"/>
                    <br/><br/>
                    <input type="button" value="Comentários" size="" class="BotaoBranco" onclick="Element.show('comments_div');" style="width:90px"/>
                    <br/><br/>
                    <input type="button" name="button" value="Fechar" size="" class="BotaoBranco" onclick="fechaTela();"  style="width:90px"/>
                </td>
            </tr>                
        </table>            
    </div>
    <div id="comments_div" style="display:none;">
        <h3> Faça seu comentário e clique em Salvar</h3>        
        <textarea cols="60" rows="6" class="CampoTexto amarelo" name="mensagem" id="mensagem"></textarea>

        <input type="button"  value="Salvar" size="" class="BotaoBranco" onclick="comentaPaginaMarkup();" style="width:90px"/>
        <input type="button" name="button" value="Cancelar comentário" size="" class="BotaoBranco" onclick="Element.hide('comments_div');"  style="width:150px"/>
    </div>
</form>
<script type="text/javascript">
    loadCropper();
    loadExample( 'basic' );
</script>