# Given two strings s and t of lengths m and n respectively, return the minimum window 
# substring
#  of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".
# 日本語で
# 文字列 s と t が与えられます。それぞれの長さは m と n です。文字列 s の中で、t のすべての文字（重複を含む）を含む最小のウィンドウを返します。そのような部分文字列がない場合は、空の文字列 "" を返します。

# The testcases will be generated such that the answer is unique.
# 日本語で
# テストケースは、答えが一意になるように生成されます。

# Example 1:

# Input: s = "ADOBECODEBANC", t = "ABC"
# Output: "BANC"
# Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
# Example 2:

# 初期状態:
# s = "ADOBECODEBANC"
# t = "ABC"
# target_count: {'A' => 1, 'B' => 1, 'C' => 1}
# required = 3
# window_count: {}
# left = 0, right = 0
# formed = 0
# min_length = Float::INFINITY
# min_left = 0, min_right = 0

# Input: s = "a", t = "a"
# Output: "a"
# Explanation: The entire string s is the minimum window.
# Example 3:

# Input: s = "a", t = "aa"
# Output: ""
# Explanation: Both 'a's from t must be included in the window.
# Since the largest window of s only has one 'a', return empty string.
 

# Constraints:

# m == s.length
# n == t.length
# 1 <= m, n <= 105
# s and t consist of uppercase and lowercase English letters.

class Solution
  def min_window(s, t)
    return "" if s.length == 0 || t.length == 0

    # tの文字カウントをセットアップ
    target_count = Hash.new(0)
    t.each_char { |char| target_count[char] += 1 }

    # 必要な文字の数を記録
    required = target_count.length

    # ウィンドウ内の文字カウントを初期化
    window_count = Hash.new(0)

    left = 0
    right = 0
    formed = 0

    # 最小ウィンドウの情報を記録
    min_length = Float::INFINITY
    min_left = 0
    min_right = 0

    while right < s.length
      # 右端の文字をウィンドウに追加
      char = s[right]
      window_count[char] += 1

      # もしウィンドウ内の文字カウントがtのカウントと一致すれば、formedを増やす
      if target_count[char] > 0 && window_count[char] == target_count[char]
        formed += 1
      end

      # ウィンドウが条件を満たす間、左端を動かしてウィンドウを縮小
      while left <= right && formed == required
        char = s[left]

        # 現在のウィンドウの長さが最小かどうかを確認し、更新
        if right - left + 1 < min_length
          min_length = right - left + 1
          min_left = left
          min_right = right
        end

        # 左端の文字をウィンドウから削除
        window_count[char] -= 1
        if target_count[char] > 0 && window_count[char] < target_count[char]
          formed -= 1
        end

        # 左端を右に移動
        left += 1
      end

      # 右端を右に移動
      right += 1
    end

    return "" if min_length == Float::INFINITY

    # 最小ウィンドウを返す
    s[min_left..min_right]
  end
end

# 使用例
solution = Solution.new
puts solution.min_window("ADOBECODEBANC", "ABC")  # 出力は "BANC"
puts solution.min_window("a", "a")               # 出力は "a"
puts solution.min_window("a", "aa")              # 出力は ""


# スライディングウィンドウの実行
# 右端 right = 0:

# 現在の文字: 'A'
# window_count 更新: {'A' => 1}
# target_count における 'A' のカウントを満たすため、formed を増加: formed = 1
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "A"
# 右端 right = 1:

# 現在の文字: 'D'
# window_count 更新: {'A' => 1, 'D' => 1}
# target_count に 'D' が含まれないので formed は変わらない。
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "AD"
# 右端 right = 2:

# 現在の文字: 'O'
# window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1}
# target_count に 'O' が含まれないので formed は変わらない。
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "ADO"
# 右端 right = 3:

# 現在の文字: 'B'
# window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1}
# target_count における 'B' のカウントを満たすため、formed を増加: formed = 2
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "ADOB"
# 右端 right = 4:

# 現在の文字: 'E'
# window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1}
# target_count に 'E' が含まれないので formed は変わらない。
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "ADOBE"
# 右端 right = 5:

# 現在の文字: 'C'
# window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1, 'C' => 1}
# target_count における 'C' のカウントを満たすため、formed を増加: formed = 3
# 条件を満たすので左端を動かし始める。
# ウィンドウ: "ADOBEC"
# 左端 left = 0:

# 現在のウィンドウの長さは 6 (right - left + 1)
# min_length を更新: min_length = 6
# 'A' を削除し、window_count 更新: {'A' => 0, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1, 'C' => 1}
# formed を減少: formed = 2
# 左端を右に動かす: left = 1
# ウィンドウ: "DOBEC"
# スライディングウィンドウの続行
# 右端 right = 6:

