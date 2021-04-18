module SatelliteTrackerApi
  
  class ApiV1 < Grape::API
    
    helpers ProductInventoryApi::Helpers::ErrorsHelper
    
    version 'v1', using: :header, vendor: "SatelliteTracker"
    prefix :api
    format :json

    
    
    # Enable swagger documentation at /api/v1/swagger_doc. This endpoint spits out JSON that can be read by
    # the npm module Swagger-UI, which allows browsing and testing of the API.
    add_swagger_documentation
  end
  
end
