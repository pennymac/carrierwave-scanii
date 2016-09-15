require 'active_model'

require 'carrierwave/scanii/configuration'
require 'carrierwave/scanii/railtie'
require "carrierwave/scanii/version"
require 'carrierwave/scanii/validator'

module CarrierWave
  module Scanii
    class << self
      attr_accessor :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end

ActiveModel::Validations.include CarrierWave::Scanii
