
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed, Interfaces.C;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed, Interfaces.C;

procedure test_enum is


type stringptr is access all char_array;
Type foo_t is (
  Foo,
   Bar,
   Blah);

  foo_val : foo_t;
begin
  foo_val := Foo;
end;
