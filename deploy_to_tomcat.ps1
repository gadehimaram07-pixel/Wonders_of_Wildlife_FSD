# Deploy Wonders of Wildlife to Tomcat
$baseDir = $PSScriptRoot
$source = "$baseDir\Wonders_of_Wildlife"
$target = "$baseDir\tomcat_base\webapps\Wonders_of_Wildlife"
$rootTarget = "$baseDir\tomcat_base\webapps\ROOT"

Write-Host "Compiling Java classes..." -ForegroundColor Cyan
javac -cp "$source\WEB-INF\lib\*" -d "$source\WEB-INF\classes" $source\src\com\wildlife\util\*.java $source\src\com\wildlife\model\*.java $source\src\com\wildlife\dao\*.java $source\src\com\wildlife\servlet\*.java
if ($LASTEXITCODE -ne 0) {
    Write-Host "Compilation failed!" -ForegroundColor Red
    exit 1
}
Write-Host "Compilation successful!" -ForegroundColor Green

# Ensure target directories exist
New-Item -ItemType Directory -Path $target -Force | Out-Null
New-Item -ItemType Directory -Path $rootTarget -Force | Out-Null

# Copy static and web resources to Wonders_of_Wildlife webapp
Write-Host "Deploying to $target..." -ForegroundColor Cyan
Copy-Item "$source\*.jsp" -Destination $target -Force
Copy-Item "$source\*.html" -Destination $target -Force
Copy-Item "$source\*.css" -Destination $target -Force
Copy-Item "$source\*.jpg" -Destination $target -Force -ErrorAction SilentlyContinue
Copy-Item "$source\*.png" -Destination $target -Force -ErrorAction SilentlyContinue
Copy-Item "$source\*.mp4" -Destination $target -Force -ErrorAction SilentlyContinue

# Copy WEB-INF
Copy-Item "$source\WEB-INF" -Destination $target -Recurse -Force

# Also deploy to ROOT for direct http://localhost:8081/ access
Write-Host "Deploying to ROOT ($rootTarget)..." -ForegroundColor Cyan
Copy-Item "$target\*" -Destination $rootTarget -Recurse -Force

Write-Host "Deployment completed successfully!" -ForegroundColor Green
