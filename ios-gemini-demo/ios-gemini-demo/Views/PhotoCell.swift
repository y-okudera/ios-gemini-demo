//
//  PhotoCell.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Gemini
import UIKit

final class PhotoCell: GeminiCell {

    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var imageView: UIImageView!
}
