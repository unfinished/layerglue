package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.application.views.IView;

	public class NavigableApplicationController extends AbstractNavigableController
	{
		public function NavigableApplicationController(structuralData:IStructuralData, view:IView)
		{
			super();
			
			this.structuralData = structuralData;
			view.structuralData = structuralData;
		}
	}
}