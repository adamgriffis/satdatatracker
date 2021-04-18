module SatelliteTrackerApi
  
  class ApiV1 < Grape::API
    version 'v1', using: :header, vendor: "SatelliteTracker"
    prefix :api
    format :json

    mount SatelliteTrackerApi::SatDataApi
    
    # Enable swagger documentation at /api/v1/swagger_doc. This endpoint spits out JSON that can be read by
    # the npm module Swagger-UI, which allows browsing and testing of the API.
    add_swagger_documentation
  end
  
end
