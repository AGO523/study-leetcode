# You are climbing a staircase. It takes n steps to reach the top.

# Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

# あなたは階段を上っています。階段の上までには n 段のステップがあります。

# 一度に「1 段」または「2 段」ずつ登ることができます。
# 階段を上り切るまでの「異なる登り方の数」を求めてください。

# Example 1:

# Input: n = 2
# Output: 2
# Explanation: There are two ways to climb to the top.
# 1. 1 step + 1 step
# 2. 2 steps
# Example 2:

# Input: n = 3
# Output: 3
# Explanation: There are three ways to climb to the top.
# 1. 1 step + 1 step + 1 step
# 2. 1 step + 2 steps
# 3. 2 steps + 1 step
 

# Constraints:

# 1 <= n <= 45

# この問題は、フィボナッチ数列と関連しています。階段を登る方法は、「1 段ずつ登る」か「2 段ずつ登る」かの組み合わせです。以下のステップを用いて、解法を考えます。

# 1. アプローチの考え方
# 階段を n 段まで登る方法を考えると、次の 2 つのシナリオが考えられます：

# 1 段 進んで、残り n-1 段を登る方法
# 2 段 進んで、残り n-2 段を登る方法
# つまり、n 段まで登る方法の数は、n-1 段までの登り方の数と n-2 段までの登り方の数を合計したものに等しくなります。

# ways(n) = ways(n-1) + ways(n-2)

# これは、フィボナッチ数列の定義と同じです。
# ways(1) = 1（1 段まで登るのは 1 通り）
# ways(2) = 2（2 段まで登るのは 2 通り）
# 2. 実装の考え方
# n = 1 の場合は、1 通りの登り方しかないので 1 を返す。
# n = 2 の場合は、1 + 1 または 2 で登る 2 通りなので 2 を返す。
# n > 2 の場合は、フィボナッチ数列の要領で ways(n) = ways(n-1) + ways(n-2) を計算し、求める。

def climb_stairs(n)
  # 階段が1段または2段の場合は特別に処理
  return 1 if n == 1
  return 2 if n == 2

  # 最初の2段目までの通り数
  first = 1  # 1段目までの登り方は1通り
  second = 2  # 2段目までの登り方は2通り
  puts "初期状態: 1段目: #{first} 通り, 2段目: #{second} 通り"

  # 3段目以降の通り数を計算
  (3..n).each do |i|
    current = first + second  # フィボナッチ数列に基づく計算
    puts "#{i} 段目: #{current} 通り (前: #{first}, 次: #{second})"
    # 更新: 前の2つの段数をずらす
    first = second
    second = current
  end

  # 最後に計算された second の値が n 段目の通り数
  second
end

# テストケースを実行
# puts "テストケース1 (n = 2): 出力 = #{climb_stairs(2)}"  # 期待される出力: 2
# puts "テストケース2 (n = 3): 出力 = #{climb_stairs(3)}"  # 期待される出力: 3
puts "テストケース3 (n = 5): 出力 = #{climb_stairs(5)}"  # 期待される出力: 8
