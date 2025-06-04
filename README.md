Hello DAS application
# Hello DAS Application
This repository contains a simple Dockerized application that responds with "Hello DAS" when accessed. It is designed to be deployed on Azure using a Bicep template.
## Prerequisites
- [Docker](https://docs.docker.com/get-docker/)
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- A Docker Hub account (optional, for pushing the image)
## Project Structure
```
bicep
├── modules
|   └── app_instance.bicep
|   ├── app_service.bicep
|   └── naming.bicep
|── bicepconfig.json
└── main.bicep
hello-app/
├── Dockerfile
├── main.bicep
├── src/
│   └── index.js
└── package-lock.json
└── package.json
```
## Building the Docker Image

To build the Docker image for this application, ensure you have [Docker](https://docs.docker.com/get-docker/) installed on your system. Then, run the following command in the project root directory (where the `Dockerfile` is located):

```sh
docker build -t hello-app:v1.0 .
```

This command creates a Docker image named `hello-app` with the tag `v1.0`.

## How to Push the Image to Docker Hub

1. **Log in to Docker Hub:**
    ```sh
    docker login
    ```
    Enter your Docker Hub username and password when prompted.

2. **Tag your image:**
    ```sh
    docker tag hello-app:v1.0 patrickmds/hello-app:v1.0
    ```

3. **Push the image to Docker Hub:**
    ```sh
    docker push patrickmds/hello-app:v1.0
    ```

4. **Verify the image is on Docker Hub:**
    Visit your Docker Hub repository page to confirm the image has been uploaded successfully.

## To deploy the application to Azure:

1. **Sign in to Azure**  
    Open a terminal and run:
    ```sh
    az login
    ```

2. **Set your subscription (optional)**  
    If you have multiple subscriptions, set the desired one:
    ```sh
    az account set --subscription "<your-subscription-name-or-id>"
    ```

3. **Create a resource group (if needed)**  
    Replace `rg-das-hello-app` and `westeurope` with your preferred resource group name and region:
    ```sh
    az group create --name rg-das-hello-app --location westeurope
    ```

4. **Deploy the Bicep file**  
    Run the following command from the project root (where `main.bicep` is located):
    ```sh
    az deployment group create --resource-group rg-das-hello-app --template-file ./main.bicep
    ```

This will provision the Azure resources as defined in your `main.bicep` file.

## Accessing the Application
Once the deployment is complete, you can access the application using the URL provided in the Azure portal or from the output of the deployment command. The URL will typically look like `http://<app-name>.azurewebsites.net`, where `<app-name>` is the name of your Azure App Service.