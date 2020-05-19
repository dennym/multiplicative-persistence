MAX = 25_000

class Loop
  def initialize
    @x2, @x3, @x5, @x7 = eval File.read(File.dirname(__FILE__) + '/../last_checked_potencies')

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
    File.write(File.dirname(__FILE__) + '/../starttime', "#{Time.now.to_i}")

    store_iterations = 0
    while true
      store_iterations += 1
      @n = @current_number.next

      a = split(@n)
      # impossible combinations
      ic1 = [2,5]
      ic2 = [4,5]
      ic3 = [6,5]
      ic4 = [8,5]

      unless a.include?(0) || (a & ic1).size == ic1.size || (a & ic2).size == ic2.size || (a & ic3).size == ic3.size || (a & ic4).size == ic4.size
        steps = Multiplicative.persistence(@n)

        if steps > 7
          puts 'Found something interesting!'
          saved_text = "Found at: #{Time.now.to_i}, Steps: #{steps}, Number: #{@n}, Potencies: #{[@x2, @x3, @x5, @x7]}\n"
          File.write(File.dirname(__FILE__) + '/../interesting_numbers', saved_text, mode: 'a')
        end
      end

      if store_iterations == 50_000
        File.write(File.dirname(__FILE__) + '/../last_checked_potencies', "#{[@x2, @x3, @x5, @x7]}")
        store_iterations = 0
        puts 'Progress saved!'
      end
    end

  rescue SystemExit, Interrupt
    File.write(File.dirname(__FILE__) + '/../last_checked_potencies', "#{[@x2, @x3, @x5, @x7]}")
  end

  def split(n)
    split=->(x, y=[]) {x < 10 ? y.unshift(x) : split.(x/10, y.unshift(x%10))}

    split.(n)
  end
end
