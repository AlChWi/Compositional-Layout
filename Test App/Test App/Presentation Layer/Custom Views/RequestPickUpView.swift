//
//  RequestPickUpView.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class RequestPickUpView: UIView {
    //MARK: - PUBLIC VARIABLES
    var requestPickUpButton = UIButton()
    //MARK: -
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(requestPickUpButton)
        requestPickUpButton.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        requestPickUpButton.setTitle("+ Request a Pickup", for: .normal)
        requestPickUpButton.titleLabel?.font = UIFont(name: "EncodeSans-Medium", size: 17)
        requestPickUpButton.setTitleColor(UIColor(red: 140 / 255, green: 140 / 255, blue: 140 / 255, alpha: 1), for: .normal)
        requestPickUpButton.contentHorizontalAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
}
