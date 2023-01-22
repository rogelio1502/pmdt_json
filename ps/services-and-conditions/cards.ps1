$template = "/sitecore/templates/Project/pmdt-jss-site/ServicesAndConditions/Card"
#$folderTemplate = "/sitecore/templates/common/folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/ServicesAndConditions/Cards"
#Read CSV file
$importList = $importList =  curl 'https://raw.githubusercontent.com/LuigiEspinosa/promedica-scraper/main/json/ProMedica/services-conditions/services-conditions.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$c = 0
foreach ( $row in $importList ) {

	$name = $row.name
	#Check if Title is not empty
	
	if($name -eq $null){
	    continue
	}
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	$name = $row.name.replace("'", "").replace("/","")
	$path = $parentPath + "/" + $name
	$item = Get-Item -Path $path -ErrorAction SilentlyContinue
	
	if($item -eq $null){
	    try{
	        $item = New-Item -Path $path -ItemType $template
	        
	    }catch{
	        Write-Host $path
	        write-host $_.Exception.Message    
	        break
	    }

	}
	
	$item.Editing.BeginEdit()
	$item['CardId'] = $row.id
	$item['Description'] = $row.description
	$item['DetailsUrl'] = $row.details
	$item["ProvidersUrl"] = $row.providers
	$item["LocationsUrl"] = $row.locations
	$item["Title"] = $row.name
	$item.Editing.EndEdit()
	
	
	$c = $c + 1
	Write-Host $name
	Write-Host $c
	
	
}
