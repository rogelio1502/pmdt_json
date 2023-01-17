$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/TypesItem" 
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/providers_types.json' -UseBasicParsing
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
        $folderPath = $itemPath + "/" + "Types"
        $folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
      
        if($folderItem -eq $null){
            continue;
        }
        
        $newItemPath = $folderPath + "/" + $row.TypeName

        $newItem = Get-Item -Path $newItemPath -ErrorAction SilentlyContinue
        if($newItem -eq $null){
            $newItem = New-Item -Path $newItemPath -ItemType $template
        }
        
    	#Assign Field values to the Sitecore Item  
    	$item = $newItem
    	$item.Editing.BeginEdit()
    	$item['Title'] = $row.TypeName
    	$item.Editing.EndEdit()
    	$c = $c + 1
    	Write-Host $c
    	
    	
    }


	
}
