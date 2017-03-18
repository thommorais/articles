<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
String nometxt = "";
String emailtxt = "";


Object email=request.getSession().getAttribute("user_email");
if(email == null){
    email=request.getSession().getAttribute("username");    
}
if(email != null && email.toString().indexOf("@")!=-1) { 
        emailtxt=email.toString(); 
}
Object nome=request.getSession().getAttribute("user_nome");
if(nome!=null){
    nometxt=nome.toString();
}else{
    nometxt=emailtxt;
}
%>
<div class='modalboxheader'><fmt:message key='site.contato'/><a href='javascript:void(0)' class='closeModalBox'><img src='<%= base %>flip/jornal/skins/king/img/icones/close-popup.png'/></a></div>    

<div id="box650_440">    
    <form method="POST" action="#" name="faleConoscoForm" id="faleConoscoForm" accept-charset="ISO-8859-1">
        <input type="hidden" name="edicao" value="<%= request.getParameter("idForm")%>"/>
        <input type="hidden" name="pagina_anchor"  id="pagina_anchor"/>
        <input type="hidden" name="faleConosco" id="faleConosco" value="true"/>
        <table width="100%" align="left" border="0" cellpadding="3px" cellspacing="1px">            
            <tr>
                <td   class="TextoPreto">
            <fmt:message key="site.seunome"/> *
            </td>
            <td   class="TextoPreto">
            <fmt:message key="text.usuario.edit.telefone"/> *
            </td>
            </tr>
            <tr>
                <td >
                    <input type="text" name="nome" id="nomeId" value="<%= nometxt %>" size="37" maxlength="255"  class="CampoTexto" style="width:230px; margin-right: 10px"/>
                </td>
                <td ><input type="tel" name="telefone" id="telefone"  size="37" maxlength="20"  class="CampoTexto"  style="width:240px"/></td>
            </tr>
            <tr>
                <td   class="TextoPreto">
            <fmt:message key="site.seuemail"/> *
            </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="email" name="email" id="emailId" value="<%= emailtxt %>" size="37" maxlength="255"  class="CampoTexto"  style="width:480px"/>
                </td>
            </tr>
            <tr>
                <td   class="TextoPreto">
            <fmt:message key="site.assunto"/> *
            </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="text" name="assunto" id="assunto" value="" size="80" maxlength="255"  class="CampoTexto" style="width:480px"/>
                </td>
            </tr>
            <tr>
                <td    class="TextoPreto"><fmt:message key="site.mensagem"/> </td>
            </tr>
            <tr>
                <td  colspan="4">
                    <textarea name="mensagem" id="mensagem" cols=60" rows="6" class="CampoTexto" style="height:60px;width:480px; max-height: 120px; max-width: 480px"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="TextoPreto TextoRequired" colspan="4">* <fmt:message key="site.camposobrigatorios"/> </td>
            </tr>
            <tr>
                <td colspan="4" align="center">                   
                    <input type="button" name="button" value="<fmt:message key='site.enviar'/>" size="" class="BotaoBranco" onclick="entraEmContato();"/>                           
                </td>                
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>            
        </table>
    </form>

</div>