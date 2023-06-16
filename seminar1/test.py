import matplotlib.pyplot as plt

# 例として、散布図を作成
fig, ax = plt.subplots()
scatter = ax.scatter([1, 2, 3], [4, 5, 6], c=[7, 8, 9])
cbar = plt.colorbar(scatter)

# 軸のtickサイズを変更する
cbar.ax.tick_params(labelsize=120)

# グラフを表示する
plt.show()
