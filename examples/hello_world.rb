#!/bin/ruby

require 'blight'

include Blight
RunsLoop.new.run do |window|
  renders_text = RendersCenteredText.new(window)
  renders_text.render("Hello, World! (type 'q' to quit)")
end
