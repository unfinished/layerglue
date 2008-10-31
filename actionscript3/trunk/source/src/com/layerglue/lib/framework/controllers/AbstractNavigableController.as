package com.layerglue.lib.framework.controllers
{
	import com.layerglue.lib.framework.navigation.NavigationPacket;
	/**
	 * The abstract base class for all Navigable controllers.
	 */
	public class AbstractNavigableController extends AbstractController implements INavigableController
	{	
		protected var _packet:NavigationPacket;
		
		public function AbstractNavigableController()
		{
			super();
		}
		
		public function navigate(packet:NavigationPacket):void
		{
			//trace("navigate: " + structuralData.uri + " | " + this)
			
			//Store the packet for use later
			_packet = packet;
			
			//Ensure the structural data is correctly set before transitioning in
			setStructuralDataToSelected();
			
			startTransitionIn();
		}
		
		override public function startTransitionIn():void
		{
			//This will be asynchronous in subclasses
			
			//Try to jump down to the next node in the address (if present)
			//tryDeeperNavigation(_packet);
			
			//setTimeout(tryDeeperNavigation, 1000, _packet);
			throw new Error("AbstractNavigableController: startTransitionIn() must be overriden in subclasses");
		}
		
		override public function startTransitionOut():void
		{
			//trace("AbstractNavigableController.startTransitionOut: " + structuralData.uri + " - " + this);
			throw new Error("AbstractNavigableController: startTransitionOut() must be overriden in subclasses");
		}
		
		public function unnavigateToCommonNode(packet:NavigationPacket):void
		{
			//TODO This needs to be more like this make the 404ing work properly but its breaking gallery image stuff in wildside
			//if((structuralData.uriNode == packet.getUriNodeStringAtDepth(depth) && (root as NavigableApplicationController).getControllerHierarchyStrand(packet).length == depth) || isRoot())
			if(structuralData.uriNode == packet.getUriNodeStringAtDepth(depth) || isRoot())
			{
				//We're at the joining node, which will be the root if there are no other matches
				//trace("UNNAVIGATING - WE'RE AT THE JOINING NODE: " + structuralData.id)
				
				(root as INavigableApplicationController).unnavigationCompleteHandler(this)
			}
			else
			{
				//Store the packet for use later
				_packet = packet;
				
				//trace("unnavigate: " + structuralData.id);
			
				startTransitionOut();
			}
		}
		
		protected function tryShallowerUnnavigation(packet:NavigationPacket):void
		{
			// Before we navigate up a level un-set our selected indexes
			setStructuralDataToUnselected();
			(parent as INavigableController).unnavigateToCommonNode(packet);
		}
		
		protected function setStructuralDataToUnselected():void
		{
			if(structuralData.parent)
			{
				//trace("setStructuralDataToUnselected: "+this);
				structuralData.deselect();
			}
		}
		
		protected function tryDeeperNavigation(packet:NavigationPacket):void
		{
			var childUri:String = packet.getUriNodeStringAtDepth(depth+1);
			
			if(packet.hasChildAtDepth(depth+1))
			{
				if(getChildByUriNode(childUri))
				{
					var c:IController = getSelectedChildFromPacket(packet);
					(getSelectedChildFromPacket(packet) as INavigableController).navigate(packet);
				}
				else
				{
					handle404(packet);
				}
			}
			else if(structuralData.defaultChild || structuralData.branchOnly == true)
			{
				getChildByUriNode(structuralData.defaultChildId).navigate(packet);
			}
			else
			{
				//End of navigation
			}
		}
		
		protected function handle404(packet:NavigationPacket):void
		{
			if(structuralData.branchOnly)
			{
				if(!defaultChild)
				{
					throw new Error("Tried to navigate to the default child of branchOnly node and none exists: " + structuralData.uri);
				}
				
				defaultChild.navigate(packet);
			}
			
		}
		
		protected function setStructuralDataToSelected():void
		{
			if(structuralData.parent)
			{
				structuralData.parent.selectedChild = structuralData;
			}
		}
		
		public function getSelectedChildFromPacket(packet:NavigationPacket):IController
		{
			var child:IController;
			if(packet.hasChildAtDepth(depth+1))
			{
				child = getChildByUriNode(packet.getUriNodeStringAtDepth(depth+1));
			}
			return child;
		}
		
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