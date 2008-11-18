package tests.com.layerglue.lib.collections
{
	import com.layerglue.lib.base.collections.ICollection;
	import com.layerglue.lib.base.collections.Collection;
	
	public class CollectionTest extends AbstractCollectionTest
	{
		public function CollectionTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override protected function createCollection():ICollection
		{
			return new Collection();
		}		
	}
}