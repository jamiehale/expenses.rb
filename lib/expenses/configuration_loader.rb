module Expenses

  ## Loads configuration from file
  class ConfigurationLoader

    def self.load( filename )
      configuration = Configuration.new
      File.open( filename ) do |f|
        read_file( f, configuration )
      end
      configuration
    end

    def self.read_file( f, configuration )
      line_count = 0
      f.each_line do |line|
        line_count += 1
        process_line( line.strip, line_count, configuration )
      end
    end

    def self.process_line( line, line_count, configuration )
      return if line.empty?
      return if line[ 0 ] == '#'
      tokens = tokenize( line )
      if tokens[ 0 ] == 'account'
        configuration.add_account( account_from( tokens, line_count ) )
      elsif valid_expense_command( tokens[ 0 ] )
        configuration.add_expense( process_expense( tokens, line_count ) )
      else
        raise "Unrecognized command on line #{line_count}: #{tokens[0]}"
      end
    end

    def self.valid_expense_command( command )
      %w( once daily monthly weekly biweekly budget ).include? command
    end

    def self.process_expense( tokens, line_count )
      return one_time_expense( tokens, line_count ) if tokens[ 0 ] == 'once'
      return daily_expense( tokens, line_count ) if tokens[ 0 ] == 'daily'
      return monthly_expense( tokens, line_count ) if tokens[ 0 ] == 'monthly'
      return weekly_expense( tokens, line_count ) if tokens[ 0 ] == 'weekly'
      return biweekly_expense( tokens, line_count ) if tokens[ 0 ] == 'biweekly'
      return budget_expense( tokens, line_count ) if tokens[ 0 ] == 'budget'
    end

    def self.account_from( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 3
      Account.new( tokens[ 1 ], tokens[ 2 ].to_f )
    end

    def self.one_time_expense( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 4
      OneTimeExpense.new( Date.parse( tokens[ 1 ] ), tokens[ 2 ].to_f, tokens[ 3 ] )
    end

    def self.daily_expense( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 3
      DailyExpense.new( tokens[ 1 ].to_f, tokens[ 2 ] )
    end

    def self.monthly_expense( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 4
      MonthlyExpense.new( tokens[ 1 ].to_i, tokens[ 2 ].to_f, tokens[ 3 ] )
    end

    def self.weekly_expense( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 4
      WeeklyExpense.new( Date.parse( tokens[ 1 ] ), tokens[ 2 ].to_f, tokens[ 3 ] )
    end

    def self.biweekly_expense( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 4
      BiWeeklyExpense.new( Date.parse( tokens[ 1 ] ), tokens[ 2 ].to_f, tokens[ 3 ] )
    end

    def self.budget_expense( tokens, line_count )
      raise "Syntax error on line #{line_count}" unless tokens.length == 4
      raise "Syntax error on line #{line_count}" unless tokens[ 1 ] == 'monthly'
      MonthlyBudgetExpense.new( tokens[ 2 ].to_f, tokens[ 3 ] )
    end

    def self.tokenize( line )
      tokens = []
      in_string = false
      token = ''
      line.each_char do |c|
        if c == '"'
          if in_string
            tokens << token
            token = ''
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
              token = ''
            end
          end
        else
          token << c
        end
      end
      tokens << token unless token.empty?
      tokens
    end

    private_class_method :tokenize

  end

end
