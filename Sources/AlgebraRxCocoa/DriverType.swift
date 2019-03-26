//
// Created by Arnon Keereena on 2019-02-15.
// Copyright (c) 2019 Allianz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol DriverType: SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
}

extension Driver: DriverType where S == DriverSharingStrategy {
}

