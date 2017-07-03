RbVHDL
======

Ruby-based Toolkit for VHDL

## Description

 - RbVHDL::Ast    : Ruby-based abstract syntax tree of VHDL.
 - RbVHDL::Writer : VHDL Code Generator from RbVHDL::Ast.

## Example

```ruby:example.rb
require_relative "lib/rbvhdl/writer"

design_unit = RbVHDL::Ast::DesignUnit.new

design_unit._library_clause('ieee')
design_unit._use_clause(RbVHDL::Ast.name(:ieee)._select(:numeric_std)._select_all)

design_unit._entity("SAMPLE"){
  _generic_interface 'WIDTH', RbVHDL::Ast.subtype_indication('integer'  )._range_to(1,8), 5
  _port_interface    'CLK'  , RbVHDL::Ast.subtype_indication('std_logic'), :in
  _port_interface    'RST'  , RbVHDL::Ast.subtype_indication('std_logic'), :in
  _port_interface    'D'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name("WIDTH"),1),0), :in
  _port_interface    'Q'    , RbVHDL::Ast.subtype_indication('std_logic_vector')._downto(RbVHDL::Ast.subtraction(RbVHDL::Ast.name("WIDTH"),1),0), :out
}

design_unit._architecture('MODEL', 'SAMPLE'){
  _process_statement._label!("MAIN")._sensitivity_signal!(RbVHDL::Ast.name('CLK'), RbVHDL::Ast.name('RST')) {
    _if_statement(RbVHDL::Ast.equal(RbVHDL::Ast.name('RST'),RbVHDL::Ast.character_literal('1'))){
      _signal_assignment_statement(
        RbVHDL::Ast.name('Q'),
        RbVHDL::Ast.aggregate(RbVHDL::Ast.aggregate_item(RbVHDL::Ast.choice_others, RbVHDL::Ast.character_literal('0')))
      )
    }._elsif!(RbVHDL::Ast.logical_and(RbVHDL::Ast.name('CLK')._attribute('event'),RbVHDL::Ast.name('CLK'), RbVHDL::Ast.character_literal('1'))){
      _signal_assignment_statement(
        RbVHDL::Ast.name('Q'),
        RbVHDL::Ast.name('D')
      )
    }
  }
}

puts design_unit._write_line
```

```
shell$ ruby example.rb
library ieee;
use     ieee.numeric_std.all;
entity  SAMPLE is
    generic(
        WIDTH   :  integer range 1 to 8 := 5
    );
    port(
        CLK     :  in  std_logic;
        RST     :  in  std_logic;
        D       :  in  std_logic_vector(WIDTH-1 downto 0);
        Q       :  out std_logic_vector(WIDTH-1 downto 0)
    );
end     SAMPLE;
architecture MODEL of SAMPLE is
begin
    MAIN: process(CLK, RST) begin
        if    RST = '1' then
            Q <= (others => '0');
        elsif CLK'event and CLK and '1' then
            Q <= D;
        end if;
    end process;
end MODEL;
```

## License

[BSD 2-Clause License](https://github.com/ikwzm/rbvhdl/blob/master/LICENSE)

## Author

[ikwzm (https://github.com/ikwzm)](https://github.com/ikwzm)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ikwzm/rbvhdl.

