//
//  UUID+zero.swift
//  UUID+zero
//
//  Created by Sven Svensson on 28/08/2021.
//

import Foundation

extension UUID {
    static var zero: UUID {
        return UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    }
}
