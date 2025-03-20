# You are given an integer array nums and an integer target.

# You want to build an expression out of nums by adding one of the symbols '+' and '-' before each integer in nums and then concatenate all the integers.

# For example, if nums = [2, 1], you can add a '+' before 2 and a '-' before 1 and concatenate them to build the expression "+2-1".
# Return the number of different expressions that you can build, which evaluates to target.

# 整数配列 nums と整数 target が与えられます。

# nums の各整数の前に + または - のいずれかの記号を追加し、すべての整数を結合して数式を構築します。

# 例えば、nums = [2, 1] の場合、+ を2の前に、- を1の前に追加して "+2-1" の数式を作ることができます。

# このようにして target に評価される異なる数式を作る方法の数を返してください。

# Example 1:

# Input: nums = [1,1,1,1,1], target = 3
# Output: 5
# Explanation: There are 5 ways to assign symbols to make the sum of nums be target 3.
# -1 + 1 + 1 + 1 + 1 = 3
# +1 - 1 + 1 + 1 + 1 = 3
# +1 + 1 - 1 + 1 + 1 = 3
# +1 + 1 + 1 - 1 + 1 = 3
# +1 + 1 + 1 + 1 - 1 = 3
# Example 2:

# Input: nums = [1], target = 1
# Output: 1
 

# Constraints:

# 1 <= nums.length <= 20
# 0 <= nums[i] <= 1000
# 0 <= sum(nums[i]) <= 1000
# -1000 <= target <= 1000

# アプローチ
# この問題では、すべての数値を足した結果とターゲットとの差分を考えることで、動的計画法を適用します。

# 問題の変換：

# 与えられた数列 nums から、+ と - を使って target を作る方法を求めるため、次のように考えます。
# 全体の和を S とします。+ の組み合わせの部分和を P、- の組み合わせの部分和を N とします。ここで P - N = target となります。
# また、P + N = S（全体の和）でもあります。
# これらの2つの式を使うと、次のようにまとめられます：
# 2P = S + target から、P = (S + target) / 2
# つまり、ターゲットに一致させるためには、「部分和が (S + target) / 2 になる組み合わせを探す」問題に変換できます。
# DPの設定：

# dp[i] を「部分和が i になる組み合わせの数」と定義します。
# 初期状態として、dp[0] = 1（何も選ばない場合が1通り存在）とします。
# 配列 nums の各要素について、それが加わることで部分和が i になるかを更新します。
# 問題の解決：

# ターゲットが (S + target) / 2 のときの部分和を求めれば良いので、dp[(S + target) / 2] を返します。

def find_target_sum_ways(nums, target)
  total_sum = nums.sum

  # (S + target) が奇数であれば、P = (S + target) / 2 が整数にならないので無理
  return 0 if (total_sum + target) % 2 != 0
  
  # 新しいターゲット値（部分和）
  # 下記を参照
  new_target = (total_sum + target) / 2
  # new_targetが負の場合も無理
  return 0 if new_target < 0
  
  # DP配列の初期化
  dp = Array.new(new_target + 1, 0)
  dp[0] = 1  # 部分和が0になる組み合わせは1通り（何も選ばない場合）

  # DPテーブルの更新
  nums.each do |num|
    new_target.downto(num).each do |i|
      dp[i] += dp[i - num]
      puts "dp[#{i}] = #{dp[i]} (using num: #{num})"
    end
  end

  dp[new_target]
end

# テストケース1
puts "テストケース1: nums = [1,1,1,1,1], target = 3"
puts "結果: #{find_target_sum_ways([1,1,1,1,1], 3)}"  # 期待される出力: 5

# # テストケース2
# puts "\nテストケース2: nums = [1], target = 1"
# puts "結果: #{find_target_sum_ways([1], 1)}"  # 期待される出力: 1

# `new_target = (total_sum + target) / 2` という式は、問題を**部分和問題（Subset Sum Problem）**に変換するための重要なステップです。この式を使うことで、もともとの「`+` と `-` を使って `target` に一致させる」という問題を、**部分和が特定の値になる組み合わせを見つける問題**に変換しています。

# ### 1. 問題の変換

# この問題では、各 `nums` の要素に `+` または `-` を使って、数式全体が `target` に一致するようにしたいわけです。まず、次の2つの考え方を導入します：

# - `P`: すべての `+` を使って足し合わせた数値の合計
# - `N`: すべての `-` を使って引いた数値の合計

# したがって、数式の合計は次のように表されます：
# \[
# P - N = target
# \]
# さらに、配列 `nums` のすべての数の合計を `S` とします。これは次のように表せます：
# \[
# P + N = S
# \]
# ここで、`P` は `+` の記号で選ばれた部分和で、`N` は `-` の記号で選ばれた部分和です。これらの2つの式を組み合わせると、次のような式が導けます：

# ### 2. 数式の変形

# 次に、この2つの式を利用して `P` について解くと、以下のように導けます：

# - `P - N = target`
# - `P + N = S`

# 上の2つの式を足し合わせると、`2P = S + target` という式が得られます。これを `P` について解くと：

# \[
# P = \frac{S + target}{2}
# \]

# この `P` は、全体の配列 `nums` の中で部分和として表せる合計値を示しています。つまり、「配列 `nums` のいくつかの要素を選んで部分和を `P` にする」ことが、元の問題に対する解となります。

# ### 3. `new_target` の意味

# `new_target = (total_sum + target) / 2` という式は、ターゲットとなる部分和を表しています。動的計画法（DP）を使って、この `new_target` に一致する部分和を作る組み合わせの数を数えます。

# - `total_sum` は、配列 `nums` のすべての要素を足し合わせた値です。
# - `target` は、問題で指定された目標値です。

# この `new_target` を求めたら、次は「配列 `nums` の中でどのような組み合わせがこの部分和 `new_target` を作れるか」を計算します。具体的には、DPを使ってこの `new_target` を作るための組み合わせの数を数え、それが元の問題における解となります。

# ### 注意点
# `(total_sum + target)` が **奇数** の場合、`2P = S + target` から計算される `P` は整数にならないので、この場合は正しい解が存在しないことになります。このため、もし `(total_sum + target) % 2 != 0` であれば、結果は `0` を返します。

# ---

# ### 例を使った説明

# 例えば、次のような問題を考えます：

# - `nums = [1, 1, 1, 1, 1]`
# - `target = 3`

# この場合、まず `total_sum = 1 + 1 + 1 + 1 + 1 = 5` です。

# これを `P` の式に代入してみると：

# \[
# new\_target = \frac{5 + 3}{2} = 4
# \]

# この `new_target` が、部分和の問題における新しい目標となります。すなわち、元の `nums` の中から部分和が `4` になるような組み合わせを探すことが、`+` と `-` の組み合わせで `target = 3` を作る方法を数えることに対応します。

# ### まとめ

# - `new_target = (total_sum + target) / 2` は、与えられた問題を部分和問題に変換するための式です。
# - この `new_target` に基づいて、部分和が `new_target` になる組み合わせの数を数えることで、元の問題の解を効率的に求めることができます。

