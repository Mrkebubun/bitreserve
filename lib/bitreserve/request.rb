module Bitreserve
  class Request
    class APIError < StandardError; end

    include ::HTTParty
    base_uri "#{Bitreserve.api_base}/v#{Bitreserve.api_version}"

    def self.perform_with_objects(http_method, request_data)
      response = new(request_data).public_send(http_method)

      with_valid_response(response) do
        request_data.entity.from_collection(response.parsed_response, response.headers['content-range'])
      end
    end

    def self.perform_with_object(http_method, request_data)
      response = new(request_data).public_send(http_method)

      with_valid_response(response) do
        request_data.entity.new(response.parsed_response)
      end
    end

    def initialize(request_data)
      @path = request_data.endpoint
      @data = request_data.payload
      @headers = request_data.headers
    end

    def get
      response = self.class.get(path, options)
      log_request_info(:get, response)
      response
    end

    def post
      response = self.class.post(path, options)
      log_request_info(:post, response)
      response
    end

    private

    attr_reader :path, :data, :auth, :headers

    def self.with_valid_response(response)
      if response.is_a?(Hash) && response['error']
        Entities::Error.new(response)
      else
        yield
      end
    end

    def options
      { body: data, headers: headers }.
        reject { |_k, v| v.nil? }
    end

    def log_request_info(http_method, response)
      Bitreserve.logger.info "[Bitreserve] #{http_method.to_s.upcase} #{self.class.base_uri}#{path} #{options[:headers]} #{response.code}"
      Bitreserve.logger.debug response.parsed_response
    end
  end
end
