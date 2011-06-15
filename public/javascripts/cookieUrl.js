var cookieUrl;cookieUrl = $.cookie('cookieUrl');$.cookie('cookieUrl',window.location,{ expires: 2, path: '/'});if(document.referrer!=""){cookieUrl = document.referrer;
}$.cookie('preCookieUrl',cookieUrl,{ expires: 2, path: '/'});

