package tests.com.layerglue.lib.collections
{
	import com.layerglue.flex3.base.collections.FlexCollection;
	import com.layerglue.lib.base.collections.ICollection;
	
	public class FlexCollectionTest extends AbstractCollectionTest
	{
		public function FlexCollectionTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override protected function createCollection(itemsToAdd:Array=null):ICollection
		{
			return new FlexCollection(itemsToAdd);
		}
	}
}