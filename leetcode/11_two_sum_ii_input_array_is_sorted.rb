# Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length.
# 日本語で
# 既に非減少の順序でソートされた整数の1からインデックス付けされた配列numbersが与えられ、特定のターゲット番号に合計する2つの数値を見つけます。これら2つの数値をnumbers[index1]とnumbers[index2]とし、1 <= index1 < index2 <= numbers.lengthとします。

# Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.
# 日本語で
# 長さ2の整数配列[index1、index2]として、1つ追加された2つの数値、index1とindex2のインデックスを返します。

# The tests are generated such that there is exactly one solution. You may not use the same element twice.
# 日本語で
# テストは、正確に1つの解決策があるように生成されます。同じ要素を2回使用することはできません。

# Your solution must use only constant extra space.
# 日本語で
# あなたの解決策は、定数の余分なスペースのみを使用する必要があります。

# Example 1:

# Input: numbers = [2,7,11,15], target = 9
# Output: [1,2]
# Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
# Example 2:

# Input: numbers = [2,3,4], target = 6
# Output: [1,3]
# Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
# Example 3:

# Input: numbers = [-1,0], target = -1
# Output: [1,2]
# Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
 

# Constraints:

# 2 <= numbers.length <= 3 * 104
# -1000 <= numbers[i] <= 1000
# numbers is sorted in non-decreasing order.
# -1000 <= target <= 1000
# The tests are generated such that there is exactly one solution.

class Solution
  def two_sum(numbers, target)
    left = 0
    right = numbers.length - 1
    
    while left < right
      p "numbers[left]: #{numbers[left]}"
      p   "numbers[right]: #{numbers[right]}"
      sum = numbers[left] + numbers[right]
      if sum == target
        # インデックスは1から始まるため、1を追加
        return [left + 1, right + 1]
      elsif sum < target
        left += 1
        # sum が target よりも小さい場合、合計を大きくする必要があります。
        # 配列は非減少順にソートされているため、left ポインターを右に移動させる（left += 1）ことで、より大きな値を持つ要素を sum に含めることができます。
        # これにより、合計がターゲットに近づく可能性が高まります。
      else
        right -= 1
        # sum が target 以上の場合、合計を小さくする必要があります。
        # 配列は非減少順にソートされているため、right ポインターを左に移動させる（right -= 1）ことで、より小さな値を持つ要素を sum に含めることができます。
        # これにより、合計がターゲットに近づく可能性が高まります。
      end
      # この方法は、二分探索のように配列の両端から中央に向かって探索することで、効率的にターゲットとなる合計を見つけることができます。
    end

    return []
  end
end

numbers1 = [2,7,11,15]
target1 = 9
numbers2 = [2,3,4]
target2 = 6
numbers3 = [-1,0]
target3 = -1

sol = Solution.new
p sol.two_sum(numbers1, target1)
p sol.two_sum(numbers2, target2)
p sol.two_sum(numbers3, target3)
