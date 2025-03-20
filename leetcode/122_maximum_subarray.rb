# Given an integer array nums, find the 
# subarray
#  with the largest sum, and return its sum.

 

# Example 1:

# Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
# Output: 6
# Explanation: The subarray [4,-1,2,1] has the largest sum 6.
# Example 2:

# Input: nums = [1]
# Output: 1
# Explanation: The subarray [1] has the largest sum 1.
# Example 3:

# Input: nums = [5,4,-1,7,8]
# Output: 23
# Explanation: The subarray [5,4,-1,7,8] has the largest sum 23.
 

# Constraints:

# 1 <= nums.length <= 105
# -104 <= nums[i] <= 104
 

# 問題の概要
# 与えられた整数配列 nums から、連続する要素で構成された部分配列の最大の和を求める問題です。例えば、配列 [-2,1,-3,4,-1,2,1,-5,4] から、和が最大になる部分配列は [4,-1,2,1] で、その和は 6 です。

# アルゴリズムの選択
# この問題の最適な解法として**カデーンのアルゴリズム（Kadane's Algorithm）**を使用します。このアルゴリズムは、配列を1回スキャンするだけで部分配列の最大の和を求めることができるため、時間計算量は O(n) と効率的です。

# カデーンのアルゴリズムとは？
# カデーンのアルゴリズムは、次の2つの変数を使用します：

# current_sum：現在の部分配列の和を追跡します。
# max_sum：これまでに見つかった最大の和を保持します。
# アルゴリズムは次のように進行します。

# 最初に配列の最初の要素を current_sum と max_sum に初期化します。
# 2番目の要素から順に配列を走査し、現在の部分配列の和を更新します。具体的には、次のどちらかの操作を選びます：
# 現在の要素を新しい部分配列の開始として採用する。
# 現在の要素をこれまでの部分配列に追加して、部分配列を続ける。
# 更新された current_sum と max_sum を比較し、max_sum を必要に応じて更新します。
# このように、current_sum は部分配列の現在の和を、max_sum は最大の和を常に保持しておき、最終的に max_sum に最大の部分配列の和が格納されます。



# 整数の配列 nums が与えられたとき、最大の和を持つ部分配列を見つけ、その和を返してください。

# 例1:
# 入力: nums = [-2,1,-3,4,-1,2,1,-5,4]
# 出力: 6
# 説明: 部分配列 [4,-1,2,1] は最大の和 6 を持ちます。

# 例2:
# 入力: nums = [1]
# 出力: 1
# 説明: 部分配列 [1] は最大の和 1 を持ちます。

# 例3:
# 入力: nums = [5,4,-1,7,8]
# 出力: 23
# 説明: 部分配列 [5,4,-1,7,8] は最大の和 23 を持ちます。

def max_sub_array(nums)
  # 変数を初期化
  max_sum = nums[0]  # 部分配列の最大の和
  current_sum = nums[0]  # 現在の部分配列の和

  # 配列の2番目の要素から順に見ていく
  (1...nums.length).each do |i|
    # 現在の部分配列の和を更新（前の和を続けるか、現在の値から始めるか）
    current_sum = [nums[i], current_sum + nums[i]].max
    # 最大の和を更新
    max_sum = [max_sum, current_sum].max
    # 経過表示
    puts "i=#{i}, nums[i]=#{nums[i]}, current_sum=#{current_sum}, max_sum=#{max_sum}"
  end

  max_sum
end

# テストケース1
puts "テストケース1: nums = [-2,1,-3,4,-1,2,1,-5,4]"
puts "結果: #{max_sub_array([-2,1,-3,4,-1,2,1,-5,4])}"  # 期待される出力: 6

# # テストケース2
# puts "\nテストケース2: nums = [1]"
# puts "結果: #{max_sub_array([1])}"  # 期待される出力: 1

# # テストケース3
# puts "\nテストケース3: nums = [5,4,-1,7,8]"
# puts "結果: #{max_sub_array([5,4,-1,7,8])}"  # 期待される出力: 23

# 解説:
# この問題は「カデーンのアルゴリズム（Kadane's Algorithm）」を使用して解決します。
# 部分配列の最大の和を求めるために、配列の各要素を見ていき、
# 現在の部分配列の和を更新するか、新たに部分配列を始めるかを判断します。
# `current_sum` は現在の部分配列の和を追跡し、`max_sum` はこれまでに見つけた最大の和を保持します。
# 最終的に、`max_sum` に最大の和が格納され、それを返します。
