## SwiftUI 知识点

 

```swift
 var body: some View {
       Text("+")
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(Color.orange)
    }
```



- 在SwiftUI中，上面四次调用，都称为View的modifier，一个view modifier作用在某个View上，并生成原来值得另外一个版本，按照这个定义，大致来说，view modifier分为两种类别：

  - 像是font， foregroundColor这样定义在具体类型(比如例子中的Text)上，然后返回同样类型(Text)的原地modifier。
  - 像是padding， background这样定义在View extension中，将原来的View进行包装并返回新的View的封装类modifier。

  原地modifier一般来说对顺序不敏感，对布局也不关心，他们更像是针对对象View本身的属性的修改。而与之相反，封装类的modifier的顺序十分重要。

- 我们需要对此进行一些解释。`ForEach` 是 SwiftUI 中一个用来列举元素，并生成对应 `View` collection 的类型。它接受一个数组，且数组中的元素需要满足 `Identifiable` 协议。如果数组元素不满足 `Identifiable`，我们可以使用 `ForEach(_:id:)` 来通过某个支持 `Hashable` 的 key path 获取一个等效的元素是 `Identifiable` 的数组。在我们的例子中，数组 `row` 中的元素类型 `CalculatorButtonItem` 是不遵守 `Identifiable` 的。为了解决这个问题，我们可以为 `CalculatorButtonItem` 加上 `Hashable`，这样就可以直接用 `ForEach(row, id: \.self)` 的方式转换为可以接受的类型了。在 `CalculatorButtonItem.swift` 文件最后，加上一行：

  extension CalculatorButtonItem: Hashable {}

- 