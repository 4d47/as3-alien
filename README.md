
as3-alien
=========

" This hack is beyond external, it's alien "

`alien.ExternalInterface2` is just like `flash.external.ExternalInterface`
except arguments can be `Function` that will be called back.

    ExternalInterface2.call("window.setInterval", onSetInterval, 3000);

`alien.FBProxy`, a thin `flash.utils.Proxy` using ExternalInterface2 that makes
you feel like directly using the Facebook JavaScript SDK from ActionScript.

    // instanciate the proxy, loading javascript sdk in the page
    private var FB:FBProxy = new FBProxy(onInit);

    // javascript is ready, using it thru as3
    private function onInit():void {
        FB.api('me', function():void {
            // ...
        });
    }

