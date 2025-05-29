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

## To deploy the application to Azure using the provided Bicep file, follow these steps:

1. **Install Azure CLI**  
    If you haven't already, [install the Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli).

2. **Sign in to Azure**  
    Open a terminal and run:
    ```sh
    az login
    ```

3. **Set your subscription (optional)**  
    If you have multiple subscriptions, set the desired one:
    ```sh
    az account set --subscription "<your-subscription-name-or-id>"
    ```

4. **Create a resource group (if needed)**  
    Replace `rg-das-hello-app` and `westeurope` with your preferred resource group name and region:
    ```sh
    az group create --name rg-das-hello-app --location westeurope
    ```

5. **Deploy the Bicep file**  
    Run the following command from the project root (where `main.bicep` is located):
    ```sh
    az deployment group create --resource-group rg-das-hello-app --template-file ./main.bicep
    ```

This will provision the Azure resources as defined in your `main.bicep` file.
