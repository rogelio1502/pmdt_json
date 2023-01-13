#$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/Location" 
#$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/locations.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$providersList = Get-Item -Path $parentPath
$c = 0

foreach ( $row in $providersList.Children ) {
     
	Write-Host $row.name
	$providerPath = $parentPath + "/" + $row.name + "/Locations"
	$providerLocationsItem = Get-Item -Path $providerPath 
	foreach($location in  $providerLocationsItem.Children){
	    Write-Host $location.name
	    foreach($loc in $importList){
	        if($loc.id -eq $location.name){
	            
	            $itemPath = 	$providerPath + "/" + $loc.id
	            Write-Host $itemPath
	            $item = Get-Item -Path $itemPath 
	            if($item -eq $null){
	                Write-Host "Not Exists" 
	                break
	            }
	            Write-Host "Exists"
	            Write-Host "Updating..."
            	$item.Editing.BeginEdit()
            	$item["Address"] = $loc.Address
                $item["ZipCode"] = $loc.ZipCode
                $item["DirectURL"] = $loc.DirectURL
                $item["City"] = $loc.City
                $item["State"] = $loc.State
                $item["Latitude"] = $loc.Latitude
                $item["Longitude"] = $loc.Longitude
                $item["Enabled"] = 1
                
                
            	$item.Editing.EndEdit()
	        }
	    }
	}
	
}
