import radius as radius

@description('The ID of your Radius Environment. Automatically injected by the rad CLI.')
param environment string

@description('The ID of your Radius Application. Automatically injected by the rad CLI.')
param application string

resource ${{ values.name }} 'Applications.Core/containers@2023-10-01-preview' = {
  name: '${{ values.name }}'
  properties: {
    application: application
    container: {
      image: 'quay.io/${{ values.imageOwner }}/${{ values.imageName }}'
    }
    connections: {
      // Define a connection to the redis container
      // Automatically injects conneciton information into the container
      redis: {
        source: db.id
      }
    }
  }
}

resource db 'Applications.Datastores/redisCaches@2023-10-01-preview' = {
  name: 'db'
  properties: {
    environment: environment
    application: application
    recipe: {
      // Name a specific recipe to use
      name: 'default'
    }
  }
}
