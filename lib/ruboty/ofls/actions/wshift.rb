module Ruboty
  module Ofls
    module Actions
      class Wshift < Ruboty::Actions::Base
        def call
          message.reply(wshift)
        rescue => e
          message.reply(e.message)
        end

        private
        def wshift
          '```' + \
          Shift.new(key: ENV["OFLS_KEY"], gid: ENV["OFLS_GID"]).week_shift(message[:number].to_i) + \
          '```'
        end
      end
    end
  end
end
