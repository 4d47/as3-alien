package alien {
    import org.flexunit.Assert;

    public class ExternalInterface2Test {

        [Test(description="Can instantiate, like the original ExternalInterface")]
        public function instanciationTest():void {
            new ExternalInterface2();
        }

        [Test(description="ExternalInterface is not available in unit tests")]
        public function unavailableToUnitTest():void {
            Assert.assertFalse( ExternalInterface2.available );
        }

        [Test(expects="Error", description="Call on unavailable interface throws an exception")]
        public function callTest():void {
            ExternalInterface2.call(null);
        }

        [Test]
        public function convertArgumentWithBasicValuesTest():void {
            Assert.assertEquals("10", ExternalInterface2.convertArgument(10));
            Assert.assertEquals("false", ExternalInterface2.convertArgument(false));
            Assert.assertEquals("\"Nick Mason\"", ExternalInterface2.convertArgument("Nick Mason"));
            Assert.assertEquals("null", ExternalInterface2.convertArgument(null));
        }

        [Test]
        public function convertArgumentWithFunctionTest():void {
            var a:Function = new Function();
            var b:Function = new Function();
            assertInterfaceCallbackInString(a, 1);
            assertInterfaceCallbackInString(a, 1); // the same function function get the same id
            assertInterfaceCallbackInString(b, 2);
        }

        [Test]
        public function convertArgumentWithComplexValuesTest():void {
            Assert.assertEquals("{}", ExternalInterface2.convertArgument( { } ));
            Assert.assertEquals("{\"name\":\"bob\"}", ExternalInterface2.convertArgument( { name: "bob" } ));
            Assert.assertEquals("[]", ExternalInterface2.convertArgument( [ ] ));
            Assert.assertEquals("[true,10,\"a\"]", ExternalInterface2.convertArgument( [ true, 10, "a" ] ));
            Assert.assertEquals("[{\"names\":[\"mike\",\"bob\"]}]", ExternalInterface2.convertArgument( [ { names: [ "mike", "bob" ] } ] ));
        }

        private function assertInterfaceCallbackInString(value:Function, expectedLength:Number):void {
            Assert.assertTrue(ExternalInterface2.convertArgument(value).indexOf(ExternalInterface2.INTERFACE_CALLBACK_FN) != -1);
            Assert.assertEquals(expectedLength, ExternalInterface2.registeredCallbacks.length);
        }
    }
}
