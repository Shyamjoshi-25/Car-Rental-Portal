param(
    [string]$TomcatHome = "C:\apache-tomcat-10.1.57-windows-x64\apache-tomcat-10.1.57"
)

$ErrorActionPreference = "Stop"

Write-Host "Starting PostgreSQL 16 in Docker..."
docker compose up -d db

Write-Host "Building Car Rental Portal with Maven..."
mvn clean package -DskipTests

$war = Join-Path (Get-Location) "target\CarRentalPortal.war"
$webapps = Join-Path $TomcatHome "webapps"
$rootWar = Join-Path $webapps "ROOT.war"
$rootDir = Join-Path $webapps "ROOT"

if (-not (Test-Path $war)) {
    throw "WAR was not created: $war"
}

if (Test-Path $rootWar) { Remove-Item $rootWar -Force }
if (Test-Path $rootDir) { Remove-Item $rootDir -Recurse -Force }

Copy-Item $war $rootWar -Force
& (Join-Path $TomcatHome "bin\startup.bat")

Write-Host "Car Rental Portal started. Open http://localhost:8080/"
