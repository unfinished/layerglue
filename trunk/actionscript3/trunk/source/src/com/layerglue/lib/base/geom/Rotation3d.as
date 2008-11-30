package com.layerglue.lib.base.geom
{
	public class Rotation3d extends Abstract3d
	{
		public function Rotation3d(x:Number=NaN, y:Number=NaN, z:Number=NaN)
		{
			super(x, y, z);
		}
		
		public function toString():String
		{
			return "[ Rotation3d - x: " + x + ", y: " + y + ", z: " + z + " ]";
		}
		
	}
}