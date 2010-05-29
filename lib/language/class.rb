class Language

  #
  def self.abbreviation
    'lang'
  end

  #
  def self.default
    @default || abbreviation
  end

  #
  def self.default=(lang)
    @default = lang
  end

  #
  def self.current
    @current || default
  end

  #
  def self.current=(lang)
    @current = lang
  end

  #
  def self.instance(string)
    @cache ||= {}
    @cache[string.object_id] = new(string)
  end

  #
  def initialize(subject)
    @self = subject
  end

end

class String
  # Higher-order function to invoke Language functions.
  def lang
    Language.instance(self)
  end
end

class Array
  # Higher-order function to invoke Language functions.
  def lang
    Language.instance(self)
  end
end

class Integer
  # Higher-order function to invoke Language functions.
  def lang
    Language.instance(self)
  end
end




=begin
module Language
  extend self

  # Subclass this in your specific language modules.
  #
  #   class English::String < Language::String
  #
  class String < ::String

    #
    def self.language
      Language
    end

    #
    def self.instance(string)
      @cache ||= {}
      @cache[string.object_id] = new(string)
    end

    #
    def initialize(string)
      super()
      replace(string)
    end

    def language
      @_language ||= self.class.language
    end

  end

  # TODO: We can't actually subclass Integer.
  # But we can fake it. However we need to sublass
  # it just so #is_a? works. However subclassing it causes
  # the .new method not to exist, how to fix?
  #
  class Integer #< ::Integer
    instance_methods{ |m| private m unless /^__/ =~ m.to_s }

    #
    def self.language
      Language
    end

    #
    def self.instance(integer)
      @cache ||= {}
      @cache[integer] = new(integer)
    end

    #
    def initialize(integer)
      @integer = integer
    end

    #
    def to_i
      @integer
    end

    #
    def method_missing(s,*a,&b)
      @integer.__send__(s,*a,&b)
    end

    #
    def language
      @_language ||= self.class.language
    end
  end

  #
  class Array < ::Array

    #
    def self.language
      Language
    end

    #
    def self.instance(array)
      @cache ||= {}
      @cache[array.object_id] = new(array)
    end

    def language
      @_language ||= self.class.language
    end
  end

end
=end

