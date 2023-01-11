
$template = "/sitecore/templates/Project/pmdt-jss-site/DoctorsFolder/Doctor" 
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/NewProviders2"
#Read CSV file
$importList = $importList =  curl 'https://rogelio1502.github.io/pmdt_json/providers.json' -UseBasicParsing
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
	
	$itemPath = $parentPath + "/" + $name + "/" + "data" #Create Item path
	
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
	$item["DoctorId"] = $row.id
	
	$item["NPI"] = $row.npi
	$item["Enabled"] = $row.enabled
	$item["ProviderImage"] = $row.image_path
	$item["NamePrefix"] = $row.name_prefix
	$item["NameSuffix"] = $row.name_suffix
	$item["FirstName"] = $row.first_name
	$item["MiddleName"] = $row.middle_name
	$item["LastName"] = $row.last_name
	$item["AdditionalSuffix"] = $row.additional_suffix
	$item["Gender"] = $row.gender
	$item["InPracticeSince"] = $row.in_practice_since
	$item["Email"] = $row.primary_email
	$item["Fax"] = $row.primary_fax
	$item["Phone"] = $row.primary_phone
	$item["Website"] = $row.primary_website
	$item["Specialty"] = $row.specialties
	$item["Languages"] = $row.languages
	$item["VirtualVisitsAvailable"] = $row.offers_online_visits
	$item["AboutMeBio"] = $row.about_me
	$item["Research"] = $row.research
	$item["PageTitle"] = $row.seo_page_title
	$item["MetaDescription"] = $row.seo_page_description
	$item["HideFromProviderSearch"] = $row.hide_form_provider_search
	$item["HideFromSiteSearch"] = $row.hide_from_site_search
	$item["ExcludedKeywords"] = $row.excluded_keywords
	$item["ChartDepartmentNumber"] = $row.my_chart_department_number
	$item["ChartNumber"] = $row.my_chart_number
	$item["CustomKeywords"] = $row.custom_keywords
	$item["EffectiveKeywords"] = $row.effective_keywords
	$item["OfferOnlineScheduling"] = $row.offers_online_scheduling
	$item.Editing.EndEdit()
	$c = $c + 1
	Write-Host $c
	
}
