# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
# n組の括弧が与えられたとき、正しい構造のすべての括弧の組み合わせを生成する関数を書いてください。

# Example 1:

# Input: n = 3
# Output: ["((()))","(()())","(())()","()(())","()()()"]
# Example 2:

# Input: n = 1
# Output: ["()"]
 

# Constraints:

# 1 <= n <= 8

# def generate_parenthesis(n)
#   result = []

#   # 再帰的に括弧の組み合わせを生成するメソッド
#   def backtrack(current, open_count, close_count, max, result)
#     if current.length == max * 2
#       result << current
#       return
#     end

#     # 開き括弧がまだ使える場合は追加
#     if open_count < max
#       backtrack(current + "(", open_count + 1, close_count, max, result)
#     end

#     # 閉じ括弧が対応する開き括弧よりも少ない場合は追加
#     if close_count < open_count
#       backtrack(current + ")", open_count, close_count + 1, max, result)
#     end
#   end

#   # 初期呼び出し
#   backtrack("", 0, 0, n, result)
#   result
# end

# # 使用例
# puts generate_parenthesis(3).inspect  # 出力: ["((()))","(()())","(())()","()(())","()()()"]
# puts generate_parenthesis(1).inspect  # 出力: ["()"]

def generate_parentheses(number_of_pairs)
  valid_combinations = []

  # 再帰的に括弧の組み合わせを生成するメソッド
  def backtrack(current_combination, open_brackets, close_brackets, max_pairs, result)
    # すべての括弧を使用した場合、結果に追加
    if current_combination.length == max_pairs * 2
      result << current_combination
      return
    end

    # 開き括弧がまだ使える場合は追加
    if open_brackets < max_pairs
      backtrack(current_combination + "(", open_brackets + 1, close_brackets, max_pairs, result)
    end

    # 閉じ括弧が対応する開き括弧よりも少ない場合は追加
    if close_brackets < open_brackets
      backtrack(current_combination + ")", open_brackets, close_brackets + 1, max_pairs, result)
    end
  end

  # 初期呼び出し
  backtrack("", 0, 0, number_of_pairs, valid_combinations)
  valid_combinations
end

# 使用例
puts generate_parentheses(3).inspect  # 出力: ["((()))","(()())","(())()","()(())","()()()"]
puts generate_parentheses(1).inspect  # 出力: ["()"]


# ### コードの説明

# 1. **`generate_parentheses` メソッド**:
#    - このメソッドは、`number_of_pairs` 組の括弧を使って生成できるすべての正しい括弧の組み合わせを返します。
#    - `valid_combinations` は最終的にすべての組み合わせを格納するための配列です。
#    - `backtrack("", 0, 0, number_of_pairs, valid_combinations)` により、空の文字列から始まり、0個の開き括弧と閉じ括弧、最大 `number_of_pairs` 組の括弧を使用して組み合わせを生成するプロセスを開始します。
#    - 最後に `valid_combinations` を返します。

# 2. **`backtrack` メソッド**:
#    - `current_combination`: 現在生成されている括弧の組み合わせを表す文字列。
#    - `open_brackets`: これまでに使用した開き括弧の数。
#    - `close_brackets`: これまでに使用した閉じ括弧の数。
#    - `max_pairs`: 使用できる括弧の組の最大数、つまり `number_of_pairs`。
#    - `result`: 有効な組み合わせを保持する配列。

# 3. **終了条件**:
#    ```ruby
#    if current_combination.length == max_pairs * 2
#      result << current_combination
#      return
#    end
#    ```
#    - `current_combination` の長さが `max_pairs * 2` になった場合、これは `number_of_pairs` 組の括弧がすべて使用され、正しい組み合わせが完成したことを意味します。`current_combination` を `result` に追加し、メソッドを終了します。

# 4. **開き括弧を追加する条件**:
#    ```ruby
#    if open_brackets < max_pairs
#      backtrack(current_combination + "(", open_brackets + 1, close_brackets, max_pairs, result)
#    end
#    ```
#    - まだ使用できる開き括弧がある場合（`open_brackets < max_pairs`）、`current_combination` に開き括弧 `(` を追加し、`open_brackets` を1増やして再帰的に `backtrack` を呼び出します。

# 5. **閉じ括弧を追加する条件**:
#    ```ruby
#    if close_brackets < open_brackets
#      backtrack(current_combination + ")", open_brackets, close_brackets + 1, max_pairs, result)
#    end
#    ```
#    - 閉じ括弧を追加する条件は、現在の開き括弧の数よりも閉じ括弧の数が少ない場合です（`close_brackets < open_brackets`）。これにより、閉じ括弧が対応する開き括弧よりも先に来ることを防ぎます。`current_combination` に閉じ括弧 `)` を追加し、`close_brackets` を1増やして再帰的に `backtrack` を呼び出します。

