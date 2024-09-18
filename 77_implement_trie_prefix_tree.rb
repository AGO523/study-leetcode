# A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.

# Implement the Trie class:

# Trie() Initializes the trie object.
# void insert(String word) Inserts the string word into the trie.
# boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
# boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.

# Trie（トライ、またはプレフィックストリー）は、文字列のデータセットにおいてキーを効率的に保存・検索するための木構造です。このデータ構造は、オートコンプリートやスペルチェッカーなど、さまざまな用途に使用されます。

# 以下の Trie クラスを実装してください:

# Trie()：トライオブジェクトを初期化します。
# void insert(String word)：文字列 word をトライに挿入します。
# boolean search(String word)：トライ内に文字列 word が存在する場合に true を返し、そうでない場合は false を返します。
# boolean startsWith(String prefix)：トライ内に、prefix で始まる文字列が存在する場合に true を返し、そうでない場合は false を返します。

# Example 1:

# Input
# ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
# [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
# Output
# [null, null, true, false, true, null, true]

# Explanation
# Trie trie = new Trie();
# trie.insert("apple");
# trie.search("apple");   // return True
# trie.search("app");     // return False
# trie.startsWith("app"); // return True
# trie.insert("app");
# trie.search("app");     // return True
 

# Constraints:

# 1 <= word.length, prefix.length <= 2000
# word and prefix consist only of lowercase English letters.
# At most 3 * 104 calls in total will be made to insert, search, and startsWith.

class TrieNode
  attr_accessor :children, :is_end_of_word

  # Trieのノードを定義
  def initialize
    @children = {}  # 子ノードを格納するハッシュ
    @is_end_of_word = false  # 単語の終わりを示すフラグ
  end
end

class Trie
  def initialize
    # ルートノードを初期化
    @root = TrieNode.new
  end

  # 文字列 word をトライに挿入する
  def insert(word)
    node = @root
    word.each_char do |char|
      # まだ存在しない子ノードがあれば作成
      node.children[char] ||= TrieNode.new
      # 次のノードに移動
      node = node.children[char]
    end
    node.is_end_of_word = true  # 単語の終わりを記録
    puts "Inserted '#{word}' into the trie"
  end

  # 文字列 word がトライに存在するかをチェック
  def search(word)
    node = find_node(word)
    if node && node.is_end_of_word
      puts "'#{word}' found in the trie"
      return true
    else
      puts "'#{word}' not found in the trie"
      return false
    end
  end

  # 指定した prefix で始まる文字列が存在するかをチェック
  def startsWith(prefix)
    node = find_node(prefix)
    if node
      puts "Prefix '#{prefix}' exists in the trie"
      return true
    else
      puts "Prefix '#{prefix}' does not exist in the trie"
      return false
    end
  end

  private

  # 指定した文字列の最後のノードを返す
  def find_node(word)
    node = @root
    word.each_char do |char|
      # 存在しないノードがあれば nil を返す
      return nil unless node.children[char]
      # 次のノードに移動
      node = node.children[char]
    end
    node
  end
end

# 使用例
trie = Trie.new
trie.insert("apple")
trie.search("apple")   # true
trie.search("app")     # false
trie.startsWith("app") # true
trie.insert("app")
trie.search("app")     # true
