if Rails.version >= "3.1"
  require "swagchart/engine"
else
  ActionView::Base.send :include, Swagchart::Helper
end
