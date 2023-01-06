//
//  UIImage+Extension.swift
//  FenixTrade
//
//  Created by macOsx on 25/09/20.
//  Copyright © 2020 macOsx. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func loadImage(string: String) {
        self.sd_setImage(with: URL(string: string), completed: nil)
    }

}
