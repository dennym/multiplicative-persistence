class Loop
  def initialize
    @current_number = File.read(File.dirname(__FILE__) + '/../last_checked_number').to_i
  end

  def start
    while true
      steps = Multiplicative.persistence(@current_number)

      if steps > 9
        puts 'Found something interesting!'
        File.write(File.dirname(__FILE__) + '/../interesting_numbers', "Steps: #{steps}, Number: #{@current_number}\n", mode: 'a')
      elsif steps % 10_000_000
        puts "Reporting in from current number: #{current_number}"
      end

      @current_number += 1
    end

  rescue SystemExit, Interrupt
    File.write(File.dirname(__FILE__) + '/../last_checked_number', @current_number)
  end
end
