module RbVHDL::Ast

  class Comment
    attr_reader :_owner
    def initialize(owner)
      @_owner = owner
    end
  end

  class Comment

    class Text < Comment
      attr_reader :_text
      def initialize(owner, text)
        super(owner)
        @_text  = text
      end
    end

    class HorizontalRule < Comment
      def initialize(owner)
        super(owner)
      end
    end

    class NewLine < Comment
      def initialize(owner)
        super(owner)
      end
    end
  end

  def self.horizontal_rule(owner)
    return RbVHDL::Ast::Comment::HorizontalRule.new(owner)
  end

  def self.new_line(owner)
    return RbVHDL::Ast::Comment::NewLine.new(owner)
  end

  def self.comment(owner, text)
    return RbVHDL::Ast::Comment::Text.new(owner, text)
  end

end
