$locationType = "PalliativeCare"
$template = "/sitecore/templates/Project/pmdt-jss-site/LocationsFolder/" + $locationType
$folderTemplate = "/sitecore/templates/common/folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$gitPath = 'https://rogelio1502.github.io/pmdt_json/' +$locationType + ".json"
$importList = $importList =  curl $gitPath -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$c = 0
foreach ( $row in $importList ) {

	$name = $row.name
	#Check if Title is not empty
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	
	$folderPath = $parentPath + "/" + $name #Create folder item path
	write-host $folderPath
	$folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($folderItem -eq $null) #Check if Item is null then create new Item
	{
		try
		{
		    continue
		    #New-Item -Path $folderPath -ItemType $folderTemplate
			#write-host "Item created: " $folderPath       
			
		}             
		catch
		{
			write-host "Failed to create Folder Root Item: " $folderPath                
			write-host $_.Exception.Message    
			break
		}
 
    }
    
    $itemPath = $folderPath + "/data"
    $item = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
    if($item -eq $null){
        try{
            $item = New-Item -Path $itemPath -ItemType $template #Get the sitecore Item
			write-host "Data Item created: " $itemPath    
			$item.Editing.BeginEdit()
	        $item["LocationName"] = $row.LocationName
	        $item["Email"] = $row.email
	        $item["LocationId"] = $row.LocationId
	        $item["Address"] = $row.Address
	        $item["City"] = $row.City
	        $item["State"] = $row.State
	        $item["Fax"] = $row.Fax
	        $item["Phone"] = $row.Phone
	        $item["ZipCode"] = $row.ZipCode
	        $item["Latitude"] = $row.Latitude
	        $item["Longitude"] = $row.Longitude
	        $item["Enabled"] = 1
 	        $item.Editing.EndEdit()
        }catch{
            write-host "Failed to create DATA Item: " $itemPath                
			write-host $_.Exception.Message    
			break
        }
    }else{
            $item.Editing.BeginEdit()
	        $item["LocationName"] = $row.LocationName
	        $item["Email"] = $row.email
	        $item["LocationId"] = $row.LocationId
	        $item["Address"] = $row.Address
	        $item["City"] = $row.City
	        $item["State"] = $row.State
	        $item["FaxNumbers"] = $row.Fax
	        $item["PhoneNumbers"] = $row.Phone
	        $item["ZipCode"] = $row.ZipCode
	        $item["Latitude"] = $row.Latitude
	        $item["Longitude"] = $row.Longitude
	        $item["Enabled"] = 1
	        $item.Editing.EndEdit()
    }

	
	#$folders = "CardCollections","Faqs","FeaturedContentBlocks","MediaGalleryFloorPlans","MediaGalleryVirtualTours",
	#"MediaGalleryPhotos","NewsFilmstrips","ParentLocations","RelatedNewsStoriesFilmstrips","Testimonials","TextContentBlocks","TabbedContent",
	#"OurPracticeLocations","OurProviders","HelpfullLinks","EducationAndCredentials","Services","Conditions","Procedures"
    $folders = ""
    foreach ($folder in $folders)
    {
        $itemPath = $parentPath + "/" + $name + "/" + $folder
    	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
    	if($currentItem -eq $null) #Check if Item is null then create new Item
    	{
    		try
    		{
    			$item = New-Item -Path $itemPath -ItemType $folderTemplate                     
    			write-host "Item created: " $itemPath             
    		}             
    		catch
    		{
    			write-host "Failed to create SUB FOLDER Item: " $itemPath                
    			write-host $_.Exception.Message    
    			break
    		}
    	}
    }
	$c = $c + 1
	Write-Host $c
	
	
}
