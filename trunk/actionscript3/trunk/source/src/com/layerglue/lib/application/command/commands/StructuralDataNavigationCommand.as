package com.layerglue.lib.application.command.commands
{
	import com.asual.swfaddress.SWFAddress;
	import com.layerglue.lib.application.LayerGlueLocator;
	import com.layerglue.lib.application.command.requests.StructuralDataNavigationRequest;
	import com.layerglue.lib.application.structure.IStructuralData;
	import com.layerglue.lib.base.command.commands.AbstractCommand;
	import com.layerglue.lib.base.command.requests.IRequest;
	

	/**
	 * <p>A command dealing with navigation requests by the system.</p>
	 * 
	 */
	public class StructuralDataNavigationCommand extends AbstractCommand
	{
		public function StructuralDataNavigationCommand()
		{
			super();
		}
		
		private function get typedRequest():StructuralDataNavigationRequest
		{
			return request as StructuralDataNavigationRequest;
		}
		
		override public function execute(request:IRequest):void
		{
			super.execute(request);
			
			trace("typedRequest.hideFromBrowser:" + typedRequest.hideFromBrowser)
			
			if(typedRequest.hideFromBrowser)
			{
				LayerGlueLocator.getInstance().navigationManager.processStructuralDataNavigation(typedRequest.structuralData);
			}
			else
			{
				if(typedRequest.structuralData.uri != SWFAddress.getValue())
				{
					//TODO: Check that entire structural data chain has valid uri getters
					var structuralData:IStructuralData = typedRequest.structuralData;
					while (structuralData.parent)
					{
						if (structuralData.uriNode == null)
						{
							throw new Error("Attempted navigation to StruturalData with invalid uri, id=" + structuralData.id + ", " + structuralData);
						}
						structuralData = structuralData.parent;
					}
					trace("StructuralDataNavigationCommand before SWFAddress.setValue");
					SWFAddress.setValue(typedRequest.structuralData.uri);
					trace("StructuralDataNavigationCommand after SWFAddress.setValue");
				}
			}
		}
	}
}