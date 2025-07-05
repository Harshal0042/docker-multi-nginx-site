#!/bin/bash

# Remove any existing containers (if any)
docker rm -f hrms website portfolio 2>/dev/null

echo "✅ Starting HRMS container on port 9001..."
docker run -d --name hrms -p 9001:80 nginx
docker cp index.html hrms:/usr/share/nginx/html/index.html

echo "✅ Starting Website container on port 9002..."
docker run -d --name website -p 9002:80 nginx
docker cp index2.html website:/usr/share/nginx/html/index.html

echo "✅ Starting Portfolio container on port 9003..."
docker run -d --name portfolio -p 9003:80 nginx
docker cp portfolio.html portfolio:/usr/share/nginx/html/index.html

echo "🚀 All containers are up and running!"
echo
docker ps --format "table {{.Names}}\t{{.Ports}}"
