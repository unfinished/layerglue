package com.layerglue.lib.base.substitution
{
	public interface ISubstitutor
	{
		function process(unsubstitutedData:*, strategy:ISubstitutionSource):*
		function getMissingSourceKeys(unsubstitutedData:*, strategy:ISubstitutionSource):Array
		function getMissingDestinationKeys(strategy:ISubstitutionSource):Array
	}
}