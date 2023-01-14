$locationType = "Hospital"
$template = "/sitecore/templates/Project/pmdt-jss-site/LocationsFolder/" + $locationType
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/hospital_url_zip.json' -UseBasicParsing
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
	
	$itemPath = $parentPath + "/" + $name + "/" #Create Item path
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($currentItem -eq $null) #Check if Item is null then create new Item
	{
		try
		{
			#$item = New-Item -Path $itemPath -ItemType $template                       
			#write-host "Item created: " $itemPath             
		}             
		catch
		{
			write-host "Failed to create Item: " $itemPath                
			write-host $_.Exception.Message    
			continue
		}
	
    }else{
        Write-Host "Exists" $row.id $row.npi $row.enabled $row.name $row.name_prefix
        Get-Item -Path $parentPath + "/" + $name + "/" + "ParentLocations"
    }
	
	
	#Assign Field values to the Sitecore Item  
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue
	$item = $currentItem
	#$item.Editing.BeginEdit()
	#$item["ZipCode"] = $row.zip_code
	#$item["DirectURL"] = $row.direct_url

	
	#$item["Description"] = $row.Description
	#$item.Editing.EndEdit()
}
