require 'set'

def longest_consecutive(nums)
  return 0 if nums.empty?

  num_set = nums.to_set
  max_length = 0

  nums.each do |num|
    # num - 1 が存在しない場合のみ、新しい連続列のスタート地点（[100,4,200,1,3,2]の場合、100 - 1 = 99 は存在しないため、スタート地点になるが、2 - 1 = 1 は存在するため、スタート地点にはならない）
    next if num_set.include?(num - 1)
    length = 1
    current = num


    # 連続する数値を探索
    while num_set.include?(current + 1)
      current += 1
      length += 1
      # すでに探索した数値は削除することで、重複して探索しないようにする
      num_set.delete(current)
    end

    max_length = [max_length, length].max
  end

  max_length
end

# テスト
p longest_consecutive([100,4,200,1,3,2])  # 4
p longest_consecutive([0,3,7,2,5,8,4,6,0,1])  # 9
p longest_consecutive([1,0,1,2])  # 3
