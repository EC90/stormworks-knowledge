---
wiki: sbarjp
page: アドオンLua/Matrices
source_url: https://wikiwiki.jp/sbarjp/%E3%82%A2%E3%83%89%E3%82%AA%E3%83%B3Lua/Matrices
last_modified: 2026-08-22
retrieved_at: 2026-08-31T01:11:30+0800
---

# アドオンLua/Matrices

|  |
| --- |
| **このページはアドオン Lua のヘルプドキュメントの翻訳です。原文のバージョンは Stormworks v1.15.20（リリース日：2026/8/15）です。アドオン Lua はたびたびアップデートされています。正確な情報は公式のアップデート情報から確認してください。** |

## Matrix Manipulation（行列の操作）

英語原文

Stormworks provides a limited set of matrix functions that are useful for transforming positions of objects in scripts:

Multiply two matrices together.

```
out_matrix = matrix.multiply(matrix1, matrix2)
```

Invert a matrix.

```
out_matrix = matrix.invert(matrix1)
```

Transpose a matrix.

```
out_matrix = matrix.transpose(matrix1)
```

Return an identity matrix.

```
out_matrix = matrix.identity()
```

Return a rotation matrix rotated in the X axis.

```
out_matrix = matrix.rotationX(radians)
```

Return a rotation matrix rotated in the Y axis.

```
out_matrix = matrix.rotationY(radians)
```

Return a rotation matrix rotated in the Z axis.

```
out_matrix = matrix.rotationZ(radians)
```

Return a translation matrix translated by x,y,z.

```
out_matrix = matrix.translation(x,y,z)
```

Get the x,y,z position from a matrix.

```
x,y,z = matrix.position(matrix1)
```

Find the distance between two matrices.

```
dist = matrix.distance(matrix1, matrix2)
```

Multiplies a matrix by a vec 4.

```
out_x, out_y, out_z, out_w = matrix.multiplyXYZW(matrix1, x, y, z, w)
```

Returns the rotation required to face an X Z vector

```
out_rotation = matrix.rotationToFaceXZ(x, z)
```

Stormworks には、スクリプト内のオブジェクトの座標を変換するのに便利な行列関数の限定的なライブラリが用意されています：

行列の積を求めます。

```
out_matrix = matrix.multiply(matrix1, matrix2)
```

逆行列を求めます。

```
out_matrix = matrix.invert(matrix1)
```

転置行列を求めます。

```
out_matrix = matrix.transpose(matrix1)
```

単位行列を返します。

```
out_matrix = matrix.identity()
```

X 軸周りの回転を表す回転行列を返します。

```
out_matrix = matrix.rotationX(radians)
```

Y 軸周りの回転を表す回転行列を返します。

```
out_matrix = matrix.rotationY(radians)
```

Z 軸周りの回転を表す回転行列を返します。

```
out_matrix = matrix.rotationZ(radians)
```

x,y,z に平行移動する平行移動行列を返します。

```
out_matrix = matrix.translation(x,y,z)
```

行列から x,y,z 座標を取得します。

```
x,y,z = matrix.position(matrix1)
```

2 つの行列の距離を求めます。

```
dist = matrix.distance(matrix1, matrix2)
```

行列と 4 次元ベクトルの積を求めます。

```
out_x, out_y, out_z, out_w = matrix.multiplyXYZW(matrix1, x, y, z, w)
```

X Z ベクトルの方向を向くために必要な回転を返します。

```
out_rotation = matrix.rotationToFaceXZ(x, z)
```

## Example（使用例）

英語原文

Most API functions take a matrix as a parameter so users that do not wish to use matrices directly can convert between matrices and coordinates as follows:

```
-- Teleport peer_1 10m up
peer_1_pos, is_success = server.getPlayerPos(1)
if is_success then
	local x, y, z = matrix.position(peer_1_pos)
	y = y + 10
	server.setPlayerPos(1, matrix.translation(x,y,z))
end
```

ほとんどの API 関数はパラメータとして行列を受け取るので、行列を直接使いたくない場合は以下のように行列と座標を変換することができます：

```
-- peer_1 を 10 メートル上にテレポートする
peer_1_pos, is_success = server.getPlayerPos(1)
if is_success then
	local x, y, z = matrix.position(peer_1_pos)
	y = y + 10
	server.setPlayerPos(1, matrix.translation(x,y,z))
end
```
