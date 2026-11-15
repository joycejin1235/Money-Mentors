$ErrorActionPreference = "Stop"

$root = [System.IO.Path]::GetFullPath($PSScriptRoot)
$assetRoot = [System.IO.Path]::GetFullPath((Join-Path $root "assets"))
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:8000/")
$listener.Start()
Write-Host "Money Mentors is running at http://localhost:8000/ (press Ctrl+C to stop)."

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        try {
            $path = $context.Request.RawUrl
            $queryIndex = $path.IndexOf("?")
            if ($queryIndex -ge 0) {
                $path = $path.Substring(0, $queryIndex)
            }
            $method = $context.Request.HttpMethod

            if ($method -ne "GET" -and $method -ne "HEAD") {
                $context.Response.StatusCode = 405
            } else {
                $filePath = $null
                $contentType = $null

                if ($path -eq "/" -or $path -eq "/index.html") {
                    $filePath = Join-Path $root "index.html"
                    $contentType = "text/html; charset=utf-8"
                } elseif ($path -match '^/assets/[A-Za-z0-9._-]+\.png$') {
                    $assetName = $path.Substring("/assets/".Length)
                    $candidatePath = [System.IO.Path]::GetFullPath((Join-Path $assetRoot $assetName))
                    $assetPrefix = $assetRoot.TrimEnd([System.IO.Path]::DirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar

                    if ($candidatePath.StartsWith($assetPrefix, [StringComparison]::OrdinalIgnoreCase) -and (Test-Path -LiteralPath $candidatePath -PathType Leaf)) {
                        $filePath = $candidatePath
                        $contentType = "image/png"
                    }
                }

                if ($null -eq $filePath) {
                    $context.Response.StatusCode = 404
                } else {
                    $content = [System.IO.File]::ReadAllBytes($filePath)
                    $context.Response.ContentType = $contentType
                    $context.Response.ContentLength64 = $content.Length
                    if ($method -eq "GET") {
                        $context.Response.OutputStream.Write($content, 0, $content.Length)
                    }
                }
            }
        } finally {
            $context.Response.Close()
        }
    }
} finally {
    $listener.Stop()
    $listener.Close()
}
