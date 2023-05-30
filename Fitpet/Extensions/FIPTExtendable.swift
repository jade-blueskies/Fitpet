//
//  FIPTExtendable.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/30.
//

import Foundation

protocol FIPTExtendable {}
extension FIPTExtendable {
    
    var fipt: FIPTExtension<Self, FIPTExtendable> {
        return .init(base: self)
    }
    
}
