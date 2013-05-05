require "spec_helper"

describe Sinatra::ZeroClipboard::Assets do
  before(:each) { app(:reset) }

  context "#registered" do
    it "should register our asset module as helper" do
      expect(app).to_not be_a(Sinatra::ZeroClipboard::Assets)

      app.register(Sinatra::ZeroClipboard::Assets)

      expect(app).to be_a(Sinatra::ZeroClipboard::Assets)
    end
  end

  context "#generate_zero_clipboard_asset_routes" do
    [:development, :test, :production].each do |environment|
      context "in #{environment} mode" do
        Sinatra::ZeroClipboard::Assets::ASSETS[environment].each_pair do |file_type, file_list|
          file_list.each_pair do |file_name, sha1_checksum|
            before(:each) do
              app.settings.environment = environment
              app.register Sinatra::ZeroClipboard::Assets
            end

            it "should register routes for #{file_type}/#{file_name}" do
              get("/#{file_type}/#{file_name}")

              expect(last_response.status).to eq(200)
            end

            it "should set an ETag for #{file_type}/#{file_name} in response headers for caching" do
              get("/#{file_type}/#{file_name}")

              expect(last_response.headers["ETag"]).to match(/#{sha1_checksum}/)
            end
          end
        end
      end
    end
  end
end
