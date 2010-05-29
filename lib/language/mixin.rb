require 'language/class'

class Language

  module Mixin
    #
    def method_missing(s,*a,&b)
      return super(s,*a,&b) if s == Language.current.to_sym

      lang = __send__(Language.current)
      if lang && lang.respond_to?(s)
        lang.__send__(s,*a,&b)
      else
        super(s,*a,&b)
      end
    end
  end

end

class String
  include Language::Mixin
end

class Numeric
  include Language::Mixin
end

class Array
  include Language::Mixin
end

