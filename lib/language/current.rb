module Language

  class << self

    def default
      @default || 'en'
    end

    def default=(lang)
      @default = lang
    end

    def current
      @current || default
    end

    def current=(lang)
      @current = lang
    end

  end

end

