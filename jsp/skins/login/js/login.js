$(document).ready(function(){
    $(".show-forgot-user").click(function(){
        $("#login-form").hide();
        $("#forgot-user").show();
        $("#forgot-pass").hide();
    });
    $(".show-forgot-pass").click(function(){
        $("#login-form").hide();
        $("#forgot-user").hide();
        $("#forgot-pass").show();
    });    
    $(".show-login").click(function(){
        $("#login-form").show();
        $("#forgot-user").hide();
        $("#forgot-pass").hide();        
    });    
    $("#login-form").submit(function(){        
        if(jQuery("#username").val() == ""){
            showError("Informe o seu usuário.");
            return false;
        }        
        if(jQuery("#senha").val() == ""){
            showError("Informe a sua senha.");
            return false;
        }       
        $(".acessalogin").hide();
        $("#error").html("Aguarde...");
        return true;
    });
    $("#forgot-user").submit(function(){    
        if(!jQuery.validateEmail(jQuery("#email").val())){
            showError("O seu email parece incorreto. Corrija-o.!");
            return false;            
        }   
        $(".acessauser").hide();
        $("#error").html("Aguarde...");        
        return true;
    });
    $("#forgot-pass").submit(function(){    
        if(jQuery("#forgotpass-username").val() == ""){
            showError("Informe o seu usuário.");
            return false;
        } 
        $(".acessapass").hide();
        $("#error").html("Aguarde...");        
        return true;
    });                   
    
    $(".acessacadastro").click(function(){                           
        abreModal('#myModal',700,'auto');                
    });   
        
    $('#password').attr("autocomplete", "off");
    setTimeout('$("#password").val("");', 50); 
        
});

function abreModal(src,w,h){    
    $(src).css('width',w).css('height',h);
    $(src).modal('show');        
}

function showError(msg){
    $("#error").html(msg);
}

jQuery.validateEmail = function (email){
    er = /^[a-zA-Z0-9][a-zA-Z0-9\._-]+@([a-zA-Z0-9\._-]+\.)[a-zA-Z-0-9]{2}/;
    if(er.exec(email))
        return true;
    else
        return false;
};