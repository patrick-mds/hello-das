param tags object = {
  deployment: 'bicep'
  application: 'hello-app'
}

module naming 'modules/naming.bicep' = {
  name: 'naming'
  params: {
    suffix: ['das', 'hello', 'app']
  }
}

module application_insights 'modules/app_insights.bicep' = {
  name: 'application_insights'
  params: {
    resource_name: naming.outputs.application_insights
    workspace_name: naming.outputs.log_analytics_workspace
    tags: tags
  }
}

module app_service 'modules/app_service.bicep' = {
  name: 'app_service'
  params: {
    application_name: naming.outputs.app_service
    service_plan_name: naming.outputs.service_plan
    sku_name: 'P1v3'
    elastic_scale_enabled: true
    docker_server_url: 'https://index.docker.io'
    container_image: 'index.docker.io/patrickmds/hello-app:v1.0'
    app_insights_connection_string: application_insights.outputs.connection_string
    app_insights_instrumentation_key: application_insights.outputs.instrumentation_key
    tags: tags
  }
}

