require 'nocms-pages'
require 'nocms-admin'
require 'jquery-rails'

module NoCms
  module Admin
    module Pages
      class Engine < ::Rails::Engine
        isolate_namespace NoCms::Admin::Pages

        config.to_prepare do
          Dir.glob(NoCms::Admin::Pages::Engine.root + "app/decorators/**/*_decorator*.rb").each do |c|
            require_dependency(c)
          end
        end

      end
    end
  end
end
