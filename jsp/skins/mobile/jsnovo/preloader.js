 var createXMLDoc = function(xmlString)  
{ 	
	        var parser = new DOMParser(); 
            xmlDocument = parser.parseFromString(xmlString,"text/xml"); 
            
            return xmlDocument; 
};

function geteditioninfo(datas) 
{
	UpdateSplash("Retrieving publication data");
	if (targetos == "android")
	{
		AndroidFinished(0);
	}
	console.log(datas);
	if (offlineprepath != "" && hasdownloaded == false)
	{
		console.log("Downloading");
			
		hasdownloaded = true;
		downloadaction = 1;
		 
		if (targetos == "HP")
		{
			console.log("Downloading " + serverprefix + "Editions.aspx?maxnumber=10000&publicationguid=" + pubguid);
			
			HPApp.$.downloader.call({
			target: serverprefix + "Editions.aspx?maxnumber=20&publicationguid=" + pubguid,
			targetDir : offlineprepath,
			targetFilename : "listeditions" + pubguid + ".xml",
			keepFilenameOnRedirect: true
			});
		}
		else
		{
			var urlpath = serverprefix + "Editions.aspx?publicationguid=" + pubguid;
			urlpath = "http://pages.mobile.cdn.pagesuite.com/xml/7ff1ad33-24fb-4fc8-a0e6-702245111df7_editions.xml";
			
			window.plugins.downloader.downloadFile(urlpath,"pagesuite/apps/" + lblpubname + "/","listeditions" + pubguid + ".xml", true,
	 		function(data)
	 		{
				tempxml = data;
	 			AndroidFinished(1);
			},
			function(data)
			{ 
				tempxml = data;
	 			AndroidFinished(1);
	 		});
			
		}
	
	}
	else
	{
		hasdownloaded = false;
		var datas;
		
		if (offlineprepath != "" && targetos != "HP")
		{
			datas = createXMLDoc(tempxml);
			
			
		}
		else if (offlineprepath != "" && targetos == "HP")
		{
			editionspath = offlineprepath + "listeditions" + pubguid + ".xml"
		}
		else
		{
			editionpath = serverprefix + "editions.aspx?maxnumber=10000&publicationguid=[GUID]";
			editionspath = editionpath;
			editionspath = editionspath.replace('[GUID]', pubguid);
		}
		console.log(editionspath);
		editionstore = new Ext.data.Store({
		model: 'editions',
		listeners: {
			datachanged: function (thiss) 
			{
				if (!ignoreinitofedition)
				{
					lbleditionguid = this.data.items[0].data['editionguid'];
					lblname = this.data.items[0].data['name'];
					lblpages = this.data.items[0].data['pages'];
					nopages = parseInt(this.data.items[0].data['pages']);
				}
				ignoreinitofedition = false;
				lbleditions = "";
				eids = "";
				thiss.data.each(function() 
				{
					
					lbleditions += this.data['editionguid'].replace(new RegExp("-", "g"), "_") + ":" + this.data['name'] + ":" + this.data['pages'] + ";"
					if (eids != "")
					{
						eids += "|" + this.data['editionguid'];
					}
					else
					{
						eids = this.data['editionguid'];
					}
					
					
				});
				
				if (targetos == "android")
					{
					if (!hasinitarchive)
					{
						
						window.plugins.downloader.downloadeditionthumbnails(lbleditionguid, "pagesuite/apps/" + lblpubname + "/", eids,
						function(data)
						{	
							readytoshowarchive = data;
							if (editionguid != null)
							{
								if (data == "Offline")
								{
									setTimeout("PopulateArchive()",1200);
								}
								else
								{
									setTimeout("PopulateArchivelive()",1200);
								} 
							}
							
						},
						function(data)
						{ 
							readytoshowarchive = "Offline";
							if (editionguid != null)
							{
								if (data == "Offline")
								{
									setTimeout("PopulateArchive()",1200);
								}
								else
								{
									setTimeout("PopulateArchivelive()",1200);
								} 
							}
							
						});
						
						hasinitarchive = true;
					}
					}
					else if (targetos == "test")
					{
						readytoshowarchive = "Online";
						if (editionguid != null)
						{
							if (!hasinitarchive)
							{
								setTimeout("PopulateArchivelive()",1200);
							}
						
							hasinitarchive = true;
						}
					}
				
				
				GetPDFInfo();
				
			}
		},
		proxy: {
			type: (offlineprepath != '') ? ((targetos == 'HP') ? 'ajax' : 'memory') : 'ajax',
			url: (offlineprepath != '') ? ((targetos == 'HP') ? editionspath : null) : ((targetos == 'test') ? 'http://pages.mobile.cdn.pagesuite.com/xml/7ff1ad33-24fb-4fc8-a0e6-702245111df7_editions.xml' : editionspath),
			data: (offlineprepath != '') ? ((targetos == 'HP') ? null : datas) : null,
			reader: new Ext.data.XmlReader({
				type: 'ajax',
				root: 'editions',
				record: 'edition'
			})
		}
		});
		editionstore.load();
			
		
		
	}
	
		
}

