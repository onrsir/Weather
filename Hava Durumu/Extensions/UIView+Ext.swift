//
//  UIView+Ext.swift
//  Hava Durumu
//
//  Created by Onur Sir on 16.02.2023.
//

import MapKit

extension UIView {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
