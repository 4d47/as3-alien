package my.external {
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    /**
     * Facebook JavaScript SDK Proxy.
     * Feel like directly using the Facebook SDK.
     *
     * @see http://developers.facebook.com/docs/reference/javascript/
     */
    public dynamic class FBProxy extends Proxy {

        public function FBProxy(ready:Function = null, prefix:String = 'FB') {
            this.prefix = prefix + '.';
            if (ready != null)
                AsyncExternalInterface.call(LOAD_SDK_SCRIPT, ready);
        }

        override flash_proxy function callProperty(name:*, ...args):* {
            args.unshift(prefix + name);
            return AsyncExternalInterface.call.apply(null, args);
        }

        override flash_proxy function getProperty(name:*):* {
            return new FBProxy(null, prefix + name)
        }

        private var prefix:String;
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
