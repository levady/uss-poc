require "rails_helper"

shared_context :basic_auth_context do
  let(:auth) do
    ActionController::HttpAuthentication::Basic.encode_credentials("username", "secure")
  end
  let(:headers) { { "HTTP_AUTHORIZATION" => auth } }
  
  around do |example|
    ENV["BASIC_AUTH_USER"] = "username"
    ENV["BASIC_AUTH_PASSWORD"] = "secure"
    example.run
    ENV["BASIC_AUTH_USER"] = nil
    ENV["BASIC_AUTH_PASSWORD"] = nil
  end
end
