//
//  String+Localized.swift
//  numerosTip
//
//  Created by Jared Perez Vega on 05/05/2019.
//  Copyright © 2019 Jared Perez Vega. All rights reserved.
//

import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
