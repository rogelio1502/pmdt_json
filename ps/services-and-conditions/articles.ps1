Add-Type -AssemblyName System.Web.Extensions
$JS = New-Object System.Web.Script.Serialization.JavaScriptSerializer

$template = "/sitecore/templates/Project/pmdt-jss-site/ServicesAndConditions/Article"
$providerTemplate = "/sitecore/templates/Project/pmdt-jss-site/ServicesAndConditions/Providers"
$locationTemplate = "/sitecore/templates/Project/pmdt-jss-site/ServicesAndConditions/Locations"
$folderTemplate = "/sitecore/templates/common/folder"
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/ServicesAndConditions/Articles"
#Read CSV file
$importList = $importList =  curl 'https://raw.githubusercontent.com/LuigiEspinosa/promedica-scraper/main/json/ProMedica/services-conditions/services-conditions-articles.json' -UseBasicParsing
$importList = $importList | ConvertFrom-Json
$c = 0
foreach ( $row in $importList ) {
    
	$name = $row.title
	#Check if Title is not empty
	
	if($name -eq $null){
	    continue
	}
	
	if($name.Trim() -eq "")
	{
		write-host "Item name should not be blank: " $name  
        continue
	}
	$name = $row.title.replace("'", "").replace("/","")
	$folderPath = $parentPath + "/" + $name
	
	$folderItem = Get-Item -Path $folderPath -ErrorAction SilentlyContinue
	
	if($folderItem -eq $null){
	    try{
	        New-Item -Path $folderPath -ItemType $folderTemplate
	        
	    }catch{
	        Write-Host $folderPath
	        write-host $_.Exception.Message    
	        break
	    }

	}
	$articlePath = $folderPath + "/data" 
	$articleItem = Get-Item $articlePath -ErrorAction SilentlyContinue
	
	if($articleItem -eq $null){
	    try{
	        $articleItem = New-Item -Path $articlePath -ItemType $template
	    }catch{
	        Write-Host $articlePath
	        write-host $_.Exception.Message    
	        break
	    }
	}
	

	$item = $articleItem 
	$item.Editing.BeginEdit()
	$item['DetailId'] = $row.id
	$item['Title'] = $row.title
	$item['Url'] = $row.url
	$ctnc = $row.content
	$item["articlecontent"] = $ctnc.articlecontent
	$item["about"] = $ctnc.about
	$item["interest"] = $ctnc.interest
	$item["whatis"] = $ctnc.whatis
	$item["getstarted"] = $ctnc.getstarted
	$item["toknow"] = $ctnc.toknow
	$item["journey"] = $ctnc.journey
	$item["dvtsymptoms"] = $ctnc.dvtsymptoms
	$item["dvtrisks"] = $ctnc.dvtrisks
	$item["mammogram"] = $ctnc.mammogram
	$item["mobile"] = $ctnc.mobile
	$item["toledo"] = $ctnc.toledo
	$item["clinic"] = $ctnc.clinic
	$item["overview"] = $ctnc.overview
	$item["programs"] = $ctnc.programs
	$item["scaledown"] = $ctnc.scaledown
	$item["approach"] = $ctnc.approach
	$item["development"] = $ctnc.development
	$item["Safety"] = $ctnc.safety
	$item["expect"] = $ctnc.expect
	$item["signs"] = $ctnc.signs
	$item["care"] = $ctnc.care
	$item["survivorship"] = $ctnc.survivorship
	$item["risks"] = $ctnc.risks
	$item["injuries"] = $ctnc.injuries
	$item["disorders"] = $ctnc.disorders
	$item["causes"] = $ctnc.causes
	$item["services"] = $ctnc.services
	$item["donations"] = $ctnc.donations
	$item["support"] = $ctnc.support
	$item["devices"] = $ctnc.devices
	$item["management"] = $ctnc.management
	$item["understanding"] = $ctnc.understanding
	$item["prevention"] = $ctnc.prevention
	$item["spine"] = $ctnc.spine
	$item["diabetes"] = $ctnc.diabetes
	$item["maleurology"] = $ctnc.maleurology
	$item["urologiccancer"] = $ctnc.urologiccancer
	$item["aboutprostatecancer"] = $ctnc.aboutprostatecancer
	$item["heartHealth"] = $ctnc.hearthealth
	$item["bodyandbreast"] = $ctnc.bodyandbreast
	$item["facialprocedures"] = $ctnc.facialprocedures
	$item["EyeHealth"] = $ctnc.eyehealth
	$item["EyeWear"] = $ctnc.eyewear
	$item["talking"] = $ctnc.talking
	$item["ourprogram"] = $ctnc.ourprogram
	$item["ourexpertise"] = $ctnc.ourexpertise
	$item["ourteam"] = $ctnc.ourteam
	$item["patientstories"] = $ctnc.patientstories
	$item["faq"] = $ctnc.faq
	$item["conditions"] = $ctnc.conditions
	$item["resources"] = $ctnc.resources
	$item["symptoms"] = $ctnc.symptons
	$item["procedures"] = $ctnc.procedures
	$item["beforeAfter"] = $ctnc.beforeafter
	$item["before"] = $ctnc.before
	$item["after"] = $ctnc.after
	$item["surgery"] = $ctnc.surgery
	$item["surgicalprocedures"] = $ctnc.surgicalprocedures
	$item["typesOfSurgery"] = $ctnc.typesOfSurgery
	$item["roboticSurgery"] = $ctnc.roboticSurgery
	$item["specialtySurgery"] = $ctnc.specialtySurgery
	$item["bariatricSurgery"] = $ctnc.bariatricSurgery
	$item["diagnosis"] = $ctnc.diagnosis
	$item["types"] = $ctnc.types
	$item["treatment"] = $ctnc.treatment
	$item["prepareToQuit"] = $ctnc.preparetoquit
	$item["abouttobacco"] = $ctnc.abouttobacco
	$item["contact"] = $ctnc.contact
	$item["yourvisit"] = $ctnc.yourvisit
	$item["primarycare"] = $ctnc.primarycare
	$item["specials"] = $ctnc.specials
	$item["specialties"] = $ctnc.specialties
	$item["emergency"] = $ctnc.emergency
	$item["moreproviders"] = $ctnc.moreproviders
	$item["morelocations"] = $ctnc.morelocations
	$item.Editing.EndEdit()
	
	$providersPath = $folderPath + "/Providers"
	$locationsPath = $folderPath + "/Locations"
	
	$pfolderItem = Get-Item -Path $providersPath -ErrorAction SilentlyContinue
	if($pfolderItem -eq $null){
	    try{
	        New-Item -Path $providersPath -ItemType $folderTemplate
	    }catch{
	        Write-Host "Error to create providers folder item"
	        break
	    }
	}
	
	foreach($provider in $row.content.providers){
	    $providerPath = $providersPath + "/" + $provider.name.replace("'", "").replace("/","")
	    Write-Host $providerPath
	    $providerItem = Get-Item $providerPath -ErrorAction SilentlyContinue
	    if($providerItem -eq $null){
	        try{
	            $providerItem = New-Item -Path $providerPath -ItemType $providerTemplate
	        }catch{
	           Write-Host "Error to create provider item"
	           write-host $_.Exception.Message 
	           break
	        }
	
	    }
	    $item = $providerItem
	    $item.Editing.BeginEdit()
	    $item["ImageSrc"] = $provider.ImageSrc
	    $item["ImageAlt"] = $provider.ImageAlt
	    $item["Location"] = $provider.Location
	    $item["ProviderName"] = $provider.name
	    $item["Phone"] = $provider.phone
	    $item["Specialty"] = $provider.specialty
	    if($provider.newPatients){
	         $item["NewPatients"] = 1
	    }else{
	         $item["NewPatients"] = 0
	    }
	   
	    $item["Details"] = $provider.details
	    $item.Editing.EndEdit()
	    
	}
	
	
	
	$lfolderItem = Get-Item -Path $locationsPath -ErrorAction SilentlyContinue
	
	if($lfolderItem -eq $null){
	    try{
	        New-Item -Path $locationsPath -ItemType $folderTemplate
	    }catch{
	        break
	    }
	}
	
	foreach($location in $row.content.locations){
	    $locationPath = $locationsPath + "/" + $location.name.replace("'", "").replace("/","")
	    Write-Host $locationPath
	    $locationItem = Get-Item $locationPath -ErrorAction SilentlyContinue
	    if($locationItem -eq $null){
	        try{
	            $locationItem = New-Item -Path $locationPath -ItemType $locationTemplate
	        }catch{
	           Write-Host "Error to create location item"
	           write-host $_.Exception.Message 
	           break
	        }
	
	    }
	    $item = $locationItem
	    $item.Editing.BeginEdit()
	    $item["ImageSrc"] = $location.ImageSrc
	    $item["ImageAlt"] = $location.ImageAlt
	    $item["LocationName"] = $location.name
	    $item["City"] = $location.city
	    $item["Address1"] = $location.add1
	    $item["Address2"] = $location.add2
	    $item["Phone"] = $location.phone
	    $item["Details"] = $location.details
	    $item.Editing.EndEdit()
	    
	}
	
	$c = $c + 1
	Write-Host $name
	Write-Host $c
	if($c -eq 1000){
	    break
	}
	
	
}
