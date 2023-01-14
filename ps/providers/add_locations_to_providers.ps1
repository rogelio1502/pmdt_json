
$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/Location" 
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/new_providers_locations.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$c = 0

foreach ( $row in $importList ) {
     
	$name = $row.name
	
	
	$itemPath = $parentPath + "/" + $name #Create Item path
	
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($currentItem -eq $null) #Check if Item is null then create new Item
	{
		
	
    }else{
        
        Write-Host "Exists" $row.id $row.npi $row.enabled $row.name $row.name_prefix
        $folderPath = $itemPath + "/" + "Locations"
        $folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
        
        if($folderItem -eq $null){
            New-Item -Path $folderPath -ItemType $folderTemplate
        }
        
        $locationItemPath = $folderPath + "/" + $row.location_id
        
        $locationItem = Get-Item -Path $locationItemPath -ErrorAction SilentlyContinue
        if($locationItem -eq $null){
            $locationItem = New-Item -Path $locationItemPath -ItemType $template
        }
        
    	#Assign Field values to the Sitecore Item  
    	$item = $locationItem
    	$item.Editing.BeginEdit()
    	$item["LocationId"] = $row.location_id
        $item["LocationName"] = $row.location_name
        $item["Schedules"] = $row.location_chedules
        $item["Primary"] = $row.location_primary
        $item["AllowAppointmentRequests"] = $row.location_allow_appointments
        $item["AcceptingNewPatients"] = $row.location_accepting_new_patients
        $item["HideFromDisplay"] = $row.location_hide_from_display
        $item["PhoneNumber"] = $row.location_phone_number
        $item["FaxNumber"] = $row.location_fax_number
    	
    	$item.Editing.EndEdit()
    	$c = $c + 1
    	Write-Host $c
    }
	#if($c -eq 100){
	#   break
	#}

	
}
