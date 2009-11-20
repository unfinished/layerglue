package com.client.project.styles
{
	import com.layerglue.flash.styles.LGStyleCollection;
	
	public class GlobalStyle extends LGStyleCollection
	{
		
		[Embed(source="/../embedded-assets/images/layerGlueLogo.gif")]
		public static var testImage:Class;
		
		public function GlobalStyle()
		{
			super();
		}
		
		override protected function defineStyles():void
		{
			
		}
		
		override protected function defineAssets():void
		{
			addAsset("testImage", testImage);
		}

	}
}