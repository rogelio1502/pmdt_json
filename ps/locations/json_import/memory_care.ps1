$commonPath = "/sitecore/content/pmdt-jss-site/content"
$db = $commonPath + "/database"
$textContentBlockTemplateId = "{BAC4E377-7F8E-4DB0-95F2-430F234FDEB7}"
$folderTemplateId = "{A87A00B1-E6DB-45AB-8B54-636FEC3B5523}"
$headerTemplateId = "{0FC9FB9F-F956-467B-9269-96A6DAA1FF5B}"
$cardItemTemplateId = "{1722911E-D7F8-487F-B008-F9AC7627E2C8}"

$githubUrl = "https://raw.githubusercontent.com/LuigiEspinosa/promedica-scraper/main/json/ProMedica/agency/memory-care-details.json";

$jsonInfo = curl $githubUrl -UseBasicParsing | ConvertFrom-Json
$newLocationsPath = $db + "/NewLocations/MemoryCare"
$newLocationsFolder = Get-Item -Path $newLocationsPath

$mediaFolder = "/sitecore/media library/pmdt-jss-site/data/media/img/ProMedica/SeniorCareLocations/"



foreach($row in $jsonInfo){

    $importDirectUrl = $row.Url.Split("/")[-2]
    foreach($ltn in $newLocationsFolder.Children){
        $data = $ltn.Children["data"]
        $directUrl = $data["directURL"]
        if($directUrl -eq $importDirectUrl){
            #Write-Host $row.Url
            Write-Host $directUrl $importDirectUrl
            
            $item = $ltn.Children["data"]
            <#
            $item.Editing.BeginEdit()
            
            #virtual tour
            [Sitecore.Data.Fields.LinkField] $linkField = $item.Fields["MediaGalleryVirtualTour"];
            $linkField.Clear()
            $linkField.Text = "Virtual Tour";
            $linkField.LinkType = "external";
            $linkField.Url =  $row.Content.virtualTour;
            
            $item["DescriptionBody"] = $row.content.description
            $item["DescriptionHeading"] = $row.content.title
            $item["PageTitle"] = $row.title
            $item.Editing.EndEdit()
            #>
            foreach($photo in $row.content.photoGallery){
                <#Write-Host $photo.imgSrc
                $path = $mediaFolder + $photo.imgSrc.Split('/')[-1].Split('.')[0]
                $imgItem = Get-Item -Path $path
                
                if($imgItem -eq $null){
                    continue
                }
                
                if($item['MediaGalleryPhotos'].Contains($imgItem.ID.ToString())){ continue }
                $item.Editing.BeginEdit()
                if (![string]::IsNullOrEmpty($item['MediaGalleryPhotos'])) {
                    $item['MediaGalleryPhotos'] += "|";
                }
                $item['MediaGalleryPhotos'] += $imgItem.ID.ToString()
                $item.Editing.EndEdit()
                #>
                
                #Write-Host "Gallery Photos Updated"
            }
            
            <#
            $hasBlock = 0
            foreach($block in $ltn.Children['TextContentBlocks'].Children){
                $hasBlock = 1
                $newTextContentBlockItemPath = $ltn.Children['TextContentBlocks'].Paths.Path + "/TextContentBlock1"
                $newTextContentBlockItem = Get-Item -Path $newTextContentBlockItemPath
                $_item = $newTextContentBlockItem
                $_item.Editing.BeginEdit()
                $_item['Title'] = $row.content.title
                $_item['Description'] = $row.content.description
                $_item.Editing.EndEdit()
            }
            
            if($hasBlock -eq 0){
                $newTextContentBlockItemPath = $ltn.Children['TextContentBlocks'].Paths.Path + "/TextContentBlock1"
                $newTextContentBlockItem = New-Item -Path $newTextContentBlockItemPath -ItemType $textContentBlockTemplateId
                Write-Host $newTextContentBlockItemPath
                $_item = $newTextContentBlockItem
                $_item.Editing.BeginEdit()
                $_item['Title'] = $row.content.title
                $_item['Description'] = $row.content.description
                $_item.Editing.EndEdit()


            }
                
     
            #>
            $item.Editing.BeginEdit()
            $item["Address"] = $row.content.Address.address1 + ' , ' + $row.Content.Address.Address2
            $item.Editing.EndEdit()
            
            foreach($testimonial in $row.content.testimonials){
                #Write-Host $testimonial.quote
              
                $testiPath = $ltn.Paths.Path + "/Testimonials/" + $testimonial.quote
                $testiItem = Get-Item -Path $testiPath -ErrorAction SilentlyContinue
                
                if($testiItem -eq $null){
                    $testiItem = New-Item -Path $testiPath -ItemType '{7BAA2D39-C319-48F8-95F8-F1DE169CDB74}'
                }
                $testiItem.Editing.BeginEdit()
                $testiItem['Title'] = $testimonial.quoteTitle
                $testiItem['Description'] = $testimonial.quote
                $testiItem['Content'] = $testimonial.quoteContent.replace('\t', '').replace('\n','')
                $testiItem.Editing.EndEdit()
                
            }
            
            $cardCollectionPath = $ltn.Paths.Path + "/CardCollections/CardCollection1";
            
            $ccItem = Get-Item -Path $cardCollectionPath
            
            if($ccItem -eq $null){
                New-Item -Path $cardCollectionPath -ItemType $folderTemplateId
            }
            
            
            $headerItemPath = $cardCollectionPath + "/Header" 
            
            $headerItem = Get-Item -Path $headerItemPath -ErrorAction SilentlyContinue
            
            if($headerItem -eq $null){
                $headerItem = New-Item -Path $headerItemPath -ItemType $headerTemplateId
            }
            
            $headerItem.Editing.BeginEdit()
            $headerItem['Title'] = 'At a Glance'
            $headerItem.Editing.EndEdit()
            
            #1
            $cardCollectionNPath = $cardCollectionPath + "/CardItem9"
            $cardItemN = Get-Item -Path  $cardCollectionNPath -ErrorAction SilentlyContinue

            if($cardItemN -eq $null){
                $cardItemN = New-Item -Path $cardCollectionNPath -ItemType $cardItemTemplateId
            }
            
            $_item = $cardItemN
            $_item.Editing.BeginEdit()
            $_item['Title'] = "Design and Layout"
            $_item["Description"] = $row.content.designLayout.content
            $_item.CardImage = Get-Item -Path "master:\media library\pmdt-jss-site\data\media\img\_placeholder_370x247"
            [Sitecore.Data.Fields.LinkField] $linkField = $_item.Fields["Url"];
            $linkField.Clear()
            $linkField.Text = "Learn More";
            $linkField.LinkType = "external";
            $linkField.Url = 'design-and-layout';
            $_item.Editing.EndEdit()
            
            # 2
            $cardCollectionNPath = $cardCollectionPath + "/CardItem10"
            $cardItemN = Get-Item -Path  $cardCollectionNPath -ErrorAction SilentlyContinue

            if($cardItemN -eq $null){
                $cardItemN = New-Item -Path $cardCollectionNPath -ItemType $cardItemTemplateId
            }
            
            $_item = $cardItemN
            $_item.Editing.BeginEdit()
            $_item['Title'] = "Memorial Fund"
            $_item["Description"] = $row.content.memorialFund.content
            $_item.CardImage = Get-Item -Path "master:\media library\pmdt-jss-site\data\media\img\_placeholder_370x247"
            [Sitecore.Data.Fields.LinkField] $linkField = $_item.Fields["Url"];
            $linkField.Clear()
            $linkField.Text = "Donate";
            $linkField.LinkType = "external";
            $linkField.Url = $row.content.memorialFund.donate;
            $_item.Editing.EndEdit()
            
            #3
            $cardCollectionNPath = $cardCollectionPath + "/CardItem11"
            $cardItemN = Get-Item -Path  $cardCollectionNPath -ErrorAction SilentlyContinue

            if($cardItemN -eq $null){
                $cardItemN = New-Item -Path $cardCollectionNPath -ItemType $cardItemTemplateId
            }
            
            $_item = $cardItemN
            $_item.Editing.BeginEdit()
            $_item['Title'] = "Customized Care"
            $_item.CardImage = Get-Item -Path "master:\media library\pmdt-jss-site\data\media\img\_placeholder_370x247"
            $_item["Description"] = $row.content.customizedCare.content
            [Sitecore.Data.Fields.LinkField] $linkField = $_item.Fields["Url"];
            $linkField.Clear()
            $linkField.Text = "Learn More";
            $linkField.LinkType = "external";
            $linkField.Url = $row.content.customizedCare.learnmore;
            $_item.Editing.EndEdit()
            
            $item.Editing.BeginEdit()
            [Sitecore.Data.Fields.LinkField] $linkField = $item.Fields["TestimonialsVideo"];
            $linkField.Clear()
            $linkField.Text = "Testimonials Video";
            $linkField.LinkType = "external";
            $linkField.Url = $row.content.testimonialsVideo
            $item.Editing.EndEdit()
            
        }
    }
    
    #break
    
    
}
