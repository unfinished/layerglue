package com.client.project.maps
{
	import com.client.project.controllers.ArtistController;
	import com.client.project.controllers.ContactController;
	import com.client.project.controllers.GalleryController;
	import com.client.project.controllers.HomeController;
	import com.client.project.controllers.ArtistImageController;
	import com.client.project.controllers.SiteController;
	import com.client.project.model.structure.Artist;
	import com.client.project.model.structure.Contact;
	import com.client.project.model.structure.Gallery;
	import com.client.project.model.structure.Home;
	import com.client.project.model.structure.ArtistImage;
	import com.client.project.model.structure.Site;
	import com.layerglue.lib.application.maps.StructuralDataToContollerMap;

	public class ProjectStructureToControllerMap extends StructuralDataToContollerMap
	{
		public function ProjectStructureToControllerMap()
		{
			super();
			
			addClassReferenceMapping(Site, SiteController);
			addClassReferenceMapping(Home, HomeController);
			addClassReferenceMapping(Gallery, GalleryController);
			addClassReferenceMapping(Artist, ArtistController);
			addClassReferenceMapping(ArtistImage, ArtistImageController);
			addClassReferenceMapping(Contact, ContactController);
		}
		
	}
}