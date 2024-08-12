# Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.

# There is only one repeated number in nums, return this repeated number.

# You must solve the problem without modifying the array nums and uses only constant extra space.

# 整数の配列 nums が与えられます。この配列には n + 1 個の整数が含まれており、各整数は [1, n] の範囲内です。

# この配列には、1つだけ重複する数値が存在します。その重複する数値を返してください。

# 配列 nums を変更せず、定数の追加メモリのみを使用して問題を解決する必要があります

# Example 1:

# Input: nums = [1,3,4,2,2]
# Output: 2
# Example 2:

# Input: nums = [3,1,3,4,2]
# Output: 3
# Example 3:

# Input: nums = [3,3,3,3,3]
# Output: 3
 

# Constraints:

# 1 <= n <= 105
# nums.length == n + 1
# 1 <= nums[i] <= n
# All the integers in nums appear only once except for precisely one integer which appears two or more times.

# この問題を解決するために、配列を直接操作せず、かつ追加メモリを使用せずに重複する数を特定する方法として、「フロイドのトータスとヘア」アルゴリズムを使用します。これはサイクル検出アルゴリズムで、リンクリストのような構造で数値をたどることで、重複した数値を見つけます。



def find_duplicate(nums)
  # ステップ1: 初期位置を設定（最初は配列の先頭の値）
  slow = nums[0]
  fast = nums[0]

  # ステップ2: サイクル検出のため、ポインタを動かす
  begin
    slow = nums[slow]  # Slowポインタは次のインデックスにジャンプする
    fast = nums[nums[fast]]  # Fastポインタは2回ジャンプする（2倍の速さで進む）
    puts "Slow is at index #{slow}, Fast is at index #{fast}"
  end while slow != fast  # 2つのポインタが出会うまでループ

  # ステップ3: Slowポインタを初期位置に戻し、サイクルの開始点（重複する数）を探す
  slow = nums[0]
  while slow != fast
    slow = nums[slow]  # Slowポインタは次のインデックスにジャンプする
    fast = nums[fast]  # Fastポインタも次のインデックスにジャンプする
    puts "Moving to find entrance, Slow is at index #{slow}, Fast is at index #{fast}"
  end

  puts "Duplicate number found: #{slow}"
  slow  # 重複している数値を返す
end

# 使用例
nums = [1, 3, 4, 2, 2]
puts "Input array: #{nums}"
result = find_duplicate(nums)
puts "Duplicate number is: #{result}"
