# 与えられた文字列 s を、各部分文字列が回文（前から読んでも後ろから読んでも同じ文字列）となるように分割します。すべての可能な回文分割を返してください。
# Given a string s, partition s such that every 
# substring
#  of the partition is a 
# palindrome
# . Return all possible palindrome partitioning of s.

 

# Example 1:

# Input: s = "aab"
# Output: [["a","a","b"],["aa","b"]]
# Example 2:

# Input: s = "a"
# Output: [["a"]]
 

# Constraints:

# 1 <= s.length <= 16
# s contains only lowercase English letters.

# アルゴリズムの説明
# この問題では、文字列を部分的に分割し、それぞれの部分文字列が回文であることを確認して、すべての回文分割を求めます。再帰的なバックトラッキングを使用して、部分文字列が回文かどうかを確認しながら探索を進めます。

# ステップ
# 再帰的な探索: 文字列を左から順に1文字、2文字...と部分文字列を取り出して、その部分文字列が回文かどうかを確認します。もし回文であれば、残りの文字列に対して再帰的に同じ操作を繰り返します。

# バックトラッキング: すべての分割パターンを試し、再帰的に進んだ後に元の状態に戻すことで、次の候補を試します。

# 回文のチェック: 各部分文字列が回文かどうかを効率よく確認するために、2つのポインタを使って左右から文字を確認します。

# 回文かどうかをチェックするメソッド
def is_palindrome(sub)
  sub == sub.reverse
end

# バックトラックを用いて回文分割を探索するメインメソッド
def backtrack(s, path, result)
  # 文字列が空になったら、現在のpathを結果に追加
  if s.empty?
    result << path.dup
    return
  end

  # 1文字から順に部分文字列を生成して回文チェック
  (1..s.length).each do |i|
    # substring は s の先頭から i 文字分の部分文字列
    # つまり、1文字目の再帰呼び出しでは、s[0, 1] が部分文字列として取得される
    # 2文字目の再帰呼び出しでは、s[0, 2] が部分文字列として取得される
    substring = s[0, i]

    if is_palindrome(substring)
      puts "Palindrome found: #{substring}"
      # 部分文字列が回文ならpathに追加して、残りの文字列で再帰的に探索
      path << substring
      backtrack(s[i..-1], path, result)
      # バックトラック（戻るときにpathを元に戻す）
      puts "path before backtracking: #{path}"
      path.pop
      puts "Backtracking, current path: #{path}"
    end
  end
end

# 文字列を回文分割するメイン関数
def partition(s)
  result = []
  backtrack(s, [], result)
  result
end

# テストケースの実行
s = "aab"
puts "Partitioning the string: #{s}"
result = partition(s)
puts "All palindrome partitions: #{result.inspect}"

# この問題を理解するのが難しい場合、まず基本的なアイデアを分解して説明します。以下で、それぞれのステップをさらに詳しく解説します。

# ### 基本的な問題の理解
# 与えられた文字列 `s` を、各部分が回文となるように分割する必要があります。

# **回文**とは、前から読んでも後ろから読んでも同じになる文字列のことです。例えば、`"a"`, `"aa"`, `"aba"` などが回文です。

# 問題は、文字列のすべての可能な回文分割を求めるというものです。

# ### 例
# **入力**: `"aab"`

# **出力**: 
# ```
# [
#   ["a", "a", "b"],  # "a" + "a" + "b" の分割
#   ["aa", "b"]       # "aa" + "b" の分割
# ]
# ```

# ### ステップ1: 再帰的な探索の基本
# 再帰的なアプローチでは、文字列を小さな部分に分け、条件を満たすかどうかを確認し、その後で次に進むという方法をとります。

# 1. 文字列の最初の1文字から始めて、その部分が回文かどうかを確認します。
# 2. もし回文なら、それを結果に追加し、残りの文字列に対して同じことを繰り返します。
# 3. すべての分割方法を試して結果を集めます。

# ### ステップ2: 部分文字列の生成と回文チェック
# - まず、文字列の最初の部分を取り出して、それが回文かどうかを確認します。
# - 例えば、`"aab"` という文字列に対して、最初に `"a"` を取り出して回文かどうか確認します。`"a"` は回文なので、この部分は条件を満たします。

# 次に残りの `"ab"` に対して同じ処理を繰り返します。

# - `"a"` の次に `"a"` をチェックし、これも回文なので、さらに `"b"` に進むことができます。
# - `"b"` も回文なので、この時点で1つの解 `["a", "a", "b"]` を得ることができます。

# ### ステップ3: バックトラッキングの使い方
# バックトラッキングとは、再帰的に選択肢を試した後で元の状態に戻す技法です。

# 例として、`"aab"` の文字列を考えます。

# - 最初に `"a"` を選んで残りの `"ab"` を処理します。
# - その後、もう1つの `"a"` を選んで残りの `"b"` を処理します。
# - このルートがすべて完了すると、他の選択肢（例えば、`"aa"`）を試すために元に戻ります。

# ### ステップ4: コードのフローの理解

# もう一度、主要な部分を見てみます。

# ```ruby
# # 1. 再帰的な探索を行うメソッド
# def backtrack(s, path, result)
#   # 文字列が空になったら、現在のpathを結果に追加
#   if s.empty?
#     result << path.dup
#     return
#   end

#   # 2. 1文字から順に部分文字列を生成して回文チェック
#   (1..s.length).each do |i|
#     substring = s[0, i]
#     if is_palindrome(substring)
#       # 3. 部分文字列が回文ならpathに追加して、残りの文字列で再帰的に探索
#       path << substring
#       backtrack(s[i..-1], path, result)
#       # 4. バックトラック（戻るときにpathを元に戻す）
#       path.pop
#     end
#   end
# end
# ```

# ### コードの流れ

# 1. `backtrack` 関数は、文字列の最初の部分を取り出し、その部分が回文かどうかを確認します。
# 2. もし回文なら、その部分を結果に追加し、残りの文字列で再帰的に探索を続けます。
# 3. 探索が終わったら、バックトラックして、次の選択肢を試します。
# 4. このプロセスをすべての可能な部分文字列に対して行い、すべての回文分割を見つけます。

# ### 経過表示の追加

# `puts` を追加することで、実行中の経過がわかるようにします。

# ```ruby
# def backtrack(s, path, result)
#   if s.empty?
#     result << path.dup
#     puts "Complete partition: #{path.inspect}"
#     return
#   end

#   (1..s.length).each do |i|
#     substring = s[0, i]
#     if is_palindrome(substring)
#       puts "Using #{substring}, current path: #{path + [substring]}"
#       path << substring
#       backtrack(s[i..-1], path, result)
#       path.pop
#       puts "Backtracking, current path: #{path}"
#     end
#   end
# end
# ```

# このように経過表示を追加すると、実際にどのように再帰的に探索が進んでいくかが確認できます。

# ### まとめ

# 再帰とバックトラッキングは、問題を分割して解く強力な方法です。この問題では、すべての回文分割を求めるために、次々に部分文字列を試し、そのたびに回文かどうかを確認しています。
