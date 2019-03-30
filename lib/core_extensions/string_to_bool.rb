# frozen_string_literal: true

module CoreExtensions
  module String
    module StringToBool
      def to_bool
        return true if strip.casecmp?('true')
        return false if strip.casecmp?('false')
        nil
      end
    end
  end
end

String.include CoreExtensions::String::StringToBool
