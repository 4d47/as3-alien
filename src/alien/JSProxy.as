package alien {
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    public dynamic class JSProxy extends Proxy {

        public function JSProxy(prefix:String = 'window') {
            this.prefix = prefix + '.';
        }

        override flash_proxy function callProperty(name:*, ...args):* {
            args.unshift(prefix + name);
            return ExternalInterface2.call.apply(null, args);
        }

        override flash_proxy function getProperty(name:*):* {
            return new JSProxy(prefix + name)
        }

        private var prefix:String;
    }
}
