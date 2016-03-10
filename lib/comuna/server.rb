require 'rubydns'
require 'logger'

module Comuna
  IN = Resolv::DNS::Resource::IN
  Name = Resolv::DNS::Name
  
  class Server
    def initialize(config)
      @interfaces = config.interfaces
      @upstream_ifaces = config.upstream
      @matches = config.matches
    end

    def call
      matches = @matches
      upstr = upstream

      RubyDNS::run_server(:listen => @interfaces) do
        @logger.level = Logger::INFO
        
        matches.each do |(name, address)|
          match(/#{name}/, IN::A) do |transaction|
            transaction.respond!(address)
          end
        end
        
        otherwise do |transaction|
          transaction.passthrough!(upstr)
        end
      end
    end

    def upstream
      RubyDNS::Resolver.new(@upstream_ifaces)
    end
  end
end
