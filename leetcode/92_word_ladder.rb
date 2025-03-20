# A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:

# Every adjacent pair of words differs by a single letter.
# Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
# sk == endWord
# Given two words, beginWord and endWord, and a dictionary wordList, return the number of words in the shortest transformation sequence from beginWord to endWord, or 0 if no such sequence exists.

# ある単語 beginWord から endWord に変換するシーケンスを、単語リスト wordList を使って構築します。beginWord -> s1 -> s2 -> ... -> sk というような単語の列であり、以下の条件を満たす必要があります:

# 連続する単語のペア（隣接する単語のペア）は、一文字だけが異なること。
# 各 si （1 <= i <= k）は wordList 内の単語であること。beginWord は wordList に含まれていなくてもよい。
# sk は endWord と一致すること。
# 与えられた beginWord から endWord への最短変換シーケンスの単語数を返します。もしそのような変換シーケンスが存在しない場合は 0 を返します。

# Example 1:

# Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
# Output: 5
# Explanation: One shortest transformation sequence is "hit" -> "hot" -> "dot" -> "dog" -> cog", which is 5 words long.
# Example 2:

# Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
# Output: 0
# Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.
 

# Constraints:

# 1 <= beginWord.length <= 10
# endWord.length == beginWord.length
# 1 <= wordList.length <= 5000
# wordList[i].length == beginWord.length
# beginWord, endWord, and wordList[i] consist of lowercase English letters.
# beginWord != endWord
# All the words in wordList are unique.

# プログラム解説と実装
# この問題は**幅優先探索（BFS）**を使用して解決できます。各単語はノード、各単語間の一文字だけ異なる単語への変換はエッジとして扱い、最短経路を探索する問題です。

# 手順:
# 初期チェック:
# endWord が wordList に含まれていなければ、変換不可能なので 0 を返します。
# 幅優先探索（BFS）を使用:
# キューを使って beginWord から探索を開始します。
# 各ステップで、現在の単語から一文字だけ異なる単語を wordList から探し、すべての隣接単語をキューに追加します。
# endWord に到達した時点で、その経路の長さ（変換シーケンスの単語数）を返します。

# 実装の解説
# このプログラムは、幅優先探索（BFS） と 隣接リスト（Adjacency List） を組み合わせて最短経路を見つける方法を使っています。

# 単語の隣接リスト（nei）の構築:

# すべての単語リスト（begin_word も含む）に対してパターンを生成します。
# 各パターンは、1文字を * で置換したものです。例えば、hit なら、以下のパターンを持ちます:
# markdown
# コードをコピーする
# *it, h*t, hi*
# このパターンをキーとして、パターンに一致する単語を値（リスト）として nei ハッシュに格納します。
# BFS の初期化:

# visit セットを初期化し、begin_word を追加します。これは、同じ単語を再度探索しないためです。
# キュー（queue）に begin_word を追加し、最初のステップ数を 1 と設定します（res 変数）。
# 幅優先探索（BFS）:

# キューが空になるまで繰り返し探索します。
# キューの先頭から単語を取り出し、その単語に対応するすべてのパターンを生成します。
# パターンに対応するすべての隣接単語（nei_word）を探索し、未訪問の単語があれば visit に追加し、キューにその単語を追加します。
# end_word に到達した場合は、その時点のステップ数を返します。
# 変換シーケンスが存在しない場合:

# end_word に到達できなかった場合は 0 を返します。

def ladder_length(begin_word, end_word, word_list)
  # BFS 用の隣接リストと訪問済みのセットを構築する
  puts "開始単語: #{begin_word}, 終了単語: #{end_word}"
  return 0 unless word_list.include?(end_word)

  # 隣接リスト（パターン）を構築
  pattern_map = build_pattern_map(word_list + [begin_word])

  # BFS の初期化
  queue = [[begin_word, 1]]  # [現在の単語, 変換ステップ数]
  visited = { begin_word => true }  # 訪問済みリスト

  puts "BFS を開始します。"
  # BFS のメインループ
  while !queue.empty?
    current_word, steps = queue.shift
    puts "現在の単語: #{current_word}, 現在のステップ数: #{steps}"

    # 現在の単語の隣接ノード（パターン）を取得して処理
    get_neighbors(current_word, pattern_map).each do |neighbor|
      if neighbor == end_word
        puts "終了単語に到達しました: #{neighbor} (ステップ数: #{steps + 1})"
        return steps + 1
      end

      # 隣接ノードが未訪問ならばキューに追加し、訪問済みに設定
      unless visited[neighbor]
        visited[neighbor] = true
        queue << [neighbor, steps + 1]
        puts "隣接単語をキューに追加: #{neighbor} (次のステップ: #{steps + 1})"
      end
    end
  end

  # 終了単語に到達できなかった場合
  puts "終了単語に到達できませんでした。"
  0
end

# 隣接リスト（パターンマップ）を作成するメソッド
def build_pattern_map(words)
  pattern_map = Hash.new { |hash, key| hash[key] = [] }

  # 各単語ごとにパターンを生成してマップに格納
  words.each do |word|
    (0...word.length).each do |j|
      pattern = generate_pattern(word, j)
      pattern_map[pattern] << word
    end
  end

  puts "隣接リスト（パターンマップ）を構築しました: #{pattern_map}"
  pattern_map
end

# 隣接するノードをパターンマップから取得するメソッド
def get_neighbors(word, pattern_map)
  neighbors = []

  # 現在の単語のすべてのパターンに対する隣接単語を集める
  (0...word.length).each do |j|
    pattern = generate_pattern(word, j)
    neighbors.concat(pattern_map[pattern])  # 該当パターンのすべての単語を取得
  end

  neighbors.uniq  # 重複を除去して返す
end

# 単語の特定の位置をワイルドカード `*` に置換してパターンを生成する
# 各単語の文字を `*` に置換してパターンを作成
# 各パターンは、1文字を * で置換したものです。例えば、hit なら、以下のパターンを持ちます:
# *it, h*t, hi*
# ↑、index が 0 の場合は、*が最初に挿入されて、indexの1以降の文字がつづけて挿入される。
def generate_pattern(word, index)
  "#{word[0...index]}*#{word[index+1..-1]}"
end

# テストケース1
puts "テストケース1: "
begin_word1 = "hit"
end_word1 = "cog"
word_list1 = ["hot", "dot", "dog", "lot", "log", "cog"]
result1 = ladder_length(begin_word1, end_word1, word_list1)
puts "出力: #{result1}"  # 期待される出力: 5

# テストケース2
puts "\nテストケース2: "
begin_word2 = "hit"
end_word2 = "cog"
word_list2 = ["hot", "dot", "dog", "lot", "log"]
result2 = ladder_length(begin_word2, end_word2, word_list2)
puts "出力: #{result2}"  # 期待される出力: 0