# ### まとめ

# このコードは、`backtrack` メソッドを使用して再帰的に有効な括弧の組み合わせを生成します。変数名をより説明的にすることで、コードの各部分が何を意味しているのか、より明確に理解できるようにしています。

# では、具体例を用いて `generate_parentheses` 関数の動作を説明します。例として `n = 3`（3組の括弧）を使います。

# ### スタート

# 最初に、`generate_parentheses(3)` が呼び出されます。このメソッドは `result` を初期化し、`backtrack("", 0, 0, 3, result)` を呼び出して再帰プロセスを開始します。

# ### `backtrack` メソッドの再帰的プロセス

# 1. **最初の呼び出し**:
#    - `current_combination = ""`, `open_brackets = 0`, `close_brackets = 0`, `max_pairs = 3`
#    - 開き括弧を追加可能（`open_brackets < max_pairs`）
#    - 呼び出し: `backtrack("(", 1, 0, 3, result)`

# 2. **2番目の呼び出し**:
#    - `current_combination = "("`, `open_brackets = 1`, `close_brackets = 0`, `max_pairs = 3`
#    - 開き括弧を追加可能（`open_brackets < max_pairs`）
#    - 呼び出し: `backtrack("((", 2, 0, 3, result)`

# 3. **3番目の呼び出し**:
#    - `current_combination = "(("`, `open_brackets = 2`, `close_brackets = 0`, `max_pairs = 3`
#    - 開き括弧を追加可能（`open_brackets < max_pairs`）
#    - 呼び出し: `backtrack("(((", 3, 0, 3, result)`

# 4. **4番目の呼び出し**:
#    - `current_combination = "((("`, `open_brackets = 3`, `close_brackets = 0`, `max_pairs = 3`
#    - 開き括弧はもう追加できない（`open_brackets = max_pairs`）
#    - 閉じ括弧を追加可能（`close_brackets < open_brackets`）
#    - 呼び出し: `backtrack("((()", 3, 1, 3, result)`

# 5. **5番目の呼び出し**:
#    - `current_combination = "((()"`, `open_brackets = 3`, `close_brackets = 1`, `max_pairs = 3`
#    - 開き括弧はもう追加できない
#    - 閉じ括弧を追加可能
#    - 呼び出し: `backtrack("((())", 3, 2, 3, result)`

# 6. **6番目の呼び出し**:
#    - `current_combination = "((())"`, `open_brackets = 3`, `close_brackets = 2`, `max_pairs = 3`
#    - 開き括弧はもう追加できない
#    - 閉じ括弧を追加可能
#    - 呼び出し: `backtrack("((()))", 3, 3, 3, result)`

# 7. **7番目の呼び出し**:
#    - `current_combination = "((()))"`, `open_brackets = 3`, `close_brackets = 3`, `max_pairs = 3`
#    - すべての括弧を使用したため、`result` に `current_combination` を追加
#    - `result = ["((()))"]`

# これで1つの組み合わせが生成されました。同様のプロセスが続き、以下のように進みます。

# ### 他の組み合わせの生成

# 次に、閉じ括弧を追加するタイミングを変えながら再帰的に他の組み合わせが生成されます。

# - **8番目の呼び出し**: `backtrack("(()(", 2, 1, 3, result)`
#   - 結果: `["((()))", "(()())"]`
  
# - **9番目の呼び出し**: `backtrack("(())(", 2, 1, 3, result)`
#   - 結果: `["((()))", "(()())", "(())()"]`
  
# - **10番目の呼び出し**: `backtrack("()((", 1, 2, 3, result)`
#   - 結果: `["((()))", "(()())", "(())()", "()(())"]`
  
# - **11番目の呼び出し**: `backtrack("()()(", 1, 2, 3, result)`
#   - 結果: `["((()))", "(()())", "(())()", "()(())", "()()()"]`

# ### 最終結果

# `result = ["((()))", "(()())", "(())()", "()(())", "()()()"]`

# このプロセスを通じて、すべての正しい括弧の組み合わせが生成されました。

# ### 結論

# `generate_parentheses(3)` では、再帰的な `backtrack` メソッドが呼び出され、すべての有効な組み合わせが生成されます。各ステップでは、開き括弧と閉じ括弧を追加するかどうかを判断し、最終的に有効な組み合わせを `result` に保存します。すべての再帰呼び出しが終了した後、`result` に格納された括弧の組み合わせを返します。
