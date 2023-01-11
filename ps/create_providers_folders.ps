$template = "/sitecore/templates/common/folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders2"
#Read CSV file
$importList =  curl 'https://rogelio1502.github.io/pmdt_json/providers_folders.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
foreach ( $row in $importList ) {
     
	$name = $row.name
	#Check if Title is not empty
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	
	$itemPath = $parentPath + "/" + $name #Create Item path
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
	}
    $folders = "HospitalAffilitations","Locations","Education","MediaVideos","MediaNews","CustomTabbedContent","Testimonials","InPracticeWith"
    foreach ($folder in $folders)
    {
        $itemPath =$parentPath + "/" + $name + "/" + $folder
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
    	}
    }
	
	
}
