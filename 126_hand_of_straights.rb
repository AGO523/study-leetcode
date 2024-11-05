# Alice has some number of cards and she wants to rearrange the cards into groups so that each group is of size groupSize, and consists of groupSize consecutive cards.

# Given an integer array hand where hand[i] is the value written on the ith card and an integer groupSize, return true if she can rearrange the cards, or false otherwise.

# アリスはカードをいくつか持っていて、各カードには数字が書かれています。彼女は、カードを並べ替えて、各グループがサイズ groupSize で、かつ groupSize 枚の連続するカードで構成されるようにしたいと考えています。

# 整数配列 hand が与えられ、hand[i] は i 番目のカードに書かれている値を示しています。また、整数 groupSize が与えられます。このカードを並べ替えて、その条件に合うようにグループ化できる場合は true を返し、できない場合は false を返してください。

# Example 1:

# Input: hand = [1,2,3,6,2,3,4,7,8], groupSize = 3
# Output: true
# Explanation: Alice's hand can be rearranged as [1,2,3],[2,3,4],[6,7,8]
# Example 2:

# Input: hand = [1,2,3,4,5], groupSize = 4
# Output: false
# Explanation: Alice's hand can not be rearranged into groups of 4.

 

# Constraints:

# 1 <= hand.length <= 104
# 0 <= hand[i] <= 109
# 1 <= groupSize <= hand.length

# アプローチと解説
# この問題では、hand 配列を連続したカードのグループに分けられるかどうかを判断します。具体的には、各グループが groupSize 枚の連続するカードで構成されるようにしたいとします。

# アプローチ
# カードの出現回数をカウント:

# まず、hand 内の各カードの出現回数をカウントします。これは Hash を使うことで実現できます。
# 最小のカードから順にグループを作成:

# hand をソートして、最も小さいカードから連続する groupSize 枚のグループを作れるか確認します。
# 最小のカードから順に groupSize 個の連続したカードを見つけられない場合、その時点で false を返します。
# カードのカウントを更新:

# 連続したグループを作成できた場合、そのカードのカウントを減らします。

def can_rearrange(hand, group_size)
  return false if hand.length % group_size != 0
  
  # カードの出現回数をカウント
  count = Hash.new(0)
  hand.each { |card| count[card] += 1 }
  
  # hand をソートして、最小のカードから順に確認
  hand.sort.each do |card|
    # 現在のカードのカウントが0なら無視
    next if count[card] == 0

    puts "グループ作成開始: カード #{card} から"
    # 連続する group_size 枚のカードが存在するか確認
    (0...group_size).each do |i|
      current_card = card + i
      if count[current_card] > 0
        count[current_card] -= 1
        puts "カード #{current_card} を使用（残り: #{count[current_card]})"
      else
        # 連続する group_size 枚のカードがなければ false を返す
        puts "カード #{current_card} が不足しているため、並べ替え不可"
        return false
      end
    end
  end
  
  true
end

# テストケース1
puts "テストケース1: hand = [1,2,3,6,2,3,4,7,8], groupSize = 3"
puts "結果: #{can_rearrange([1,2,3,6,2,3,4,7,8], 3)}"  # 期待される出力: true

# # テストケース2
# puts "\nテストケース2: hand = [1,2,3,4,5], groupSize = 4"
# puts "結果: #{can_rearrange([1,2,3,4,5], 4)}"  # 期待される出力: false
