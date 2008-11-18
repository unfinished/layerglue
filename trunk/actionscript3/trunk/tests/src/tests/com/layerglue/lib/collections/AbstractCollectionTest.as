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
		
		protected function createCollection(itemsToAdd:Array=null):ICollection
		{
			return null;
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			
			_collection = null;
		}
		
		public function testConstructorAdding():void
		{
			var c1:ICollection = createCollection();
			assertEquals("Without adding anything", 0, c1.getLength());
			
			var c2:ICollection = createCollection(["a"]);
			assertEquals("Adding one item", 1, c2.getLength());
			
			var c3:ICollection = createCollection(["a", "b", "c"]);
			assertEquals("Adding one item", 3, c3.getLength());
		}
		
		public function testAddItem():void
		{
			var c:ICollection = createCollection();
			assertEquals("length is 0 before adding an item", 0, c.getLength());
			
			c.addItem("a");
			assertEquals("length is 1 after adding an item", 1, c.getLength());
			assertEquals("index 0 is 'a'", "a", _collection.getItemAt(0));
			
			c.addItem("b");
			assertEquals("length is 1 after adding an item", 2, c.getLength());
			assertEquals("index 1 is 'b'", "b", _collection.getItemAt(1));
		}
		
		public function testAddItemAt():void
		{
			assertEquals("length is 3 before adding anything", 3, _collection.getLength());
			assertEquals("before adding anything", "a", _collection.getItemAt(0));
			assertEquals("before adding anything", "b", _collection.getItemAt(1));
			assertEquals("before adding anything", "c", _collection.getItemAt(2));
			
			_collection.addItemAt("d", 0);
			assertEquals("After adding 'd' at index 0", 4, _collection.getLength());
			assertEquals("After adding 'd' at index 0", "d", _collection.getItemAt(0));
			assertEquals("After adding 'd' at index 0", "a", _collection.getItemAt(1));
			assertEquals("After adding 'd' at index 0", "b", _collection.getItemAt(2));
			assertEquals("After adding 'd' at index 0", "c", _collection.getItemAt(3));
			
			_collection.addItemAt("e", 1);
			assertEquals("length is 5 after adding 'e' at index 1", 5, _collection.getLength());
			assertEquals("After adding 'e' at index 1", "d", _collection.getItemAt(0));
			assertEquals("After adding 'e' at index 1", "e", _collection.getItemAt(1));
			assertEquals("After adding 'e' at index 1", "a", _collection.getItemAt(2));
			assertEquals("After adding 'e' at index 1", "b", _collection.getItemAt(3));
			assertEquals("After adding 'e' at index 1", "c", _collection.getItemAt(4));
		}
		
		public function testGetItemAt():void
		{
			assertEquals("first item is 'a'", "a", _collection.getItemAt(0));
			assertEquals("first item is 'b'", "b", _collection.getItemAt(1));
			assertEquals("first item is 'c'", "c", _collection.getItemAt(2));
		}
		
		public function testItemIndex():void
		{
			assertEquals("From setUp", 0, _collection.getItemIndex("a"));
			assertEquals("From setUp", 1, _collection.getItemIndex("b"));
			assertEquals("From setUp", 2, _collection.getItemIndex("c"));
		}
		
		public function testRemoveItemAt():void
		{
			assertEquals("length is 3 before adding anything", 3, _collection.getLength());
			assertEquals("Before removing anything", "a", _collection.getItemAt(0));
			assertEquals("Before removing anything", "b", _collection.getItemAt(1));
			assertEquals("Before removing anything", "c", _collection.getItemAt(2));
			
			_collection.removeItemAt(0);
			assertEquals("After removing item at 0", 2, _collection.getLength());
			assertEquals("After removing item at 0", "b", _collection.getItemAt(0));
			assertEquals("After removing item at 0", "c", _collection.getItemAt(1));
			
			_collection.removeItemAt(1);
			assertEquals("After removing item at 1", 1, _collection.getLength());
			assertEquals("After removing item at 1", "b", _collection.getItemAt(0));
		}
		
		public function testRemoveAll():void
		{
			assertEquals("length is 3 before adding anything", 3, _collection.getLength());
			_collection.removeAll();
			assertEquals("length is 0 after removAll", 0, _collection.getLength());
		}
		
		public function testContains():void
		{
			var c1:Collection = new Collection();
			assertFalse("Before addding item to c1",c1.contains("a"));
			c1.addItem("a");
			assertTrue("After adding to c1",c1.contains("a"));
			
			assertTrue("From setUp",_collection.contains("a"));
			assertTrue("From setUp",_collection.contains("b"));
			assertTrue("From setUp",_collection.contains("c"));
			assertFalse("From setUp",_collection.contains("s"));
		}
		
	}
}