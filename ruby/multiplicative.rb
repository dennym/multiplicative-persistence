class Multiplicative
  class << self
    def persistence(n, steps = 1)
      return steps if n == 0
      return steps if get_length(n) <= 1

      persistence(split(n).inject(:*), steps += 1)
    end

    private

    def split(n)
      split=->(x, y=[]) {x < 10 ? y.unshift(x) : split.(x/10, y.unshift(x%10))}

      split.(n)
    end

    def get_length(n)
      Math.log10(n).to_i + 1
    end
  end
end


