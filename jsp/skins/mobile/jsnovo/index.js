function init() 
{
	
    document.addEventListener("deviceready", SetupSystem, true);
    document.addEventListener("searchbutton", OpenSearch, false);
	
}



var OpenReader = function()
{
			
    if (hasinitilised == false)
    {
        LaunchSplashPanel();
        geteditioninfo("2");
    }
    else
    {
        if (targetos == 'android')
            window.plugins.downloader.autorotate(function(data){},function(data){});
        if (hascreatedreader)
            DisplayReader();
        else
            CreateReader();
    }
};
		
var LaunchSplashPanel = function()
{ 
	
    infopanel = new Ext.Panel({
        floating: true,
        modal: true,
        height: 120,
        centered: true,
        width: 320,
        html: "Launching",
        ui: 'dark',
        hideOnMaskTap: false

    });
    infopanel.show();
}

var InitHP = function()
{
    HPApp = new App();
}

var UpdateSplash = function(message)
{
    infopanel.update("<br><br><span style = 'padding-left:20px'>" + message + "</span>");
}

var imback = function()
{
    //console.log("closing");
	
}


var subwindow;

var SetupSystem = function()
{
    Ext.setup({
        tabletStartupScreen: 'tablet_startup.png',
        phoneStartupScreen: 'phone_startup.png',
        icon: 'icon.png',
        glossOnIcon: false,

        onReady: function()
        {
            videoscontainer = new Ext.Container
            ();
		
            var pnlSubs = new Ext.Panel(
            {
                id : 'Subscriber',
                html: 'Going here',
                title : 'Paper',
                fullscreen: false,
                hidden: true
            });
			
            if (targetos == "HP")
            {
				
            }
            else
            {
                SetupSystemReady();
            }
		
        }
	
    });
	
}
var SetupSystemReady = function()
{
    if (targetos == 'android')
    {
        viewport = document.querySelector("meta[name=viewport]");
        viewport.setAttribute('content', 'initial-scale=1.0, width=device-width, target-densitydpi=device-dpi,maximum-scale=1.0, user-scalable=no');
		
    }
	


	
    Ext.is.platforms.push({
        property: 'userAgent',
        regex: /(?=.*android)(?=.*mobile)/i,
        identity: 'AndroidPhone'
    },
    {
        property: 'userAgent',
        regex: /playbook/i,
        identity: 'Playbook'
    });

	
    Ext.is.init();
    Ext.is.AndroidTablet = Ext.is.Android && (!Ext.is.AndroidPhone);
    Ext.is.Tablet = Ext.is.iPad ||(Ext.is.Android && !Ext.is.AndroidPhone) || Ext.is.Playbook;

    if (targetos != '')
    {
        pnlDownloads = new Ext.Panel(
        {
            id : 'Downloads',
            title: 'Downloads',
            hidden: true,
            iconCls: 'download',
            cls: 'card3',
            html: '&nbsp;',
            dockedItems: [toolDownload],
            fullscreen: true,
            items: [pnlLoader,segmentedButton],
            afterrender: function (s)
            {
				
            }
			
        });
    	
        optionsstore = new Ext.data.JsonStore({
            model  : 'Options',
            data: [
            {
                Name: 'Download this edition'
            },

            {
                Name: 'Download this page'
            },

            {
                Name: 'Search'
            },
            (targetos == 'android') ? {
                Name : 'Share'
            } : null
		
		
            ]
        });

        pnlSettings = new Ext.Panel(
        {
            fullscreen:true,
            title: 'Settings',
            iconCls: 'settings',
            cls: 'card4',
            dockedItems: [toolSettings],
            id : 'Settings',
            hidden: true,
            items:[
            mainContainer
            ]
        });
		
    }

    onlineoptionsstore = new Ext.data.JsonStore({
        model  : 'OptionsOnline',
        data: [
        {
            Name: 'Email link'
        },

        {
            Name: 'Download this edition'
        }
		
        ]
    });

       
    var OpenHome = function()
    {
        pnlHome.show();
    };
	
		
    var OpenDownloads = function()
    {
        //storesavededitions.add({ EditionGUID: "ss", Name: "sdfdsfds" });
        //storesavededitions.add({ EditionGUID: "sdsdfs", Name: "sdfdsfdsdfds" });
        storesavededitions.sync();
        //console.log(storesavededitions.getCount());
        pnlDownloads.show();
        if (buttonindex == 0)
        {
            setTimeout("ShowEditions()",10);
        }
        else
        {
            setTimeout("ShowPages()",10);
        }
			
			
    //();
			
    };
		
    var OpenSettings = function()
    {
        pnlSettings.show();
    };
		
    var OpenArchive = function()
    {
			
        pnlArchive.show();
			
			
			
    };
		
    var tapHandler = function(button, event) {
        if (pnlH != null)
            pnlH.hide();
        if (pnlArchive != null)
            pnlArchive.hide();
        if (pnlPaper != null)
            pnlPaper.hide();
        if (pnlDownloads != null)
            pnlDownloads.hide();
        if (pnlSettings != null)
            pnlSettings.hide();
        switch (button.text)
        {
            case "Home":
                OpenHome();
                break;
            case "Archive":
                OpenArchive();
                break;
            case "Reader":
                OpenReader();
                break;
            case "Downloads":
                OpenDownloads();
                break;
            case "Settings":
                OpenSettings();
                break;
        }
			
        var txt = "User tapped the '" + button.text + "' button.";
        pnlMain.doLayout();
            
    };
		
    segButtons  = new Ext.SegmentedButton({
        xtype: 'segmentedbutton',
        items: [{
            text: 'Archive',
            handler: tapHandler
        }, {
            text: 'Reader',
            handler: tapHandler
        }, {
            text: 'Downloads',
            handler: tapHandler
        }, {
            text: 'Settings',
            handler: tapHandler
        }]
    });
		
		

       
    var pnlH = new Ext.Panel(
    {
        id : 'Home',
        html: '',
        hidden: false,
        pressed: true,
        title: 'Home',
        iconCls: 'home'
    })
        
           
    // Phone has far less screen real-estate
        

    pnlPaper = new Ext.Panel(
    {
        id : 'Paper',
        html: '',
        hidden: true,
        title: 'Paper',
        iconCls: 'paper'
    });
		

    if (targetos != "")
    {
			
        pnlMain = new ((supportstabpanel == false) ? Ext.Panel : Ext.TabPanel)
        ({
            id: 'toolbartxt',
            dockedItems: ((supportstabpanel == false) ? [{
                dock : 'bottom',
                xtype: 'toolbar',
                ui   : 'dark',
                items: [
                {
                    xtype: 'spacer'
                },
                segButtons,
                {
                    xtype: 'spacer'
                }
                ]
            }] : null),
            cardSwitchAnimation: false,
            html: '&nbsp;',
            ui        : 'dark',
            tabBar: {
                dock: 'bottom',
                style : 'font-size:' + fontsize + 'pt',
                layout: {
                    pack: 'center'
                }
			    
            },
            xtype: 'toolbar',
            items: [pnlArchive,pnlPaper,pnlDownloads,pnlSettings],
            fullscreen: true,
            listeners: {
					
                cardswitch : function (t,n,o,i,a)
                {
						
                    if (pnlPaper != null)
                        pnlPaper.hide();
                    if (pnlDownloads != null)
                        pnlDownloads.hide();
                    if (pnlSettings != null)
                        pnlSettings.hide();
                    if (pnlArchive != null)
                        pnlArchive.hide();
					
                    switch (i)
                    {
                        case 0:
                            if (targetos == 'android')
                                window.plugins.downloader.home(function(data){},function(data){});
								
                            break;
                        case 1:
                            if (targetos == 'android')
                                window.plugins.downloader.portrait(function(data){},function(data){});
                            OpenArchive();
                            break;
                        case 2:
                            if (targetos == 'android')
                                window.plugins.downloader.autorotate(function(data){},function(data){});
                            OpenReader();
                            break;
                        case 3:
                            if (targetos == 'android')
                                window.plugins.downloader.portrait(function(data){},function(data){});
                            OpenDownloads();
                            break;
                        case 4:
                            if (targetos == 'android')
                                window.plugins.downloader.portrait(function(data){},function(data){});
                            OpenSettings();
                            break;
								
                    }
						
                },
                afterrender: function (s)
                {
                    if (hashomebutton)
                    {
                        if (supportstabpanel)
                        {
                            s.insert(0, pnlH);
                        }
                        else
                        {
                            segButtons.insert(0, {
                                text: 'Home',
                                handler: tapHandler
                            });
                            segButtons.doLayout();
                        }
                    }
                    if (targetos != "")
                    {
                        if (targetos == "HP")
                        {
                            console.log("HP");
                        }
                        devicemultiple = window.devicePixelRatio;
                        heightofpanel = this.getHeight() - 90;
                        if (!supportstabpanel)
                        {
                            heightofpanel = heightofpanel - 40;
                        }
                        CreateHome();
                        showarchive = true;
                        LaunchSplashPanel();
                        geteditioninfo("4");
                        //OpenReader();
							
                        widths = this.getWidth();
                        resizehome();
                        downloadaction = 1;
							
                    }
                    else
                    {
                        devicemultiple = 1;
                        heightofpanel = this.getHeight() - 10;
                        offlineprepath = "";
                        widths = this.getWidth();
                        s.add(pnlPaper);
                        OpenReader();
                        window.plugins.downloader.autorotate(function(data){},function(data){});
                    }
						
						
                }
                    
            }
        });
    }
    else
    {
        pnlMain = new Ext.Panel({
            id: 'toolbartxt',
            html: '&nbsp;',
            fullscreen: true,
            listeners: {
                afterrender: function (s)
                {
                    devicemultiple = 1;
                    heightofpanel = this.getHeight() - 10;
                    offlineprepath = "";
                    widths = this.getWidth();
                    s.add(pnlPaper);
                    OpenReader();
                    if (targetos == "android")
                    {
                        window.plugins.downloader.autorotate(function(data){},function(data){});
                    }
                }
                    
            }
        });
    }
		
		
        
		
		 
    Ext.EventManager.onWindowResize(function () {
        if (disableresize == false)
        {
            if (timeouthome)
            {
                clearTimeout(timeouthome)
            }
            timeouthome=setTimeout("Resize()",1200);
        }
        else
        {
            if (listresults != null)
            {
                if (searchpanel != null)
                {
                    console.log("Setting height");
                    searchpanel.height = heights - 125;
                    listresults.height = searchpanel.height - 87;
                }
            }
        }
				
                
            

    });
		
}



