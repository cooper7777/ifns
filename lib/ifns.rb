require 'active_support'
require 'active_support/core_ext'
require 'ifns/version'
require 'ifns/client'
require 'ifns/configuration'
require 'ifns/response_ticket'
require 'ifns/response_validation'

module Ifns
  class << self
    def configuration
      @configuration ||= Ifns::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
