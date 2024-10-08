`find` と `union` は、**Union-Find データ構造（別名：Disjoint Set Union, DSU）** における主要な操作です。これらは、グラフアルゴリズム（特に最小全域木を求めるクラスカル法など）や、データのグループ化、サイクルの検出、効率的な集合管理など、さまざまな用途で使用されます。

Union-Find データ構造を理解するために、まず `find` と `union` がどのような操作を行っているかを詳細に解説します。

## 1. Union-Find（または Disjoint Set Union）とは？

Union-Find とは、**いくつかの異なる集合（グループ）を管理し、集合間の統合や要素の所属確認を効率的に行うためのデータ構造**です。

### 代表的な用途

- **グラフアルゴリズム**:
  - **クラスカル法**での最小全域木の構築。
  - **サイクル検出**や**連結成分の判定**。
- **クラスタリング**や**グループ管理**:
  - データをグループ分けし、グループの統合や所属確認を行う。

### 基本操作

Union-Find には、以下の 2 つの主要な操作があります：

1. **`find(x)`**:
   - 要素 `x` が属する集合の**代表（ルート）**を見つけます。
   - 例えば、あるグループの代表（親ノード）を探し、同じ代表を持つかどうかで「同じグループか」を確認します。
2. **`union(x, y)`**:
   - 要素 `x` が属する集合と要素 `y` が属する集合を**1 つに結合**します。
   - これにより、2 つの集合が「1 つのグループ」として管理されるようになります。

## 2. `find` の役割と動作

### `find(x)` の役割

`find(x)` は、要素 `x` が属する集合の**代表ノード（ルートノード）**を見つける操作です。

- Union-Find では、各要素は初期状態では**自分自身を親として持つ**ように設定されています。
- そのため、`find` 操作を行うことで、各要素が最終的にどの代表ノードにたどり着くか（親ノードをたどっていく）を確認できます。

### 例

以下の図のような集合を考えます（親ノードを矢印で示す）：

```
0 ← 1   2 ← 3
```

- 要素 `1` の `find` を行うと、`1` の親ノードは `0` です。さらに `0` 自身が「代表（ルート）ノード」であるため、`find(1)` の結果は `0` となります。
- 同様に、`find(3)` の結果は `2` となります。

### 実装例

`find` は**経路圧縮**（Path Compression）を行うことで、効率的に代表を見つけます。経路圧縮とは、親をたどっていく途中ですべてのノードの親をルートに直接繋ぎ直すことです。これにより、次回以降の `find` 操作が高速化されます。

```ruby
def find(x)
  if @parent[x] != x
    @parent[x] = find(@parent[x])  # 再帰的にルートを探し、経路を圧縮
  end
  @parent[x]
end
```

#### 経路圧縮の動作例

経路圧縮を使う前の集合構造：

```
0 ← 1 ← 2 ← 3
```

- `find(3)` を行うと、最初は `3` の親は `2`、`2` の親は `1`、`1` の親は `0` です。
- `0` がルートノードであるとわかったら、`3`、`2`、`1` のすべてのノードの親を `0` に設定し直します。

経路圧縮後の構造：

```
0 ← 1
0 ← 2
0 ← 3
```

次回以降、`find(3)` を行うと直接 `0` を返せるようになり、効率が向上します。

## 3. `union` の役割と動作

### `union(x, y)` の役割

`union(x, y)` は、要素 `x` と `y` が属する 2 つの集合を**1 つの集合に結合**する操作です。

- `x` と `y` の代表ノード（ルートノード）を確認し、2 つの集合が異なる場合に統合を行います。
- これにより、`x` と `y` が同じ集合に属することが保証されます。

### ランク（高さ）による結合

`union` 操作では、ランク（`rank`）やサイズを考慮して結合を行うことがあります。これを**ランク付け**と呼びます。

- 各集合は**ランク（高さ）**を持ちます。ランクが高い方を親とすることで、**木の高さをできるだけ低く保つ**ようにします。
- 木の高さが低いと、`find` 操作が速くなります（すべての要素がルートに近づくため）。

#### 例

次の 2 つの集合があるとします：

```
0 ← 1          2 ← 3 ← 4
```

- `find(1) = 0`
- `find(4) = 2`

`union(1, 4)` を行うと、`0` と `2` の高さを比較します。例えば、`2` の方が高さが高い場合、`0` を `2` に接続し、次のようになります：

```
2 ← 3 ← 4
   ↑
   0 ← 1
```

### 実装例

以下のコードは、`rank` を使用した `union` の実装です：

```ruby
def union(x, y)
  rootX = find(x)
  rootY = find(y)

  # 2つのノードのルートが同じ場合は、既に同じ集合なので結合しない
  return if rootX == rootY

  # ランクの高い方を親とする
  if @rank[rootX] > @rank[rootY]
    @parent[rootY] = rootX
  elsif @rank[rootX] < @rank[rootY]
    @parent[rootX] = rootY
  else
    @parent[rootY] = rootX
    @rank[rootX] += 1  # 同じランクなら、結合後にランクを1増やす
  end
end
```

### `union` の操作例

次のような 2 つの集合があるとします：

```
集合1: 0 ← 1
集合2: 2 ← 3
```

- `union(1, 3)` を行うと、`find(1)` の結果は `0`、`find(3)` の結果は `2` です。
- ランクを比較し、どちらかのルートにもう一方を接続します。例えば、`2` を `0` に接続すると、次のようになります：

```
0 ← 1
↑
2 ← 3
```

これにより、`0, 1, 2, 3` が 1 つの集合に統合されました。

## 4. Union-Find クラス全体の実装例

以下は、`Union-Find` のクラス全体の例です。これにより、`find` と `union` の動作を理解しやすくなります。

```ruby
class UnionFind
  def initialize(size)
    @parent = (0...size).to_a  # 各ノードの親を自分自身に初期化
    @rank = Array.new(size, 1) # ランクを1に初期化
  end

  # ルートノードを見つける（経路圧縮を行う）
  def find(x)
    if x != @parent[x]
      @parent[x] = find(@parent[x])
    end
    @parent[x]
  end

  # 2つのノードを結合する（ランクを考慮して結合）
  def union(x, y)


 rootX = find(x)
    rootY = find(y)
    return if rootX == rootY

    # ランクの高い方を親とする
    if @rank[rootX] > @rank[rootY]
      @parent[rootY] = rootX
    elsif @rank[rootX] < @rank[rootY]
      @parent[rootX] = rootY
    else
      @parent[rootY] = rootX
      @rank[rootX] += 1
    end
  end

  # 同じグループ（親が同じ）かを確認
  def connected?(x, y)
    find(x) == find(y)
  end
end
```

これにより、`find` と `union` の詳細な動作を確認し、Union-Find データ構造の動作をより深く理解できます。
