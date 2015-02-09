//
//  Constants.swift
//  AuctionApp
//
//  Created by Mike Choi on 17/11/2014.
//  Copyright (c) 2014 LifePlusDev. All rights reserved.
//


import UIKit

let Device = UIDevice.currentDevice()

private let iosVersion = NSString(string: Device.systemVersion).doubleValue

let iOS8 = iosVersion >= 8
let iOS7 = iosVersion >= 7 && iosVersion < 8