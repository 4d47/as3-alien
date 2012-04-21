package my.external {
    import org.flexunit.Assert;

    public class AsyncExternalInterafceTest {
        [Test]
	public function canInstanciate():void {
            new AsyncExternalInterafceTest();
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
