package com.layerglue.lib.base.geom
{
	public class Position3d extends Abstract3d
	{
		public function Position3d(x:Number=NaN, y:Number=NaN, z:Number=NaN)
		{
			super(x, y, z);
		}
		
		public function toString():String
		{
			return "[ Position3d - x: " + x + ", y: " + y + ", z: " + z + " ]";
		}
	}
}