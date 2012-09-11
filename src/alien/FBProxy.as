package alien {

    /**
     * Facebook JavaScript SDK Proxy.
     * Feel like directly using the Facebook SDK.
     *
     * @see http://developers.facebook.com/docs/reference/javascript/
     */
    public dynamic class FBProxy extends JSProxy {

        /**
         * @param fbAsyncInit Function called as soon as the SDK is loaded.
         * @param isBeta Flag telling to load the beta tier version.
         */
        public function FBProxy(fbAsyncInit:Function = null, isBeta:Boolean = false) {
            super('FB');
            if (fbAsyncInit != null)
                ExternalInterface2.call(LOAD_SDK_SCRIPT, isBeta, fbAsyncInit);
        }

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
