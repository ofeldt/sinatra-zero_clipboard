module Sinatra
  module ZeroClipboard

    module Assets
      ASSETS = {
        development: {
          swf: { "ZeroClipboard.swf" => "2fa578220e56ec9d382e26e2dbb82ad0b9550ac2" },
          js: { "ZeroClipboard.js" => "e3f0c042f93fe9aeaa570ba09e774a308681f2ed" }
        },
        production: {
          swf: { "ZeroClipboard.swf" => "2fa578220e56ec9d382e26e2dbb82ad0b9550ac2" },
          js: { "ZeroClipboard.min.js" => "20699686261a143ba1972b18a3ef3f0b3dbcd95c" }
        }       
      }
      ASSETS.default = ASSETS[:production]
      
      class << self
        def generate_zero_clipboard_asset_routes(application)
          ASSETS[application.settings.environment].each do |file_type, files|
            files.each_pair do |file_name, sha1_checksum|
              application.get "/#{file_type}/#{file_name}", :provides => file_type do
                cache_control :public, :must_revalidate, :max_age => 3600
                etag sha1_checksum

                File.read(File.join(Gem.datadir("sinatra-zero_clipboard"), "assets", file_name))
              end
            end
          end
        end 

        def registered(application)
          generate_zero_clipboard_asset_routes(application)
          application.helpers AssetsHelper
        end
      end
    end

  end
end
