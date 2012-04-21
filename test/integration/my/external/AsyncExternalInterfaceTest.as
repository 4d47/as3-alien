package {
    import flash.display.Sprite;
    import flash.external.ExternalInterface;
    import flash.events.UncaughtErrorEvent;
    import flash.system.Security;

    import my.external.AsyncExternalInterface;
  
    public class AsyncExternalInterfaceTest extends Sprite {
        public function AsyncExternalInterfaceTest() {
            ExternalInterface.marshallExceptions = true;
            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, fail);
            first();
        }

        private function first():void {
            AsyncExternalInterface.call('double', 10, second);
        }

        private function second(num:Number):void {
            if (num !== 20)
                fail();
            AsyncExternalInterface.call(LOAD_SDK_SCRIPT, third);
        }

        private function third():void {
            AsyncExternalInterface.call('FB.api', FACEBOOK_PLATFORM_ID, fourth);
        }

        private function fourth(data:Object):void {
            if (data.id !== FACEBOOK_PLATFORM_ID)
                fail();
            if (!(this is AsyncExternalInterfaceTest))
                fail();
            success();
        }

        private function fail(e:UncaughtErrorEvent = null):void {
            ExternalInterface.call('endTest', false);
        }

        private function success():void {
            ExternalInterface.call('endTest', true);
        }

        private static const FACEBOOK_PLATFORM_ID:String = '19292868552';

        private static const LOAD_SDK_SCRIPT:XML =
            // http://developers.facebook.com/docs/reference/javascript
            <script>
                <![CDATA[
                    function(fn) {
                        window.fbAsyncInit = fn;
                        var js, id = 'facebook-jssdk', ref = document.getElementsByTagName('script')[0];
                        if (document.getElementById(id)) { return; }
                        js = document.createElement('script'); js.id = id; js.async = true;
                        js.src = "//connect.facebook.net/en_US/all.js";
                        ref.parentNode.insertBefore(js, ref);
                    }
                ]]>
            </script>;
    }
}
