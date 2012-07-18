
as3-alien
=========

" This is not ActionScript 3 "

`alien.ExternalInterface2`, just like `flash.external.ExternalInterface` but accepts Function in arguments.

    ExternalInterface2.call("window.setInterval", onSetInterval, 3000);

`alien.FBProxy`, a small `flash.utils.Proxy` to feel like directly using Facebook JavaScript SDK.

    var FB:FBProxy = new FBProxy();
	FB.api('me', function():void {
	    // ...
	});

