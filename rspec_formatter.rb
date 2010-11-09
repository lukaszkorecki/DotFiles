require 'spec/runner/formatter/progress_bar_formatter'

class VimForm < Spec::Runner::Formatter::ProgressBarFormatter
  def example_failed(example, counter, failure)
    super
    @output.puts example.location
    exit
  end
end

