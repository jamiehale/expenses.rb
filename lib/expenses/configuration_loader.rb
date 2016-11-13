module Expenses

  class ConfigurationLoader

    def self.load( filename )
      configuration = Configuration.new
      File.open( filename ) do |f|
        line_count = 0
        f.each_line do |line|
          line_count += 1
          stripped_line = line.strip
          next if stripped_line.empty?
          next if stripped_line[ 0 ] == '#'
          tokens = tokenize( stripped_line )
          if tokens[ 0 ] == 'account'
            if tokens.length == 3
              configuration.add_account( Account.new( tokens[ 1 ], tokens[ 2 ].to_f ) )
            end
          else
            raise "Unrecognized command on line #{line_count}: #{tokens[0]}"
          end
        end
      end
      configuration
    end

    private

    def self.tokenize( line )
      tokens = []
      in_string = false
      token = ""
      line.each_char do |c|
        if c == '"'
          if in_string
            tokens << token
            token = ""
            in_string = false
          else
            in_string = true
          end
        elsif c == ' ' || c == "\t"
          if in_string
            token << c
          else
            unless token.empty?
              tokens << token
              token = ""
            end
          end
        else
          token << c
        end
      end
      tokens << token
      tokens
    end

  end

end
