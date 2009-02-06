package tests.com.layerglue.lib.collections
{
	import com.layerglue.lib.base.collections.ArrayExt;
	import com.layerglue.lib.base.collections.ICollection;
	
	public class ArrayExtTest extends AbstractCollectionTest
	{
		public function ArrayExtTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override protected function createCollection(itemsToAdd:Array=null):ICollection
		{
			return new ArrayExt(itemsToAdd);
		}
		
	}
}