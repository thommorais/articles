var flag=0

function printIt(){
    flag=0;
    setTimeout('printPDF();',750);
}

function printPDF(){
    flag=0;
    if (!isIE){
        window.frames["printImage"].focus();
        window.frames["printImage"].print();        
        fechaJanela();
    }else{        
        document.printImage.focus();
        document.printImage.print();
        fechaJanela();
    }
}

function printReload(){
    if (flag>0){
        printIt();
    }
    flag=flag+1;
}

function printLoad(src){
    if  (flag==1){
        jQuery('.printdiv').html("<h2><center>Printing,please wait...</center></h2>");
        if(isIE){
            document.getElementById('printImage').src=base+'flip/jornal/jsp/printPreview.jsp?imagem='+src;
        //document.printImage.onload=new function(){ printReload();};
        }else{      
            var newurl=base+'flip/jornal/jsp/printPreview.jsp?imagem='+src;
            try{
                window.frames["printImage"].location=newurl;
            }catch(e){
                document.getElementById('printImage').src=newurl;
                window.frames["printImage"].location.reload();
            }
        }
    }
    if (flag >1) printIt();
}