module Sinatra
  module ZeroClipboard

    module AssetsHelper
      def zero_clipboard_assets
        environment = Assets::ASSETS.has_key?(settings.environment) ? settings.environment : :production
        html_fragments = Assets::ASSETS[environment][:js].keys.each_with_object([]) do |file_name, memo|
          memo << "<script type=\"text/javascript\" src=\"#{url("/js/#{file_name}")}\"></script>"
        end

        html_fragments.join("\n")
      end
    end

  end
end
