# NfsePrefeituraSp

Gem para integração com a Nota Fiscal de Serviços Eletrônica (NFS-e) da Prefeitura de São Paulo.
Emissão de Nota Fiscal de Serviço Eletrônica (NFS-e) na Prefeitura de São Paulo.

## Módulos disponíveis

Abaixo estão indicados os serviços já disponíveis (`[X]`) e os pendentes de implementação (`[ ]`).

### Serviços síncronos

  - `[X] ENVIO DE RPS`
  - `[ ] ENVIO DE LOTE DE RPS`
  - `[X] TESTE DE ENVIO DE LOTE DE RPS`
  - `[ ] CONSULTA DE NF-E`
  - `[ ] CONSULTA DE NF-E RECEBIDAS`
  - `[ ] CONSULTA DE NF-E EMITIDAS`
  - `[ ] CONSULTA DE LOTE`
  - `[ ] CONSULTA INFORMAÇÕES DO LOTE`
  - `[ ] CANCELAMENTO DE NF-E`
  - `[ ] CONSULTA DE CNPJ`

### Serviços assíncronos

  - `[ ] ENVIO DE LOTE DE RPS - ASSÍNCRONO`
  - `[ ] CONSULTA SITUAÇÃO LOTE ASSÍNCRONO`
  - `[ ] TESTE ENVIO DE LOTE RPS - ASSÍNCRONO`
  - `[ ] EMISSÃO DE GUIA - ASSÍNCRONO`
  - `[ ] CONSULTA SITUAÇÃO GUIA`
  - `[ ] CONSULTA GUIA`

## Instalação

Criando um cliente:

```ruby
client = NfsePrefeituraSp::Client.new(
  cert_path:    '/path/to/cert.p12',
  cert_password: 'passwd'
)
```

### Exemplos de serviços síncronos

ENVIO DE RPS:

```ruby
data = {
  cnpj_remetente: '00000000000000',
  rps: [
    {
      chave_rps: {
        inscricao_prestador: '00000000',
        numero_rps:          '000000',
      },

      tipo_rps:                       'RPS',
      codigo_servico:                 '00000',
      aliquota_servicos:              '0.029'
      tributacao_rps:                 'T',
      status_rps:                     'N',
      data_emissao:                   'YYYY-MM-DD',
      discriminacao:                  'Serviço prestado...',
      percentual_carga_tributaria:    '0.XXXX',
      valor_carga_tributaria:         'XX.XX',
      valor_final_cobrado:            'XXX.XX',
      valor_ipi:                      'XX.XX',
      valor_pis:                      'XX.XX',
      valor_cofins:                   'XX.XX',
      valor_inss:                     'XX.XX',
      valor_ir:                       'XX.XX',
      valor_csll:                     'XX.XX',
      exigibilidade_suspensa:         '0',
      pagamento_parcelado_antecipado: '0',
      nbs:                            '000000000',
      c_loc_prestacao:                '0000000', # Código IBGE
      iss_retido:                     false,
      valor_deducoes:                 '0.00',
      endereco_tomador: {
        tipo_logradouro:      'Rua',
        logradouro:           'Logradouro',
        numero_endereco:      '000',
        complemento_endereco: 'Complemento',
        bairro:               'Bairro',
        cidade:               '0000000', # Código IBGE
        uf:                   'SP',
        cep:                  '00000000',
      },
      cpf_cnpj_tomador: {
        cnpj: '00000000000000',
      },
      razao_tomador: 'Razão Social',
      ibs_cbs: {
        fin_nfse:  '0',
        ind_final: '0',
        c_ind_op:  '000000',
        ind_dest:  '0',
        valores: {
          trib: {
            g_ibs_cbs: {
              c_class_trib: '000000',
            },
          },
        },
      },
    },
  ],
}

response = client.sync_envio_rps(data)
# TODO: exemplo de resposta
```

TESTE DE ENVIO DE LOTE DE RPS:

```ruby
data = {
  cnpj_remetente: '00000000000000',
  dt_inicio:'YYYY-MM-DD',
  dt_fim:   'YYYY-MM-DD',
  rps: [
    {
      chave_rps: {
        inscricao_prestador: '00000000',
        numero_rps:          '000000',
      },

      tipo_rps:                       'RPS',
      codigo_servico:                 '00000',
      aliquota_servicos:              '0.029'
      tributacao_rps:                 'T',
      status_rps:                     'N',
      data_emissao:                   'YYYY-MM-DD',
      discriminacao:                  'Serviço prestado...',
      percentual_carga_tributaria:    '0.XXXX',
      valor_carga_tributaria:         'XX.XX',
      valor_final_cobrado:            'XXX.XX',
      valor_ipi:                      'XX.XX',
      valor_pis:                      'XX.XX',
      valor_cofins:                   'XX.XX',
      valor_inss:                     'XX.XX',
      valor_ir:                       'XX.XX',
      valor_csll:                     'XX.XX',
      exigibilidade_suspensa:         '0',
      pagamento_parcelado_antecipado: '0',
      nbs:                            '000000000',
      c_loc_prestacao:                '0000000', # Código IBGE
      iss_retido:                     false,
      valor_deducoes:                 '0.00',
      endereco_tomador: {
        tipo_logradouro:      'Rua',
        logradouro:           'Logradouro',
        numero_endereco:      '000',
        complemento_endereco: 'Complemento',
        bairro:               'Bairro',
        cidade:               '0000000', # Código IBGE
        uf:                   'SP',
        cep:                  '00000000',
      },
      cpf_cnpj_tomador: {
        cnpj: '00000000000000',
      },
      razao_tomador: 'Razão Social',
      ibs_cbs: {
        fin_nfse:  '0',
        ind_final: '0',
        c_ind_op:  '000000',
        ind_dest:  '0',
        valores: {
          trib: {
            g_ibs_cbs: {
              c_class_trib: '000000',
            },
          },
        },
      },
    },
  ],
}

response = client.sync_teste_envio_lote_rps(data)
# TODO: exemplo de resposta
```

## Como usar

TODO: Write usage instructions here

## Licença

Esta gem está disponível como código aberto sob os termos da [Licença MIT](https://opensource.org/licenses/MIT).
