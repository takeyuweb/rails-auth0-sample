# https://auth0.com/docs/users/migrations/automatic
#
# rake auth0:get_all_connections[ACCESS_TOKEN]
# rake auth0:enable_data_validation[ACCESS_TOKEN, CONNECTION_ID]
#
# CONNECTION_ID
# Use rake auth0:get_all_connections[ACCESS_TOKEN]
#
# ACCESS_TOKEN
# See https://auth0.com/docs/api/management/v2/tokens

require 'pp'

namespace :auth0 do
  desc 'Get all connections'
  task :get_all_connections, [:access_token] => :environment do |_task, args|
    url = URI("https://#{Rails.application.secrets.auth0_domain}/api/v2/connections")
    get(args.access_token, url)
  end

  desc 'Enable Data Validation'
  task :enable_data_validation, [:access_token, :connection_id] => :environment do |_task, args|
    url = "https://#{Rails.application.secrets.auth0_domain}/api/v2/connections/#{args.connection_id}"
    # get_all_connections の結果をみて必要なオプションを変更
    data = {
      options: {
        strategy_version: 2,
        nextOptionParam: {
          # APIで設定を変更するときここを設定？
          # 設定項目は get_all_connections
        }
      }
    }
    patch(args.access_token, url, data)
  end

  def get(access_token, url)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri)

    pp send_request(access_token, http, request)
  end

  def patch(access_token, url, data)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Patch.new(uri)
    request['content-type'] = 'application/json'
    request.body = data.to_json

    pp send_request(access_token, http, request)
  end

  def send_request(access_token, http, request)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request['authorization'] = "Bearer #{access_token}"

    response = http.request(request)
    JSON.parse(response.read_body)
  end
end
