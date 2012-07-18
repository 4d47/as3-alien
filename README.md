
as3-alien
=========

" This is not ActionScript 3 "

`alien.ExternalInterface2`, just like `flash.external.ExternalInterface` but accepts Function in arguments.

    ExternalInterface2.call("window.setInterval", onSetInterval, 3000);

`alien.FBProxy`, a small `flash.utils.Proxy` to feel like directly using Facebook JavaScript SDK.

    // instanciate the proxy, loading javascript sdk in the page
    var FB:FBProxy = new FBProxy(onInit);

    // javascript is ready, using it thru as3
    private function onInit():void {
	FB.api('me', function():void {
	    // ...
	});
    }

