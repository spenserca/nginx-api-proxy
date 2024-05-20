# nginx-api-proxy

## Running Locally

1. Pull the image from dockerhub
2. Run the image binding ports `8080:8080`
3. Navigate to [http://localhost:8080/hello-world](http://localhost:8080/hello-world)

## Publishing

To publish the hello world API image, run `dotnet publish //t:PublishContainer -p ContainerImageTags="latest"`