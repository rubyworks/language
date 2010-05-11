# A hash of International 2- and 3-letter ISO639-1 and ISO639-2 language codes.

module Language

  #
  module Codes

	  # Hash of ISO639 2--letter language codes
	  ISO639_1 = {}

	  # Hash of ISO639 3-letter language codes
	  ISO639_2 = {}

    file = File.join(File.dirname(__FILE__), 'codes_iso639.txt')

	  File.readlines(file).each do |line|
      next if /^#/ =~ line

      codes3, codes2, desc = line[0,7].strip, line[9,6].strip, line[15...-1].strip

      codes3 = codes3.split('/')
      codes2 = codes2.split('/')

      codes2.each do |code|
        if ISO639_1.key?(code)
          raise "Duplicate language code #{code}"
	      end
        ISO639_1[code] = desc
		  end

      codes3.each do |code|
        if ISO639_2.key?(code)
          raise "Duplicate language code #{code}"
	      end
        ISO639_2[code] = desc
		  end

	  end

  end

end

