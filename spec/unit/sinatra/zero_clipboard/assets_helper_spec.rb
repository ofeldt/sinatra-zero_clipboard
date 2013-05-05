require "spec_helper"

describe Sinatra::ZeroClipboard::AssetsHelper do
  context "#zero_clipboard_assets" do
    before(:each) do
      app(:reset)
      app.register Sinatra::ZeroClipboard::Assets
      app.get("/") { zero_clipboard_assets }
    end

    it "should return html fragments" do
      get("/")

      expect(last_response.body).to eq('<script type="text/javascript" src="http://example.org/js/ZeroClipboard.min.js"></script>')
    end

    it "should return non-minified version in development environment" do
      app.settings.environment = :development

      get("/")

      expect(last_response.body).to eq('<script type="text/javascript" src="http://example.org/js/ZeroClipboard.js"></script>')
    end

    it "should return minified version in test environment" do
      app.settings.environment = :test

      get("/")

      expect(last_response.body).to eq('<script type="text/javascript" src="http://example.org/js/ZeroClipboard.min.js"></script>')
    end

    it "should return minified version in production environment" do
      app.settings.environment = :production

      get("/")

      expect(last_response.body).to eq('<script type="text/javascript" src="http://example.org/js/ZeroClipboard.min.js"></script>')
    end
  end
end
