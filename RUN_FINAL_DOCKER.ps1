$ErrorActionPreference = 'Stop'

Write-Host 'Car Rental Portal - Final Responsive Version' -ForegroundColor Cyan
Write-Host 'The PostgreSQL volume is preserved. Use -ResetDatabase only when you intentionally want a fresh database.' -ForegroundColor Yellow

Write-Host 'Stopping existing containers...' -ForegroundColor Cyan
docker compose down

Write-Host 'Building the final version without Docker cache...' -ForegroundColor Cyan
docker compose build --no-cache

Write-Host 'Starting database and application...' -ForegroundColor Cyan
docker compose up -d

Write-Host 'Current container status:' -ForegroundColor Cyan
docker compose ps

Write-Host 'Clearing Tomcat JSP cache...' -ForegroundColor Cyan
docker exec car-rental-portal sh -c "rm -rf /usr/local/tomcat/work/Catalina/localhost/ROOT/*"
docker restart car-rental-portal | Out-Null

Write-Host ''
Write-Host 'Car Rental Portal is running.' -ForegroundColor Green
Write-Host 'Desktop:  http://localhost:8081'
Write-Host 'HTTPS:    https://localhost:8443'
Write-Host 'Mobile:   http://YOUR-PC-IP:8081'
