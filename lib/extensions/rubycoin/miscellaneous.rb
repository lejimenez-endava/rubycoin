module Rubycoin
  module Miscellaneous
    def every(seconds)
      Thread.new do
        loop do
          sleep seconds
          yield
        end
      end
    end

    module_function :every
  end
end