var LoadArchive = function(num)
{
	var itemnum = 0;
	if (supportstabpanel)
	{
		if (hashomebutton)
		{
			pnlMain.setActiveItem(2);
		}
		else
		{
			pnlMain.setActiveItem(1);
		}
	}
	else
	{
		if (hashomebutton)
							{
								segButtons.setPressed(2);
							}
							else
							{
								segButtons.setPressed(1);
							}
							if (pnlArchive != null)
								pnlArchive.hide();
							OpenReader();
	}
	editionstore.data.each(function() 
	{
		if (itemnum == num)
		{
			if (lbleditionguid == this.data['editionguid'])
			{
				if (pageno != 1)
				{
					pageno = 0;
					nextpageno = 1;
					cache1pageno = -1;
					cache2pageno = -1;
					cache3pageno = -1;
					carind1 = -1;
					carind2 = -1;
					carind3 = -1;
					SetPageNo(1);
				}
			}
			else
			{
				lbleditionguid = this.data['editionguid'];
				lblname = this.data['name'];
				nextpageno = 1;
				lblpages = this.data['pages'];
				nopages = this.data['pages'];
				changingarchive = true;
				OpenDownloadedEdition();
				isfromdownload = true;
			}
		}
		itemnum++;
	});
																
}

var GetPDFInfo = function()
{
	UpdateSplash("Retrieving edition data");
	if (offlineprepath != "" && hasdownloaded == false)
	{
		hasdownloaded = true;
		downloadaction = 2;
		
		
		if (targetos == "HP")
		{
			console.log("Downloading " + serverprefix + "p.aspx?eid=" + lbleditionguid + "&pnum=1 to " + lbleditionguid + ".xml");
			HPApp.$.downloader.call({
			target: serverprefix + "p.aspx?eid=" + lbleditionguid + "&pnum=1",
			targetDir : offlineprepath,
			targetFilename : lbleditionguid + ".xml",
			keepFilenameOnRedirect: true
			});
		}
		else
		{
			window.plugins.downloader.downloadFile(serverprefix + "p.aspx?eid=" + lbleditionguid + "&pnum=1","pagesuite/apps/" + lblpubname + "/",lbleditionguid + ".xml", false,
	 		function(data)
	 		{	
	 			tempxml = data;
	 			AndroidFinished(2);
			},
			function(data)
			{ 
				tempxml = data;
	 		 	AndroidFinished(2);
	 		});
		}
		
		
	}
	else
	{
		hasdownloaded = false;
		var dimensionpath;
		var datas;
		
		if (offlineprepath != "")
		{
			dimensionpath = offlineprepath + lbleditionguid + ".xml";
			if (targetos != "HP")
			{
				datas = createXMLDoc(tempxml);
			}
		}
		else
		{
			dimensionpath = serverprefix + "p.aspx?eid=" + lbleditionguid;
			console.log(dimensionpath);
		}
		console.log(dimensionpath);
			pdfstore = new Ext.data.XmlStore({
            model: 'pdfinfo',
            listeners: {
        		datachanged: function (thiss) 
        		{
        			lblpagewidth = this.data.items[0].data['width'];
        			lblpageheight = this.data.items[0].data['height'];
        			lblpageratio = this.data.items[0].data['ratio'];
					
					GetLinks();
					
        			
    			}
    		},
            proxy: {
                type: (offlineprepath != '') ? ((targetos == 'HP') ? 'ajax' : 'memory') : 'ajax',
				url: (offlineprepath != '') ? ((targetos == 'HP') ? dimensionpath : null) : dimensionpath,
				data: (offlineprepath != '') ? ((targetos == 'HP') ? null : datas) : null,
                reader: new Ext.data.XmlReader({
                    type: 'xml',
                    record: 'dimensions'
                })
            }
        	});
			
        	
        pdfstore.load();
		
	}
	
	
}

