require_relative './multiplicative.rb'

class Loop
  def initialize
    @current_number = File.read('../last_checked_number').to_i
  end

  def start
    while true
      steps = Multiplicative.persistence(@current_number)

      if steps > 4
        puts 'Found something interesting!'
        File.write('../interesting_numbers', "Steps: #{steps}, Number: #{@current_number}\n", mode: 'a')
      end

      @current_number += 1
    end

  rescue SystemExit, Interrupt
    File.write('../last_checked_number', @current_number)
    raise
  end
end