$locationType = "PPG"
$template = "/sitecore/templates/common/folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$importList = ""
foreach ( $row in $importList ) {
     
	$name = $row.name
	#Check if Title is not empty
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	
	$itemPath = $parentPath + "/" + $name #Create Item path
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($currentItem -eq $null) #Check if Item is null then create new Item
	{
		try
		{
			$item = New-Item -Path $itemPath -ItemType $template                       
			write-host "Item created: " $itemPath             
		}             
		catch
		{
			write-host "Failed to create Item: " $itemPath                
			write-host $_.Exception.Message    
			continue
		}
	}
    $folders = "CardCollections","Faqs","FeaturedContentBlocks","MediaGalleryFloorPlans","MediaGalleryVirtualTours","MediaGalleryPhotos","NewsFilmstrips","ParentLocations","RelatedNewsStoriesFilmstrips","Testimonials","TextContentBlocs","TabbedContent"
    foreach ($folder in $folders)
    {
        $itemPath =$parentPath + "/" + $name + "/" + $folder
    	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
    	if($currentItem -eq $null) #Check if Item is null then create new Item
    	{
    		try
    		{
    			$item = New-Item -Path $itemPath -ItemType $template                      
    			write-host "Item created: " $itemPath             
    		}             
    		catch
    		{
    			write-host "Failed to create Item: " $itemPath                
    			write-host $_.Exception.Message    
    			continue
    		}
    	}
    }
	
	
}
