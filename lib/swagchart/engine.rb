module Swagchart
  class Engine < ::Rails::Engine

    initializer "helper" do |app|

      ActiveSupport.on_load(:action_controller) do
        include Helper
      end

      ActiveSupport.on_load(:action_view) do
        include Helper
      end
    end

  end
end
