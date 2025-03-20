# Design a data structure that supports adding new words and finding if a string matches any previously added string.

# Implement the WordDictionary class:

# WordDictionary() Initializes the object.
# void addWord(word) Adds word to the data structure, it can be matched later.
# bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.

# 新しい単語の追加と、文字列が以前に追加された単語と一致するかどうかを調べるデータ構造を設計してください。

# WordDictionary クラスを実装します:

# WordDictionary()：オブジェクトを初期化します。
# void addWord(word)：単語をデータ構造に追加します。後で一致する単語を検索できます。
# bool search(word)：データ構造内に与えられた単語と一致するものがあれば true を返し、それ以外は false を返します。単語にはドット '.' が含まれていることがあります。ドットは任意の文字と一致します。

# Example:

# Input
# ["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
# [[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
# Output
# [null,null,null,null,false,true,true,true]

# Explanation
# WordDictionary wordDictionary = new WordDictionary();
# wordDictionary.addWord("bad");
# wordDictionary.addWord("dad");
# wordDictionary.addWord("mad");
# wordDictionary.search("pad"); // return False
# wordDictionary.search("bad"); // return True
# wordDictionary.search(".ad"); // return True
# wordDictionary.search("b.."); // return True
 

# Constraints:

# 1 <= word.length <= 25
# word in addWord consists of lowercase English letters.
# word in search consist of '.' or lowercase English letters.
# There will be at most 2 dots in word for search queries.
# At most 104 calls will be made to addWord and search.

# コード解説付き解答
# この問題では、トライ（Trie）というデータ構造を使って解決します。トライは文字列検索に効率的であり、addWord や search に便利です。特に . で任意の文字に一致させる検索の処理が必要なので、再帰的に検索を行います。

# Trieノードを表現するクラス
class TrieNode
  attr_accessor :children, :is_end_of_word

  def initialize
    # 子ノードを格納するためのハッシュ (アルファベット26文字に対応)
    @children = {}
    # 単語の終わりを示すフラグ
    @is_end_of_word = false
  end
end

# WordDictionary クラス
class WordDictionary
  def initialize()
    # ルートノードを初期化
    @root = TrieNode.new
  end

  # 単語をトライに追加するメソッド
  def addWord(word)
    node = @root

    # word の各文字に対してノードを作成
    word.each_char do |char|
      # 文字が存在しない場合は新しいノードを作成
      node.children[char] ||= TrieNode.new
      # 次のノードに移動
      node = node.children[char]
    end
    # 単語の終わりを設定
    node.is_end_of_word = true
    puts "Added word: #{word}"
  end

  # 検索を行うメソッド
  def search(word)
    puts "Searching for word: #{word}"
    # 再帰的に検索するヘルパーメソッドを呼び出す
    search_recursive(@root, word, 0)
  end

  private

  # 再帰的に検索を行うメソッド
  # 現在のノードから探索を開始し、word が見つかるかどうかを返す
  # 現在のノードに word の index 番目が存在しない場合は、次のノードに移動する
  def search_recursive(node, word, index)
    # 全ての文字を見終わったら、そのノードが単語の終わりかを確認
    return node.is_end_of_word if index == word.length

    char = word[index]

    # '.' が現れた場合、全ての子ノードに対して再帰的に探索
    if char == '.'
      node.children.each do |child_char, child_node|
        puts "Trying child node with char: #{child_char}"
        # どれかの子ノードで一致するものがあればtrueを返す
        return true if search_recursive(child_node, word, index + 1)
      end
      # どの子ノードでも一致しない場合はfalse
      return false
    end

    # その文字に対応する子ノードが存在しない場合はfalse
    return false unless node.children[char]

    # 次のノードに移動し、次の文字を確認
    search_recursive(node.children[char], word, index + 1)
  end
end

# テストケース
wordDictionary = WordDictionary.new
wordDictionary.addWord("bad")
wordDictionary.addWord("dad")
wordDictionary.addWord("mad")
wordDictionary.addWord("mcd")
wordDictionary.addWord("dfp")

puts wordDictionary.search("pad")  # 出力: false
puts wordDictionary.search("bad")  # 出力: true
puts wordDictionary.search(".ad")  # 出力: true
puts wordDictionary.search("b..")  # 出力: true
puts wordDictionary.search("..p")  # 出力: true
puts wordDictionary.search("d.p")  # 出力: true
