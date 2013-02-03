require "epi_js/version"

module EpiJs
  module Rails
    if ::Rails.version < '3.1'
      require 'epi_js/railtie'
    else
      require 'epi_js/engine'
    end
  end
end