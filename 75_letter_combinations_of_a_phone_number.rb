# Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.

# A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.


# 2から9までの数字を含む文字列が与えられたとき、その数字が表す可能性のあるすべての文字の組み合わせを返してください。答えは順不同で返す必要があります。

# 電話のボタンと同様の数字と文字の対応が次のように与えられています（数字1はどの文字とも対応していません）。

# Example 1:

# Input: digits = "23"
# Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
# Example 2:

# Input: digits = ""
# Output: []
# Example 3:

# Input: digits = "2"
# Output: ["a","b","c"]
 

# Constraints:

# 0 <= digits.length <= 4
# digits[i] is a digit in the range ['2', '9'].

# 回答（Ruby）と解説
# この問題は、電話の数字に対応する文字の組み合わせを再帰的に生成するバックトラッキングの問題です。

# 例えば、数字 "23" に対応する文字は ["a", "b", "c"] と ["d", "e", "f"] です。これらを組み合わせて、すべての可能な組み合わせを生成する必要があります。

# 実装の流れ
# 数字と文字の対応を保持するハッシュを用意します。
# 再帰的に数字に対応する文字列を組み合わせていきます。
# すべての数字に対応する文字列が完成したら、その結果をリストに追加します。

# 数字とそれに対応する文字を定義
def letter_combinations(digits)
  return [] if digits.empty?

  # 各数字に対応する文字をハッシュとしてマッピング
  phone_map = {
    '2' => ['a', 'b', 'c'],
    '3' => ['d', 'e', 'f'],
    '4' => ['g', 'h', 'i'],
    '5' => ['j', 'k', 'l'],
    '6' => ['m', 'n', 'o'],
    '7' => ['p', 'q', 'r', 's'],
    '8' => ['t', 'u', 'v'],
    '9' => ['w', 'x', 'y', 'z']
  }

  result = []  # 結果を格納する配列

  # バックトラッキング関数
  def backtrack(index, path, digits, phone_map, result)
    if index == digits.length
      result << path.join  # すべての文字が選ばれたら結果に追加
      puts "Complete combination: #{path.join}"
      return
    end

    # 現在の数字に対応する文字のリストを取得
    current_digit = digits[index]
    phone_map[current_digit].each do |char|
      path << char  # 文字を追加
      puts "Adding #{char}, current path: #{path.join}"
      backtrack(index + 1, path, digits, phone_map, result)  # 次の数字へ進む
      path.pop  # バックトラック、最後の文字を削除して他の選択肢を試す
      puts "Backtracking, current path: #{path.join}"
    end
  end

  # バックトラッキングを開始
  backtrack(0, [], digits, phone_map, result)

  result
end

# 使用例
digits = "23"
puts "Input digits: #{digits}"
result = letter_combinations(digits)
puts "All possible combinations: #{result.inspect}"
