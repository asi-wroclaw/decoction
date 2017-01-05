#/usr/bin/env bash
docker run -p 5432:5432 -e POSTGRES_USER=decoction -e POSTGRES_PASSWORD=decoction --name decoction -d postgres:9.6-alpine
