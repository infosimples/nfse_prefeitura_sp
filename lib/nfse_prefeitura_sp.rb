# frozen_string_literal: true

require 'base64'
require 'openssl'
require 'nokogiri'
require 'savon'

module NfsePrefeituraSp
  # Supports only XSD version 2.x introduced by the "Reforma triburtária 2026".
  XSD_VERSION = 2
end

require_relative 'nfse_prefeitura_sp/client'
require_relative 'nfse_prefeitura_sp/response'
require_relative 'nfse_prefeitura_sp/services'
require_relative 'nfse_prefeitura_sp/signer'
require_relative 'nfse_prefeitura_sp/types'
require_relative 'nfse_prefeitura_sp/version'
Dir.glob(File.join(File.expand_path('../', __FILE__), 'nfse_prefeitura_sp/types/**', '*.rb')).each { |file| require_relative(file) }
Dir.glob(File.join(File.expand_path('../', __FILE__), 'nfse_prefeitura_sp/services/**', '*.rb')).each { |file| require_relative(file) }
