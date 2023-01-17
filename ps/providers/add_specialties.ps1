$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/SpecialtiesItem" 
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/providers_specialties.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$c = 0

foreach ( $row in $importList ) {
     
	$name = $row.name
	
	$itemPath = $parentPath + "/" + $name #Create Item path
	
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($currentItem -eq $null) #Check if Item is null then create new Item
	{
		
	
    }else{
        
        Write-Host "Exists" $row.name
        $folderPath = $itemPath + "/" + "Specialties"
        #$folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
      
        #if($folderItem -eq $null){
        #    New-Item -Path $folderPath -ItemType $folderTemplate
        #}
        
        $newItemPath = $folderPath + "/" + $row.SpecialtyName

        $newItem = Get-Item -Path $newItemPath -ErrorAction SilentlyContinue
        if($newItem -eq $null){
            $newItem = New-Item -Path $newItemPath -ItemType $template
        
        }
        
    	#Assign Field values to the Sitecore Item  
    	$item = $newItem
    	$item.Editing.BeginEdit()
    	$item['Title'] = $row.SpecialtyName
    	$item["BoardCertified"] = $row.IsCertified
    	$item["Primary"] = $row.IsPrimary
    
    	$item.Editing.EndEdit()
    	$c = $c + 1
    	Write-Host $c
    	
    }


	
}
