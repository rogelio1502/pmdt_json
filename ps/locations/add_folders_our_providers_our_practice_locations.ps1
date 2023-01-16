$locationType = "Hospice"
$template = "/sitecore/templates/Project/pmdt-jss-site/LocationsFolder/" + $locationType
$folderTemplate = "/sitecore/templates/Common/Folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$importList = Get-Item -Path $parentPath 
$c = 0
foreach ( $row in $importList.Children ) {
    
    $subLocation = $parentPath + "/" + $row.name
	Write-Host $subLocation
	$newFolders = "OurProviders","OurPracticeLocations"
	foreach($newFolder in $newFolders){
	    $newPath = $subLocation + "/" + $newFolder
	    $item = Get-Item -Path $newPath -ErrorAction SilentlyContinue
	    if($item -eq $null){
	       Write-Host $newPath + " creating..."
	       New-Item -Path $newPath -ItemType $folderTemplate
	       Write-Host $newPath + " created."
	    }

	}
	
	
	
	

}