# 現在の文字: 'O'
# window_count 更新: {'A' => 0, 'D' => 1, 'O' => 2, 'B' => 1, 'E' => 1, 'C' => 1}
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "DOBECO"
# 右端 right = 7:

# 現在の文字: 'D'
# window_count 更新: {'A' => 0, 'D' => 2, 'O' => 2, 'B' => 1, 'E' => 1, 'C' => 1}
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "DOBECOD"
# 右端 right = 8:

# 現在の文字: 'E'
# window_count 更新: {'A' => 0, 'D' => 2, 'O' => 2, 'B' => 1, 'E' => 2, 'C' => 1}
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "DOBECODE"
# 右端 right = 9:

# 現在の文字: 'B'
# window_count 更新: {'A' => 0, 'D' => 2, 'O' => 2, 'B' => 2, 'E' => 2, 'C' => 1}
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "DOBECODEB"
# 右端 right = 10:

# 現在の文字: 'A'
# window_count 更新: {'A' => 1, 'D' => 2, 'O' => 2, 'B' => 2, 'E' => 2, 'C' => 1}
# target_count における 'A' のカウントを満たすため、formed を増加: formed = 3
# 条件を満たすので左端を動かし始める。
# ウィンドウ: "DOBECODEBA"
# 左端 left = 1:

# 現在のウィンドウの長さは 10 (right - left + 1)
# min_length を更新: min_length = 10
# 'D' を削除し、window_count 更新: {'A' => 1, 'D' => 1, 'O' => 2, 'B' => 2, 'E' => 2, 'C' => 1}
# formed は変わらない
# 左端を右に動かす: left = 2
# ウィンドウ: "OBECODEBA"
# 左端 left = 2:

# 現在のウィンドウの長さは 9 (right - left + 1)
# min_length を更新: min_length = 9
# 'O' を削除し、window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 2, 'E' => 2, 'C' => 1}
# formed は変わらない
# 左端を右に動かす: left = 3
# ウィンドウ: "BECODEBA"
# 左端 left = 3:

# 現在のウィンドウの長さは 8 (right - left + 1)
# min_length を更新: min_length = 8
# 'B' を削除し、window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 2, 'C' => 1}
# formed は変わらない
# 左端を右に動かす: left = 4
# ウィンドウ: "ECODEBA"
# 左端 left = 4:

# 現在のウィンドウの長さは 7 (right - left + 1)
# min_length を更新: min_length = 7
# 'E' を削除し、window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1, 'C' => 1}
# formed は変わらない
# 左端を右に動かす: left = 5
# ウィンドウ: "CODEBA"
# 左端 left = 5:

# 現在のウィンドウの長さは 6 (right - left + 1)
# min_length を更新: min_length = 6
# 'C' を削除し、window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1, 'C' => 0}
# formed を減少: formed = 2
# 左端を右に動かす: left = 6
# ウィンドウ: "ODEBA"
# 右端 right = 11:

# 現在の文字: 'N'
# window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1, 'C' => 0, 'N' => 1}
# 条件を満たさないので左端を動かさない。
# ウィンドウ: "ODEBAN"
# 右端 right = 12:

# 現在の文字: 'C'
# window_count 更新: {'A' => 1, 'D' => 1, 'O' => 1, 'B' => 1, 'E' => 1, 'C' => 1, 'N' => 1}
# target_count における 'C' のカウントを満たすため、formed を増加: formed = 3
# 条件を満たすので左端を動かし始める。
# ウィンドウ: "ODEBANC"
# 左端 left = 6:

# 現在のウィンドウの長さは 7 (right - left + 1)
# min_length は更新されない
# 'O' を削除し、window_count 更新: {'A' => 1, 'D' => 1, 'O' => 0, 'B' => 1, 'E' => 1, 'C' => 1, 'N' => 1}
# formed は変わらない
# 左端を右に動かす: left = 7
# ウィンドウ: "DEBANC"
# 左端 left = 7:

# 現在のウィンドウの長さは 6 (right - left + 1)
# min_length を更新: min_length = 6
# 'D' を削除し、window_count 更新: {'A' => 1, 'D' => 0, 'O' => 0, 'B' => 1, 'E' => 1, 'C' => 1, 'N' => 1}
# formed を減少: formed = 2
# 左端を右に動かす: left = 8
# ウィンドウ: "EBANC"
# 結果
# 最終的に、条件を満たす最小のウィンドウは "BANC" です。
