require 'yaml'

module Comuna  
  class Config
    attr_reader :interfaces, :upstream,
                :matches
    
    def initialize
      load!
    end

    def load!
      extract_with_defaults!(parsed)
    end

    def raw
      if File.exist?('config.yml')
        File.read('config.yml')
      elsif File.exist?('config.yaml')
        File.read('config.yaml')
      else
        ''
      end
    end

    def parsed
      read = YAML.load(raw)
      read.is_a?(Hash) ? read : {}
    end

    def extract_with_defaults!(config)
      port = config.fetch('port', 5300)
      
      @interfaces = config.fetch('interfaces', [[:udp, '0.0.0.0', port],
                                                [:tcp, '0.0.0.0', port]])
      @upstream = config.fetch('upstream', [[:udp, '8.8.8.8', 53],
                                            [:tcp, '8.8.8.8', 53]])
      @matches = config.fetch('matches', {myself: '0.0.0.0'})
    end
  end
end
