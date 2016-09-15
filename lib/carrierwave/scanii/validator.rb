module CarrierWave
  module Scanii
    class ScaniiValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)

        conf = CarrierWave::Scanii.configuration

        conn = Faraday.new(url: 'https://api.scanii.com', ssl: {verify:false}) do |faraday|
          faraday.request :multipart
          faraday.request :url_encoded
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.proxy conf.proxy if conf.proxy
        end

        conn.basic_auth(conf.api_key, conf.secret_key)

        response = conn.post '/v2.1/files', { :file => Faraday::UploadIO.new(value.path, value.content_type) }

        json_response = JSON.parse(response.body)
        if json_response["findings"].length > 0
          record.errors.add attribute, :scanii_unsafe
        end
      end
    end
  end
end
