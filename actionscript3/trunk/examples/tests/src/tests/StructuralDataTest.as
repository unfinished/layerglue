package tests
{
	import com.layerglue.lib.application.structure.StructuralData;
	
	import flexunit.framework.TestCase;

	public class StructuralDataTest extends TestCase
	{
		public function StructuralDataTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public function testId():void
		{
			var s:StructuralData;
			s = new StructuralData("home");
			assertTrue("id is 'home' when set through constructor", s.id == "home");
			s = new StructuralData();
			assertNull("id is null when not set through constructor", s.id);
			s.id = "home";
			assertTrue("id is 'home' when set via property", s.id == "home");
		}
		
		public function testParent():void
		{
			var s:StructuralData;
			s = new StructuralData();
			assertNull("parent is null when structural data is instantiated on its own", s.parent);
			
			var p:StructuralData = new StructuralData();
			s.parent = p;
			assertStrictlyEquals("strictly equals", s.parent, p);
			
			// this passes because it's only comparing properties on the object?
			var p2:StructuralData = new StructuralData();
			assertObjectEquals("object equals", s.parent, p2);
			
			// test via deserializer?
		}
		
		public function testIsRoot():void
		{
			var s:StructuralData;
			s = new StructuralData();
			assertTrue("isRoot is true when structural data is instantiated on its own", s.isRoot());
			
			s.parent = null;
			assertTrue("isRoot is true when parent is null", s.isRoot());
			
			var p:StructuralData = new StructuralData();
			s.parent = p;
			assertFalse("isRoot is false when parent has been set", s.isRoot());
		}
	}
}