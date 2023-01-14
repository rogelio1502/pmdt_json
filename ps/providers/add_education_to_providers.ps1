
$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/Education" 
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/provider_education.json' -UseBasicParsing
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
        $folderPath = $itemPath + "/" + "Education"
        $folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
        
        if($folderItem -eq $null){
            New-Item -Path $folderPath -ItemType $folderTemplate
        }
        
        $educationItemPath = $folderPath + "/" + $row.education
        
        $educationItem = Get-Item -Path $educationItemPath -ErrorAction SilentlyContinue
        if($educationItem -eq $null){
            $educationItem = New-Item -Path $educationItemPath -ItemType $template
        }
        
    	#Assign Field values to the Sitecore Item  
    	$item = $educationItem
    	$item.Editing.BeginEdit()
    	$item["InstitutionName"] = $row.institution_name
        $item["Type"] = $row.education_types
        $item["YearCompleted"] = $row.year_completed
        $item["Completed"] = $row.completed
        
    	$item.Editing.EndEdit()
    	$c = $c + 1
    	Write-Host $c
    }


	
}
