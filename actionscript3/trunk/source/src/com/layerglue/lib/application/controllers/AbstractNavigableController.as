package com.layerglue.lib.application.controllers
{
	import com.layerglue.lib.application.navigation.NavigationManager;
	import com.layerglue.lib.application.navigation.NavigationPacket;
	import com.layerglue.lib.application.navigation.NavigationPacket;
	/**
	 * The abstract base class for all Navigable controllers.
	 */
	public class AbstractNavigableController extends AbstractController implements INavigableController
	{	
		public function AbstractNavigableController()
		{
			super();
		}
		
		public function navigate():void
		{
			structuralData.selected = true;
			
			startTransitionIn();
		}
		
		override public function startTransitionIn():void
		{
			//This will be asynchronous in subclasses
			throw new Error("AbstractNavigableController: startTransitionIn() must be overriden in subclasses");
		}
		
		override public function startTransitionOut():void
		{
			//trace("AbstractNavigableController.startTransitionOut: " + structuralData.uri + " - " + this);
			throw new Error("AbstractNavigableController: startTransitionOut() must be overriden in subclasses");
		}
		
		public function unnavigateToCommonNode():void
		{
			var currentAddressPacketControllerAtOurDepth:INavigableController = navigationManager.currentAddressPacket.getControllerAtDepth(depth) 
			if(isRoot() || ( currentAddressPacketControllerAtOurDepth && structuralData == currentAddressPacketControllerAtOurDepth.structuralData))
			{
				navigationManager.unnavigationCompleteHandler(this);
			}
			else
			{
				startTransitionOut();
			}
		}
		
		protected function tryShallowerUnnavigation():void
		{
			structuralData.selected = false;
			(parent as INavigableController).unnavigateToCommonNode();
		}
		
		protected function setStructuralDataToUnselected():void
		{
			if(structuralData.parent)
			{
				//trace("setStructuralDataToUnselected: "+this);
				structuralData.selected = false;
			}
		}
		
		protected function tryDeeperNavigation():void
		{
			var p:NavigationPacket = navigationManager.currentAddressPacket;
			
			var c:INavigableController = p.getControllerAtDepth(depth+1);
			
			if(c)
			{
				c.navigate();
			}
		}
		
		protected function setStructuralDataToSelected():void
		{
			if(structuralData.parent)
			{
				structuralData.parent.selectedChild = structuralData;
			}
		}
		
		/* public function getSelectedChildFromPacket(packet:NavigationPacket):IController
		{
			var child:IController;
			if(packet.hasChildAtDepth(depth+1))
			{
				child = getChildByUriNode(packet.getUriNodeStringAtDepth(depth+1));
			}
			return child;
		} */
		
		/**
		 * Searches contained children for an item with a structuralData.uriNode property matching
		 * the supplied value
		 */
		public function getChildByUriNode(nodeName:String):INavigableController
		{
			var child:INavigableController;
			for each(child in children)
			{
				if(child.structuralData.uriNode == nodeName)
				{
					return child;
				}
			}
			
			return null;
		}
		
		/**
		 * Searches contained children for an item with a structuralData.id property matching
		 * the supplied value
		 */
		public function getChildById(id:String):INavigableController
		{
			var child:INavigableController;
			for each(child in children)
			{
				if(child.structuralData.id == id)
				{
					return child;
				}
			}
			
			return null;
		}
		
		/**
		 * Returns the default child of this controller if one is specified
		 */
		public function get defaultChild():INavigableController
		{
			return structuralData.defaultChild ? getChildByUriNode(structuralData.defaultChild.uriNode) : null;
		}
		
		
	}
}