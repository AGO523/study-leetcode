# Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.

# The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the 
# frequency
#  of at least one of the chosen numbers is different.

# The test cases are generated such that the number of unique combinations that sum up to target is less than 150 combinations for the given input.

# 異なる整数を含む配列 candidates と目標整数 target が与えられたとき、candidates の中から選んだ数の和が target になるような、すべてのユニークな組み合わせをリストとして返してください。組み合わせの順序は任意です。

# 同じ数を何度でも選ぶことができますが、少なくとも1つの選ばれた数の出現頻度が異なる場合に、その組み合わせはユニークとみなされます。

# テストケースは、与えられた入力に対してユニークな組み合わせの数が150以下になるように生成されています。

# Example 1:

# Input: candidates = [2,3,6,7], target = 7
# Output: [[2,2,3],[7]]
# Explanation:
# 2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
# 7 is a candidate, and 7 = 7.
# These are the only two combinations.
# Example 2:

# Input: candidates = [2,3,5], target = 8
# Output: [[2,2,2,2],[2,3,3],[3,5]]
# Example 3:

# Input: candidates = [2], target = 1
# Output: []
 

# Constraints:

# 1 <= candidates.length <= 30
# 2 <= candidates[i] <= 40
# All elements of candidates are distinct.
# 1 <= target <= 40


# 解説
# この問題はバックトラッキングのアプローチを使うことで解決できます。candidates の中から要素を選びながら、target に到達するまで試行錯誤を繰り返します。

# 再帰的に数を追加していき、target に到達したらその組み合わせを記録します。
# 数を追加していく過程で、target を超えたらそのパスは不正とし、それ以上探索しないようにします。
# 同じ数を何度でも使えるので、再帰呼び出しの際に同じ数を使うことも許されます

def combination_sum(candidates, target)
  result = []  # 解答を格納する配列

  # バックトラッキング関数
  def backtrack(candidates, target, current, start, result)
    # 基本ケース: targetが0になったら、現在の組み合わせを結果に追加
    if target == 0
      result << current.clone
      puts "Found combination: #{current}"
      return
    end

    # targetを超えた場合、そのパスは無効
    if target < 0
      puts "Exceeded target, backtracking from: #{current}"
      return
    end

    # 現在の組み合わせに要素を追加して再帰的に探索
    (start...candidates.size).each do |i|
      current << candidates[i]  # 要素を追加
      puts "Adding #{candidates[i]} to current combination #{current}"

      # 同じ要素を使えるので、iを再度渡して次の再帰呼び出し
      backtrack(candidates, target - candidates[i], current, i, result)

      # バックトラッキング: 最後に追加した要素を取り除いて次の探索に進む
      removed = current.pop
      puts "Backtracking by removing #{removed}, current combination: #{current}"
      # ここまで来ると、再帰呼び出しの処理が終わり、呼び出し元に戻ります。
      # ループの i が進み、次の要素を追加して再帰呼び出しを行います。
    end
  end

  # 初期呼び出し
  backtrack(candidates, target, [], 0, result)
  result
end

# 実行例
candidates = [2, 3, 6, 7]
target = 7
puts "Candidates: #{candidates}, Target: #{target}"
result = combination_sum(candidates, target)
puts "All combinations: #{result}"
