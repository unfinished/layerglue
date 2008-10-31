package com.layerglue.controls.geom
{
	public class Size3d extends Object
	{
		
		public function Size3d(width:Number=NaN, height:Number=NaN, depth:Number=NaN)
		{
			super();
			
			this.width = width;
			this.height = height;
			this.depth = depth;
		}
		
		public var width:Number;
		public var height:Number;
		public var depth:Number;
		
		public function deserialize(xml:XML):void
		{
			for each(var prop:XML in xml.children())
			{
				switch(prop.localName())
				{
					case "width":
					case "height":
					case "depth":
						this[prop.localName()] = prop.valueOf();
					break;
				}
			}
		}
		
		public function toString():String
		{
			return "[ Sized - width: " + width + ", height: " + height + ", depth: " + depth + " ]";
		}
	}
}