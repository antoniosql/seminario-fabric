# **Mostrar el Hub Onelake**
- Desde el portal de Fabric, mostrar el Hub de Onelake

# **Onelake Explorer**

- Mostrar Onelake Explorer
- Enseñar como se ven los datos, y los estados de sincronización
- Transferencia

# **Acceso desde Código**

[Access OneLake with Python - Microsoft Fabric | Microsoft Learn](https://learn.microsoft.com/en-us/fabric/onelake/onelake-access-python)

```
pip install azure-storage-file-datalake azure-identity
```

```
import os
from azure.storage.filedatalake import (
    DataLakeServiceClient,
    DataLakeDirectoryClient,
    FileSystemClient
)
from azure.identity import DefaultAzureCredential
```


```
def get_service_client_token_credential(self, account_name) -> DataLakeServiceClient:
    account_url = f"https://{account_name}.dfs.fabric.microsoft.com"
    token_credential = DefaultAzureCredential()

    service_client = DataLakeServiceClient(account_url, credential=token_credential)

    return service_client
```


```
def create_file_system_client(self, service_client, file_system_name: str) : DataLakeServiceClient) -> FileSystemClient:
    file_system_client = service_client.get_file_system_client(file_system = file_system_name)
    return file_system_client

def create_directory_client(self, file_system_client : FileSystemClient, path: str) -> DataLakeDirectoryClient: directory_client 
    directory_client = file_system_client.GetDirectoryClient(path)
    return directory_client


def list_directory_contents(self, file_system_client: FileSystemClient, directory_name: str):
    paths = file_system_client.get_paths(path=directory_name)

    for path in paths:
        print(path.name + '\n')
```


```
def upload_file_to_directory(self, directory_client: DataLakeDirectoryClient, local_path: str, file_name: str):
    file_client = directory_client.get_file_client(file_name)

    with open(file=os.path.join(local_path, file_name), mode="rb") as data:
        file_client.upload_data(dataW, overwrite=True)
```

## **Ejemplo Completo**

```
#Install the correct packages first in the same folder as this file. 
#pip install azure-storage-file-datalake azure-identity

from azure.storage.filedatalake import (
    DataLakeServiceClient,
    DataLakeDirectoryClient,
    FileSystemClient
)
from azure.identity import DefaultAzureCredential

# Set your account, workspace, and item path here
ACCOUNT_NAME = "onelake"
WORKSPACE_NAME = "<myWorkspace>"
DATA_PATH = "<myLakehouse>.Lakehouse/Files/<path>"

def main():
    #Create a service client using the default Azure credential

    account_url = f"https://{ACCOUNT_NAME}.dfs.fabric.microsoft.com"
    token_credential = DefaultAzureCredential()
    service_client = DataLakeServiceClient(account_url, credential=token_credential)

    #Create a file system client for the workspace
    file_system_client = service_client.get_file_system_client(WORKSPACE_NAME)
    
    #List a directory within the filesystem
    paths = file_system_client.get_paths(path=DATA_PATH)

    for path in paths:
        print(path.name + '\n')

if __name__ == "__main__":
    main()
```