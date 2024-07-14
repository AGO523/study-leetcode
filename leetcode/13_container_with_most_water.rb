# You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
# 日本語で
# 長さnの整数配列heightが与えられます。 i番目の線分の2つの端点が(i, 0)と(i, height[i])であるように描かれたn本の垂直線があります。

# Find two lines that together with the x-axis form a container, such that the container contains the most water.
# 日本語で
# x軸と一緒にコンテナを形成する2つの線を見つけて、コンテナが最も多くの水を含むようにします。

# Return the maximum amount of water a container can store.

# Notice that you may not slant the container.

# Input: height = [1,8,6,2,5,4,8,3,7]
# Output: 49
# Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
# Example 2:

# Input: height = [1,1]
# Output: 1
 

# Constraints:

# n == height.length
# 2 <= n <= 105
# 0 <= height[i] <= 104

class Solution
  def max_area(height)
    # 左ポインターを配列の最初の位置に設定
    left = 0
    # 右ポインターを配列の最後の位置に設定
    right = height.length - 1
    # 最大面積を記録する変数を初期化
    max_area = 0

    # 左ポインターが右ポインターに追いつくまでループ
    while left < right
      # 現在の面積を計算
      current_area = [height[left], height[right]].min * (right - left)
      # 最大面積を更新
      max_area = [max_area, current_area].max

      # 高さが低い方のポインターを内側に移動
      if height[left] < height[right]
        left += 1
      else
        right -= 1
      end
    end

    max_area
  end
end

height1 = [1,8,6,2,5,4,8,3,7]
height2 = [1,1]

sol = Solution.new
p sol.max_area(height1)
p sol.max_area(height2)