var startdownload = function()
{
	if (startdownloading)
	{
		DownloadFinished("Already");
	}
	else
	{
		startdownloading = true;
		
		
		var foundit = false;
		var textbit = "<p>This edition will appear in your downloads section.</p>";
		storesavedpages.data.each(function() 
		{
			if (this.data['editionguid'] == lbleditionguid)
			{
				foundit = true;
				textbit = "This has already been downloaded";
			}			
        			
        });
		
		
		downloadlbleditionguid = lbleditionguid;
		downloadlblname = lblname;
		downloadnopages = nopages;
		popup = new Ext.Panel({
						floating: true,
						centered: true,
						width: 240,
						height: 165,
						styleHtmlContent: true,
						scroll: 'vertical',
						html: textbit,
						dockedItems: [{
							dock: 'top',
							xtype: 'toolbar',
							title: 'Downloading.....'
						}],
						listeners:
						{
							afterrender: function (s)
							{
								timeoutpopup=setTimeout("KillPopup()",1500);
								
							},
							afterhide: function (s) { s.destroy();s=null; }
						}
					});
			popup.show('pop');
		if (!foundit)
		{
			if (targetos == "HP")
			{
				downloadaction = 4;
				downloaditem = 0;
				downloadcount = nopages;
				HPApp.$.downloader.call({
								target: "http://pages.mobile.cdn.pagesuite.com/images/" + pagestore.data.items[downloaditem].data['pageguid'] + "/full.jpg",
								targetDir : offlineprepath,
								targetFilename : pagestore.data.items[downloaditem].data['pageguid'] + ".jpg",
								keepFilenameOnRedirect: true
							});
							downloaditem++;
				//pnlHome.hide();
				console.log("Downloading");
			}
			else
			{
				downloadaction = 4;
				downloaditem = 0;
				downloadcount = nopages;
				DownloadOfflineDroid();
				
			}
		}
		else
		{
			startdownloading = false;
		}
	}
	
}

var ShowDownloads = function()
{
	if (pnlHome != null)
				pnlHome.hide();
			if (pnlPaper != null)
				pnlPaper.hide();
			if (pnlDownloads != null)
				pnlDownloads.hide();
			if (pnlSettings != null)
				pnlSettings.hide();
	pnlDownloads.show();
	ShowEditions();
}


var GetLinks = function()
{
	UpdateSplash("Retrieving links data");
	var linkpath = serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=link";
	if (offlineprepath != "" && hasdownloaded == false)
	{
		hasdownloaded = true;
		downloadaction = 5;
		
		 
		if (targetos == "HP")
		{
			HPApp.$.downloader.call({
			target: serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=link",
			targetDir : offlineprepath,
			targetFilename : lbleditionguid + "links.xml",
			keepFilenameOnRedirect: true
			});
		}
		else
		{
			window.plugins.downloader.downloadFile(serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=link","pagesuite/apps/" + lblpubname + "/",lbleditionguid + "links.xml", false,
	 		function(data)
	 		{	
				tempxml = data;
	 			AndroidFinished(5);
			},
			function(data)
			{ 
				tempxml = data;
	 		 	AndroidFinished(5);
	 		});
		}
		
		
	}
	else
	{
		hasdownloaded = false;
		var dimensionpath;
		var datas;
		
		if (offlineprepath != "")
		{
			linkpath = offlineprepath + lbleditionguid + "links.xml";
			if (targetos != "HP")
			{
				datas = createXMLDoc(tempxml);
			}
		}
		else
		{
			linkpath = serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=link";
			console.log(linkpath);
		}
			linkstore = new Ext.data.XmlStore({
            model: 'linkinfo',
            listeners: {
        		datachanged: function (thiss) 
        		{
					GetVideoLinks();
					
        			
    			}
    		},
            proxy: {
                type: (offlineprepath != '') ? ((targetos == 'HP') ? 'ajax' : 'memory') : 'ajax',
				url: (offlineprepath != '') ? ((targetos == 'HP') ? linkpath : null) : linkpath,
				data: (offlineprepath != '') ? ((targetos == 'HP') ? null : datas) : null,
                reader: new Ext.data.XmlReader({
                    type: 'xml',
                    record: 'link'
                })
            }
        	});
			
        	
        linkstore.load();
		
	}
}

