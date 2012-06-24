# blight

Blight is a little library to help you write apps with [ncurses](http://en.wikipedia.org/wiki/Ncurses) in an object-oriented way. ([rubygems](http://rubygems.org/gems/blight)).

## example

Here's a hello world app:

``` ruby
require 'blight'

include Blight
RunsLoop.new.run do |window|
  renders_text = RendersCenteredText.new(window)
  renders_text.render("Hello, World! (type 'q' to quit)")
end
```

And here's what that looks like:

![Hello, World example terminal](http://i.minus.com/iHdecPL7PnNyw.png)

## issues

* Requires Ruby 1.9.x, but without good reason
* Depends on the little-used [ncurses-ruby]() gem, because I couldn't get any of the other ncurses wrappers to compile (on MRI 1.9.3, rbenv, OS X Lion, XCode CLI tools June 2012).