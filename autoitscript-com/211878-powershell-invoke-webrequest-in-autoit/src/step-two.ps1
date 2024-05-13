# Target ID (GUID)
$guid = "1c09aabd-5134-4b57-9e50-454b6dd63ad0"

# Json body
$post = @{size = 0; updateID = $guid; uidInfo = $guid} | ConvertTo-Json -Compress
$body = @{updateIDs = "[$post]"}

# POST request
$params = @{
    Uri = "https://www.catalog.update.microsoft.com/DownloadDialog.aspx"
    Method = "POST"
    Body = $body
    ContentType = "application/x-www-form-urlencoded"
}
$downloadData = Invoke-WebRequest @params

# Write the response data to file (for debugging purposes).
# This isn't necessary, but to understand to RegEx below it's helpful.
$downloadData.Content > "result-powershell.html"

# Get only the download URL(s) for the cumulative update (based by the GUID on top).
$regExPattern = '(?s)\.files?\[\d+\]\.url(\s+)?=(\s+)?''(.+?.msu)'
$downloadData.Content |
    Select-String -Pattern $regExPattern -AllMatches |
    %{ $_.matches.groups[3].value }