var GetVideoLinks = function()
{
	UpdateSplash("Retrieving video links data");
	var linkpath = serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=video";
	if (offlineprepath != "" && hasdownloaded == false)
	{
		hasdownloaded = true;
		downloadaction = 6;
		
		
		if (targetos == "HP")
		{
			HPApp.$.downloader.call({
			target: serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=video",
			targetDir : offlineprepath,
			targetFilename : lbleditionguid + "video.xml",
			keepFilenameOnRedirect: true
			});
		}
		else
		{
			window.plugins.downloader.downloadFile(serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=video","pagesuite/apps/" + lblpubname + "/",lbleditionguid + "video.xml", false,
	 		function(data)
	 		{	
				tempxml = data;
	 			AndroidFinished(6);
			},
			function(data)
			{ 
				tempxml = data;
	 		 	AndroidFinished(6);
	 		});
		}
		
		
	}
	else
	{
		hasdownloaded = false;
		var dimensionpath;
		var datas; 
		if (offlineprepath != "")
		{
			linkpath = offlineprepath + lbleditionguid + "video.xml";
			if (targetos != "HP")
			{
				datas = createXMLDoc(tempxml);
			}
		}
		else
		{
			linkpath = serverprefix + "links.aspx?eid=" + lbleditionguid + "&type=video";
			console.log(linkpath);
		}
			videostore = new Ext.data.XmlStore({
            model: 'linkinfo',
            listeners: {
        		datachanged: function (thiss) 
        		{
					GetPageInfo();
					
        			
    			}
    		},
            proxy: {
                type: (offlineprepath != '') ? ((targetos == 'HP') ? 'ajax' : 'memory') : 'ajax',
				url: (offlineprepath != '') ? ((targetos == 'HP') ? linkpath : null) : linkpath,
				data: (offlineprepath != '') ? ((targetos == 'HP') ? null : datas) : null,
                reader: new Ext.data.XmlReader({
                    type: 'xml',
                    record: 'video'
                })
            }
        	});
			
        	
        videostore.load();
		
	}
}

