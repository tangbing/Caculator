//
//  ContentView.swift
//  Caculator
//
//  Created by Tb on 2022/3/22.
//

import SwiftUI

let scale: CGFloat = UIScreen.main.bounds.width / 414

struct ContentView: View {
    
    //@State private var brain: CaculatorBrain = .left("0")
    @ObservedObject var model = CaculatorModel()
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer() /// SwiftUI 允许我们定义可伸缩的空白：Spacer，它会尝试将可占据的空间全部填满
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity,  alignment: .trailing)
            Button("Test") {
                print("Test")
               // self.brain = .left("1.23")
            }
            CaculatorButtonPad(brain: $model.brain)
                .padding(.bottom)
        }
        .scaleEffect(scale)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().previewDevice("iPhone SE")
        }
    }
}

struct CaculatorButton: View {
    let fontSize: CGFloat = 38.0
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void

    
    var body: some View {

        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: fontSize))
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName)
                .cornerRadius(size.width / 2)
                )
        }
    }
}

struct CaculatorButtonRow: View {
    
    @Binding var brain: CaculatorBrain

    
    let row: [CaculatorButtonItem]
    var body: some View {
        HStack {
            ForEach(row, id:\.self) {item in
                CaculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
                    print("Button:\(item.title)")
                    self.brain =  self.brain.apply(item: item)
                }
            }
        }
    }
}

struct CaculatorButtonPad: View {
    @Binding var brain: CaculatorBrain

    let pad: [[CaculatorButtonItem]] = [
        [.command(.clear), .command(.flip),
        .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
        ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id:\.self) { row in
                CaculatorButtonRow(brain: self.$brain, row: row)
            }
        }
    }
}
