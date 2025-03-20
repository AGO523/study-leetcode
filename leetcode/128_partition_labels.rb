# You are given a string s. We want to partition the string into as many parts as possible so that each letter appears in at most one part.

# Note that the partition is done so that after concatenating all the parts in order, the resultant string should be s.

# Return a list of integers representing the size of these parts.

# 文字列 s が与えられます。文字列をできるだけ多くの部分に分割したいとします。ただし、各部分には同じ文字が1回しか現れないようにします。

# 分割後にすべての部分を連結した結果が元の文字列 s と一致する必要があります。

# 各部分のサイズを整数のリストとして返してください。



# Example 1:

# Input: s = "ababcbacadefegdehijhklij"
# Output: [9,7,8]
# Explanation:
# The partition is "ababcbaca", "defegde", "hijhklij".
# This is a partition so that each letter appears in at most one part.
# A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits s into less parts.
# Example 2:

# Input: s = "eccbbbbdec"
# Output: [10]
 

# Constraints:

# 1 <= s.length <= 500
# s consists of lowercase English letters.

# ababcbaca 内では a, b, c が複数回出現しています。しかし、問題の条件では、各文字が少なくとも1つの部分に含まれ、それぞれの文字がその部分内で完結していることが重要です。つまり、ある文字が1つの部分にすべて含まれていれば、その部分内で複数回出現しても問題ありません。

# 例：ababcbacadefegdehijhklij
# この例について詳細に確認してみましょう。

# 分割の手順
# ababcbaca

# この部分には a, b, c が複数回出現していますが、すべての a, b, c がこの部分内に収まっており、この後の部分には a, b, c は一切登場しません。
# defegde

# この部分には d, e, f が登場していますが、これらの文字もすべてこの部分内に収まり、この後の部分には出現しません。
# hijhklij

# この部分には h, i, j, k, l が登場し、同様にこれらの文字もすべてこの部分内で完結しています。
# 条件の確認
# 各部分の中で、文字が重複していても構わないという条件です。
# 各文字が分割後の複数部分にまたがって現れないようにすることで、文字列 s 全体が一意に分割されます。
# まとめ
# 「各文字が一度しか現れないようにする」というのではなく、「同じ文字が複数の部分にまたがって現れないようにする」ことが条件です。この条件を満たしていれば、1つの部分内で文字が複数回出現しても問題ありません。


# アプローチと解説
# この問題では、各文字の最後の出現位置を確認し、文字列を部分に分割する際にその情報を利用します。具体的には、各部分が1つの文字を全て含む範囲であり、他の部分にその文字が含まれないようにします。

# アプローチ
# 各文字の最後の出現位置を記録:

# 文字列を1回走査して、各文字の最後に現れるインデックスを記録します。
# 部分の開始と終了位置を管理:

# 文字列を左から右に走査しながら、部分の開始と終了位置を管理します。
# 現在の文字の最後の出現位置までを考慮し、その位置を現在の部分の終了位置として更新します。
# 部分のサイズを記録:

# 現在のインデックスが部分の終了位置と一致した場合、その部分のサイズを記録し、次の部分の開始位置を設定します。

# instance method String#chars
# chars -> [String][permalink][rdoc][edit]
# chars {|cstr| block } -> self
# 文字列の各文字を文字列の配列で返します。(self.each_char.to_a と同じです)

# 例

# "hello世界".chars # => ["h", "e", "l", "l", "o", "世", "界"]

def partition_labels(s)
  # 各文字の最後の出現位置を記録
  last_occurrence = {}
  s.chars.each_with_index do |char, index|
    # 同じ文字が複数回出現する場合、最後の出現位置を更新するようになっている
    last_occurrence[char] = index
  end

  # 結果を格納する配列
  partitions = []
  # 現在のパーティションの開始位置と終了位置
  start = 0
  last = 0
  
  # 文字列を走査してパーティションを決定
  s.chars.each_with_index do |char, index|
    # 現在の文字の最後の出現位置を基に、現在のパーティションの終了位置を更新
    last = [last, last_occurrence[char]].max
    puts "現在の文字: #{char}, インデックス: #{index}, 更新された終了位置: #{last}"
    
    # インデックスがパーティションの終了位置に到達した場合、パーティションを決定
    # つまり、その文字以降に同じ文字が出現しないため、その文字を含む部分はこれ以上分割しない
    # 各部分が1つの文字を全て含む範囲であり、他の部分にその文字が含まれない
    # 現在の文字の最後の出現位置までを考慮し、その位置を現在の部分の終了位置として更新
    if index == last
      partition_size = last - start + 1
      partitions << partition_size
      puts "パーティション決定: サイズ #{partition_size}, 開始位置 #{start}, 終了位置 #{last}"
      # 次のパーティションの開始位置を設定
      start = index + 1
    end
  end
  
  partitions
end

# テストケース1
puts "テストケース1: s = 'ababcbacadefegdehijhklij'"
puts "結果: #{partition_labels('ababcbacadefegdehijhklij')}"  # 期待される出力: [9, 7, 8]
