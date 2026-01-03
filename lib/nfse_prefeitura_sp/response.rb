# frozen_string_literal: true
# Based on https://github.com/iugu/nfe-paulistana in order to keep as consistent as possible.
class NfsePrefeituraSp::Response
  RETURN_ROOT = {
    teste_envio_lote_rps:      :envio_lote_rps,
    consulta_n_fe:             :consulta,
    consulta_n_fe_emitidas:    :consulta,
    consulta_n_fe_recebidas:   :consulta,
    consulta_lote:             :consulta,
    consulta_informacoes_lote: :informacoes_lote,
  }

  def initialize(options = {})
    @options = options
  end

  def xml
    @options[:xml]
  end

  def nfe_method
    @options[:method]
  end

  def retorno
    Hash.from_xml(Nokogiri::XML(xml).to_s).deep_transform_keys { |key| key.to_s.underscore.to_sym }[("retorno_" + (RETURN_ROOT[@options[:method]] || @options[:method]).to_s).to_sym]
  end

  def success?
    retorno[:cabecalho][:sucesso] == 'true'
  end

  def errors
    return if success?
    retorno[:alerta] || retorno[:erro]
  end
end
