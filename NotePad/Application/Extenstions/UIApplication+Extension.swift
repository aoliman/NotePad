//
//  File.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import UIKit

public extension UIApplication {

    static var rootViewController: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
}
