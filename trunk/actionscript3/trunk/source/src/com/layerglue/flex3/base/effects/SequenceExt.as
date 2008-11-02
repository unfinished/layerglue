package com.layerglue.flex3.base.effects
{
	import mx.effects.Effect;
	import mx.effects.Sequence;
	
	/**
	 * An extension of the Sequence class to allow multiple effects to be passed into the constructor.
	 */
	public class SequenceExt extends Sequence
	{
		public function SequenceExt(...effects)
		{
			super();
			
			for each(var effect:Effect in effects)
			{
				addChild(effect);
			}
		}
		
	}
}