var HPApp;
enyo.kind({
    name: "App",
    kind: enyo.VFlexBox,
    components: [
    {
        kind: "BasicWebView",
        name: "myWebView",
        onPageTitleChanged:"loading",
        url: "http://",
        autoHorizontal: false,
        vertical: false,
        autoVertical: false,
        horizontal: false,
        retries: 0,
        retry: false
    },
    {
        kind: "DialogPrompt",
        name: "dialog",
        title: "Subscribe",
        message: "No internet connectivity found",
        acceptButtonCaption: "Retry",
        cancelButtonCaption: "Cancel",
        onAccept: "retry",
        onCancel: "cancel",
        onClose: "close",
        dismissWithClick: false
    },
		
    {
        kind: "ModalDialog",
        name: "DownloadViewer",
        layoutKind: "VFlexLayout",
        caption: "Initilising Reader",
        onOpen: "dialogOpened",
        components: [

        {
            layoutKind: "HFlexLayout",
            pack: "center",
            components: [
            {
                kind: "Control",
                name: "output"
            }
				
            ]
        }
        ]
    }
    ,
    {
        kind: enyo.PalmService,
        name: "downloader",
        service: "palm://com.palm.downloadmanager/",
        method: "download",
        subscribe: true,
        onSuccess : "downloadFinished",
        onFailure : "DownloadFailed"
    },
    {
        name : "deleteDownloadFile",
        kind : "PalmService",
        service : "palm://com.palm.downloadmanager/",
        method : "deleteDownloadedFile",
        onSuccess : "deleteFinished"
         
    }
    ],
    cancel: function(){
        window.close();
        console.log('cancel');
    },
    retry: function(){
        this.$.myWebView.retries = 0;
        this.$.myWebView.setUrl("http://mobile.pagesuite.com/SubscribeHTML5/subscribe.aspx?pub="+HPObj.pubGuid + "&rand=" + escape(new Date()));
        console.log('retry');
    },
    loading: function(inWebview, inTitle, inUrl, inCanGoForward){
	
        console.log(inUrl);
	
        if(inUrl.length<=1) {
		
            console.log('retry count: ' + this.$.myWebView.retries);
				
            if(this.$.myWebView.retries < 3){
                this.$.myWebView.setUrl("http://mobile.pagesuite.com/SubscribeHTML5/subscribe.aspx?pub="+HPObj.pubGuid + "&rand=" + escape(new Date()));
            }
            else {
                console.log('no internet');
                this.$.dialog.open();
                console.log('dialog opened');
            }
				
            this.$.myWebView.retries++;
		
        }
        else
        {
            if(inUrl.indexOf("action=cancel") !=-1) {
                HPObj.finished('cancel');
            // cancelled
            }
            else if(inUrl.indexOf("action=login") !=-1) {
                HPObj.finished('success');
                // allow access
                var subscriberGuid = inUrl.split("|")[1];
            }
            else if(inUrl.indexOf("action=register") !=-1) {
			
                var transactionGuid = inUrl.split("|")[1];
                var subscriptionGuid = inUrl.split("|")[2];
                var status = inUrl.split("|")[3];
                var endDate = inUrl.split("|")[4];
				
                endDate = decodeURI(endDate);
				
                console.log('tx guid: ' + transactionGuid);
                console.log('sub guid: ' + subscriptionGuid);
                console.log('status: ' + status);
                console.log('expiry: ' + endDate);
				
                if(endDate.indexOf("failed") !=-1) {

                    console.log('failed');
                    // registration failed, return nothing
                    HPObj.finished();
				
                }
                // else if(endDate.indexOf("pending") !=-1) {
                // console.log('pending');
                // var subscriptionObj = {guid: subscriptionGuid, expiry: endDate, confirmed: false};
                // HPObj.finished(subscriptionObj);
                //payment pending
				
                // }
                else if(Date.parse(endDate)) {
                    var confirmed;
                    if(status === 'confirmed') confirmed = true;
                    else confirmed = false;
				
                    console.log('valid date');
                    var subscriptionObj = {
                        guid: subscriptionGuid,
                        expiry: endDate,
                        confirmed: confirmed
                    };
                    HPObj.finished(subscriptionObj);
                // registration successful
                }
                else{
				
                    console.log('do nothing');
                }
            }
        //else{HPObj.finished('cancel');}
        }
    }
    ,
    gotoURL: function(url) {
        this.$.myWebView.setUrl(url);
    },
    deleteFinished : function(inSender, inResponse) {
        console.log("deleteDownloadedFile success");
    },
    DownloadFailed : function(inSender, inResponse)
    {
        switch (downloadaction)
        {
            case 0:
					
                console.log("Got image");
					
                break;
            case 1:
                console.log("Edition");
					
                UpdateSplash("Retrieving publication data");
                geteditioninfo();
                break;
            case 2:
                UpdateSplash("Retrieving edition data");
                GetPDFInfo();
                break;
            case 3:
                //lblpagepath = "/media/internal/" + lbleditionguid + "pages.xml";
                UpdateSplash("Retrieving page data");
                GetPageInfo();
                break;
            case 4:
                // Failed
                DownloadFinished("Error");
                break;
            case 5:
                // Failed
                DownloadFinished("Error");
                startdownloading = false;
                break;
            case 6:
                storesavededitions.add({
                    EditionGUID: downloadlbleditionguid,
                    Name: downloadlblname,
                    Pages: downloadnopages
                });
                storesavededitions.sync();
                DownloadFinished("Success");
                startdownloading = false;
                console.log("Got saved image");
                break;
            case 7:
                storesavedpages.add({
                    EditionGUID: lbleditionguid,
                    PageGUID: pagestore.data.items[downloaditem].data['pageguid'],
                    Name: lblname,
                    PartOfEdition : "No",
                    Page: (downloaditem + 1),
                    Pages: nopages
                });
                storesavedpages.sync();
                var isdone = true;
                if (dontdownloadagain == false)
                {
                    if (islandscape())
                    {
                        var realpageno = downloaditem + 1;
                        if (realpageno > 1 && realpageno < nopages)
                        {
                            console.log("In criteria");
                            dontdownloadagain = true;
                            if ((realpageno % 2) > 0)
                            {
                                downloaditem = downloaditem - 1;
                            }
                            else
                            {
                                downloaditem = downloaditem + 1;
                            }
								
                            if (!localStorage.getItem(pagestore.data.items[downloaditem].data['pageguid']))
                            {
                                console.log("Page not downloaded");
                                downloadaction = 5;
                                HPApp.$.downloader.call({
                                    target: "http://pages.mobile.cdn.pagesuite.com/images/" + pagestore.data.items[downloaditem].data['pageguid'] + "/full.jpg",
                                    targetDir : offlineprepath,
                                    targetFilename : pagestore.data.items[downloaditem].data['pageguid'] + ".jpg",
                                    keepFilenameOnRedirect: true
                                });
                                isdone = false;
                            }
                            else
                            {
                                console.log("Page already downloaded");
                                dontdownloadagain = false;
									
                            }
								
								
                        }
                    }
                }
                else
                {
                    dontdownloadagain = false;
						
                }
					
                if (isdone)
                {
                    DownloadFinished("Success");
                    startdownloading = false;
                    console.log("Got saved image");
                }
					
					
                break;
        }
    }
    ,
    downloadFinished: function(inSender, inResponse) {
        if (inResponse.completionStatusCode != null)
        {
            if (localStorage.getItem("savedcache"))
            {
                savedtickets = localStorage.getItem("savedcache");
            }
            if (savedtickets == "")
            {
                savedtickets = inResponse.ticket;
            }
            else
            {
                savedtickets += "," + inResponse.ticket;
            }
            localStorage.setItem("savedcache", savedtickets);
			
			
            switch (downloadaction)
            {
                case 0:
					
                    console.log("Got image");
					
                    break;
                case 1:
                    console.log("Edition");
					
                    UpdateSplash("Retrieving publication data");
					
                    geteditioninfo();
                    break;
                case 2:
                    UpdateSplash("Retrieving edition data");
					
                    GetPDFInfo();
                    break;
                case 3:
                    //lblpagepath = "/media/internal/" + lbleditionguid + "pages.xml";
                    UpdateSplash("Retrieving page data");
                    pnlLoader.update("");
                    GetPageInfo();
                    break;
                case 4:
                    var st  = "" + inResponse.ticket;
                    localStorage.setItem(st, pagestore.data.items[downloaditem - 1].data['pageguid']) ;
                    localStorage.setItem(pagestore.data.items[downloaditem - 1].data['pageguid'], inResponse.ticket) ;
                    console.log("Storing data for " + st);
                    var pagedata = "";
                    if (localStorage.getItem(lbleditionguid))
                    {
                        pagedata = localStorage.getItem(lbleditionguid);
                    }
                    if (pagedata == "")
                    {
                        pagedata = inResponse.ticket;
                    }
                    else
                    {
                        pagedata += "," + inResponse.ticket;
                    }
                    localStorage.setItem(lbleditionguid, pagedata);
						
                    if (downloaditem < downloadcount)
                    {
                        console.log("Downloading page " + (downloaditem + 1) + " " + pagestore.data.items[downloaditem].data['pageguid']);
                        pnlLoader.update("<div style = 'width:120px;float:left'><img src = 'http://edition.pagesuite-professional.co.uk/get_image.aspx?h=120&eid=" + lbleditionguid + "&PNUM=" + (downloaditem + 1)  + "'></div>&nbsp;&nbsp;<div style = 'float:left'><br><br>Downloading Page " + (downloaditem + 1) + " of " + downloadcount + "</div><div style = 'clear:both'></div>");
                        HPApp.$.downloader.call({
                            target: "http://pages.mobile.cdn.pagesuite.com/images/" + pagestore.data.items[downloaditem].data['pageguid'] + "/full.jpg",
                            targetDir : offlineprepath,
                            targetFilename : pagestore.data.items[downloaditem].data['pageguid'] + ".jpg",
                            keepFilenameOnRedirect: true
                        });
						
                        downloaditem++;
                    }
                    else
                    {
                        pnlLoader.update("<div style = 'width:200px;float:left'></div>&nbsp;&nbsp;<div style = 'float:left'>Download Finished</div><div style = 'clear:both'></div>");
					
                        downloadaction = 6;
                        HPApp.$.downloader.call({
                            target: "http://edition.pagesuite-professional.co.uk/get_image.aspx?h=140&eid=" + lbleditionguid + "&pnum=1&c=50",
                            targetDir : offlineprepath,
                            targetFilename : lbleditionguid + "_c.jpg",
                            keepFilenameOnRedirect: true
                        });
                        DownloadFinished("Success");
                        startdownloading = false;
						
						
                    }
						
                    break;
                case 5:
                    localStorage.setItem(pagestore.data.items[downloaditem].data['pageguid'], inResponse.ticket) ;
                    downloadaction = 7;
                    HPApp.$.downloader.call({
                        target: "http://edition.pagesuite-professional.co.uk/get_image.aspx?h=140&eid=" + lbleditionguid + "&pnum=" + (downloaditem + 1) + "&c=50",
                        targetDir : offlineprepath,
                        targetFilename : lbleditionguid + "_p" + (downloaditem + 1) + "_c.jpg",
                        keepFilenameOnRedirect: true
                    });
                    console.log("Downloaded Page");
                    startdownloading = false;
						
                    break;
                case 6:
                    storesavededitions.add({
                        EditionGUID: downloadlbleditionguid,
                        Name: downloadlblname,
                        Pages: downloadnopages
                    });
                    storesavededitions.sync();
                    DownloadFinished("Success");
                    startdownloading = false;
                    console.log("Got saved image");
                    break;
                case 7:
                    storesavedpages.add({
                        EditionGUID: lbleditionguid,
                        PageGUID: pagestore.data.items[downloaditem].data['pageguid'],
                        Name: lblname,
                        PartOfEdition : "No",
                        Page: (downloaditem + 1),
                        Pages: nopages
                    });
                    storesavedpages.sync();
                    var isdone = true;
                    if (dontdownloadagain == false)
                    {
                        if (islandscape())
                        {
                            var realpageno = downloaditem + 1;
                            if (realpageno > 1 && realpageno < nopages)
                            {
                                console.log("In criteria");
                                dontdownloadagain = true;
                                if ((realpageno % 2) > 0)
                                {
                                    downloaditem = downloaditem - 1;
                                }
                                else
                                {
                                    downloaditem = downloaditem + 1;
                                }
								
                                if (!localStorage.getItem(pagestore.data.items[downloaditem].data['pageguid']))
                                {
                                    console.log("Page not downloaded");
                                    downloadaction = 5;
                                    HPApp.$.downloader.call({
                                        target: "http://pages.mobile.cdn.pagesuite.com/images/" + pagestore.data.items[downloaditem].data['pageguid'] + "/full.jpg",
                                        targetDir : offlineprepath,
                                        targetFilename : pagestore.data.items[downloaditem].data['pageguid'] + ".jpg",
                                        keepFilenameOnRedirect: true
                                    });
									
                                    localStorage.setItem(pagestore.data.items[downloaditem].data['pageguid'], pagestore.data.items[downloaditem].data['pageguid']);
                                    isdone = false;
                                }
                                else
                                {
                                    console.log("Page already downloaded");
                                    dontdownloadagain = false;
									
                                }
								
								
                            }
                        }
                    }
                    else
                    {
                        dontdownloadagain = false;
						
                    }
					
                    if (isdone)
                    {
                        DownloadFinished("Success");
                        startdownloading = false;
                        console.log("Got saved image");
                    }
                    break;
            }
			
        }
			
    }
});

function stringToBoolean(string){
    switch(string.toLowerCase()){
        case "true": case "yes": case "1":
            return true;
        case "false": case "no": case "0": case null:
            return false;
        default:
            return Boolean(string);
    }
}