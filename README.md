[![Gem Version](https://badge.fury.io/rb/sinatra-zero_clipboard.png)](http://badge.fury.io/rb/sinatra-zero_clipboard)
# Sinatra::ZeroClipboard 

**Sinatra::ZeroClipboard** is a sinatra plugin to access [ZeroClipboard](https://github.com/jonrohan/ZeroClipboard), 
a **Flash-based cross-browser clipboard library**. Accessing the clipboard from pure Javascript is still disabled
on most browser due to security concerns, but sometimes needed in a project to improve user experience.
This gem should mitigate this nuisance until better options are broadly available.

## Requirements:

server-side:
  * sinatra  >= 1.4.2
  
client-side:
  * Javascript & Flash-enabled Browser

## Usage:

#### Add gem to your Gemfile
    gem "sinatra-zero_clipboard"

#### Require the gem
``` ruby 
require 'sinatra/zero_clipboard'
```

#### Register helper for asset routes
``` ruby
class SampleApplication < Sinatra::Base
  # ...
  register Sinatra::ZeroClipboard::Assets
  # ...
end
```

#### Add asset links to HTML head
``` haml
%html
  %head
    = zero_clipboard_assets
```

#### Add a button
``` haml
%button{ id: "clip_button", data-clipboard-text: "Default text", data-clipboard-target: "text_to_copy" }
  %span Copy to Clipboard
```

#### Add a target
``` haml
%textarea{ id: "text_to_copy", rows: "3" cols: "40"} I'm getting copied, Yeah!
```

#### Add ZeroClipboard Javascript binding
``` javascript
var clip = new ZeroClipboard(document.getElementById("clip_button"), {
  moviePath: "swf/ZeroClipboard.swf"
});
```

## More Information
For more ZeroClipboard Javascript options look [here](https://github.com/jonrohan/ZeroClipboard)
