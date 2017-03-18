<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/struts-bean-el" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html-el" prefix="html" %>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/app" prefix="app" %>
<%
    Integer modelo = Integer.parseInt(request.getParameter("modelo"));
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    request.setAttribute("profissoes", br.com.maven.flip.util.LabelValueUtil.getProfissoes());
    request.setAttribute("escolaridades", br.com.maven.flip.util.LabelValueUtil.getEscolaridades());
    request.setAttribute("estados", br.com.maven.services.javasql.dao.MavenEstadoDAO.list(27));
    request.setAttribute("checklists", br.com.maven.flip.javasql.dao.ChecklistCamposDAO.listAtivos(modelo));
%>
<div id="box650_440" style="width:800px">

    <script type="text/javascript">
        var prefixo="<%= base%>flip/";
    </script>
    <link href="<%= base%>flip/jornal/css/cadastra.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/prototype.js"></script>
    <script type="text/javascript" src="<%= base%>flip/jornal/js/scriptaculous/scriptaculous.js"></script>    
    <script type="text/javascript" src="<%= base%>flip/web/js/dw.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/dwinit.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/StringBuffer.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/basic.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/funcoes.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/validation.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/XmlHttpLookup.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/calendar.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/dateUtilities.js"></script>
    <script type="text/javascript" src="<%= base%>flip/web/js/comboFunctions.js"></script>
    <script type="text/javascript" src="<%= base%>flip/jornal/js/cadastra.js"></script>
    <script type="text/javascript">
        function validateForm(form){
            try{   
                if(estaVazio($('flipUsuario.nome'))){
                    addMessage('Precisa informar o nome!');
                }
                if(estaVazio($('cpfCnpj'))){
                    addMessage('Precisa informar o CPF/CNPJ!');
                }
                if(estaVazio($('flipUsuario.username'))){
                    addMessage('Precisa informar o username');
                }
                if(estaVazio($('flipUsuario.senha'))){
                    addMessage('Precisa informar o senha');
                }
                if(estaVazio($('estados'))){
                    addMessage('Precisa informar o estado e cidade');
                }      
                if(estaVazio($('flipUsuario.email'))){
                    addMessage('Precisa informar o email');
                }
                if($('flipUsuario.assinante')){
                    var assinante=$('flipUsuario.assinante').value;
                    if(assinante == 'false'){
                        if(estaVazio($('flipUsuario.enderecoResidencial')) || estaVazio($('flipUsuario.enderecoComercial'))){
                            addMessage('Você não é assinante. Precisa informar o endereço');
                        }
                    }
                }

                if(showMessages()){
                    showMouseWaiting(true);
                    return true;
                }else{
                    return false;
                }
            }catch(e){
                alert(e);
                return false;
            }
        }
        function validaassinante(){
            if($('flipUsuario.assinante')){
                var assinante=$('flipUsuario.assinante').value;
                if(assinante != null){
                    if(assinante == 'false'){
                        Element.show("end1");
                        Element.show("end2");
                    }else{
                        Element.hide("end1");
                        Element.hide("end2");
                    }
                }
            }
        }

        window.onload=function(){
            validaassinante();
            if(!NiftyCheck()) return;
            Rounded("div#nifty","transparent","#FFFFFF");             
        }

    </script>
    <form method="POST" action="#" name="cadastroForm" id="cadastroForm" accept-charset="ISO-8859-1">
        <link href="<%= base%>flip/web/css/messages.css" rel="stylesheet" type="text/css" />
        <input type="hidden" name="cadastra" value="S"/>            
        <div class="main" id="nifty">
            <div class="box">                                  
                <label class="left">
                    <span class="normal">* Nome:</span>
                    <input type="text"  size='40'  maxlength='100'  name = 'flipUsuario.nome' id='flipUsuario.nome' class="input-text" />
                </label>
                <label >
                    <span class="normal">* CPF/CNPJ:</span>
                    <input type="text"  size='20'  maxlength='50'  name = 'flipUsuario.cpfCnpj' id='cpfCnpj'  class="input-text"  />
                </label>

                <label class="left">
                    <span class="normal">* Username:</span>
                    <input type="text"  size='20'  maxlength='20'  name = 'flipUsuario.username' id='flipUsuario.username'  class='input-text' />
                </label>
                <label>
                    <span class="normal">* Senha:</span>
                    <input type="password"  size='20'  maxlength='20'  name = 'flipUsuario.senha' id='flipUsuario.senha'  class='input-text'  />
                </label>
                <label class="left">
                    <span class="normal">* Estado:</span>
                    <select   name = 'flipUsuario.cidade.mavenEstadoidid_estado.id' id='estados'   class='input-text' onchange="pesquisarCidades(this.value,$('flipUsuario.cidade.id'));">
                        <option value="">[Selecione]</option>
                        <c:forEach var="item" items="${estados}">
                            <option value="<c:out value="${item.id}"/>">
                        <c:out value="${item.codigo}"/>
                        </option>
                    </c:forEach>
                </select>
            </label>

            <label>
                <span class="normal">* Cidade:</span>
                <select name="flipUsuario.cidade.id" id="flipUsuario.cidade.id" class="input-text" >
                    <option value="">[Selecione o estado]</option>
                </select>
            </label>

            <label class="left">
                <span class="normal">* Email:</span>
                <input type="text"  size='40'  maxlength='250'  name = 'flipUsuario.email' id='flipUsuario.email'  class='input-text' />
            </label>
            <label>
                <span class="normal">* Nascimento:</span>
                <input type="text"  size='10'  maxlength='10'  name = 'flipUsuario.dataNascimentoFormatada'   id='flipUsuario.dataNascimentoFormatada'  class='input-text'  onkeypress=" formatar(this,'##/##/####')  ;return key(event);" />  <a href="#" onclick="openCal( $('flipUsuario.dataNascimentoFormatada'), true ); return false;" ><img src="<%= base%>flip/web/html/calendar/button_calendar_on.gif" width="20" height="20" alt="" border="0"/></a>
            </label>

            <label class="left">
                <span class="normal">Telefone:</span>
                (<input type="text"  size='4'  maxlength='4'  name = 'flipUsuario.dddTelefone' id='flipUsuario.dddTelefone'  class='input-text' style="width:30px"/>)
                <input type="text"  size='4'  maxlength='10'  name = 'flipUsuario.telefone' id='flipUsuario.telefone'  class='input-text' style="width:140px"/>
            </label>
            <label>
                <span class="normal">É assinante?</span>
                <select name="flipUsuario.assinante" id="flipUsuario.assinante" class='input-text' onchange="validaassinante();">
                    <option value="true">Sim</option>
                    <option value="false">Não</option>
                </select>                
            </label>               
            <label class="left" id="end1">
                <span class="normal">Endereço residencial:</span>
                <input type="text"  size='40'  maxlength='200'  name = 'flipUsuario.enderecoResidencial' id='flipUsuario.enderecoResidencial'  class='input-text' />                
            </label>
            <label  id="end2">
                <span class="normal">Endereço comercial:</span>
                <input type="text"  size='40'  maxlength='200'  name = 'flipUsuario.enderecoComercial' id='flipUsuario.enderecoComercial'  class='input-text' />                            
            </label>             

            <label class="left">
                <span class="normal">* Profissão:</span>
                <select   name = 'flipUsuario.profissao' id='flipUsuario.profissao'  class='input-text'>
                    <option value="">[Selecione]</option>
                    <c:forEach var="item" items="${profissoes}">
                        <option value="<c:out value="${item.nome}"/>">
                    <c:out value="${item.nome}"/>
                    </option>
                </c:forEach>
            </select>
        </label>

        <label>
            <span class="normal">* Escolaridade:</span>
            <select   name = 'flipUsuario.escolaridade' id='flipUsuario.escolaridade'  class='input-text'>
                <option value="">[Selecione]</option>
                <c:forEach var="item" items="${escolaridades}">
                    <option value="<c:out value="${item.nome}"/>">
                <c:out value="${item.nome}"/>
                </option>
            </c:forEach>
        </select>
    </label>      
    <div class="spacer">
        <img  src="<%= base%>flip/jornal/images/enviar.gif" onclick="register();"/>
    </div>
</div>

</div>
</form>


<div id="divMessages" style="display:none;"> </div>

</div>