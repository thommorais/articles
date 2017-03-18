/*
 * var kiss=new Kiss();
 * kiss.kissIdentify('user');
 * kiss.setEvent('hitPaywall').addProperty('name','value');
 * kiss.record();
 */
function KissObject() {
    this.eventName=null;
    this.eventValues=new Array();
}
function Kiss(){
    this.userName = null;
    this.kissObject=new KissObject();
}
Kiss.prototype.addProperty = function (nome,value) {    
    if(value){        
        if(this.kissObject.eventValues.length>=3){
            var object=this.kissObject.eventValues[2];
            object[nome]=value;
        }else{        
            var object=JSON.parse('{"'+nome+'":"'+value+'"}');
            this.kissObject.eventValues.push(object);
        }               
    }else{
        if(this.kissObject.eventValues.length<3){
            this.kissObject.eventValues.push(nome);
        }
    }
    return this;
}
Kiss.prototype.setEvent = function (name) {    
    this.kissObject.eventName=name;
    return this;
}
Kiss.prototype.kissIdentify = function (user) { 
    if(!user || user==null || user==''){
        user=myUser;
    }
     if(this.userName == null){
         _kmq.push(['identify', user]);
         this.userName=user;
    }
    return this;
}
Kiss.prototype.record = function () {   
    kissPropertyRecorder(this.kissObject);        
    this.kissObject=new KissObject();
}

function kissStartPropertyBuilder(eventName,kissobject){
    kissobject.addProperty('record');
    kissobject.addProperty(eventName);    
    kissobject.addProperty('dispositivo','desktop');
    kissobject.addProperty('produto','Jornal Digital');
    kissobject.addProperty('plataforma','Web');
    kissobject.addProperty('origem','direto');   
}

function kissIssuePropertyBuilder(kissobject){
    kissobject.addProperty('numero edicao',numeroEdicao);     
    kissobject.addProperty('data edicao',dataEdicao);
    kissobject.addProperty('dia semana',dataExtenso);
    
    if(!titleEdicao || titleEdicao==null || titleEdicao==''){
        titleEdicao=document.title;
    }
    
    kissobject.addProperty('nome edicao',titleEdicao);
    if(titleEdicao.indexOf("noite")!=-1){
        kissobject.addProperty("tipo edicao","Segunda edição");
    }else{
        if(titleEdicao.indexOf("ZH")!=-1){
            kissobject.addProperty("tipo edicao","Primeira edição");
        }else{
            kissobject.addProperty("tipo edicao","Produto especial");
        }
    }
    
}
function kissPropertyRecorder(object){    
    _kmq.push(object.eventValues);    
}
Kiss.prototype.hitPaywall = function(){        
    kissStartPropertyBuilder('hit paywall',this);   
    this.addProperty('tipo usuario','nao assinante');
    this.record();
}
Kiss.prototype.realizouLogin = function(){    
    kissStartPropertyBuilder('realizou login',this);    
    this.addProperty('tipo login','wrs');  
    this.addProperty('tipo usuario','identificado wrs');
    this.addProperty('origem login','wall');
    this.addProperty('nome usuario',nomeUsuario);
    if(emailUsuario && emailUsuario != ''){
        this.addProperty('email usuario',emailUsuario);
    }
    this.record();
}
//operations
Kiss.prototype.visitouCapa = function(){    
    kissStartPropertyBuilder('visitou capa',this);    
    kissIssuePropertyBuilder(this);       
    this.addProperty('tipo usuario','identificado wrs');
    this.record();
}
Kiss.prototype.visitouConteudo = function(){    
    kissStartPropertyBuilder('visitou conteudo',this);
    kissIssuePropertyBuilder(this);       
    this.addProperty('tipo usuario','identificado wrs');
    this.record();
}
Kiss.prototype.visitouEditoria = function(editoria){    
    kissStartPropertyBuilder('visitou editoria',this);    
    kissIssuePropertyBuilder(this);       
    this.addProperty('editoria',editoria);
    this.addProperty('tipo usuario','identificado wrs');
    this.record();
}
Kiss.prototype.visitouGaleria = function(){    
    kissStartPropertyBuilder('visitou galeria',this);   
    this.addProperty('tipo usuario','identificado wrs');
    this.record();
}