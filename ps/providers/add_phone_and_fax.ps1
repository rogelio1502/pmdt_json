#$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/Location" 
#$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/providers_contact_info.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$providersList = Get-Item -Path $parentPath
$c = 0

foreach ( $row in $providersList.Children ) {
     
	Write-Host $row.name
	$dataPath = $parentPath + "/" + $row.name + "/data"
	$dataItem = Get-Item -Path $dataPath -ErrorAction SilentlyContinue
	if($dataItem -eq $null){
	    Write-Host "Not exists"
	    continue
	}
	 
    foreach($loc in $importList){
        if($loc.directURL -eq $dataItem['DirectURL']){
            $item = $dataItem
            Write-Host "Exists"
            Write-Host "Updating..."
        	$item.Editing.BeginEdit()
        	$item["Phone"] = $loc.phone
            $item["Fax"] = $loc.fax
            
            
        	$item.Editing.EndEdit()
        }
    }
	
	
}
