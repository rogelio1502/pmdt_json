$template = "/sitecore/templates/Project/pmdt-jss-site/BlogsFolder/Blog DB Item - Template New 2" 
$parentPath ="master:/sitecore/content/pmdt-jss-site/Content/Database/Blogs_230308/Promedica"

#Read CSV file

$fileNames = "health-technology-2.json","body-conditions-2.json","general-health-2.json","news-community-2.json","wellness-2.json"

foreach($_file in $fileNames){
    $_name = 'https://raw.githubusercontent.com/rogelio1502/pmdt_json/main/' + $_file
    $importList = $importList =  curl $_name  -UseBasicParsing
    $importList = $importList | ConvertFrom-Json
    $c = 0
    
    
    foreach($row in $importList){
        $itemPath = $parentPath + "/" + $row.PostType + " - " + $row.id + " - " + $row.Title
        $item = Get-Item -Path $itemPath -ErrorAction SilentlyContinue
        if($item -eq $null){
            Write-Host $itemPath
            New-item -Path $itemPath -ItemType $template
            $item = Get-Item -Path $itemPath -ErrorAction SilentlyContinue
    
        }
        $item.Editing.BeginEdit()
        $item['BlogId'] = $row.id
        $item['Title'] = $row.Title
        $item['Content'] = $row.Content
        $item['Permalink'] = $row.Permalink
        $item['Post Type'] = $row.Permalink
        $item['Date'] = $row.Date
        $item['ImageURL'] = $row.ImageURL
        $item['ImageFilename'] = $row.ImageFilename
        $item["ImagePath"] = $row.ImagePath
        $item["ImageID"] = $row.ImageID
        $item["ImageTitle"] = $row.ImageTitle
        $item["ImageCaption"] = $row.ImageCaption
        $item["ImageAltText"] = $row.ImageAltText
        $item["ImageFeatured"] = $row.ImageFeatured
        $item["Attachment URL"] = $row.AttachmentURL
        $item["Attachment Filename"] = $row.AttachmentFilename
        $item["Attachment Path"] = $row.AttachmentPath
        $item["Attachment ID"] = $row.AttachmentID
        $item["Attachment Title"] = $row.AttachmentTitle
        $item["Attachment Caption"] = $row.AttachmentCaption
        $item["Attachment Description"] = $row.AttachmentDescription
        $item["Attachment Alt Text"] = $row.AttachmentAltText
        $item["Categories"] = $row.Categories
        $item["Link Categories"] = $row.LinkCategories
        $item["Formats"] = $row.Formats
        $item["Wellness Sections"] = $row.WellnessSections
        $item["General Health Sections"] = $row.GeneralHealthSections
        $item["Your Body and Conditions Sections"] = $row.YourBodyConditionsSections
        $item["Health Technology Sections"] = $row.HealthTechnologySections
        $item["Community Health Sections"] = $row.CommunityHealthSections
        $item["Contributors Sections"] = $row.ContributorsSections
        $item["Status"] = $row.Status
        $item["Author ID"] = $row.AuthorID
        $item["AuthorUsername"] = $row.AuthorUsername
        $item["AuthorEmail"] = $row.AuthorEmail
        $item["AuthorFirstName"] = $row.AuthorFirstName
        $item["AuthorLastName"] = $row.AuthorLastName
        $item["Format"] = $row.Format
        $item["Slug"] = $row.Slug
        $item["Template"] = $row.Template
        $item["Parent"] = $row.Parent
        $item["Parent Slug"] = $row.ParentSlug
        $item["Order"] = $row.Order
        $item["Comment Status"] = $row.CommentStatus
        $item["Ping Status"] = $row.PingStatus
        $item["Post Modified Date"] = $row.PostModifiedDate
        $item.Editing.EndEdit()
        
    }
}
