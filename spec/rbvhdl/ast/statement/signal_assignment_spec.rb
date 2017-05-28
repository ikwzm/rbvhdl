require "spec_helper"

describe 'RbVHDL::Ast::Statement::SimpleSignalAssignment' do

  context "new" do

    it "new(nil, name('sig0'), waveform(character_literal('0')))" do
      stmt = RbVHDL::Ast::Statement::SimpleSignalAssignment.new(nil, RbVHDL::Ast.name('sig0'), RbVHDL::Ast.waveform(RbVHDL::Ast.character_literal('0')))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig0
      expect(stmt._waveform.class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size        ).to eq 1
      expect(stmt._waveform._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value).to eq "0"
      expect(stmt._waveform._list[0][1]       ).to eq nil
      expect(stmt._postponed                  ).to eq nil
      expect(stmt._guarded                    ).to eq nil
      expect(stmt._delay                      ).to eq nil
    end

    it "simple_signal_assignment_statement(nil, name('sig1'), character_literal('1'))" do
      stmt = RbVHDL::Ast.simple_signal_assignment_statement(nil, RbVHDL::Ast.name('sig1'), RbVHDL::Ast.character_literal('1'))
      expect(stmt.class                       ).to eq RbVHDL::Ast::Statement::SimpleSignalAssignment
      expect(stmt._owner                      ).to eq nil
      expect(stmt._label                      ).to eq nil
      expect(stmt._target.class               ).to eq RbVHDL::Ast::Expression::SimpleName
      expect(stmt._target._name.class         ).to eq RbVHDL::Ast::Identifier
      expect(stmt._target._name               ).to eq :sig1
      expect(stmt._waveform.class             ).to eq RbVHDL::Ast::Statement::Waveform
      expect(stmt._waveform._list.size        ).to eq 1
      expect(stmt._waveform._list[0][0].class ).to eq RbVHDL::Ast::Expression::CharacterLiteral
      expect(stmt._waveform._list[0][0]._value).to eq "1"
      expect(stmt._waveform._list[0][1]       ).to eq nil
      expect(stmt._postponed                  ).to eq nil
      expect(stmt._guarded                    ).to eq nil
      expect(stmt._delay                      ).to eq nil
    end

  end
  
end
