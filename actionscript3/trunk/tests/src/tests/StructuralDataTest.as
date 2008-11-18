package tests
{
	import com.layerglue.flex3.base.collections.FlexCollection;
	import com.layerglue.lib.application.structure.StructuralData;
	
	import flexunit.framework.TestCase;

	public class StructuralDataTest extends TestCase
	{
		public function StructuralDataTest(methodName:String=null)
		{
			super(methodName);
		}
		
		protected var complexStructuralData:StructuralData;
		
		override public function setUp():void
		{
			super.setUp();
			complexStructuralData = new StructuralData();
			// TODO by setting up complex data here half these tests are redundant,
			// because the functionality will be tested here...
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			complexStructuralData = null;
		}
		
		public function testId():void
		{
			var s:StructuralData;
			s = new StructuralData("home");
			assertEquals("id is 'home' when set through constructor", "home", s.id);
			
			s = new StructuralData();
			assertNull("id is null when NOT set through constructor", s.id);
			
			s.id = "home";
			assertEquals("id is 'home' when set via property", "home", s.id);
		}
		
		public function testUriNode():void
		{
			var s:StructuralData = new StructuralData();
			assertNull("uriNode is null when instantiated", s.uriNode);
			s.uriNode = "home";
			assertEquals("uriNode is 'home' when set via property", "home", s.uriNode);
		}
		
		public function testUri():void
		{
			var structureRoot:StructuralData = new StructuralData();
			structureRoot.uriNode = "structureRoot";
			assertEquals("uri is / when it's instantiated", "/", structureRoot.uri);
			
			var home:StructuralData = new StructuralData();
			home.uriNode = "home";
			// TODO: You can set 'parent' without it actually being in the children array
			home.parent = structureRoot;
			assertEquals("First level child's uri is /home/ when it has a parent", "/home/", home.uri);
			
			home.parent = null;
			assertEquals("First level child's uri is / when it's parent is null", "/", home.uri);
		}
		
		public function testChildren():void
		{
			var s:StructuralData = new StructuralData();
			assertNull("children is null when it's instantiated", s.children);
		}
		
		public function testDefaultChild():void
		{
			var structureRoot:StructuralData = new StructuralData();
			assertNull("defaultChild is null when it's instantiated", structureRoot.defaultChild);
			
			structureRoot.children = new FlexCollection();
			assertNull("defaultChild is null when children is instantiated but empty", structureRoot.defaultChild);
			
			structureRoot.defaultChildId = "gallery";
			assertNull("defaultChild is null when the child with id=gallery doesn't exist", structureRoot.defaultChild);
			
			var gallery:StructuralData = new StructuralData();
			gallery.id = "gallery";
			structureRoot.children.addItem(gallery);
			assertStrictlyEquals("defaultChild exist when the child with id=gallery exists", gallery, structureRoot.defaultChild);
		}
		
		public function testTitle():void
		{
			var s:StructuralData = new StructuralData();
			assertNull("StructuralData.title is null when instantiated", s.title);
			s.title = "Home";
			assertEquals("uriNode is 'Home' when set", "Home", s.title);
		}
		
		public function testDefaultChildId():void
		{
			var s:StructuralData = new StructuralData();
			assertNull("defaultChildId is null when instantiated", s.defaultChildId);
			s.defaultChildId = "home";
			assertEquals("defaultChildId is 'Home' when set", "home", s.defaultChildId);
		}
		
		public function testParent():void
		{
			var s:StructuralData;
			s = new StructuralData();
			assertNull("parent is null when structural data is instantiated", s.parent);
			
			var p:StructuralData = new StructuralData();
			s.parent = p;
			assertStrictlyEquals("parent should point to an instance of StructuralData", p, s.parent);
			
			// test via deserializer?
		}
		
		public function testIsRoot():void
		{
			var s:StructuralData;
			s = new StructuralData();
			assertTrue("isRoot is true when structural data is instantiated", s.isRoot());
			
			var p:StructuralData = new StructuralData();
			s.parent = p;
			assertFalse("isRoot is false when parent has been set", s.isRoot());
			
			s.parent = null;
			assertTrue("isRoot is true when parent is null", s.isRoot());
		}
	}
}