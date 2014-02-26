module Rbkmoney
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc << "Description:\n    Copies configuration file to your application's config folder."

      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        puts "Installing config:"
        copy_file "config/rbkmoney.yml", "config/rbkmoney.yml"
      end
    end
  end
end