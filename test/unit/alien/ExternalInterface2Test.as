package alien {
    import org.flexunit.Assert;

    public class ExternalInterface2Test {
        [Test]
        public function canInstanciate():void {
            new ExternalInterface2();
        }

        [Test]
        public function unavailableToUnitTest():void {
            Assert.assertFalse( ExternalInterface2.available );
        }

        [Test(expects="Error", description="Not available")]
        public function callWithNull():void {
            ExternalInterface2.call(null);
        }
    }
}
