require 'httparty'

module Api
    class Base
        attr_accessor :options

        def initialize(options)
            @options = options
        end

        def request(type, url, options = {})
            HTTParty.send(type, url, options) do |response|
                # parse the response
            end
        end

        def parsed_response(response)
            "#{___method___}"
        end
    end
end
