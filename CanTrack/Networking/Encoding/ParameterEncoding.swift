//
//  ParameterEncoding.swift
//  CanTrack
//
//  Created by Hugh Broome on 6/22/19.
//  Copyright © 2019 Lygre. All rights reserved.
//

import Foundation


public typealias Parameters = [String: Any]

public protocol ParameterEncoder {

	static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws

}
