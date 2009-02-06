/**
 * FlashQuery - Returns query variables from URL string
 */
function getQueryVar(urlVarName)
{
	//divide the URL in half at the '?'
	var urlHalves = String(document.location).split('?');
	var urlVarValue = '';
	
	if(urlHalves[1])
	{
		//load all the name/value pairs into an array
		var urlVars = urlHalves[1].split('&');
		
		//loop over the list, and find the specified url variable
		for(i=0; i<=(urlVars.length); i++)
		{
			if(urlVars[i])
			{
				//load the name/value pair into an array
				var urlVarPair = urlVars[i].split('=');
				if (urlVarPair[0] && urlVarPair[0] == urlVarName)
				{
					//I found a variable that matches, load it's value into the return variable
					urlVarValue = urlVarPair[1];
				}
			}
		}
	}
	
	return urlVarValue;   
}