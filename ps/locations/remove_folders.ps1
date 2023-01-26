$locationType = "Hospice"

$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
#Read CSV file
$importList = Get-Item -Path $parentPath -ErrorAction SilentlyContinue
foreach ( $row in $importList.Children ) {
     
	$itemPath = $parentPath + "/" + $row.name  #Create Item path
	
 
    Write-Host "Exists" $row.id $row.npi $row.enabled $row.name $row.name_prefix
    
    $fNameList = "ParentLocations","EducationAndCredentials","OurPracticeLocations","RelatedNewsStoriesFilmstrips","NewsFilmstrips","Conditions","Procedures"
    
    foreach($fName in $fNameList){
        $pLPath = $itemPath + "/" + $fName
        Write-Host $pLPath
        $plItem = Get-Item -Path $pLPath -ErrorAction SilentlyContinue
        
        if($pLItem -eq $null){
            write-host "Folder"  $fName   "already removed"
        }else{
            Get-Item -Path $pLPath | Remove-Item -ErrorAction SilentlyContinue
        }
    
    }
    
    
}
