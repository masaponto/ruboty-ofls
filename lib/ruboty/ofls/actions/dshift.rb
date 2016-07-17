module Ruboty
  module Ofls
    module Actions
      class Dshift < Ruboty::Actions::Base
        def call
          message.reply(dshift)
        rescue => e
          message.reply(e.message)
        end

        private
        def dshift
          '```' + \
          Shift.new(key: ENV["OFLS_KEY"], gid: ENV["OFLS_GID"]).date_shift(message[:date]) + \
          '```'
        end
      end
    end
  end
end
