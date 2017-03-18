var editions = Ext.regModel('editions', {
	fields: [
		   { name: 'editionguid', mapping: '@editionguid', type: 'string' },
		   { name: 'name', mapping: '@name', type: 'string' },
		   { name: 'pages', mapping: '@pages', type: 'string' }
		   
	   ]
});

var modpageinfo = Ext.regModel('pageinfo', {
	fields: [
		   { name: 'pageguid', mapping: '@pageguid', type: 'string' },
		   { name: 'editionpageguid', mapping: '@editionpageguid', type: 'string' },
		   { name: 'number', mapping: '@number', type: 'string' }
		   
	   ]
});

var modlinkinfo = Ext.regModel('linkinfo', {
	fields: [
		   { name: 'url', mapping: '@url', type: 'string' },
		   { name: 'desc', mapping: '@desc', type: 'string' },
		   { name: 'x', mapping: '@x', type: 'string' },
		   { name: 'y', mapping: '@y', type: 'string' },
		   { name: 'w', mapping: '@w', type: 'string' },
		   { name: 'h', mapping: '@h', type: 'string' },
		   { name: 'page', mapping: '@page', type: 'string' }
		   
		  
	   ]
});



var modsearchinfo = Ext.regModel('searchinfo', {
	fields: [
		   { name: 'pnum', mapping: '@pnum', type: 'string' },
		   { name: 'eid', mapping: '@eid', type: 'string' },
		   { name: 'name', mapping: '@name', type: 'string' },
		   { name: 'result',mapping: '#', type: 'string' }
		   
	   ]
});

var modpdfinfo = Ext.regModel('pdfinfo', {
	fields: [
		   { name: 'width', type: 'string' },
		   { name: 'height', type: 'string' },
		   { name: 'ratio', type: 'string' }
		    
	   ]
});

Ext.regModel('EditionStructure', { 
    fields: [
        {name: 'id', type: 'int' },
        {name: 'EditionGUID', type: 'string' },
        {name: 'PageGUID', type: 'string' },
        {name: 'Name', type: 'string' },
        {name: 'PartOfEdition', type: 'string' },
		{name: 'Page', type: 'int' },
		{name: 'Pages', type: 'int' }
		
	]
});


Ext.regModel('Options', {
            fields: ['Name']
        });
        
        Ext.regModel('OptionsOnline', {
            fields: ['Name']
        });

var storesavededitions = new Ext.data.Store({ 

        model: "EditionStructure",
        storeId: "EditionStore",
        proxy: {
            type: "localstorage",
            id: "editionstorage"            
        }
		,
		listeners:
		{
			remove : function( s,r,i )
			{
				var pages = localStorage.getItem(r.get('EditionGUID')).split(",");
				for(i = 0; i < pages.length; i++){
					if (targetos == "hp")
					{
						HPApp.$.deleteDownloadFile.call({ticket: pages[i]});
					}
					else
					{
					window.plugins.downloader.deleteFile("", pages[i],
					function(data)
					{
						
					},
					function(data)
					{
						
					}
					);
					}
					var pageguid = localStorage.getItem(pages[i]);
					localStorage.removeItem(pageguid);
					localStorage.removeItem(pages[i]);
					
					
				}
				localStorage.removeItem(r.get('EditionGUID'));
				this.sync();
				
				//HPApp.$.deleteDownloadFile.call({ticket: localStorage.getItem(r.get('PageGUID'))});
				//console.log("Record deleted at " + i);
				//localStorage.removeItem(r.get('PageGUID'));
				//console.log(r.get('PageGUID'));
				//this.sync();
				
			}					
		}
    });
storesavededitions.read();

var storesavedpages = new Ext.data.Store({ 

        model: "EditionStructure",
        storeId: "PageStore",
        proxy: {
            type: "localstorage",
            id: "pagestorage"            
        },
		listeners:
		{
			remove : function( s,r,i )
			{
				if (targetos == "hp")
				{
					HPApp.$.deleteDownloadFile.call({ticket: localStorage.getItem(r.get('PageGUID'))});
				}
				else
				{
					window.plugins.downloader.deleteFile("", localStorage.getItem(r.get('PageGUID')),
					function(data)
					{
						
					},
					function(data)
					{
						
					}
					);
				}
				console.log("Record deleted at " + i);
				localStorage.removeItem(r.get('PageGUID'));
				console.log(r.get('PageGUID'));
				this.sync();
				
			}					
		}
    });
storesavedpages.read();
console.log("There are " + storesavedpages.getCount() + " stored pages");