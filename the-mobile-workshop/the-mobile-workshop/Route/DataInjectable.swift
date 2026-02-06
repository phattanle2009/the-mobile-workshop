//
//  DataInjectable.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 5/2/26.
//

protocol DataInjectable {
    associatedtype DataType
    func inject(data: DataType)
}
