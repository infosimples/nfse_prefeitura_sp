module NfsePrefeituraSp::Services
  module Sync
    # WSDL_URL = 'https://nfe.prefeitura.sp.gov.br/ws/lotenfe.asmx?WSDL' # Production
    WSDL_URL = 'https://nfews.prefeitura.sp.gov.br/lotenfe.asmx?WSDL' # Test
  end

  module Async
    WSDL_URL = 'https://nfews.prefeitura.sp.gov.br/lotenfeasync.asmx?WSDL'
  end
end
