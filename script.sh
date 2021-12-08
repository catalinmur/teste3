docker image  build -t nginx-local .
docker run --name nginx -p 80:80 -d nginx-local