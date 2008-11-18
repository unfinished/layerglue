package tests.com.layerglue.lib.collections
{
	import flexunit.framework.TestCase;
	import com.layerglue.lib.base.collections.ICollection;
	import com.layerglue.lib.base.collections.Collection;

	public class AbstractCollectionTest extends TestCase
	{
		protected var _collection:ICollection;
		
		public function AbstractCollectionTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void
		{
			super.setUp();
			
			_collection = createCollection();
			_collection.addItem("a");
			_collection.addItem("b");
			_collection.addItem("c");
		}
		
		protected function createCollection():ICollection
		{
			return null;
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			
			_collection = null;
		}
		
		public function testAddItem():void
		{
			var c:ICollection = createCollection();
			
			assertEquals("length is 0 before adding an item", c.getLength(), 0);
			
			c.addItem("a");
			
			assertEquals("length is 1 after adding an item", c.getLength(), 1);
		}
		
		public function testRemoveItem():void
		{
			var c:ICollection = createCollection();
			
			c.addItem("a");
			
			assertEquals("length is 1 after adding an item", c.getLength(), 1);
			
			c.removeItem("a");
			
			assertEquals("length is 1 after adding an item", c.getLength(), 0);
		}
		
		
		
	}
}