function Resize()
{
    console.log("Resizing");
    if (targetos != "")
    {
        heightofpanel = pnlMain.getHeight() - 120;
        widths = pnlMain.getWidth();
    }
    else
    {
        heightofpanel = pnlMain.getHeight() - 60;
        widths = pnlMain.getWidth();
		
    }
    if (iszoomedin == false)
        resizereader();
}
  
function ReadLatest()
{
    if (startdownloading)
    {
        buttonsGroup2.setPressed(1);
        OpenReader();
		
    }
    else
    {
        buttonsGroup2.setPressed(1);
        LaunchSplashPanel();
        geteditioninfo("5");
    }
}

function OpenDownloadedEdition()
{
    if (hasinitilised == false)
    {
        LaunchSplashPanel();
        ;
        geteditioninfo("6");
    }
    else
    {
        ignorecardswitch = true;
        LaunchSplashPanel();
        ;
        GetPDFInfo();
        pageno = nextpageno;
        cache1pageno = -1;
        cache2pageno = -1;
        cache3pageno = -1;
        carind1 = -1;
        carind2 = -1;
        carind3 = -1;
    }
}

function DownloadLatest()
{
    buttonsGroup2.setPressed(2);
    if (hasinitilised == false)
    {
        LaunchSplashPanel();
        geteditioninfo("7");
        shoulddownload = true;
    }
    else
    {
        startdownload();
        pnlDownloads.show();
    }
	
	
	
}
