@description('The name of the app service.')
@maxLength(60)
param application_name string
@description('The name of the service plan.')
@maxLength(40)
param service_plan_name string
@description('The sku name of the service plan.')
@allowed([
  'F1'
  'B1'
  'B2'
  'B3'
  'P1v3'
  'P2v3'
  'P3v3'
])
param sku_name string
@description('Whether to enable elastic scale for the service plan.')
param elastic_scale_enabled bool = false
@description('Whether to enable per-site scaling for the service plan.')
param per_site_scaling bool = false
@description('Docker server URL.')
param docker_server_url string
@description('The container image to use for the app service.')
@maxLength(256)
param container_image string
@description('The instrumentation key for Application Insights.')
param app_insights_instrumentation_key string
@description('The connection string for Application Insights.')
param app_insights_connection_string string
@description('The tags of the resource')
param tags object = {}

resource service_plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: service_plan_name
  location: resourceGroup().location
  sku: {
    name: sku_name
  }
  kind: 'linux'
  properties: {
    reserved: true
    elasticScaleEnabled: elastic_scale_enabled
    perSiteScaling: per_site_scaling
  }
  tags: tags
}

resource app_service 'Microsoft.Web/sites@2024-04-01' = {
  name: application_name
  location: resourceGroup().location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: service_plan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      healthCheckPath: '/health'
      linuxFxVersion: 'DOCKER|${container_image}'
      appCommandLine: ''
      appSettings: [
        { name: 'PORT', value: '3000' }
        { name: 'APPINSIGHTS_INSTRUMENTATIONKEY', value: app_insights_instrumentation_key }
        { name: 'APPLICATIONINSIGHTS_CONNECTION_STRING', value: app_insights_connection_string }
        { name: 'ApplicationInsightsAgent_EXTENSION_VERSION', value: '~2' }
        { name: 'DOCKER_REGISTRY_SERVER_URL', value: docker_server_url }
        { name: 'XDT_MicrosoftApplicationInsights_Mode', value: 'recommended' }
      ]
    }
  }
}

output id string = app_service.id
output name string = app_service.name
output service_plan_id string = service_plan.id
output service_plan_name string = service_plan.name
output uri string = 'https://${app_service.properties.defaultHostName}'
