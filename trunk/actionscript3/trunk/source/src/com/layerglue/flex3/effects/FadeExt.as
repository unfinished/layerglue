package com.layerglue.flex3.effects
{
	import mx.effects.Fade;
	
	/**
	 * An extension of the Fade class to allow construction in one line.
	 */
	public class FadeExt extends Fade
	{
		public function FadeExt(
			target:Object=null,
			alphaFrom:Number=NaN,
			alphaTo:Number=NaN,
			duration:Number=500,
			startDelay:Number=NaN)
		{
			super(target);
			
			this.target = target,
			this.alphaFrom = alphaFrom ? alphaFrom : target.alpha;
			
			this.alphaTo = alphaTo;
			this.duration = duration;
			this.startDelay = startDelay;
		}
		
	}
}