//
//  CaculatorButtonItem.swift
//  Caculator
//
//  Created by Tb on 2022/3/24.
//

import Foundation
import SwiftUI

enum CaculatorButtonItem {

    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multiply = "×"
        case equal = "="
    }
    
    enum Command: String {
    case clear = "AC"
    case flip = "+/-"
    case percent = "%"
    }
    
    case digit(Int) /// 代表从 0 至 9 的数字 digit
    case dot /// 小数点 dot
    case op(Op) /// 加减乘除等号这样的操作 (Op)
    case command(Command) /// 清空、符号翻转等这类命令 (Command)
    
}

extension CaculatorButtonItem {
    var title: String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }
    
    var size: CGSize {
        if case .digit(let value) = self, value == 0 {
            return CGSize(width: 88 * 2, height: 88)
        }
       return CGSize(width: 88, height: 88)
    }
    
    var backgroundColorName: String {
        switch self {
        case .digit, .dot: return "digitBackground"
        case .op: return "operatorBackground"
        case .command: return "commandBackground"
        }
    }
    
}

extension CaculatorButtonItem: Hashable {}

