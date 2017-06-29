require_relative '../reserved_words'

module RbVHDL::Writer
  RESERVED_WORDS = RbVHDL::RESERVED_WORDS.keys.map{|key| [key, key.to_s]}.to_h
end
