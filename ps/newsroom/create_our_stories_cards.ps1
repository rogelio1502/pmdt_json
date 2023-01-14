
$template = "/sitecore/templates/Project/pmdt-jss-site/Promedica-Newsroom/Card" 
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/Promedica-Newsroom/Our Stories/Cards"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/our_cards.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$c = 1

foreach ( $row in $importList ) {
     
	$name = $row.name
	
	#Check if Title is not empty
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	
	$itemPath = $parentPath + "/" + $name  #Create Item path
	
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue #Get the sitecore Item
	if($currentItem -eq $null) #Check if Item is null then create new Item
	{
		try
		{
			$item = New-Item -Path $itemPath -ItemType $template                       
			write-host "Item created: " $itemPath             
		}             
		catch
		{
			write-host "Failed to create Item: " $itemPath                
			write-host $_.Exception.Message    
			continue
		}
	
    }else{
        Write-Host "Exists" $row.id $row.npi $row.enabled $row.name $row.name_prefix
    }
	
	$currentItem = Get-Item -Path $itemPath -ErrorAction SilentlyContinue
	$item = $currentItem
	#Assign Field values to the Sitecore Item  
	$item.Editing.BeginEdit()
	$item["Title"] = $row.Title
	$item["Description"] = $row.Description
	$item["LinkSrc"] = $row.LinkSrc
	$item["LinkText"] = $row.LinkText
	$item["ImgSrc"] = $row.ImgSrc
	$item["ImgAlt"] = $row.ImgAlt
	$item["CardId"] = $c
	$item["ArticleId"] = $row.Article_Id
	
	$item.Editing.EndEdit()
	$c = $c + 1
	Write-Host $c
	
}
