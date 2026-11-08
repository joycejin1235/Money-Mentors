$ErrorActionPreference = "Stop"

$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:8000/")
$listener.Start()
Write-Host "Money Mentors is running at http://localhost:8000/ (press Ctrl+C to stop)."

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        try {
            $path = $context.Request.Url.AbsolutePath
            $method = $context.Request.HttpMethod

            if ($method -ne "GET" -and $method -ne "HEAD") {
                $context.Response.StatusCode = 405
            } elseif ($path -ne "/" -and $path -ne "/index.html") {
                $context.Response.StatusCode = 404
            } else {
                $content = [System.IO.File]::ReadAllBytes((Join-Path $PSScriptRoot "index.html"))
                $context.Response.ContentType = "text/html; charset=utf-8"
                $context.Response.ContentLength64 = $content.Length
                if ($method -eq "GET") {
                    $context.Response.OutputStream.Write($content, 0, $content.Length)
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
