@description('The name of the resource')
@maxLength(260)
param resource_name string
@description('The workspace name')
@maxLength(60)
param workspace_name string
@description('The tags of the resource')
param tags object = {}

// Create the log analytics workspace.
resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: workspace_name
  location: resourceGroup().location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
  tags: tags
}

// Create the application insights.
resource app_insights 'Microsoft.Insights/components@2020-02-02' = {
  name: resource_name
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    IngestionMode: 'LogAnalytics'
    RetentionInDays: 30
    WorkspaceResourceId: workspace.id
  }
  tags: tags
}

output id string = app_insights.id
output name string = app_insights.name
output instrumentation_key string = app_insights.properties.InstrumentationKey
output connection_string string = app_insights.properties.ConnectionString
