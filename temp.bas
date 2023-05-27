Sub tt_Intersect()
    Dim sr As ShapeRange, s As Shape
    Set sr = ActiveSelectionRange
    Set s = sr(1).Intersect(sr(2), True, False)
End Sub

    
Sub XPosition()
 Dim s1 As Shape, sr As New ShapeRange
 Dim s As Shape
 Dim cps As CrossPoints
 Dim cp As CrossPoint
 sr.Add ActiveLayer.CreateEllipse2(4, 4, 3)
 sr.Add ActiveLayer.CreateEllipse2(5, 3, 2)
 Set s = sr.Combine
 Set cps = s.Curve.SubPaths(1).GetIntersections(s.Curve.SubPaths(2))
 For Each cp In cps
  ActiveLayer.CreateEllipse2 cp.PositionX, cp.PositionY, 0.1
 Next cp
End Sub
      
      
要让Python中的坐标点等距，你需要使用数学库，例如numpy。以下是一个简单的示例代码，可用于在二维平面上生成等距的坐标点：

```python
import numpy as np

# 定义坐标点数量
n_points = 10

# 生成等距坐标点
x = np.linspace(0, 1, n_points)
y = np.linspace(0, 1, n_points)
xx, yy = np.meshgrid(x, y)
points = np.column_stack((xx.ravel(), yy.ravel()))

# 输出坐标点
print(points)
```

在上面的代码中，我们首先使用`numpy`库中的`linspace`函数沿着x和y轴生成等距的坐标点。然后，我们使用`meshgrid`函数将这些坐标点组合成网格，并使用`column_stack`函数将它们转换为一个二维数组。最后，我们打印出这个数组，以查看生成的坐标点。

这个简单的代码示例将生成一个包含10x10个等距坐标点的二维数组。你可以改变`n_points`变量的值来生成不同数量的坐标点。
