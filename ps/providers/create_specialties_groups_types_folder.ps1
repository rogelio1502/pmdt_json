$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/SpecialtiesItem" 
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = Get-Item -Path $parentPath
$c = 0

foreach ( $row in $importList.Children ) {
     
	$name = $row.name
	
	$itemPath = $parentPath + "/" + $name #Create Item path
	
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($currentItem -eq $null) #Check if Item is null then create new Item
	{
		
	
    }else{
        
        Write-Host "Exists" $row.name
        $folderPath = $itemPath + "/" + "Specialties"
        $folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
      
        if($folderItem -eq $null){
            New-Item -Path $folderPath -ItemType $folderTemplate
        }
        
        $folderPath = $itemPath + "/" + "Types"
        $folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
      
        if($folderItem -eq $null){
            New-Item -Path $folderPath -ItemType $folderTemplate
        }
        
        $folderPath = $itemPath + "/" + "Groups"
        $folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
      
        if($folderItem -eq $null){
            New-Item -Path $folderPath -ItemType $folderTemplate
        }
        
        
        
        
    	$c = $c + 1
    	Write-Host $c
    }


	
}
