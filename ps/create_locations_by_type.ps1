$locationType = "Hospice"
$template = "/sitecore/templates/Project/pmdt-jss-site/LocationsFolder/" + $locationType
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$importList = ""
foreach ( $row in $importList ) {
     
	$name = $row.LocationName
	#Check if Title is not empty
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	
	$itemPath = $parentPath + "/" + $name + "/" + "data" #Create Item path
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
	
	
	#Assign Field values to the Sitecore Item  
	$item.Editing.BeginEdit()
	$item["LocationId"] = $row.LocationId
	$item["Enabled"] = $row.Enabled
	$item["LocationName"] = $row.LocationName
	$item["Address"] = $row.Address
	$item["Latitude"] = $row.Latitude
	$item["Longitude"] = $row.Longitude
	$item["Email"] = $row.Email
	$item["MapDownload"] = $row.MapDownload
	$item["PhoneNumbers"] = $row.PhoneNumbers
	$item["FaxNumbers"] = $row.FaxNumbers
	$item["HideFromSiteSearch"] = $row.HideFromSiteSearch
	$item["HideFromLocationSearch"] = $row.HideFromLocationSearch
	$item["HideFromProviderDisplay"] = $row.HideFromProviderDisplay
	#$item["Description"] = $row.Description
	$item.Editing.EndEdit()
}
