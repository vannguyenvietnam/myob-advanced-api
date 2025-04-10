require 'base64'
require 'oauth2'

module MyobAdvanced
  module Api
    class Client
      include MyobAdvanced::Api::Helpers

      attr_reader :client

      SERVICE_TYPES = {
        restful_api: {
          name: 'RESTful API',
          value: 'RESTFUL_API'
        },
        odata_v3: {
          name: 'OData V3',
          value: 'ODATA_V3'
        },
        odata_v4: {
          name: 'OData V4',
          value: 'ODATA_V4'
        },
        odata_gi: {
          name: 'OData - Generic Inquiry',
          value: 'ODATA_GI'
        },
        odata_dac: {
          name: 'OData - Data Access Classes',
          value: 'ODATA_DAC'
        }
      }.freeze

      def initialize(options)
        @redirect_uri         = options[:redirect_uri]
        @consumer             = options[:consumer]
        @access_user          = options[:access_user]
        @access_token         = options[:access_token]
        @refresh_token        = options[:refresh_token]
        @site_url             = options[:site_url]
        @default_version      = options[:default_version] # Default web servive enpoint version
        @header               = options[:header]
        @tenant               = options[:tenant]
        # RESTFUL_API || ODATA_V3 || ODATA_V4 || ODATA_GI || ODATA_DAC
        # Default is RESTFUL_API
        @service_type         = options[:service_type] || self.class::SERVICE_TYPES[:restful_api][:value]

        @site_url = @site_url.to_s.gsub(/\/*$/, '')
        # Init model methods
        MyobAdvanced::Api::Model::Base.subclasses.each {|c| model(c.name.split("::").last)}

        @client               = OAuth2::Client.new(@consumer[:key], @consumer[:secret], {
          :site          => @site_url,
          :authorize_url => '/identity/connect/authorize',
          :token_url     => '/identity/connect/token',
        })
      end

      def default_api_url
        case @service_type
        when self.class::SERVICE_TYPES[:odata_v3][:value]
          result = odata_v3_url
        when self.class::SERVICE_TYPES[:odata_v4][:value]
          result = odata_v4_url
        when self.class::SERVICE_TYPES[:odata_gi][:value]
          result = odata_gi_url
        when self.class::SERVICE_TYPES[:odata_dac][:value]
          result = odata_dac_url
        else # RESTFUL_API
          result = restful_api_url
        end

        result
      end

      def restful_api_url
        "#{@site_url}/entity/Default/#{@default_version}"
      end

      def odata_v3_url
        "#{@site_url}/odata/#{@tenant}"
      end

      def odata_v4_url
        "#{@site_url}/odatav4/#{@tenant}"
      end

      def odata_gi_url
        "#{@site_url}/t/#{@tenant}/api/odata/gi"
      end

      def odata_dac_url
        "#{@site_url}/t/#{@tenant}/api/odata/dac"
      end

      def site_url
        @site_url
      end

      def get_access_code_url(params = {})
        scope = params[:scope] || 'api offline_access'
        @client.auth_code.authorize_url(params.merge(scope: scope, redirect_uri: @redirect_uri))
      end

      def get_access_token(access_code)
        @token         = @client.auth_code.get_token(access_code, redirect_uri: @redirect_uri)
        @access_token  = @token.token
        @expires_at    = @token.expires_at
        @refresh_token = @token.refresh_token
        @token
      end

      def get_access_token_password_grant_type
        params = { scope: 'api offline_access' }
        @token         = @client.password.get_token(@access_user[:username], @access_user[:password], params)
        @access_token  = @token.token
        @expires_at    = @token.expires_at
        @refresh_token = @token.refresh_token
        @token
      end

      def refresh_access_token!
        @token         = OAuth2::AccessToken.new(@client, @access_token, {
          :refresh_token => @refresh_token
        }).refresh!

        @access_token  = @token.token
        @expires_at    = @token.expires_at
        @refresh_token = @token.refresh_token
        @token
      end

      def headers(options = {})
        result = {
          'Accept'            => 'application/json',
          'Content-Type'      => 'application/json',
          'Cookie'            => @header[:cookie]
        }

        return result unless options[:attachment]

        result = {
          'Accept'            => 'application/octet-stream',
          'Content-Type'      => 'application/json',
          'Cookie'            => @header[:cookie]
        }

        return result unless options[:method] == 'put'

        {
          'Accept'            => 'application/json',
          'Content-Type'      => 'application/octet-stream',
          'Cookie'            => @header[:cookie]
        }
      end

      def connection
        @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token)
      end

      def endpoints
        url = "#{@site_url}/entity"
        response = connection.get(url, { headers: headers })
        JSON.parse(response.body)
      end

      # Return XML
      def metadata
        url "#{default_api_url}/$metadata"
        response = connection.get(url, { headers: headers })
        Nokogiri::XML(response.body)
      end

      def restful_api?
        @service_type == self.class::SERVICE_TYPES[:restful_api][:value]
      end

      def odata?
        [
          self.class::SERVICE_TYPES[:odata_v3][:value],
          self.class::SERVICE_TYPES[:odata_v4][:value],
          self.class::SERVICE_TYPES[:odata_gi][:value],
          self.class::SERVICE_TYPES[:odata_dac][:value]
        ].include?(@service_type)
      end

      private
    end
  end
end
