module Highspot
  class CLI
    OUTPUT_FILE = './output.json'.freeze

    def run
      args = parse_args
      source = parse_json_file(args['-s'])
      changes = parse_json_file(args['-c'])
      result = Highspot::Changer.new.perform(source: source, changes: changes)
      save_file(result)
    rescue StandardError
      puts 'Program failed'
    end

    private

    def parse_args
      args = Hash[*ARGV]
      raise ArgumentError if !args.include?('-s') || !args.include?('-c') || (args.length != 2)

      args
    rescue StandardError => e
      puts 'Usage: -s <source file> -c <file with changes>'
      raise e
    end

    def parse_json_file(path)
      JSON.load_file(path, symbolize_names: true)
    rescue StandardError => e
      puts "JSON file invalid, path: #{path}"
      raise e
    end

    def save_file(data)
      File.open(OUTPUT_FILE, 'w') do |io|
        io.puts JSON.pretty_generate(data)
      end
    end
  end
end
