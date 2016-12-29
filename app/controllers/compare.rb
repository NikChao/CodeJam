require './compiler.rb'

def test(lang, code, expected)
  return Compiler.new.compile_and_run(lang, code) == expected
end
