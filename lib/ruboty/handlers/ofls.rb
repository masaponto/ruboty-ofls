require "ruboty/ofls/actions/dshift"
require "ruboty/ofls/actions/wshift"


module Ruboty
  module Handlers
    # ofls shift
    class Ofls < Base
      on /dshift (?<number>.*?)\z|dshift\z/, name: 'dshift', description: 'print date shift'
      on /wshift (?<number>.*?)\z|wshift\z/, name: 'wshift', description: 'print week shift'
      env :OFLS_KEY, "google spread sheet key"
      env :OFLS_GID, "google spread sheet gid"

      def dshift(message)
        Ruboty::Ofls::Actions::Dshift.new(message).call
      end

      def wshift(message)
        Ruboty::Ofls::Actions::Wshift.new(message).call
      end

    end
  end
end
