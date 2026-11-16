$headers = @{
    'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
}

$queries = @(
    @{ title = "Red_panda"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\redpanda.jpg" },
    @{ title = "Sloth_bear"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\slothbear.jpg" },
    @{ title = "Sarus_crane"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\saruscrane.jpg" },
    @{ title = "Indian_roller"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\indianroller.jpg" },
    @{ title = "Chital"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\deer.jpg" },
    @{ title = "Indian_leopard"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\leopard.jpg" },
    @{ title = "Great_hornbill"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\hornbill.jpg" },
    @{ title = "Malabar_pied_hornbill"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\hornbillgallery.jpg" },
    @{ title = "Asiatic_lion"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\lion.png" },
    @{ title = "Kaziranga_National_Park"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\kaziranga.jpg" },
    @{ title = "Keoladeo_National_Park"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\keoladeo.jpg" },
    @{ title = "Kanha_Tiger_Reserve"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\kanha.jpg" },
    @{ title = "Mudumalai_National_Park"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\mudumalai.jpg" },
    @{ title = "Indian_Wild_Ass_Sanctuary"; file = "c:\Wonders_of_Wildlife\Wonders_of_Wildlife\wildass1.jpg" }
)

foreach ($item in $queries) {
    try {
        $url = "https://en.wikipedia.org/api/rest_v1/page/summary/$($item.title)"
        $res = Invoke-RestMethod -Uri $url -Headers $headers
        $imgUrl = $null
        if ($res.originalimage -and $res.originalimage.source) {
            $imgUrl = $res.originalimage.source
        } elseif ($res.thumbnail -and $res.thumbnail.source) {
            $imgUrl = $res.thumbnail.source
        }

        if ($imgUrl) {
            Write-Output "Downloading for $($item.title) from $imgUrl"
            Invoke-WebRequest -Uri $imgUrl -OutFile $item.file -Headers $headers
            Write-Output "Successfully saved $($item.file)"
        } else {
            Write-Output "No image found for $($item.title)"
        }
    } catch {
        Write-Output "Error fetching $($item.title): $_"
    }
}
