# This module charaterizes the most common forms of Orthography
# in computer systems --words divided by spaces, used paragraphs
# by blank lines, and so on.

require 'language/class'

class Language

  # If block given, iterate through each word.
  #
  #   "a string".each_word { |word, range| ... }
  #    
  # Returns an array of words.
  #
  #   "abc 123".words  #=> ["abc","123"]
  #
  def self.words(string, &yld)
    if block_given?
      string.scan(/([-'\w]+)/).each do |word|
        range = $~.begin(0)...$~.end(0)
        if yld.arity == 1
          yld.call(word)
        else
          yld.call(word, range)
        end
      end
    else
      string.scan(/([-'\w]+)/).flatten
    end
  end

  #
  def self.sentences(string, &yld)
    if block_given?
      string.scan(/(.*?\.\ )/).each do |sentence|
        range = $~.begin(0)...$~.end(0)
        if yld.arity == 1
          yld.call(sentence)
        else
          yld.call(sentence, range)
        end
      end
    else
      string.scan(/(.*?\.\ )/)
    end
  end

  #
  def self.paragraphs(string, &yld)
    if block_given?
      string.scan(/(.*?\n\s{2,})/).each do |paragraph|
        range = $~.begin(0)...$~.end(0)
        if yld.arity == 1
          yld.call(paragraph)
        else
          yld.call(paragraph, range)
        end
      end
    else
      string.scan(/(.*?\n\s{2,})/)
    end
  end

  # Word wrap a string not exceeding max width.
  #
  #   puts "this is a test".word_wrap(4)
  #
  # _produces_
  #
  #   this
  #   is a
  #   test
  #
  # CREDIT: Gavin Kistner
  # CREDIT: Dayne Broderson

  def self.word_wrap(string, col_width=79)
    string = string.gsub( /(\S{#{col_width}})(?=\S)/, '\1 ' )
    string = string.gsub( /(.{1,#{col_width}})(?:\s+|$)/, "\\1\n" )
    string
  end

=begin
  # TODO: This is alternateive from glue: worth providing?
  #
  # Enforces a maximum width of a string inside an
  # html container. If the string exceeds this maximum width
  # the string gets wraped.
  #
  # Not really useful, better use the CSS overflow: hidden
  # functionality.
  #
  # === Input:
  # the string to be wrapped
  # the enforced width
  # the separator used for wrapping
  #
  # === Output:
  # the wrapped string
  #
  # === Example:
  #  text = "1111111111111111111111111111111111111111111"
  #  text = wrap(text, 10, " ")
  #  p text # => "1111111111 1111111111 1111111111"
  #
  # See the test cases to better understand the behaviour!

  #   def wrap(width = 20, separator = " ")
  #     re = /([^#{separator}]{1,#{width}})/
  #     scan(re).join(separator)
  #   end
=end

  def words(&blk)
    self.class.words(@self, &blk)
  end

  #
  def each_word(&blk)
    words(&blk)
  end

  def sentences(&yld)
    self.class.sentences(@self, &blk)
  end

  #
  def each_sentence(&blk)
    sentences(&blk)
  end

  def paragrpahs(&yld)
    self.class.paragraphs(@self, &blk)
  end

  #
  def each_paragraph(&blk)
    paragraphs(&blk)
  end

  #
  def word_wrap(col_width=79)
    self.class.word_wrap(@self, col_width)
  end

  # As with #word_wrap, but modifies the string in place.
  def word_wrap!(col_width=79)
    @self.replace(word_wrap(col_width=79))
  end

end

