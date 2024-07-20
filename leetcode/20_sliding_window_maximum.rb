# You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

# Return the max sliding window.

# 整数の配列 nums が与えられます。配列の左端から右端に向かってスライドするサイズ k のウィンドウがあります。各ウィンドウが1つ右にスライドするたびに、ウィンドウ内の k 個の数字を見ることができます。

# 各ウィンドウが右に1つスライドするたびに、ウィンドウ内の最大値を返してください。

# Example 1:

# Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
# Output: [3,3,5,5,6,7]
# Explanation: 
# Window position                Max
# ---------------               -----
# [1  3  -1] -3  5  3  6  7       3
#  1 [3  -1  -3] 5  3  6  7       3
#  1  3 [-1  -3  5] 3  6  7       5
#  1  3  -1 [-3  5  3] 6  7       5
#  1  3  -1  -3 [5  3  6] 7       6
#  1  3  -1  -3  5 [3  6  7]      7
# Example 2:

# Input: nums = [1], k = 1
# Output: [1]

# Constraints:

# 1 <= nums.length <= 105
# -104 <= nums[i] <= 104
# 1 <= k <= nums.length

# 解法のアプローチ
# Dequeを使って、ウィンドウ内の要素を管理します。Dequeの先頭には常にウィンドウ内の最大値が位置します。
# 新しい要素をウィンドウに追加するとき、Dequeの後ろから要素を削除し、Dequeの要素が単調減少になるようにします。
# ウィンドウから古い要素を削除する際、Dequeの先頭から要素を削除します。
# 各ウィンドウの最大値をDequeの先頭から取得し、それを結果に追加します。


def max_sliding_window(nums, k)
  return [] if nums.empty?
  return nums if k == 1
  
  # Dequeを初期化（ウィンドウ内の要素のインデックスを保持）
  deque = []
  # 結果を格納する配列
  result = []

  nums.each_with_index do |num, i|
    # Dequeの先頭がウィンドウ外に出た場合、先頭を削除
    if !deque.empty? && deque.first == i - k
      deque.shift
    end
    
    # Dequeの後ろから現在の要素より小さい要素を削除
    # これにより、Deque内の要素が単調減少になるようにする
    while !deque.empty? && nums[deque.last] < num
      deque.pop
    end
    
    # 現在の要素のインデックスをDequeに追加
    deque << i
    
    # ウィンドウのサイズがkに達したら、結果配列に最大値を追加
    # Dequeの先頭の要素がウィンドウ内の最大値を指す
    if i >= k - 1
      result << nums[deque.first]
    end
  end

  result
end

# 使用例
puts max_sliding_window([1,3,-1,-3,5,3,6,7], 3).inspect  # 出力: [3, 3, 5, 5, 6, 7]
puts max_sliding_window([1], 1).inspect                # 出力: [1]
