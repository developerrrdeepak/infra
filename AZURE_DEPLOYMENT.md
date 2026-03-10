# Azure Deployment Setup

## Step 1: Get Azure Publish Profile

1. Go to Azure Portal → App Service → Infralith1
2. Click "Get publish profile" (top right)
3. Save the XML file

## Step 2: Add GitHub Secret

1. Go to GitHub repo → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Name: `AZURE_PUBLISH_PROFILE`
4. Value: Paste entire contents of the publish profile XML file
5. Click "Add secret"

## Step 3: Configure Environment Variables in Azure

Set these in Azure App Service → Configuration → Application settings:

```
NODE_ENV=production
NEXTAUTH_SECRET=<your-strong-secret-min-32-chars>
NEXTAUTH_URL=https://infralith1-cffgqeb7cdbozfbu.southindia-01.azurewebsites.net

AZURE_AD_CLIENT_ID=<your-client-id>
AZURE_AD_CLIENT_SECRET=<your-client-secret>
AZURE_AD_TENANT_ID=<your-tenant-id>

AZURE_OPENAI_KEY=<your-key>
AZURE_OPENAI_ENDPOINT=<your-endpoint>
AZURE_OPENAI_RESOURCE_NAME=<your-resource>
AZURE_OPENAI_DEPLOYMENT_NAME=model-router
AZURE_OPENAI_API_VERSION=2024-08-01-preview

AZURE_DOCUMENT_INTELLIGENCE_ENDPOINT=<your-endpoint>
AZURE_DOCUMENT_INTELLIGENCE_KEY=<your-key>

AZURE_AI_SEARCH_ENDPOINT=<your-endpoint>
AZURE_AI_SEARCH_API_KEY=<your-key>
AZURE_AI_SEARCH_INDEX_NAME=infralith-index

AZURE_COSMOS_CONNECTION_STRING=<your-connection-string>
AZURE_COSMOS_DATABASE_ID=InfralithDB
AZURE_COSMOS_CONTAINER_ID=BIMModels
AZURE_COSMOS_COLLAB_CONTAINER_ID=CollabState

INFRALITH_STRICT_REAL_DATA=true
INFRALITH_3D_SOURCE_ONLY=true
```

## Step 4: Deploy

Push to main branch:
```bash
git push origin main
```

GitHub Actions will automatically:
1. Build the Next.js app
2. Create deployment package
3. Deploy to Azure App Service

Monitor deployment in GitHub → Actions tab.

## Troubleshooting

If deployment fails:
1. Check GitHub Actions logs
2. Check Azure App Service logs: Monitoring → Log stream
3. Verify all environment variables are set
4. Ensure publish profile secret is correct
