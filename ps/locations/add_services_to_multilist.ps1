$locations = "AssistedLiving","HomeHealth","Hospital","Hospice","MemoryCare","PalliativeCare","SkilledNursing","Tier2-3","PPG"
$locationServicesPath = "master:/sitecore/content/pmdt-jss-site/Content/Database/LocationServices"
$ServicesPath = "master:/sitecore/content/pmdt-jss-site/Content/Database/Services"
$matches = 0
foreach($location in $locations){
    $locationType = $location

    $parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewLocations/" + $locationType
    #Read CSV file
    $importList = Get-Item -Path $parentPath -ErrorAction SilentlyContinue
    foreach ( $row in $importList.Children ) {
         
    	$locationPath = $parentPath + "/" + $row.name + "/data"  #Create Item path
    	
        
        
        $locationItem = Get-Item -Path $locationPath -ErrorAction SilentlyContinue
        if($locationItem -eq $null){
            continue;
        }else{
            Write-Host "Updating " $locationPath
            if($locationItem['LocationId'] -eq $null -or  $locationItem['LocationId'] -eq ''){
                Write-Host "No Id"
                continue;
            }
            $locationServicesFolder = Get-Item -Path $locationServicesPath -ErrorAction SilentlyContinue
            foreach($lschild in $locationServicesFolder.Children){
     
                if($lschild['LocationServicesLocationId'] -eq $locationItem.LocationId){
    
                    Write-Host "YEEES " $lschild.Name 
                    Write-Host "LocationId" $locationItem.LocationId
                    
                    $targetName = $lschild['LocationServicesService']
                    
                    $servicesFolder = Get-Item -Path $servicesPath -ErrorAction SilentlyContinue
                    
                    foreach($serviceItem in $servicesFolder.Children){
                        if($serviceItem['ServicesName'] -eq $targetName -and !$serviceItem['ServicesName'] -eq ''){
                            try{
                                if($locationItem['Services2'].Contains($serviceItem.ID.ToString())){ continue }
                                $locationItem.Editing.BeginEdit()
                                if (![string]::IsNullOrEmpty($locationItem['Services2'])) {
                                    $locationItem['Services2'] += "|";
                                }
                                $locationItem['Services2'] += $serviceItem.ID.ToString()
                                $locationItem.Editing.EndEdit()
                                Write-Host $serviceItem.ID.ToString()
                                Write-Host "Updated"
                            }catch{
                                Write-Host "Error to set"
                                
                            }
                            
                            
                            
                            $matches += 1
                            
                        }
                    }
                }
            }
        
        }
      
        
        
    }
}
Write-Host $matches
