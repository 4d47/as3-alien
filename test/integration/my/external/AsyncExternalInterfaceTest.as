package {
    import flash.display.Sprite;
    import flash.external.ExternalInterface;
    import flash.events.UncaughtErrorEvent;

    import my.external.AsyncExternalInterface;
    import my.external.FBProxy;
  
    public class AsyncExternalInterfaceTest extends Sprite {

        public function AsyncExternalInterfaceTest() {
            // make sure we see exceptions
            ExternalInterface.marshallExceptions = true;
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, fail);
            // eg. call the browser setTimeout function
            var id:uint = AsyncExternalInterface.call('setTimeout', onSetTimeout, 200);
        }

        private function onSetTimeout(lateness:* = null):void {
            // initialize the proxy (the js sdk will be loaded in the html)
            FB = new FBProxy(facebookLoaded);
        }

        private function facebookLoaded():void {
            // now feel like using FB js object.
            FB.api(FACEBOOK_PLATFORM_ID, onResult);
        }

        private function onResult(data:Object):void {
            if (data.id !== FACEBOOK_PLATFORM_ID)
                throw new Error("Received an object but not with the expected id.");
            // eg. calling nested objects
            FB.Event.subscribe('auth.authResponseChange', onAuthResponseChange);
            ExternalInterface.call('endTest', true);
        }

        private function onAuthResponseChange(response:Object):void {
            trace('The auth response changed');
        }

        private function fail(e:UncaughtErrorEvent = null):void {
            ExternalInterface.call('endTest', false);
        }

        private var FB:FBProxy;
        private static const FACEBOOK_PLATFORM_ID:String = '19292868552';
    }
}
