# Given an integer array nums, find a 
# subarray
#  that has the largest product, and return the product.

# The test cases are generated so that the answer will fit in a 32-bit integer.

# 整数配列 nums が与えられたとき、その中で積が最大となる部分配列（連続する要素の配列）を見つけ、その積を返してください。

# テストケースは、答えが32ビット整数に収まるように作成されています。



# Example 1:

# Input: nums = [2,3,-2,4]
# Output: 6
# Explanation: [2,3] has the largest product 6.
# Example 2:

# Input: nums = [-2,0,-1]
# Output: 0
# Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
 

# Constraints:

# 1 <= nums.length <= 2 * 104
# -10 <= nums[i] <= 10
# The product of any subarray of nums is guaranteed to fit in a 32-bit integer.

# この問題では、配列の中で積が最大となる部分配列を求める必要があります。正の数や負の数が含まれており、負の数の処理が重要なポイントになります。

# アプローチ
# 部分配列の積の更新：

# 連続した要素の積が最大になるように部分配列を選びます。
# 配列に負の数が含まれる場合、その時点で部分配列の積が最小になることがありますが、その後にもう一度負の数が来ると、積は再び大きくなる可能性があります。
# そのため、現在の部分配列の最大積（max_product）だけでなく、最小積（min_product）も記録し、両方を考慮します。
# 動的計画法を使って、現在の位置での最大積・最小積を更新しながら、全体の最大積を求めます。

# 状態遷移のアイデア
# max_product: 現在の要素を含めた場合の最大積。
# min_product: 現在の要素を含めた場合の最小積（負の数が次に正の数と掛け合わされる場合に役立つ）。
# 各ステップで、nums[i] を使って max_product と min_product を更新します。

def max_product(nums)
  return nums[0] if nums.length == 1  # 要素が1つだけの場合、そのまま返す

  # 最大積と最小積を初期化
  max_product = nums[0]
  min_product = nums[0]
  result = nums[0]

  (1...nums.length).each do |i|
    current_num = nums[i]
    # 負の数の場合、最大値と最小値を交換する
    # 負の数を掛けると符号が反転するため、これまでの最大値が最小値になる可能性があるため
    if current_num < 0
      max_product, min_product = min_product, max_product
    end

    # max_product と min_product を更新
    max_product = [current_num, max_product * current_num].max
    min_product = [current_num, min_product * current_num].min
    result = [result, max_product].max
    puts "現在の最大積: #{result}"
  end

  result  # 最終的な最大積を返す
end

# テストケース1
puts "テストケース1: nums = [2, 3, -2, 4]"
puts "出力: #{max_product([2, 3, -2, 4])}"  # 期待される出力: 6

# テストケース2
puts "\nテストケース2: nums = [-2, 0, -1]"
puts "出力: #{max_product([-2, 0, -1])}"  # 期待される出力: 0
