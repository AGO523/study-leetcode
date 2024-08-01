# There is an integer array nums sorted in ascending order (with distinct values).

# Prior to being passed to your function, nums is possibly rotated at an unknown pivot index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

# Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

# You must write an algorithm with O(log n) runtime complexity.

# 整数配列 nums は昇順にソートされています（重複はありません）。

# この配列は、未知のピボットインデックス k (1 <= k < nums.length) で回転されている可能性があります。その結果、配列は [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] になります（0インデックス）。例えば、[0,1,2,4,5,6,7] はピボットインデックス3で回転されて [4,5,6,7,0,1,2] になるかもしれません。

# この可能性のある回転後の配列 nums と整数 target が与えられたとき、target が nums に存在する場合はそのインデックスを返し、存在しない場合は -1 を返してください。

# この問題を O(log n) の時間複雑度で解決するアルゴリズムを作成してください。

# Example 1:

# Input: nums = [4,5,6,7,0,1,2], target = 0
# Output: 4
# Example 2:

# Input: nums = [4,5,6,7,0,1,2], target = 3
# Output: -1
# Example 3:

# Input: nums = [1], target = 0
# Output: -1
 

# Constraints:

# 1 <= nums.length <= 5000
# -104 <= nums[i] <= 104
# All values of nums are unique.
# nums is an ascending array that is possibly rotated.
# -104 <= target <= 104

# この問題は、回転されたソート済み配列に対して二分探索を行うことで効率的に解決できます。以下に、Rubyでの実装例とその解説を示します。

# アルゴリズムの概要
# 探索範囲の設定:

# 配列の左端を left、右端を right として設定します。
# 二分探索のループ:

# left が right 以下の間、ループを続けます。
# 中間のインデックス mid を計算し、 nums[mid] と target を比較します。
# nums[mid] が target と一致する場合、そのインデックス mid を返します。
# それ以外の場合、nums[left] から nums[mid] の範囲がソートされているか、nums[mid] から nums[right] の範囲がソートされているかを判定します。
# ソートされている範囲内に target が含まれているかどうかで、探索範囲を更新します。
# 結果の返却:

# ループが終了しても target が見つからなかった場合、-1 を返します。

def search(nums, target)
  # 初期の探索範囲を設定
  left, right = 0, nums.length - 1

  # 二分探索のループ
  while left <= right
    mid = (left + right) / 2

    # 経過を表示
    puts "Checking range: [#{left}, #{right}], mid: #{mid}, nums[mid]: #{nums[mid]}"

    # 中央の要素がターゲットと一致する場合
    if nums[mid] == target
      puts "Found target at index: #{mid}"
      return mid
    end

    # 左半分がソートされている場合（mid の数値も含めて、ソートされているかどうかを見ている）
    if nums[left] <= nums[mid]
      # 経過を表示
      puts "Left part is sorted: nums[left]: #{nums[left]}, nums[mid]: #{nums[mid]}"

      if nums[left] <= target && target < nums[mid]
        right = mid - 1
      else
        left = mid + 1
      end
    # 右半分がソートされている場合（mid の数値も含めて、ソートされているかどうかを見ている）
    else
      # 経過を表示
      puts "Right part is sorted: nums[mid]: #{nums[mid]}, nums[right]: #{nums[right]}"

      if nums[mid] < target && target <= nums[right]
        left = mid + 1
      else
        right = mid - 1
      end
    end
  end

  # ターゲットが見つからなかった場合
  puts "Target not found"
  -1
end

# 使用例
puts "Result: #{search([4,5,6,7,0,1,2], 0)}"  # 出力: 4
puts "Result: #{search([4,5,6,7,0,1,2], 3)}"  # 出力: -1
puts "Result: #{search([1], 0)}"              # 出力: -1
