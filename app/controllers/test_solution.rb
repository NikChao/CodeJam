require "open3"
require 'date'

@@ext = {"ruby" => ".rb",
         "javascript" => ".js",
         "python" => ".py",
         "C" => ".c",
         "haskell" => ".hs"
        }

def make_file(solution)
  filename = DateTime.now.to_s + Process.pid.to_s + @@ext[solution.language]
  `touch #{filename}`
  File.open(filename, 'w') { |file| file.write(solution.code) }
  return filename
end

def cmd_string(filename, language)
  return case language
    when "javascript"
      return "node #{filename}"
    when "python"
      return "python #{filename}"
    when "ruby"
      return "ruby #{filename}"
    when "C"
      `gcc -o #{pid} #{filename}`
      return "./#{pid}"
    when "haskell"
      `ghc --make #{filename}`
      `return ./#{filename}`
  end
end

def run(cmd, inputs, &block)
  Open3.popen3(cmd) do |stdin, stdout, stderr, thread|

    if block_given?
      Thread.new do
        until (line = stdout.gets).nil? do
          yield line, nil, thread
        end
      end
    end

    #open up Stdin
    Thread.new do
      stdin.puts $stdin.gets while thread.alive?
    end

    # Write to thread stdin
    if inputs.length > 0
      inputs.each do |input|
        stdin.write (input.to_s + "\n")
      end
    end
    stdin.close

    thread.join
  end
end

def test_solution(inputs, output, solution)
  `touch this`
  filename = make_file(solution)
  cmd = cmd_string(filename, solution.language)
  result = "Your Program Had No output or had a syntax error" #empty result
  run(cmd, inputs) do |stdout, stderr, thread|
    result = "Correct" if stdout == output #correct solution
    result = "Wrong, expected: #{output}got: #{stdout}" if stdout != output #bad solution
    result stderr if stderr #if error
  end
  destroy_file(filename)
  puts result
  return true if result == "Correct"
  return false
end

def destroy_file(filename)
  `rm #{filename}*`
end
