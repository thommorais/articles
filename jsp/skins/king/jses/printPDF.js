flag=0

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
        if(isIE){
            document.getElementById('printImage').src=base+'flip/jornal/jsp/printPreview.jsp?imagem='+src;
        //document.printImage.onload=new function(){ printReload();};
        }else{            
            window.frames["printImage"].location=base+'flip/jornal/jsp/printPreview.jsp?imagem='+src;
        }
    }
    if (flag >1) printIt();
}