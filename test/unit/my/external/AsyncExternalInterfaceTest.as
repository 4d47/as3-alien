package my.external {
    import org.flexunit.Assert;

    public class AsyncExternalInterfaceTest {
        [Test]
        public function canInstanciate():void {
            new AsyncExternalInterface();
        }

        [Test]
        public function unavailableToUnitTest():void {
            Assert.assertFalse( AsyncExternalInterface.available );
        }

        [Test(expects="Error", description="Not available")]
        public function callWithNull():void {
            AsyncExternalInterface.call(null);
        }
    }
}
