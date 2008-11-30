package com.layerglue.lib.base.geom
{
	public class CubeDescription3d extends Description3d
	{
		public function CubeDescription3d(size3d:Size3d=null, position3d:Position3d=null, rotation3d:Rotation3d=null)
		{
			super(position3d, rotation3d);
			this.size = size;
		}
		
		private var _size:Size3d;

		public function get size():Size3d
		{
			return _size;
		}

		public function set size(v:Size3d):void
		{
			_size = v;
		}
		
		override public function deserialize(xml:XML):void
		{
			super.deserialize(xml);
			
			for each(var prop:XML in xml.children())
			{
				
				switch(prop.localName())
				{
					case "size":
						size = new Size3d();
						size.deserialize(prop.valueOf());
					break;	
				}
			}
		}
	}
}