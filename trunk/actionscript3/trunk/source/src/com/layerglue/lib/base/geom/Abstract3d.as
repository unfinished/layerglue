package com.layerglue.lib.base.geom
{
	public class Abstract3d extends Object
	{
		public function Abstract3d(x:Number=NaN, y:Number=NaN, z:Number=NaN)
		{
			super();
			
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function deserialize(xml:XML):void
		{
			for each(var prop:XML in xml.children())
			{
				switch(prop.localName())
				{
					case "x":
					case "y":
					case "z":
						this[prop.localName()] = prop.valueOf();
					break;
				}
			}
		}
	}
}