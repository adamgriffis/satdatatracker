require 'rest-client'

module NestioSatClient

  URL = 'http://nestio.space/api/satellite/data'
  SUCCESS_RESPONSE = 200 
  
  def self.get_stat_data
    response = RestClient.get(URL)

    if response.code == SUCCESS_RESPONSE
      return JSON.parse(response.body)
    else
      return false
    end
  end
end