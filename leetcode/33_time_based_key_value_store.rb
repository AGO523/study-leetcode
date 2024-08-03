# Design a time-based key-value data structure that can store multiple values for the same key at different time stamps and retrieve the key's value at a certain timestamp.

# Implement the TimeMap class:

# TimeMap() Initializes the object of the data structure.
# void set(String key, String value, int timestamp) Stores the key key with the value value at the given time timestamp.
# String get(String key, int timestamp) Returns a value such that set was called previously, with timestamp_prev <= timestamp. If there are multiple such values, it returns the value associated with the largest timestamp_prev. If there are no values, it returns "".

# 時間ベースのキー・バリュー データ構造を設計してください。このデータ構造は、同じキーに対して異なるタイムスタンプで複数の値を格納し、特定のタイムスタンプでキーの値を取得できるようにします。

# TimeMap クラスを実装してください：

# TimeMap()：データ構造のオブジェクトを初期化します。
# void set(String key, String value, int timestamp)：与えられたキー key に対して値 value をタイムスタンプ timestamp と共に格納します。
# String get(String key, int timestamp)：以前に set が呼び出された値を返します。この値は timestamp_prev <= timestamp を満たします。複数の値がある場合、最も大きな timestamp_prev に関連付けられた値を返します。値が存在しない場合は "" を返します。

# Example 1:

# 最初の配列は呼び出すメソッドのリストを示しています。
# 二番目の配列は各メソッドに対する引数を示しています。


# Input
# ["TimeMap", "set", "get", "get", "set", "get", "get"]
# [[], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5]]
# Output
# [null, null, "bar", "bar", null, "bar2", "bar2"]

# Explanation
# TimeMap timeMap = new TimeMap();
# timeMap.set("foo", "bar", 1);  // store the key "foo" and value "bar" along with timestamp = 1.
# timeMap.get("foo", 1);         // return "bar"
# timeMap.get("foo", 3);         // return "bar", since there is no value corresponding to foo at timestamp 3 and timestamp 2, then the only value is at timestamp 1 is "bar".
# timeMap.set("foo", "bar2", 4); // store the key "foo" and value "bar2" along with timestamp = 4.
# timeMap.get("foo", 4);         // return "bar2"
# timeMap.get("foo", 5);         // return "bar2"
 

# Constraints:

# 1 <= key.length, value.length <= 100
# key and value consist of lowercase English letters and digits.
# 1 <= timestamp <= 107
# All the timestamps timestamp of set are strictly increasing.
# At most 2 * 105 calls will be made to set and get.


# ユーザーの設定情報を時間ベースで管理し、特定の時間における設定値を取得できるデータ構造を設計します。このデータ構造は、異なる時間に設定された値を保存し、指定された時間に最も近い過去の設定値を取得する機能を提供します。
# ["TimeMap", "set", "get", "get", "set", "get", "get"]
# [[], ["user123", "dark_mode_on", 100], ["user123", 100], ["user123", 150], ["user123", "dark_mode_off", 200], ["user123", 200], ["user123", 250]]


# あなたは、特定のキーに対して異なるタイムスタンプで複数の値を保存し、その値を後から特定のタイムスタンプで取得できるデータ構造を設計する必要があります。これを実現するために、TimeMap クラスを実装します。

# 要求される操作
# 初期化:

# TimeMap()：データ構造のオブジェクトを初期化します。
# 値の設定:

# void set(String key, String value, int timestamp)：キー key に対して値 value をタイムスタンプ timestamp と共に保存します。
# 値の取得:

# String get(String key, int timestamp)：以前に set メソッドで保存されたキー key に対して、指定されたタイムスタンプ timestamp 以下で保存された最新の値を取得します。値が存在しない場合は空の文字列 "" を返します。



# この問題を解決するために、辞書（ハッシュマップ）を使用してキーに関連付けられたタイムスタンプと値を管理します。各キーに対してタイムスタンプと値のペアを格納し、二分探索を用いて特定のタイムスタンプに最も近い（または一致する）値を効率的に取得します。

class TimeMap
  def initialize
    @store = Hash.new { |hash, key| hash[key] = [] }
  end

  def set(key, value, timestamp)
    # キーに対応するタイムスタンプと値のペアを保存
    @store[key] << [timestamp, value]
    puts "Set key: #{key}, value: #{value}, timestamp: #{timestamp}"
  end

  def get(key, timestamp)
    return "" unless @store[key]

    # 二分探索でタイムスタンプに対応する値を見つける
    list = @store[key]
    left, right = 0, list.length - 1
    result = ""

    while left <= right
      mid = (left + right) / 2
      if list[mid][0] <= timestamp
        result = list[mid][1]
        left = mid + 1
      else
        right = mid - 1
      end
    end

    puts "Get key: #{key}, timestamp: #{timestamp}, result: #{result}"
    result
  end
end

# 使用例
time_map = TimeMap.new
time_map.set("foo", "bar", 1)      # Set key: foo, value: bar, timestamp: 1
puts time_map.get("foo", 1)        # Get key: foo, timestamp: 1, result: bar => 出力: bar
puts time_map.get("foo", 3)        # Get key: foo, timestamp: 3, result: bar => 出力: bar
time_map.set("foo", "bar2", 4)     # Set key: foo, value: bar2, timestamp: 4
puts time_map.get("foo", 4)        # Get key: foo, timestamp: 4, result: bar2 => 出力: bar2
puts time_map.get("foo", 5)        # Get key: foo, timestamp: 5, result: bar2 => 出力: bar2
