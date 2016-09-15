module CarrierWave
  module Scanii
    class Configuration
      attr_accessor :api_key, :secret_key, :proxy

      def initialize
        @api_key = nil
        @secret_key = nil
        @proxy = nil
      end

    end
  end
end
