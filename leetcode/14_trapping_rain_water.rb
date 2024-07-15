# Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.
# n個の非負の整数が与えられています。これらは各棒の幅が1である標高マップを表しています。雨が降った後に、どれだけの水が溜められるかを計算してください。

# Example 1:
# Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
# Output: 6
# Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.
# 説明: 上の標高マップ（黒い部分）は配列 [0,1,0,2,1,0,1,3,2,1,2,1] で表されています。この場合、6単位の雨水（青い部分）が溜められます。


# Example 2:
# Input: height = [4,2,0,3,2,5]
# Output: 9
 

# Constraints:

# n == height.length
# 1 <= n <= 2 * 104
# 0 <= height[i] <= 105

class Solution
  def trap(height)
    # 配列の長さが2未満の場合、溜められる水はない
    return 0 if height.size < 2

    # 左ポインターと右ポインターを初期化
    left = 0
    right = height.size - 1
    # 左側の最大値と右側の最大値を初期化
    left_max = height[left]
    right_max = height[right]
    # 溜められる水の総量を初期化
    total_water = 0

    # 左ポインターが右ポインターに追いつくまでループ
    while left < right
      if height[left] < height[right]
        # 左側の高さが右側の高さよりも低い場合
        left += 1
        left_max = [left_max, height[left]].max
        # 左側の最大値と現在の高さの差分を加算
        total_water += left_max - height[left]
      else
        # 右側の高さが左側の高さよりも低い場合
        right -= 1
        right_max = [right_max, height[right]].max
        # 右側の最大値と現在の高さの差分を加算
        total_water += right_max - height[right]
      end
    end

    # 溜められる水の総量を返す
    total_water
  end
end

height1 = [0,1,0,2,1,0,1,3,2,1,2,1]
height2 = [4,2,0,3,2,5]

sol = Solution.new
p sol.trap(height1)
p sol.trap(height2)
