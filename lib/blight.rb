require 'ncurses'

module Blight

  class RunsLoop
    def run(options = {})
      config = default_options.merge(options)

      begin
        Ncurses.initscr
        Ncurses.raw
        Ncurses.start_color if config[:color]
        config[:echo] ? Ncurses.echo : Ncurses.noecho

        yield window = Window.new

        while window.open?
          key = Ncurses.stdscr.getch
          config[:listeners].each { |l| l.listen({value: key.chr}, window) }
        end

      ensure
        Ncurses.endwin
      end
    end

    private

    def default_options
      {
        color: true,
        listeners: [ListensForQuitters.new],
        echo: false
      }
    end

  end

  class Window

    def initialize
      @window = Ncurses.stdscr
    end

    def x
      Ncurses.getcurx(@window)
    end

    def y
      Ncurses.getcury(@window)
    end

    def width
      Ncurses.getmaxx(@window)
    end

    def height
      Ncurses.getmaxy(@window)
    end

    def print(string, x = x, y = y)
      Ncurses.mvwprintw(@window, y, x, string)
      refresh
    end

    def open?
      !@closed
    end

    def close
      @closed = true
    end

    def refresh
      Ncurses.refresh
    end

  end

  class RendersCenteredText
    def initialize(window)
      @window = window
    end

    def render(text)
      center_x = @window.x + (@window.width - text.length) / 2
      center_y = @window.height / 2
      @window.print(text, center_x, center_y)
    end
  end

  class UsesColors
    def initialize(window)
      @window = window
    end

    def use(foreground, background)
      Ncurses.init_pair(1, find(foreground), find(background))
      Ncurses.attron(Ncurses.COLOR_PAIR(1))
      yield
      Ncurses.attroff(Ncurses.COLOR_PAIR(1))
    end

    private

    def find(color)
      Ncurses.const_get("COLOR_#{color.to_s.upcase}")
    end

  end

  class ListensForQuitters
    def listen(event, window)
      window.close if event[:value] == 'q'
    end
  end

end

