/*
 * No copyright 2012 the origin author or authors. No Rights Reserved.
 * 
 * You have a sunshine.
 */

package my.external {
    import flash.external.ExternalInterface;
    import com.adobe.serialization.json.JSON;

    /**
     * Helper class to ease passing Function arguments to the ExternalInterface.
     *
     * @see http://stackoverflow.com/questions/2520306/how-to-pass-a-reference-to-a-js-function-as-an-argument-to-an-externalinterface
     * @see http://stackoverflow.com/questions/3802638/pass-a-callback-in-externalinterface
     * @see http://help.adobe.com/en_US/as3/dev/WS5b3ccc516d4fbf351e63e3d118a9b90204-7cb2.html#WS5b3ccc516d4fbf351e63e3d118a9b90204-7ca8
     */
    public final class AsyncExternalInterface {

        public static function call(functionName:String, ... args):* {
            return ExternalInterface.call(subroutine(functionName, args.map(convertArgument).join()));
        }

        public static function get available():Boolean {
            return ExternalInterface.available;
        }

        // Convert argument value to a JavaScript string value;
        // substituting functions with a proxying JavaScript function.
        private static function convertArgument(value:*, index:int = 0, arr:Array = null):String {
            if (value is Function)
                return javaScriptCallback(value);
            else if (isRawValue(value))
                return com.adobe.serialization.json.JSON.encode(value);
            else if (value is Array)
                return '[' + value.each(convertArgument).join() + ']';
            else {
                var str:String = '';
                for (var prop:String in value) {
                    if (str.length > 0)
                        str += ',';
                    str += prop + ':' + convertArgument(value[prop]);
                }
                return '{' + str + '}'
            }
        }

        private static function isRawValue(value:*):Boolean {
            return value is Boolean || value is Number || value is String || value == null;
        }

        private static function javaScriptCallback(fn:Function):String {
            return subroutine(INTERFACE_CALLBACK_FN, registeredCallbackID(fn), 'Array.prototype.slice.call(arguments)');
            // Must convert "arguments" object to a real Array otherwise Flash Player will throw a type coercion Error.
        }

        private static function subroutine(func:String, ...args):String {
            // we wrap the func in parentheses to allow either function name or expression
            return 'function(){ return (' + func + ')(' + args.join() + ')}';
        }

        private static function registeredCallbackID(fn:Function):int {
            var id:int = registeredCallbacks.indexOf(fn);
            return (id > -1) ? id : registeredCallbacks.push(fn) - 1;
        }

        // single ExternalInterface callback added, proxying to previously registered Function.
        private static function callback(callbackID:uint, args:Array):void {
            registeredCallbacks[callbackID].apply(null, args);
        }

        private static var registeredCallbacks:Array = []; // todo: consider using Dictionary(true) for weak references
        private static const INTERFACE_CALLBACK_NAME:String = 'AsyncExternalInterfaceCallback';
        private static const INTERFACE_CALLBACK_FN:String = 'document.getElementById("' + ExternalInterface.objectID + '").' + INTERFACE_CALLBACK_NAME

        {
            if (available)
                ExternalInterface.addCallback(INTERFACE_CALLBACK_NAME, callback);
        }
    }
}

