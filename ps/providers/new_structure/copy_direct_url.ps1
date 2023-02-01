$oldItemID = '/sitecore/content/pmdt-jss-site/Content/Database/NewProviders'

$providersFolder = Get-Item $oldItemID

$newPath = '/sitecore/content/pmdt-jss-site/Content/Database/Providers_230126/'

Write-Host $database

foreach($provider in $providersFolder.Children){
    Write-Host $provider.Name
    $newItemPath = $newPath + $provider.Name + "/Page"
    $item = Get-Item -Path $newItemPath 
    $oldItemPath = $oldItemID + "/" + $provider.Name + "/data"
    $oldItem = Get-Item -Path $oldItemPath
    Write-Host $item['First Name']
    Write-Host $oldItem['FirstName']
    $item.Editing.BeginEdit()
    $item['DirectURL'] = $oldItem['DirectURL']
    $item.Editing.EndEdit()
    Write-Host "-----------------------"
    
}
