# temperatures = [73,74,75,71,69,72,76,73]
# answer = [1,1,4,2,1,1,0,0]

def daily_temperatures(temperatures)
  stack = []
  result = Array.new(temperatures.size, 0)

  temperatures.length.times do |i|
    while !stack.empty? && temperatures[i] > temperatures[stack.last]
      last_index = stack.pop
      result[last_index] = i - last_index
    end

    stack.push(i)
  end

  result
end
