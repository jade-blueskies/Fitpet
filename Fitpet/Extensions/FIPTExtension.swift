//
//  FIPTExtension.swift
//  Fitpet
//
//  Created by 박지성 on 2023/05/30.
//

import Foundation

struct FIPTExtension<Base, Extension> {
    let base: Base
    init(base: Base) {
        self.base = base
    }
}
