//
//  Theme.swift
//  Music
//
//  Created by WangPengHui on 16/10/26.
//  Copyright © 2016年 美鲜冻品商城. All rights reserved.
//

import UIKit

public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds
//swift版
public func DLog<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("<\((file as NSString).lastPathComponent) : \(line)>, \(method)  \(message)")
    #endif
}
