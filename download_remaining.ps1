$headers = @{
    'User-Agent' = 'WondersOfWildlifeApp/1.0 (https://example.com; contact: pavan@example.com)'
}

$tasks = @(
    @{ title = "Sarus_crane"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\saruscrane.jpg" },
    @{ title = "Malabar_pied_hornbill"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\hornbillgallery.jpg" },
    @{ title = "Mudumalai_National_Park"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\mudumalai.jpg" }
)

foreach ($t in $tasks) {
    Start-Sleep -Seconds 3
    try {
        $url = "https://en.wikipedia.org/api/rest_v1/page/summary/$($t.title)"
        $res = Invoke-RestMethod -Uri $url -Headers $headers
        $img = $null
        if ($res.originalimage -and $res.originalimage.source) {
            $img = $res.originalimage.source
        } elseif ($res.thumbnail -and $res.thumbnail.source) {
            $img = $res.thumbnail.source
        }
        if ($img) {
            Write-Output "Downloading $($t.title) from $img"
            Start-Sleep -Seconds 2
            Invoke-WebRequest -Uri $img -OutFile $t.file -Headers $headers
            Write-Output "Saved to $($t.file)"
        }
    } catch {
        Write-Output "Error: $_"
    }
}
