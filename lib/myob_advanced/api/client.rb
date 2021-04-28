require 'base64'
require 'oauth2'

module MyobAdvanced
  module Api
    class Client
      include MyobAdvanced::Api::Helpers

      attr_reader :client

      def initialize(options)
        @redirect_uri         = options[:redirect_uri]
        @consumer             = options[:consumer]
        @access_user          = options[:access_user]
        @access_token         = options[:access_token]
        @refresh_token        = options[:refresh_token]
        @site_url             = options[:site_url]
        @default_version      = options[:default_version] # Default web servive enpoint version

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
        "#{@site_url}/entity/Default/#{@default_version}"
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

      def headers
        {
          'Accept'            => 'application/json',
          'Content-Type'      => 'application/json'
        }
      end

      def connection
        @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token)
      end

      def enpoints
        url = "#{@site_url}/entity"
        response = connection.get(url, { headers: headers })
        JSON.parse(response.body)
      end

      private
    end
  end
end
