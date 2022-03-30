//
//  CaculatorModel.swift
//  Caculator
//
//  Created by Tb on 2022/3/30.
//

import Foundation
import Combine


class CaculatorModel: ObservableObject {
    /// “PassthroughSubject 提供了一个 send 方法，来通“知外界有事件要发生了 (此处的事件即驱动 UI 的数据将要发生改变)。”
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    var brain: CaculatorBrain = .left("0") {
        willSet {
            objectWillChange.send()
        }
    }
    
}
