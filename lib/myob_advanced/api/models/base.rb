module MyobAdvanced
  module Api
    module Model
      class Base
        QUERY_OPTIONS = [:top, :skip, :filter, :expand, :select, :custom]

        def initialize(client, model_name)
          @client          = client
          @api_url         = client.default_api_url
          @model_name      = model_name || 'Base'
        end

        def model_route
          @model_name.to_s
        end

        def all(options = {})
          perform_request(self.url(nil, options[:params]), options)
        end
        alias_method :get, :all

        def find(id, options = {})
          object = { 'ID' => id }
          perform_request(self.url(object, options[:params]), options)
        end

        def find_by_path(sub_path, options = {})
          object = { 'sub_path' => sub_path }
          perform_request(self.url(object, options[:params]), options)
        end

        def first(options = {})
          all(options).first
        end

        def destroy(id)
          object = { 'ID' => id }
          @client.connection.delete(self.url(object), :headers => @client.headers)
        end

        def destroy_by_path(sub_path)
          object = { 'sub_path' => sub_path }
          @client.connection.delete(self.url(object), :headers => @client.headers)
        end

        def exec_action(action, options = {})
          options[:method] = 'post'
          object = { 'sub_path' => action }
          perform_request(self.url(object, options[:params]), options)
        end

        def put_attach(options = {})
          options[:method] = 'put'
          options[:attachment] = true
          object = nil
          object = { 'sub_path' => options[:sub_path] } if options[:sub_path]
          perform_request(self.url(object, options[:params]), options)
        end

        def get_attach(options = {})
          options[:attachment] = true
          object = nil
          object = { 'sub_path' => options[:sub_path] } if options[:sub_path]
          perform_request(self.url(object, options[:params]), options)
        end

        def create(object, options = {})
          object = typecast(object)
          request_options = { body: object, method: 'put' }
          perform_request(self.url(nil, options[:params]), request_options)
        end

        def update(object, options = {})
          object = typecast(object)
          request_options = { body: object, method: 'put' }
          perform_request(self.url(nil, options[:params]), request_options)
        end

        def url(object = nil, params = nil)
          @model_route ||= model_route
          url = @api_url

          # Default RESTful API URL
          if @model_route.present?
            sub_path = nil
            sub_path = "/#{object['ID']}" if object && object['ID']
            sub_path = "/#{object['sub_path']}" if object && object['sub_path']
            # Init url
            url = "#{@api_url}/#{@model_route}#{sub_path}"
          end

          if @client.odata?
            url = "#{@api_url}/#{@model_route}"
          end

          if params.is_a?(Hash)
            query = query_string(params)
            url += "?#{query}" if !query.nil? && query.length > 0
          end

          url
        end

        private

        def typecast(object)
          returned_object = object.dup # don't change the original object

          returned_object.each do |key, value|
            if value.respond_to?(:strftime)
              returned_object[key] = value.strftime(date_formatter)
            end
          end

          returned_object
        end

        def date_formatter
          "%Y-%m-%dT%H:%M:%S"
        end

        def resource_url
          "#{@api_url}/#{self.model_route}"
        end

        def perform_request(url, options = {})
          headers = @client.headers(options)
          request_options = { headers: headers }
          request_options[:body] = options[:body] if options[:body]
          request_options[:body] = request_options[:body].to_json if request_options[:body].is_a?(Hash)
          method = options[:method] || 'get'
          parse_response(@client.connection.send(method, url, request_options))
        end

        def query_string(params)
          params.map do |key, value|
            if QUERY_OPTIONS.include?(key)
              value = build_filter(value) if key == :filter
              key = "$#{key}"
            end

            "#{key}=#{CGI.escape(value.to_s)}"
          end.join('&')
        end

        def build_filter(value)
          return value unless value.is_a?(Hash)

          temp = "\\\\'"
          value.map { |key, value| "#{key} eq '#{value.to_s.gsub("'", temp)}'" }.join(' and ')
        end

        def parse_response(response)
          return response.body unless response.body.present?

          JSON.parse(response.body) rescue response.body
        end

        def process_query(data, query)
          query.each do |property, value|
            data.select! {|x| x[property] == value}
          end

          data
        end
      end
    end
  end
end
