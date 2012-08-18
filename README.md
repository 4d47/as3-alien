
as3-alien
=========

![An AS3 Monster for going external](http://mathieu.gagnon.name/random/alien.jpg)

" This hack is beyond external, it's alien "

`alien.ExternalInterface2` is just like `flash.external.ExternalInterface`
except arguments can be `Function` that will be called back.

    ExternalInterface2.call("window.setInterval", onSetInterval, 3000);

`alien.FBProxy`, a thin `flash.utils.Proxy` using ExternalInterface2 that makes
you feel like directly using the Facebook JavaScript SDK from ActionScript.

    var FB:FBProxy = new FBProxy();

    FB.api('me', function(data:Object):void {
        // ...
    });

