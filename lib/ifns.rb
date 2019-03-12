require 'active_support'
require 'active_support/core_ext'
require 'ifns/version'
require 'ifns/client'
require 'ifns/configuration'
require 'ifns/responses/base'
require 'ifns/responses/ticket'
require 'ifns/responses/validation'

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
