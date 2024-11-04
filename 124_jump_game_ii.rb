# You are given a 0-indexed array of integers nums of length n. You are initially positioned at nums[0].

# Each element nums[i] represents the maximum length of a forward jump from index i. In other words, if you are at nums[i], you can jump to any nums[i + j] where:

# 0 <= j <= nums[i] and
# i + j < n
# Return the minimum number of jumps to reach nums[n - 1]. The test cases are generated such that you can reach nums[n - 1].

 

# Example 1:

# Input: nums = [2,3,1,1,4]
# Output: 2
# Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
# Example 2:

# Input: nums = [2,3,0,1,4]
# Output: 2
 

# Constraints:

# 1 <= nums.length <= 104
# 0 <= nums[i] <= 1000
# It's guaranteed that you can reach nums[n - 1].


# 整数の配列 nums が与えられています。配列の長さは n です。あなたは最初、配列の最初の要素 nums[0] に位置しています。
# 各要素 nums[i] は、その位置から前方にジャンプできる最大の長さを表しています。
# nums[n - 1] に到達するために必要な最小のジャンプ数を返してください。
# テストケースは、必ず nums[n - 1] に到達できるように生成されています。

# 例1:
# 入力: nums = [2,3,1,1,4]
# 出力: 2
# 説明: 最小のジャンプ数は 2 です。インデックス 0 から 1 へ1ステップジャンプし、次にインデックス 1 から最後のインデックスまで3ステップジャンプします。

# 例2:
# 入力: nums = [2,3,0,1,4]
# 出力: 2

# 制約:
# 1 <= nums.length <= 10^4
# 0 <= nums[i] <= 1000
# 必ず nums[n - 1] に到達できると保証されています。

def min_jumps(nums)
  n = nums.length
  jumps = 0  # ジャンプ回数
  current_end = 0  # 現在のジャンプで到達できる範囲の終端
  farthest = 0  # 次のジャンプで到達可能な最大位置

  (0...n - 1).each do |i|
    # 到達可能な最も遠い位置を更新
    farthest = [farthest, i + nums[i]].max

    # 現在の範囲の終端に到達したらジャンプを増やす
    if i == current_end
      p i
      p current_end
      jumps += 1
      current_end = farthest
      # 経過表示
      puts "インデックス #{i} でジャンプ: 現在のジャンプ数=#{jumps}, 到達可能な最大位置=#{farthest}"
    end
  end

  jumps
end

# テストケース1
puts "テストケース1: nums = [2,3,1,1,4]"
puts "結果: #{min_jumps([2,3,1,1,4])}"  # 期待される出力: 2

# # テストケース2
# puts "\nテストケース2: nums = [2,3,0,1,4]"
# puts "結果: #{min_jumps([2,3,0,1,4])}"  # 期待される出力: 2

# 解説:
# この問題は、貪欲法を使用して解決します。
# 変数 `farthest` を使って、各位置で次に到達可能な最大の範囲を追跡します。
# 変数 `current_end` は現在のジャンプで到達可能な範囲の終端を示し、その範囲に到達したらジャンプ回数を増やします。
# これにより、必要な最小のジャンプ回数を効率的に求めることができます。

### 詳細な解説

# この問題は、「配列の最初から最後の要素まで到達するために必要な最小のジャンプ数を求める」問題です。各要素 `nums[i]` は、その位置から前方にジャンプできる最大の長さを表しています。

# #### アプローチ
# この問題を解くために**貪欲法**を使用します。貪欲法では、各ステップで現在到達可能な最大の範囲を追跡し、最小のジャンプ回数を効率的に決定します。

# #### 変数の使い方
# - **`jumps`**：
#   - 必要なジャンプ回数をカウントする変数です。
# - **`current_end`**：
#   - 現在のジャンプで到達可能な範囲の終端を示します。
#   - 一度ジャンプすると、そのジャンプで到達可能な位置を示す境界です。
# - **`farthest`**：
#   - 次のジャンプで到達可能な最大の位置を追跡します。
#   - これにより、次のジャンプで最も遠くに進むための候補を常に保持します。

# #### アルゴリズムの流れ
# 1. **初期化**：
#    - 配列の長さを `n` とし、`jumps` を `0` に、`current_end` と `farthest` を `0` に初期化します。
# 2. **配列を1回走査**：
#    - インデックス `0` から `n - 2` までの範囲でループを回します。最後の要素に到達する必要がないため、`n - 1` までではなく `n - 2` までとします。
# 3. **`farthest` の更新**：
#    - 各インデックスで、現在位置 `i` からジャンプして到達可能な最大位置を `farthest` に更新します。
#    - `farthest = [farthest, i + nums[i]].max` のように、`i` からジャンプして得られる最大の到達可能インデックスと既存の `farthest` を比較して、大きい方を選択します。
# 4. **`current_end` に到達した場合**：
#    - ループ中にインデックス `i` が `current_end` に到達した場合、現在のジャンプでカバーされる範囲が終了したことを意味します。
#    - その時点で `jumps` を1つ増やし、次のジャンプで到達可能な最大の位置（`farthest`）を `current_end` として設定します。
#    - これにより、新たなジャンプで進める最大の範囲に移動します。
# 5. **最終的な結果**：
#    - ループが終了する時点で、`jumps` には配列の最初から最後まで到達するための最小ジャンプ数が格納されています。

# #### 例を使った解説
# ##### 例1：`nums = [2, 3, 1, 1, 4]`
# 1. 最初に `i = 0` で、`nums[0] = 2` です。ここからジャンプして到達できる最大の位置は `i + nums[i] = 2` なので、`farthest = 2` になります。
# 2. 現在のジャンプでの終端 `current_end = 0` に到達したので、ジャンプを増やして `jumps = 1`、`current_end` を `farthest = 2` に更新します。
# 3. 次に、インデックス `1` に進みます。`nums[1] = 3` で、ここからジャンプして到達可能な最大位置は `1 + 3 = 4` です。したがって、`farthest = 4` になります。
# 4. 再び `current_end = 2` に到達したので、ジャンプを増やして `jumps = 2`、`current_end` を `farthest = 4` に更新します。
# 5. 最後のインデックス `4` に到達できるので、最小ジャンプ数は `2` です。

# ##### 例2：`nums = [2, 3, 0, 1, 4]`
# - 同様に進めると、`jumps` は `2` になります。インデックス `0` から `1` へジャンプし、その後インデックス `1` から最後のインデックスに到達します。

# #### 状態遷移の経過表示
# プログラムでは、各インデックスでのジャンプのタイミングと、`farthest` および `current_end` の値を `puts` で表示しています。これにより、各ステップでどのようにジャンプが行われ、到達可能範囲が更新されているかが確認できます。

# #### 計算量
# - **時間計算量**：`O(n)`。配列を1度走査するだけであるため、効率的です。
# - **空間計算量**：`O(1)`。追加の空間はほとんど使用せず、いくつかの定数の変数のみを使用します。

# このアプローチは、貪欲法に基づいており、最小のジャンプ回数を求めるために最適な方法です。各位置で可能な最大のジャンプを追跡し、最小のジャンプ数を見つけることができます。
