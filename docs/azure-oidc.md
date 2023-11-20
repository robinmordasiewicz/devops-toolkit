# Configuring OIDC in Azure to Authenticate a GitHub Repository

This guide will walk you through the steps to configure OpenID Connect (OIDC) in Azure to authenticate a GitHub repository. The instructions will cover both the web interface and the equivalent Azure CLI commands.

## Prerequisites

Before you begin, make sure you have the following:

- An Azure account with sufficient permissions to create and manage resources.
- A GitHub repository that you want to authenticate.

## Step 1: Create an Azure Active Directory (AAD) Application

1. Go to the [Azure portal](https://portal.azure.com) and sign in with your Azure account.
2. Navigate to the Azure Active Directory service.
3. Click on "App registrations" and then click on "New registration".
4. Provide a name for your application and select the appropriate account type.
5. In the "Redirect URI" section, select "Web" and enter the redirect URI for your GitHub repository.
6. Click on "Register" to create the application.

![Create AAD Application](https://example.com/create-aad-application.png)

## Step 2: Configure Authentication

1. In the AAD application page, navigate to the "Authentication" section.
2. Under "Platform configurations", click on "Add a platform" and select "Web".
3. Enter the redirect URI for your GitHub repository.
4. Under "Implicit grant", select "Access tokens" and "ID tokens".
5. Click on "Configure" to save the changes.

![Configure Authentication](https://example.com/configure-authentication.png)

## Step 3: Grant API Permissions

1. In the AAD application page, navigate to the "API permissions" section.
2. Click on "Add a permission" and select the appropriate API.
3. Grant the necessary permissions for your GitHub repository.
4. Click on "Grant admin consent" to save the changes.

![Grant API Permissions](https://example.com/grant-api-permissions.png)

## Step 4: Generate Client Secret

1. In the AAD application page, navigate to the "Certificates & secrets" section.
2. Click on "New client secret" and enter a description.
3. Set the expiration and click on "Add" to generate the client secret.
4. Make sure to copy and securely store the client secret as it will not be visible again.

![Generate Client Secret](https://example.com/generate-client-secret.png)

## Step 5: Configure GitHub Repository

1. Go to your GitHub repository settings.
2. Navigate to the "Secrets" section and click on "New repository secret".
3. Enter a name for the secret and paste the client secret value.
4. Click on "Add secret" to save the changes.

![Configure GitHub Repository](https://example.com/configure-github-repository.png)

## Azure CLI Equivalent Commands

Here are the equivalent Azure CLI commands to perform the above steps:

```bash
# Step 1: Create an Azure Active Directory (AAD) Application
az ad app create --display-name "MyApp" --redirect-uri "https://github.com/redirect-uri"

# Step 2: Configure Authentication
az ad app update --id <application-id> --reply-urls "https://github.com/redirect-uri" --oauth2-allow-implicit-flow true

# Step 3: Grant API Permissions
az ad app permission add --id <application-id> --api <api-id> --api-permissions <permissions>

# Step 4: Generate Client Secret
az ad app credential reset --id <application-id> --credential-description "MyClientSecret"

# Step 5: Configure GitHub Repository
az repos secret update --name <secret-name> --value <client-secret> --repository <repository-name>
```

Replace `<application-id>`, `<api-id>`, `<permissions>`, `<secret-name>`, `<client-secret>`, and `<repository-name>` with the appropriate values.

## Testing and Validation

To test and validate that the authentication works, follow these steps:

1. Clone the GitHub repository to your local machine.
2. Run the following command to authenticate using the Azure CLI:

```bash
az login --identity
```

3. If the authentication is successful, you will be logged in with your Azure account.

That's it! You have successfully configured OIDC in Azure to authenticate a GitHub repository.
