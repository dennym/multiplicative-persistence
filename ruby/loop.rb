MAX = 150

class Loop
  def initialize
    @x2, @x3, @x5, @x7 = eval File.read(File.dirname(__FILE__) + '/../last_checked_number')

    puts "Initialize with: #{[@x2, @x3, @x5, @x7]}"

    @current_number = Enumerator.new do |y|
      values = %w[@x2 @x3 @x5 @x7]
      loop do
        y.yield (2**@x2 * 3**@x3 * 5**@x5 * 7**@x7)

        if [@x2, @x3, @x5, @x7] == [MAX, MAX, MAX, MAX]
          break
        elsif @x5 == MAX && @x3 == MAX && @x2 == MAX
          @x7 += 1
          @x2 = @x3 = @x5 = 0
        elsif @x3 == MAX && @x2 == MAX
          @x5 += 1
          @x2 = @x3 = 0
        elsif @x2 == MAX
          @x3 += 1
          @x2 = 0
        else
          @x2 += 1
        end
      end
    end
  end

  def start
    while true
      n = @current_number.next
      # if split(@current_number) & [0, 5] == []
      if split(n).include?(0)
        # skip
      else
        steps = Multiplicative.persistence(n)

        if steps > 7
          puts 'Found something interesting!'
          saved_text = "Steps: #{steps}, Number: #{n}, Potencies: #{[@x2, @x3, @x5, @x7]}\n"
          File.write(File.dirname(__FILE__) + '/../interesting_numbers', saved_text, mode: 'a')
        elsif [@x2, @x3, @x5, @x7].map{_1 % 10}.uniq == [0]
          puts "Reporting in from current number: #{n}"
        end
      end
    end

  rescue SystemExit, Interrupt
    File.write(File.dirname(__FILE__) + '/../last_checked_number', "#{[@x2, @x3, @x5, @x7]}")
  end

  def split(n)
    split=->(x, y=[]) {x < 10 ? y.unshift(x) : split.(x/10, y.unshift(x%10))}

    split.(n)
  end
end
