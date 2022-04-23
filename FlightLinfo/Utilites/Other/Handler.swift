//
//  Handler.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import Foundation

public typealias ActionStateHandler = (_ status: Bool) -> ()
public typealias ActionHandler = (_ status: Bool, _ message: String) -> ()
public typealias CompletionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()
public typealias CompletionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()
public typealias AlertActionHandler = (_ action: String) -> ()
