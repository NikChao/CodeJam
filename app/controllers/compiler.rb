require 'date'

class Compiler

  @@ext = {"ruby" => ".rb", "javascript" => ".js", "python" => ".py", "C" => ".c"}
  
  def initialize
  end
  
  def execute_javascript(filename)
    return `node #{filename}`
  end

  def execute_python(filename)
    return `python #{filename}`
  end

  def execute_ruby(filename)
    return `ruby #{filename}`
  end
  
  def execute_c(filename)
    pid = Process.pid
    `gcc -o #{pid} #{filename}`
    output = `./#{pid}`
    `rm #{pid}`
    return output
  end

  def execute_command(language, filename)
    return case language
      when "javascript"
        execute_javascript(filename)
      when "python"
        execute_python(filename)
      when "C"
        execute_c(filename)
    end
  end

  def check_output(expected, actual)
    if expected == actual
      return true
    else
      return false
    end
  end

  def compile_and_run(language, code)

    # generate filename based on process_id, datetime and language
    filename = DateTime.now.to_s + Process.pid.to_s + @@ext[language]

    # create file
    #`touch #{filename}`

    # write code to file
    File.open(filename, 'w') { |file| file.write(code) }
  
    # execute file
    value = execute_command(language, filename)
  
    # format expected and actual
    expected = "Hello, World!"
    value = value.to_s

    # check output
    mark = check_output(expected, value.to_s)
    
    #delete file
    `rm #{filename}`
    return value
  end
end
