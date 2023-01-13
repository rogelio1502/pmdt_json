$locationType = "PPG"
$template = "/sitecore/templates/Project/pmdt-jss-site/LocationsFolder/" + $locationType
$listSection = "/sitecore/templates/Project/pmdt-jss-site/LocationsFolder/ListSection"
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/ppg_url_zip.json' -UseBasicParsing
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
			$item = New-Item -Path $itemPath -ItemType $template                  
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
        $pLPath = $parentPath + "/" + $name + "/ParentLocations"
        $plItem = Get-Item -Path $pLPath -ErrorAction SilentlyContinue
        if($pLItem -eq $null){
            write-host "Folder ParentLocations already removed"
        }else{
            Get-Item -Path $pLPath | Remove-Item -ErrorAction SilentlyContinue
           
        }
        $txtBlockPath = $parentPath + "/" + $name + "/TextContentBlocs"
        $txtBlockItem = Get-Item -Path $txtBlockPath -ErrorAction SilentlyContinue
        
        if($txtBlockItem -eq $null){
            write-host "Text Content Blocs already removed"
        }else{
            Get-Item $txtBlockPath | Remove-Item
            $txtBlockPath = $parentPath + "/" + $name + "/TextContentBlocks"
            $blockOkPath = Get-Item $txtBlockPath -ErrorAction SilentlyContinue
            if($blockOkPath -eq $null){
                New-Item -Path $txtBlockPath -ItemType $folderTemplate
            }
            
        }
        
        
    }
    

    
    $newFolders = "Services","Conditions","EducationAndCredentials","Procedures"
    foreach($newFolder in $newFolders){
        $folderPath = $parentPath + "/" + $name + "/" + $newFolder
        $folder = Get-Item $folderPath -ErrorAction SilentlyContinue
        if($folder -eq $null){
            New-Item -Path $folderPath -ItemType $folderTemplate
        }
        $dataPath = $folderPath + "/data"
        $item = Get-Item -Path $dataPath -ErrorAction SilentlyContinue
        if($item -eq $null){
            $item = New-Item -Path $dataPath -ItemType $listSection
            $item.Editing.BeginEdit()
            $item["Title"] = $newFolder
            $item.Editing.EndEdit()
        }
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
