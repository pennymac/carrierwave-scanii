module CarrierWave
  module Scanii
    if defined? Rails
      class Railtie < Rails::Railtie
        initializer "carrierwave_scanii.setup_paths" do |app|
          pattern = CarrierWave::Scanii::Railtie.locales_pattern_from app.config.i18n.available_locales

          files = Dir[File.join(File.dirname(__FILE__), 'locale', "#{pattern}.yml")]
          # Loads the Carrierwave locale files before the Rails application locales
          # letting the Rails application overwrite the carrierwave locale defaults
          I18n.load_path = files.concat I18n.load_path
        end

        private

        def self.locales_pattern_from(args)
          array = Array(args || [])
          array.blank? ? '*' : "{#{array.join ','}}"
        end

      end
    end
  end
end
