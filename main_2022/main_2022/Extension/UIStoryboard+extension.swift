//
//  UIStoryboard+extension.swift
//  main_2022
//
//  Created by Andy on 2022/3/2.
//

import UIKit

extension UIStoryboard {
    public static var Main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: .main)
    }
        
    public func newInstance<T: UIViewController>(typeName: String) -> T {
        return self.instantiateViewController(withIdentifier: typeName) as! T
    }
}
