package alien {
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    /**
     * Facebook JavaScript SDK Proxy.
     * Feel like directly using the Facebook SDK.
     *
     * @see http://developers.facebook.com/docs/reference/javascript/
     */
    public dynamic class FBProxy extends Proxy {

        /**
         * @param fbAsyncInit Function called as soon as the SDK is loaded.
         * @param isBeta Flag telling to load the beta tier version.
         * @param prefix Internal SDK name in the JavaScript interface.
         */
        public function FBProxy(fbAsyncInit:Function = null, isBeta:Boolean = false, prefix:String = 'FB') {
            this.prefix = prefix + '.';
            if (fbAsyncInit != null)
                ExternalInterface2.call(LOAD_SDK_SCRIPT, isBeta, fbAsyncInit);
        }

        override flash_proxy function callProperty(name:*, ...args):* {
            args.unshift(prefix + name);
            return ExternalInterface2.call.apply(null, args);
        }

        override flash_proxy function getProperty(name:*):* {
            return new FBProxy(null, false, prefix + name)
        }

        private var prefix:String;

        private static const LOAD_SDK_SCRIPT:XML =
            // http://developers.facebook.com/docs/reference/javascript
            // http://developers.facebook.com/support/beta-tier/
            <script>
                <![CDATA[
                    function(isBeta, fn) {
                        window.fbAsyncInit = fn;
                        var js, id = 'facebook-jssdk', ref = document.getElementsByTagName('script')[0];
                        if (document.getElementById(id)) { return; }
                        js = document.createElement('script'); js.id = id; js.async = true;
                        js.src = "//connect." + (isBeta ? "beta." : "") + "facebook.net/en_US/all.js";
                        ref.parentNode.insertBefore(js, ref);
                    }
                ]]>
            </script>;
    }
}
