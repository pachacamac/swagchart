require "swagchart/version"
require "swagchart/helper"
require "swagchart/rails" if defined?(Rails)
require "swagchart/sinatra" if defined?(Sinatra)

module Swagchart
  class << self
    attr_accessor :content_for
  end
end