var GetPageInfo = function()
{
	UpdateSplash("Retrieving page data");
	if (offlineprepath != "" && hasdownloaded == false)
	{
		hasdownloaded = true;
		downloadaction = 3;
		
		
		if (targetos == "HP")
		{
			HPApp.$.downloader.call({
			target: serverprefix + "list_pages.aspx?id=" + lbleditionguid,
			targetDir : offlineprepath,
			targetFilename : lbleditionguid + "pages.xml",
			keepFilenameOnRedirect: true
	});
		}
		else
		{
				
			window.plugins.downloader.downloadFile(serverprefix + "list_pages.aspx?id=" + lbleditionguid,"pagesuite/apps/" + lblpubname + "/",lbleditionguid + "pages.xml", false,
	 		function(data)
	 		{	
	 			tempxml = data;
	 			AndroidFinished(3);
			},
			function(data)
			{ 
				tempxml = data;
	 		 	AndroidFinished(3);
	 		});
		}

		
	}
	else
	{
		hasdownloaded = false;
		
		var pagepath;
		
		if (offlineprepath != "")
		{
			pagepath = offlineprepath + lbleditionguid + "pages.xml";
			datas = createXMLDoc(tempxml);
			
		}
		else
		{
			pagepath = serverprefix + "list_pages.aspx?id=" + lbleditionguid;
		}
		
	    
		pagestore = new Ext.data.XmlStore({
            model: 'pageinfo',
            listeners: {
        		datachanged: function (thiss) 
        		{
					hasinitilised = true;
					
					  
					archivecontainer = "";
					archivecontainerlive = "";
					var bigheight = heightofpanel;
					var bigwidth = pnlMain.getWidth();
					var percentage = 127 / bigheight;
					var smallwidth = GetWidth() * percentage;
					smallwidth = (Math.floor(smallwidth) * devicemultiple);
					console.log(smallwidth);
					totalarchiveheight = 0;
					var totalwidth = 20;
					var itemnum = 0;
					editionstore.data.each(function() 
					{
						if ((((totalwidth + (smallwidth + 20)) * 1) + smallwidth) > (pnlMain.getWidth()  * devicemultiple))
						{
							totalarchiveheight += 195;
							totalwidth = 20;
							
						} 
						archivecontainer += "<span style = 'color:gray;text-weight:bold;text-align:center;position:absolute;top:" + (totalarchiveheight + 0) + "px;left:" + totalwidth + "px'>" + this.data['name'] + "</span><img onclick = 'LoadArchive(" + itemnum + ")' style = 'width:" + smallwidth + "px;position:absolute;top:" + (totalarchiveheight + 25) + "px;left:" + totalwidth + "px' src = '" + offlineprepath + this.data['editionguid'] + ".jpg'>&nbsp;&nbsp;&nbsp;&nbsp;";
						archivecontainerlive += "<span style = 'color:gray;text-weight:bold;text-align:center;position:absolute;top:" + (totalarchiveheight + 0) + "px;left:" + totalwidth + "px'>" + this.data['name'] + "</span><img onclick = 'LoadArchive(" + itemnum + ")' style = 'position:absolute;top:" + (totalarchiveheight + 25) + "px;left:" + totalwidth + "px' src = 'http://edition.pagesuite-professional.co.uk/get_image.aspx?w=" + parseInt(smallwidth) + "&eid=" + this.data['editionguid'] + "'>&nbsp;&nbsp;&nbsp;&nbsp;";
						
							
						 
						
						totalwidth += smallwidth + 15;
						itemnum++;
						
					});
					totalarchiveheight += 215;
					if (readytoshowarchive != "")
					{
						
						if (readytoshowarchive == "Offline")
						{
							setTimeout("PopulateArchive()",100);
						}
						else
						{
							setTimeout("PopulateArchivelive()",100);
						} 
					}
        			editionguid = lbleditionguid;
					if (showarchive)
					{
						infopanel.destroy();
						pnlArchive.show();
						
						if (supportstabpanel)
						{
							if (hashomebutton)
							{
								pnlMain.setActiveItem(1);
							}
							else
							{
								pnlMain.setActiveItem(0);
							}
						}
						else
						{
							if (hashomebutton)
							{
								segButtons.setPressed(1);
							}
							else
							{
								segButtons.setPressed(0);
							}
							
						}
						showarchive = false;
							
						
					}
					else
					{
						if (changingarchive)
						{
							changingarchive = false;
							infopanel.destroy();
							if (nextpageno > 0)
							{
								SetPageNo(nextpageno);
								
							
							}
							else 
							{
								SetPageNo(1);
								
							}
							nextpageno = 0;
							
							if (isfromdownload)
							{
								if (hascreatedreader)
									DisplayReader();
								else
									CreateReader();
							}
							isfromdownload = false;
							carouselpart.layout.next({ type: "slide" }, true);
							
						}
						else
						{
							infopanel.destroy();
							if (shoulddownload)
							{
								shoulddownload = false;
								startdownload();
								setTimeout("ShowDownloads()",20);
								
							}
							else
							{
								if (hascreatedreader)
								{
									DisplayReader();
									cache1pageno = -1;
									cache2pageno = -1;
									cache3pageno = -1;
									carind1 = -1;
									carind2 = -1;
									carind3 = -1;
									pageno=1;
									SetPageNo(1);
								}
								else
									CreateReader();
							}
						}
						}
					
    				
        		}
    		},
            proxy: {
                type: (offlineprepath != '') ? ((targetos == 'HP') ? 'ajax' : 'memory') : 'ajax',
				url: (offlineprepath != '') ? ((targetos == 'HP') ? pagepath : null) : pagepath,
				data: (offlineprepath != '') ? datas : null,
               
                
                reader: new Ext.data.XmlReader({
                    type: 'xml',
                    root: 'pages',
                    record: 'page'
                })
            }
        });
		pagestore.load();
		
	}
	
	
}
