package com.layerglue.controls.geom
{
	public class Description3d extends Object
	{
		public function Description3d(position3d:Position3d=null, rotation3d:Rotation3d=null)
		{
			super();
		}
		
		private var _position:Position3d;

		public function get position():Position3d
		{
			return _position;
		}

		public function set position(value:Position3d):void
		{
			_position = value;
		}
		
		private var _rotation:Rotation3d;

		public function get rotation():Rotation3d
		{
			return _rotation;
		}

		public function set rotation(value:Rotation3d):void
		{
			_rotation = value;
		}
		
		public function deserialize(xml:XML):void
		{
			for each(var prop:XML in xml.children())
			{
				switch(prop.localName())
				{
					case "position":
						position = new Position3d();
						position.deserialize(prop.valueOf());
					break;
					
					case "rotation":
						rotation = new Rotation3d();
						rotation.deserialize(prop.valueOf());
					break;	
				}
			}
		}
		
		
	}
}