require 'sinatra/base'
require 'sinatra/zero_clipboard'
require 'slim'

class SampleApplication < Sinatra::Base
  # register our helper to setup neccessary asset routes
  register Sinatra::ZeroClipboard::Assets

  use Rack::CommonLogger

  enable :inline_templates

  get '/' do
    slim :index
  end

end

SampleApplication.run!

__END__
@@ layout
doctype html
html
  head
    -# use helper to include links in our HTML
    == zero_clipboard_assets
  body
    == yield

@@ index
-# Add a button
-# 
-# date-clipboard-text is the default text which would be copied if the target was missing
-# data-clipboard-target is the target element from which we copy our text
-#
button id="clip_button" data-clipboard-text="Default clipboard text" data-clipboard-target="text_to_copy" title="Click me to copy to clipboard."
  span Copy to Clipboard

.label
  label for="text_to_copy" Change copy text here
-# Add a Target
-#
-# set the id
textarea id="text_to_copy" rows="3" cols="40" Copy me!

.label
  label for="testarea" Paste text here for comparison
textarea id="testarea" rows="3" cols="40"

#debug_output

javascript:
  // Add ZeroClipboard Javascript binding
  // 
  // You'll find the needed flash movie under /swf/ZeroClipboard.swf
  //
  // For more ZeroClipboard documentation go to: https://github.com/jonrohan/ZeroClipboard
  var clip = new ZeroClipboard(document.getElementById("clip_button"), {
    moviePath: "swf/ZeroClipboard.swf"
  });

  clip.on('load', function (client) {
    debug_output("Flash movie loaded and ready.");
  });

  clip.on('noflash', function (client) {
    debug_output("Your browser has no flash.");
  });

  clip.on('complete', function (client, args) {
    debug_output("Copied text to clipboard: " + args.text);
  });

  function debug_output(text) {
    p = document.createElement("p")
    p.innerHTML = text
    document.getElementById("debug_output").appendChild(p)
  }
