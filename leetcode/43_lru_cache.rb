# Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

# Implement the LRUCache class:

# LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
# int get(int key) Return the value of the key if the key exists, otherwise return -1.
# void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
# The functions get and put must each run in O(1) average time complexity.

# Least Recently Used (LRU) キャッシュの制約に従うデータ構造を設計してください。

# LRUCache クラスを実装します:

# LRUCache(int capacity): 正のサイズ capacity で LRU キャッシュを初期化します。
# int get(int key): キーが存在する場合、そのキーの値を返します。存在しない場合は -1 を返します。
# void put(int key, int value): キーが既に存在する場合、その値を更新します。存在しない場合は、キーと値のペアをキャッシュに追加します。キーの数がこの操作によってキャッシュの容量を超える場合、最も最近使用されていないキーを削除します。
# get と put 関数は、それぞれ O(1) の平均時間計算量で実行される必要があります。



# Example 1:

# Input
# ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
# [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
# Output
# [null, null, null, 1, null, -1, null, -1, 3, 4]

# Explanation
# LRUCache lRUCache = new LRUCache(2);
# lRUCache.put(1, 1); // cache is {1=1}
# lRUCache.put(2, 2); // cache is {1=1, 2=2}
# lRUCache.get(1);    // return 1
# lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
# lRUCache.get(2);    // returns -1 (not found)
# lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
# lRUCache.get(1);    // return -1 (not found)
# lRUCache.get(3);    // return 3
# lRUCache.get(4);    // return 4
 

# Constraints:

# 1 <= capacity <= 3000
# 0 <= key <= 104
# 0 <= value <= 105
# At most 2 * 105 calls will be made to get and put.

# 解答
# この問題を解決するためには、LRUキャッシュを実装するためのデータ構造として、ハッシュマップと双方向リンクリストを組み合わせます。ハッシュマップはO(1)の時間でキーに対応する値を見つけるために使用され、双方向リンクリストはキーの挿入順序を管理するために使用されます。

# Least Recently Used (LRU) キャッシュは、キャッシュ内のデータを管理するアルゴリズムの一種で、使用頻度が低いデータを優先的に削除することでキャッシュの容量を効率的に利用します。具体的には、キャッシュの容量がいっぱいになったとき、最も長い間アクセスされていないデータ（つまり最も古いデータ）を削除し、新しいデータを追加します。

# LRUキャッシュの特徴
# 最近使用されていないデータを削除:

# キャッシュの容量が制限されているため、キャッシュがいっぱいになったときには、最も長い間使用されていないデータを削除します。
# 高速なアクセス:

# データの取得（get）や更新（put）は高速に行われるように設計されています。具体的には、これらの操作はO(1)の時間で行えるようにすることが理想です。

class ListNode
  attr_accessor :key, :value, :prev, :next

  def initialize(key = 0, value = 0)
    @key = key
    @value = value
    @prev = nil
    @next = nil
  end
end

class LRUCache
  def initialize(capacity)
    @capacity = capacity  # キャッシュの容量
    @cache = {}  # ハッシュマップ: キー => リンクリストノード
    @head = ListNode.new  # ダミーのヘッドノード
    @tail = ListNode.new  # ダミーのテールノード
    @head.next = @tail  # 初期状態ではヘッドとテールが接続されている
    @tail.prev = @head
  end

  def get(key)
    if @cache.key?(key)
      node = @cache[key]
      remove(node)  # ノードを現在の位置から削除
      add_to_front(node)  # ノードをリストの先頭に移動
      puts "Accessed key #{key}: Value is #{node.value}"
      return node.value
    else
      puts "Key #{key} not found"
      return -1
    end
  end

  def put(key, value)
    if @cache.key?(key)
      node = @cache[key]
      remove(node)  # ノードを現在の位置から削除
      node.value = value  # 値を更新
    else
      if @cache.size >= @capacity
        lru = @tail.prev
        remove(lru)  # 最も最近使われていないノードを削除
        @cache.delete(lru.key)
        puts "Evicted least recently used key #{lru.key}"
      end
      node = ListNode.new(key, value)
      @cache[key] = node
    end
    add_to_front(node)  # 新しいノードをリストの先頭に追加
    puts "Put key #{key} with value #{value}"
  end

  private

  # remove(node) メソッドは、リンクリストから指定されたノードを取り除くために、前後のノードを直接つなげます。これにより、リスト内から node が安全に削除されます。
  def remove(node)
    # 現在の node をリストから取り除く
    prev_node = node.prev
    next_node = node.next
    prev_node.next = next_node
    next_node.prev = prev_node
    puts "Removed key #{node.key} from its current position"
  end

  # add_to_front(node) メソッドは、指定されたノードをリストの先頭に追加するために、ヘッドノードの次に node を挿入し、元々の先頭ノードとのリンクを再設定します。これにより、リスト内でのノードの順序を適切に管理できます。
  def add_to_front(node)
    # ノードをリストの先頭に追加する
    # first_node = @head.next:

    # 現在リストの先頭にあるノードを取得します。リストのヘッドはダミーノードで、その次のノードが実際のリストの先頭です。
    # @head.next = node:

    # ヘッドノードの next ポインタを、新しく追加する node に設定します。これにより、node がリストの新しい先頭になります。
    # node.prev = @head:

    # 新しく追加された node の prev ポインタをヘッドノードに設定します。
    # node.next = first_node:

    # 新しく追加された node の next ポインタを、元々リストの先頭にあった first_node に設定します。
    # first_node.prev = node:

    # 元々の先頭ノードの prev ポインタを、新しい先頭ノードである node に設定します。
    # この操作により、指定された node がリストの先頭に移動されます。これにより、リストの順序が適切に維持され、最も新しいノードが常に先頭に来るように管理されます。
    first_node = @head.next
    @head.next = node
    node.prev = @head
    node.next = first_node
    first_node.prev = node
    puts "Moved key #{node.key} to the front of the list"
  end
end

# 使用例
lru_cache = LRUCache.new(2)  # 容量2のLRUキャッシュを作成

lru_cache.put(1, 1)  # キャッシュに {1=1} を追加
lru_cache.put(2, 2)  # キャッシュに {1=1, 2=2} を追加
lru_cache.get(1)     # 1 を返す
lru_cache.put(3, 3)  # キャッシュが満杯なのでキー 2 を削除し {1=1, 3=3} を追加
lru_cache.get(2)     # -1 を返す（キー 2 は削除されたため）
lru_cache.put(4, 4)  # キャッシュが満杯なのでキー 1 を削除し {4=4, 3=3} を追加
lru_cache.get(1)     # -1 を返す（キー 1 は削除されたため）
lru_cache.get(3)     # 3 を返す
lru_cache.get(4)     # 4 を返す
