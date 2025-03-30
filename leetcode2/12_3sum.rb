def three_sum(nums)
  nums.sort! # まず配列をソート
  result = []

  nums.each_with_index do |num, i|
    # 同じ数をスキップして重複を避ける
    # nums[i] == nums[i - 1] は、nums[i] が前の数と同じ場合をチェック
    # 例えば、[-1, -1, 0, 1, 2] の場合、最初の -1 を選んだ後、
    # 次の -1 を選ぶと、同じ組み合わせができてしまうのでスキップする
    next if i > 0 && nums[i] == nums[i - 1]

    left, right = i + 1, nums.length - 1

    while left < right
      sum = num + nums[left] + nums[right]
      
      if sum == 0
        result << [num, nums[left], nums[right]]

        # 同じ数をスキップして重複を避ける
        #  nums[left] == nums[left + 1] は、nums[left] が次の数と同じ場合をチェック
        left += 1 while left < right && nums[left] == nums[left + 1]
        right -= 1 while left < right && nums[right] == nums[right - 1]

        left += 1
        right -= 1
      elsif sum < 0
        left += 1 # 合計が小さすぎるので left を増やす
      else
        right -= 1 # 合計が大きすぎるので right を減らす
      end
    end
  end

  result
end

# テスト
p three_sum([-1, 0, 1, 2, -1, -4]) # => [[-1, -1, 2], [-1, 0, 1]]
p three_sum([0, 1, 1]) # => []
p three_sum([0, 0, 0]) # => [[0, 0, 0]]
