# Given an m x n board of characters and a list of strings words, return all words on the board.

# Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

# 与えられた m x n の文字のボードと文字列のリスト words から、ボード上に存在するすべての単語を返してください。
# 各単語は、隣接したセル（水平または垂直に隣接するセル）にある文字を順に使用して構成されます。
# 同じセルの文字は一度しか使用できません。

# Example 1:


# Input: board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], words = ["oath","pea","eat","rain"]
# Output: ["eat","oath"]
# Example 2:


# Input: board = [["a","b"],["c","d"]], words = ["abcb"]
# Output: []
 

# Constraints:

# m == board.length
# n == board[i].length
# 1 <= m, n <= 12
# board[i][j] is a lowercase English letter.
# 1 <= words.length <= 3 * 104
# 1 <= words[i].length <= 10
# words[i] consists of lowercase English letters.
# All the strings of words are unique.

# 回答の解説
# この問題では、board 上で与えられた単語のリスト words から、存在するすべての単語を見つける必要があります。ここではトライ木（Trie）とバックトラッキングを使って解決します。

# アルゴリズムの手順
# トライ木の構築：

# すべての words をトライ木に挿入します。このトライ木は単語の探索を高速化します。
# ボード上で探索：

# 各セルからスタートし、隣接するセルに移動しながら、トライ木内の単語に一致するかどうかをチェックします。
# すでに訪れたセルは再利用できないので、訪問済みマークを使います。
# バックトラッキング：

# 一度探索を始めたら、隣接するすべてのセルを試し、もしそのパスが単語に繋がらなければ元の状態に戻って他の経路を試します。

class TrieNode
  attr_accessor :children, :word
  
  def initialize
    @children = {}
    @word = nil  # 終端ノードには単語が入る
  end
end

class Trie
  def initialize()
    @root = TrieNode.new
  end
  
  def insert(word)
    node = @root
    word.each_char do |char|
      node.children[char] ||= TrieNode.new
      node = node.children[char]
    end
    node.word = word  # 単語の終端ノードにその単語を格納
  end
  
  def get_root
    @root
  end
end

def find_words(board, words)
  # トライ木の構築
  trie = Trie.new
  words.each { |word| trie.insert(word) }
  
  @result = []
  root = trie.get_root

  # ボード上での探索
  (0...board.length).each do |i|
    (0...board[0].length).each do |j|
      dfs(board, i, j, root)
    end
  end
  
  @result
end

def dfs(board, i, j, node)
  char = board[i][j]
  return unless node.children[char]  # 文字がトライ木にない場合は終了

  node = node.children[char]
  if node.word  # 単語が見つかった場合
    @result << node.word
    puts "Word found: #{node.word}"
    node.word = nil  # 重複して同じ単語を追加しないようにクリア
  end
  
  # 探索中のマーク
  board[i][j] = '#'

  # 4方向への探索
  [[0,1], [1,0], [0,-1], [-1,0]].each do |dx, dy|
    x, y = i + dx, j + dy
    if x >= 0 && x < board.length && y >= 0 && y < board[0].length
      dfs(board, x, y, node)
    end
  end
  
  # 探索後に元に戻す
  board[i][j] = char
end

# テストケースの実行
board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]]
words = ["oath", "pea", "eat", "rain"]
puts "Words found on board: #{find_words(board, words)}"
