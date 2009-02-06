package com.layerglue.flex3.base.effects
{
	import mx.effects.Effect;
	import mx.effects.Parallel;
	
	/**
	 * An extension of the Parallel class to allow multiple effects to be passed into the constructor.
	 */
	public class ParallelExt extends Parallel
	{
		public function ParallelExt(...effects)
		{
			super();
			
			for each(var effect:Effect in effects)
			{
				addChild(effect);
			}
			trace("effects: "+effects.length);
		}
		
	}
}