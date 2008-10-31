package com.layerglue.flex3.effects
{
	import mx.effects.Move;
	
	/**
	 * An extension of the Move class to allow construction in one line.
	 */
	public class MoveExt extends Move
	{
		public function MoveExt(
			target:Object=null,
			xFrom:Number=NaN,
			xTo:Number=NaN,
			yFrom:Number=NaN,
			yTo:Number=NaN,
			duration:Number=500,
			startDelay:Number=0)
		{
			super(target);
			
			this.target = target;
			this.xFrom = xFrom ? xFrom : target.x;
			this.xTo = xTo;
			this.yFrom = yFrom ? yFrom : target.y;
			this.yTo = yTo;
			this.duration = duration;
			this.startDelay = startDelay;
		}
		
	}
}