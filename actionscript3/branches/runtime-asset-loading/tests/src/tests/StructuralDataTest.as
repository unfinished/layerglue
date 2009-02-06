package tests
{
	import com.layerglue.flex3.base.collections.FlexCollection;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.structure.StructuralData;
	import com.layerglue.lib.base.collections.ICollection;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;

	public class StructuralDataTest extends TestCase
	{
		protected var structureRoot:IStructuralData;
		protected var structureHome:IStructuralData;
		protected var structureGallery:IStructuralData;
		protected var structureGalleryPage:IStructuralData;
		protected var structureAbout:IStructuralData;
		
		public function StructuralDataTest(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite():TestSuite
		{
			var testSuite:TestSuite = new TestSuite();
			
			// Tested in order of reliance on each other
			testSuite.addTest( new StructuralDataTest("testId") );
			testSuite.addTest( new StructuralDataTest("testUriNode") );
			testSuite.addTest( new StructuralDataTest("testTitle") );
			testSuite.addTest( new StructuralDataTest("testDefaultChildId") );
			
			testSuite.addTest( new StructuralDataTest("testChildren") );
			testSuite.addTest( new StructuralDataTest("testParent") );
			testSuite.addTest( new StructuralDataTest("testIsRoot") );
			testSuite.addTest( new StructuralDataTest("testUri") );
			
			testSuite.addTest( new StructuralDataTest("testDefaultChild") );
			testSuite.addTest( new StructuralDataTest("testSelectedChildIndex") );
			testSuite.addTest( new StructuralDataTest("testSelectedChild") );
			testSuite.addTest( new StructuralDataTest("testSelected") );
			
			return testSuite;
		}
		
		override public function setUp():void
		{
			super.setUp();
			structureRoot = newStructuralDataInstance();
			structureHome = newStructuralDataInstance();
			structureGallery = newStructuralDataInstance();
			structureGalleryPage = newStructuralDataInstance();
			structureAbout = newStructuralDataInstance();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			structureRoot = null;
			structureHome = null;
			structureGallery = null;
			structureGalleryPage = null;
			structureAbout = null;
		}
		
		protected function newStructuralDataInstance():IStructuralData
		{
			return new StructuralData();
		}
		
		protected function newChildrenCollectionInstance():ICollection
		{
			return new FlexCollection();
		}
		
		public function testId():void
		{
			assertNull("The id property is null when not specified in constructor", structureRoot.id);
			structureRoot.id = "root";
			assertEquals("The id is set through the property", "root", structureRoot.id);
		}
		
		public function testUriNode():void
		{
			assertNull("The uriNode is null when first instantiated", structureRoot.uriNode);
			structureRoot.uriNode = "home";
			assertEquals("The uriNode is set through the property", "home", structureRoot.uriNode);
		}
		
		public function testUri():void
		{
			assertEquals("The uri is / when it's instantiated and has no parent", "/", structureRoot.uri);
			
			structureRoot.uriNode = "structureRoot";
			assertEquals("uri is / when it has no parent but has a valid uriNode", "/", structureRoot.uri);
			
			structureHome.uriNode = "home";
			structureHome.parent = structureRoot;
			assertEquals("First level child's uri is valid when has a parent", "/home/", structureHome.uri);
			assertEquals("Root level structure's uri is valid when has a pchild", "/", structureRoot.uri);
			
			structureHome.parent = null;
			assertEquals("Home level child's uri acts as root when parent is null", "/", structureHome.uri);
			
			structureRoot.children = new FlexCollection();
			structureRoot.children.addItem(structureHome);
			assertEquals("Home level child's uri is valid when added to the children collection", "/home/", structureHome.uri);
			
			structureGallery.uriNode = "gallery";
			structureHome.children = newChildrenCollectionInstance();
			structureHome.children.addItem(structureGallery);
			assertEquals("Root level child's uri is valid when two child levels are present", "/", structureRoot.uri);
			assertEquals("Home level child's uri is valid when two child levels are present", "/home/", structureHome.uri);
			assertEquals("Gallery level child's uri is valid when two child levels are present", "/home/gallery/", structureGallery.uri);
			
			structureHome.parent = null;
			assertEquals("Home level child's uri acts as root when it's parent is null", "/", structureHome.uri);
			assertEquals("Gallery level child's uri is valid when it's parent is removed from children", "/gallery/", structureGallery.uri);
			
			structureHome.children.removeItemAt(0);
			assertEquals("Gallery level child's uri acts as root when it's removed from children", "/", structureGallery.uri);
		}
		
		public function testChildren():void
		{
			assertNull("The children collection is null when instantiated", structureRoot.children);
		}
		
		public function testDefaultChildId():void
		{
			assertNull("defaultChildId is null when instantiated", structureRoot.defaultChildId);
			structureRoot.defaultChildId = "home";
			assertEquals("defaultChildId is 'Home' when set", "home", structureRoot.defaultChildId);
		}
		
		public function testDefaultChild():void
		{
			assertNull("The defaultChild is null when instantiated", structureRoot.defaultChild);
			
			structureRoot.children = new FlexCollection();
			assertNull("The defaultChild is null when children is instantiated but empty", structureRoot.defaultChild);
			
			structureRoot.defaultChildId = "gallery";
			assertNull("The defaultChild is null when defaultChildId is set but children is empty", structureRoot.defaultChild);
			
			structureRoot.children = newChildrenCollectionInstance();
			structureRoot.children.addItem(structureHome);
			structureRoot.children.addItem(structureGallery);
			assertNull("The defaultChild is null when defaultChildId is set but a child with that id doesn't exist", structureRoot.defaultChild);
			
			structureGallery.id = "gallery";
			assertStrictlyEquals("The defaultChild returns an instance of the child with defaultChildId", structureGallery, structureRoot.defaultChild);
			
			structureHome.id = "gallery";
			assertStrictlyEquals("The defaultChild returns an instance of the FIRST child with defaultChildId when two exist", structureHome, structureRoot.defaultChild);
			structureHome.id = "home";
			
			structureGallery.children = newChildrenCollectionInstance();
			structureGallery.children.addItem(structureGalleryPage);
			structureGalleryPage.id = "galleryPage";
			structureGallery.defaultChildId = "galleryPage";
			assertStrictlyEquals("The defaultChild returns an instance of the child with defaultChildId", structureGalleryPage, structureGallery.defaultChild);
			assertStrictlyEquals("The defaultChild works on a hierarchical chain of two defaultChilds", structureGalleryPage, structureRoot.defaultChild.defaultChild);
			
			structureRoot.defaultChildId = null;
			assertNull("The defaultChild is null when defaultChildId is null", structureRoot.defaultChild);
		}
		
		public function testTitle():void
		{
			assertNull("StructuralData.title is null when instantiated", structureRoot.title);
			structureRoot.title = "Home";
			assertEquals("The title is valid when set through the property", "Home", structureRoot.title);
		}
		
		public function testParent():void
		{
			assertNull("The parent is null when structural data is instantiated", structureRoot.parent);
			
			structureHome.parent = structureRoot;
			assertStrictlyEquals("parent is set through child parent property", structureRoot, structureHome.parent);
			
			structureHome.parent = null;
			assertNull("The parent is null when nulled", structureRoot.parent);
			
			structureRoot.children = newChildrenCollectionInstance();
			structureRoot.children.addItem(structureHome);
			assertStrictlyEquals("The parent is set on a child when it's added via the children collection", structureRoot, structureHome.parent);
			
			structureRoot.children.removeItemAt(0);
			assertNull("The child's parent is nulled when it's removed from children collection", structureHome.parent);
			
			structureRoot.children.addItem(structureHome);
			structureHome.parent = null;
			assertNull("The child's parent is nulled when added via children collection but nulled via property", structureHome.parent);
		}
		
		public function testIsRoot():void
		{
			assertTrue("isRoot is true when structural data is instantiated", structureRoot.isRoot());
			
			structureHome.parent = structureRoot;
			assertFalse("isRoot is false when parent has been set", structureHome.isRoot());
			
			structureHome.parent = null;
			assertTrue("isRoot is true when parent is null", structureHome.isRoot());
		}
		
		
		protected function setupComplexStructuralHierarchy():IStructuralData
		{
			structureRoot.id = "root";
			structureHome.id = "home";
			structureGallery.id = "gallery";
			structureGalleryPage.id = "galleryPage";
			structureAbout.id = "about";
			
			structureRoot.children = newChildrenCollectionInstance();
			structureHome.children = newChildrenCollectionInstance();
			structureGallery.children = newChildrenCollectionInstance();
			
			structureRoot.children.addItem(structureHome);
			structureRoot.children.addItem(structureGallery);
			structureGallery.children.addItem(structureGalleryPage);
			structureRoot.children.addItem(structureAbout);
			
			return structureRoot;
		}
		
		public function testSelected():void
		{
			structureRoot = setupComplexStructuralHierarchy();
			
			assertTrue("Structure root is selected by default", structureRoot.selected);
			assertFalse("Structural children are not selected by default", structureHome.selected);
			assertFalse("Structural children are not selected by default", structureGallery.selected);
			assertFalse("Structural children are not selected by default", structureGalleryPage.selected);
			assertFalse("Structural children are not selected by default", structureAbout.selected);
			
			structureGallery.selected = true;
			assertTrue("Structure root is selected when home is selected", structureRoot.selected);
			assertFalse("Structural home is not selected when home is selected", structureHome.selected);
			assertTrue("Structure gallery is selected when home is selected", structureGallery.selected);
			assertFalse("Structural galleryPage is not selected when home is selected", structureGalleryPage.selected);
			assertFalse("Structural about is not selected when home is selected", structureAbout.selected);
			assertStrictlyEquals("Structure gallery is selectedChild of root when selected", structureGallery, structureRoot.selectedChild);
			assertEquals("The root.selectedChildIndex is 1 when gallery is selectedChild of root", structureRoot.selectedChildIndex, 1);
			
			structureAbout.selected = true;
			assertTrue("Structure root is selected when about is selected", structureRoot.selected);
			assertFalse("Structural home is not selected when about is selected", structureHome.selected);
			assertFalse("Structure gallery is not selected when about is selected", structureGallery.selected);
			assertFalse("Structural galleryPage is not selected when about is selected", structureGalleryPage.selected);
			assertTrue("Structural about is selected when about is selected", structureAbout.selected);
			assertStrictlyEquals("Structure about is selectedChild of root when selected", structureAbout, structureRoot.selectedChild);
			assertEquals("The root.selectedChildIndex is 2 when about is selectedChild of root", structureRoot.selectedChildIndex, 2);
			
			structureGalleryPage.selected = true;
			assertTrue("Structure root is selected when galleryPage is selected", structureRoot.selected);
			assertFalse("Structural home is not selected when galleryPage is selected", structureHome.selected);
			assertFalse("Structure gallery is not selected when galleryPage is selected", structureGallery.selected);
			assertTrue("Structural galleryPage is selected when galleryPage is selected", structureGalleryPage.selected);
			assertTrue("Structural about is selected when galleryPage is selected", structureAbout.selected);
			assertStrictlyEquals("Structure about is selectedChild of root when selected", structureAbout, structureRoot.selectedChild);
			assertStrictlyEquals("Structure galleryPage is selectedChild of gallery when selected", structureGalleryPage, structureGallery.selectedChild);
			assertEquals("The root.selectedChildIndex is 2 when about is selectedChild of root", structureRoot.selectedChildIndex, 2);
			assertEquals("The gallery.selectedChildIndex is 0 when galleryPage is selectedChild of gallery", structureGallery.selectedChildIndex, 0);
			
			structureGallery.selected = true;
			assertTrue("Structure root is selected when gallery.galleryPage is selected", structureRoot.selected);
			assertFalse("Structural home is not selected when gallery.galleryPage is selected", structureHome.selected);
			assertTrue("Structure gallery is selected when gallery.galleryPage is selected", structureGallery.selected);
			assertTrue("Structural galleryPage is selected when gallery.galleryPage is selected", structureGalleryPage.selected);
			assertFalse("Structural about is not selected when gallery.galleryPage is selected", structureAbout.selected);
			assertStrictlyEquals("Structure gallery is selectedChild of root when selected", structureGallery, structureRoot.selectedChild);
			assertStrictlyEquals("Structure galleryPage is selectedChild of gallery when selected", structureGalleryPage, structureGallery.selectedChild);
			assertEquals("The root.selectedChildIndex is 1 when gallery is selectedChild of root", structureRoot.selectedChildIndex, 1);
			
			structureGalleryPage.selected = false;
			assertTrue("Structure gallery is selected when gallery.galleryPage is selected", structureGallery.selected);
			assertFalse("Structural galleryPage is not selected when gallery.galleryPage is selected", structureGalleryPage.selected);
			assertStrictlyEquals("Structure gallery is selectedChild of root when selected", structureGallery, structureRoot.selectedChild);
			assertNull("Structure gallery.selectedChild is null when gallery page is not selected", structureGallery.selectedChild);
			assertEquals("The gallery.selectedChildIndex is -1 when galleryPage is not selected", structureGallery.selectedChildIndex, -1);
		}
		
		public function testSelectedChild():void
		{
			structureRoot = setupComplexStructuralHierarchy();
			
			assertNull("Structure root has null selectedChild by default", structureRoot.selectedChild);
			assertNull("Structural children has null selectedChild by default", structureHome.selectedChild);
			assertNull("Structural children has null selectedChild by default", structureGallery.selectedChild);
			assertNull("Structural children has null selectedChild by default", structureGalleryPage.selectedChild);
			assertNull("Structural children has null selectedChild by default", structureAbout.selectedChild);

			structureRoot.selectedChild = structureHome;
			assertStrictlyEquals("Structure root has selectedChild home", structureHome, structureRoot.selectedChild);
			assertNull("Structural home has null selectedChild", structureHome.selectedChild);
			assertNull("Structure gallery has null selectedChild", structureGallery.selectedChild);
			assertNull("Structural galleryPage has null selectedChild", structureGalleryPage.selectedChild);
			assertNull("Structural about has null selectedChild", structureAbout.selectedChild);
			
			structureRoot.selectedChild = structureAbout;
			assertStrictlyEquals("Structure root has selectedChild about", structureAbout, structureRoot.selectedChild);
			assertNull("Structural home has null selectedChild", structureHome.selectedChild);
			assertNull("Structure gallery has null selectedChild", structureGallery.selectedChild);
			assertNull("Structural galleryPage has null selectedChild", structureGalleryPage.selectedChild);
			assertNull("Structural about has null selectedChild", structureAbout.selectedChild);
			
			structureGallery.selectedChild = structureGalleryPage;
			assertStrictlyEquals("Structure root has selectedChild about", structureAbout, structureRoot.selectedChild);
			assertNull("Structural home has null selectedChild", structureHome.selectedChild);
			assertStrictlyEquals("Structure gallery has galleryPage selectedChild", structureGalleryPage, structureGallery.selectedChild);
			assertNull("Structural galleryPage has null selectedChild", structureGalleryPage.selectedChild);
			assertNull("Structural about has null selectedChild", structureAbout.selectedChild);
			
			structureRoot.selectedChild = structureGallery;
			assertStrictlyEquals("Structure root has selectedChild gallery", structureGallery, structureRoot.selectedChild);
			assertNull("Structural home has null selectedChild", structureHome.selectedChild);
			assertStrictlyEquals("Structure gallery has galleryPage selectedChild", structureGalleryPage, structureGallery.selectedChild);
			assertNull("Structural galleryPage has null selectedChild", structureGalleryPage.selectedChild);
			assertNull("Structural about has null selectedChild", structureAbout.selectedChild);
			
			assertStrictlyEquals("The selectedChild chain is root/gallery/galleryPage", structureGalleryPage, structureRoot.selectedChild.selectedChild);
			
			// TODO: test selectedChildIndex gets set when these do
		}
		
		public function testSelectedChildIndex():void
		{
			structureRoot = setupComplexStructuralHierarchy();
			
			assertEquals("Structure root has -1 selectedChildIndex by default", -1, structureRoot.selectedChildIndex);
			assertEquals("Structure home has -1 selectedChildIndex by default", -1, structureHome.selectedChildIndex);
			assertEquals("Structure gallery has -1 selectedChildIndex by default", -1, structureGallery.selectedChildIndex);
			assertEquals("Structure galleryPage has -1 selectedChildIndex by default", -1, structureGalleryPage.selectedChildIndex);
			assertEquals("Structure about has -1 selectedChildIndex by default", -1, structureAbout.selectedChildIndex);
			
			structureRoot.selectedChildIndex = 0;
			assertEquals("Structure root has 0 selectedChildIndex when home is selected", 0, structureRoot.selectedChildIndex);
			assertEquals("Structure home has -1 selectedChildIndex when home is selected", -1, structureHome.selectedChildIndex);
			assertEquals("Structure gallery has -1 selectedChildIndex when home is selected", -1, structureGallery.selectedChildIndex);
			assertEquals("Structure galleryPage has -1 selectedChildIndex when home is selected", -1, structureGalleryPage.selectedChildIndex);
			assertEquals("Structure about has -1 selectedChildIndex when home is selected", -1, structureAbout.selectedChildIndex);
			
			structureRoot.selectedChildIndex = 2;
			assertEquals("Structure root has 2 selectedChildIndex when about is selected", 2, structureRoot.selectedChildIndex);
			assertEquals("Structure home has -1 selectedChildIndex when about is selected", -1, structureHome.selectedChildIndex);
			assertEquals("Structure gallery has -1 selectedChildIndex when about is selected", -1, structureGallery.selectedChildIndex);
			assertEquals("Structure galleryPage has -1 selectedChildIndex when about is selected", -1, structureGalleryPage.selectedChildIndex);
			assertEquals("Structure about has -1 selectedChildIndex when about is selected", -1, structureAbout.selectedChildIndex);
			
			structureRoot.selectedChildIndex = 1;
			structureGallery.selectedChildIndex = 0;
			assertEquals("Structure root has 1 selectedChildIndex when gallery is selected", 1, structureRoot.selectedChildIndex);
			assertEquals("Structure home has -1 selectedChildIndex when gallery is selected", -1, structureHome.selectedChildIndex);
			assertEquals("Structure gallery has 0 selectedChildIndex when gallery is selected", 0, structureGallery.selectedChildIndex);
			assertEquals("Structure galleryPage has -1 selectedChildIndex when gallery is selected", -1, structureGalleryPage.selectedChildIndex);
			assertEquals("Structure about has -1 selectedChildIndex when gallery is selected", -1, structureAbout.selectedChildIndex);
			
			// TODO: check setting index out of bounds
		}
		
	}
}