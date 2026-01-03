# frozen_string_literal: true

# Handles communication with Prefeitura de São Paulo web services.
class NfsePrefeituraSp::Client
  def initialize(cert_path:, cert_password:)
    raise "[NfsePrefeituraSp] Certificate path missing" if !File.exist?(cert_path)
    OpenSSL::Provider.load("legacy") if defined?(OpenSSL::Provider)
    @cert   = OpenSSL::PKCS12.new(File.read(cert_path), cert_password)
    @signer = NfsePrefeituraSp::Signer.new(@cert)
  end

  def sync_teste_envio_lote_rps(data)
    service     = NfsePrefeituraSp::Services::Sync::TesteEnvioLoteRPS.new(data, @signer)
    soap_client = soap_client(:sync)
    message     = service.request_xml
    # request     = soap_client.build_request(service.class::OPERATION_REQUEST, message: message, attributes:{ xmlns: 'http://www.prefeitura.sp.gov.br/nfe' })
    response    = soap_client.call(service.class::OPERATION_REQUEST, message: message, attributes: { xmlns: 'http://www.prefeitura.sp.gov.br/nfe' })
    # puts "\n\n\n\n\n=============== REQUEST ==============="
    # puts request.body
    # puts "=============== REQUEST ===============\n\n\n\n\n"
    # puts "=============== RESPONSE ==============="
    # puts response.full_hash[:envelope][:body][:teste_envio_lote_rps_response][:retorno_xml]
    # puts "=============== RESPONSE ===============\n\n\n\n\n"

    NfsePrefeituraSp::Response.new(xml: response.full_hash[:envelope][:body][service.class::OPERATION_RESPONSE][:retorno_xml], method: service.class::OPERATION_REQUEST)
  end

  def sync_envio_rps(data)
    service     = NfsePrefeituraSp::Services::Sync::EnvioRps.new(data, @signer)
    soap_client = soap_client(:sync)
    message     = service.request_xml
    # request     = soap_client.build_request(service.class::OPERATION_REQUEST, message: message, attributes:{ xmlns: 'http://www.prefeitura.sp.gov.br/nfe' })
    response    = soap_client.call(service.class::OPERATION_REQUEST, message: message, attributes: { xmlns: 'http://www.prefeitura.sp.gov.br/nfe' })
    # puts "\n\n\n\n\n=============== REQUEST ==============="
    # puts request.body
    # puts "=============== REQUEST ===============\n\n\n\n\n"
    # puts "=============== RESPONSE ==============="
    # puts response.full_hash[:envelope][:body][:envio_rps_response][:retorno_xml]
    # puts "=============== RESPONSE ===============\n\n\n\n\n"

    NfsePrefeituraSp::Response.new(xml: response.full_hash[:envelope][:body][service.class::OPERATION_RESPONSE][:retorno_xml], method: service.class::OPERATION_REQUEST)
  end

  private

    def soap_client(interface)
      wsdl = case interface
      when :sync
        NfsePrefeituraSp::Services::Sync::WSDL_URL
      when :async
        NfsePrefeituraSp::Services::Async::WSDL_URL
      else
        raise "[NfsePrefeituraSp] Unknown interface `#{interface}`."
      end

      Savon.client(
        env_namespace:        :soap,
        soap_version:         2,
        ssl_verify_mode:      OpenSSL::SSL::VERIFY_PEER,
        ssl_cert:             @cert.certificate,
        ssl_cert_key:         @cert.key,
        wsdl:                 wsdl,
        namespace_identifier: nil,
        open_timeout:         300,
        read_timeout:         300,
      )
    end

end
