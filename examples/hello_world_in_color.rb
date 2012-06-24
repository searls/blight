#!/bin/ruby

require 'blight'

include Blight

RunsLoop.new.run do |window|
  renders_text = RendersCenteredText.new(window)

  UsesColors.new(window).use(:blue, :black) do
    renders_text.render("Hello, World! (type 'q' to quit)")
  end
end
