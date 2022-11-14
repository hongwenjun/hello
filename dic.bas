Sub testdic()
  Dim a, d, i
  Set d = CreateObject("Scripting.dictionary")
  
  Dim sh As Shape, shs As Shapes, ssr As New ShapeRange
  Set shs = ActiveSelection.Shapes
  
  For Each sh In shs
    d.Add sh.StaticID, sh.CenterY
  Next sh
  
'  Debug.Print d.keys()(0), d.items()(0)

  Dim s As Shape
  a = d.keys
  For i = 0 To d.Count - 1 Step 2
    Set s = ActivePage.FindShape(StaticID:=a(i))
    ssr.Add s
  Next

 Set s = ssr.Group
 s.Fill.ApplyNoFill

End Sub

'// Properties 属性返回 Properties 集合，它允许您指定和操作与页面关联的自定义数据。
'// 以下 VBA 示例将当前选择存储在活动页面属性的数组中。
Sub SaveSelection()
    Dim s As Shape, n As Long
    ActivePage.Properties("StoredSelection", 0) = ActiveSelection.Shapes.Count
    n = 1
    For Each s In ActiveSelection.Shapes
        ActivePage.Properties("StoredSelection", n) = s.StaticID   ' 存储当前形状的 ID 号
        n = n + 1
    Next s
End Sub

'// 以下 VBA 示例将当前选择存储在活动页面属性的数组中。
Sub RestoreSelection()
    Dim s As Shape, sr As New ShapeRange
    Dim v As Variant
    Dim Num As Long, i As Long, id As Long
    v = ActivePage.Properties("StoredSelection", 0) '
    If Not IsNull(v) Then
        ActivePage.Properties.Delete "StoredSelection", 0 ' 检索存储的形状参考总数
        Num = v
        For i = 1 To Num
            id = ActivePage.Properties("StoredSelection", i) ' 如果它仍然存在于文档中，则将形状添加到形状范围
            Set s = ActivePage.FindShape(StaticID:=id)
            If Not s Is Nothing Then sr.Add s '
                ActivePage.Properties.Delete "StoredSelection", i ' Delete the property
            Next i
            sr.CreateSelection ' 选择找到的所有形状
        Else
            MsgBox "活动页面中未存储任何选择"
        End If
End Sub


Sub Test等分曲线()
  Dim seg As Segment
  Dim t As Double
  Dim n As Long
  n = 5  '// 等分曲线N段
  For Each seg In ActiveShape.Curve.Segments
    For t = 1 To (n - 1)
      MarkPoint seg, t / n
    Next t
  Next seg
End Sub

Private Sub MarkPoint(seg As Segment, t As Double)
  Dim x As Double, y As Double
    seg.GetPointPositionAt x, y, t, cdrRelativeSegmentOffset
    ' seg.GetPointPositionAt x, y, t, cdrAbsoluteSegmentOffset
  ActiveLayer.CreateEllipse2 x, y, 0.2
End Sub

Sub 曲线等分添加节点()
  Dim a, d, i
  Dim seg As Segment
  Dim t As Double, n As Long, x As Double, y As Double
  n = 5  '// 等分曲线N段
  Set d = CreateObject("Scripting.dictionary")
  
  For Each seg In ActiveShape.Curve.Segments
    For t = 1 To (n - 1)
      seg.GetPointPositionAt x, y, t / n, cdrRelativeSegmentOffset
      d.Add x, y
    Next t
  Next seg

  For i = 0 To d.Count - 1
    Debug.Print d.keys()(i), d.items()(i)
  Next

Stop
End Sub
