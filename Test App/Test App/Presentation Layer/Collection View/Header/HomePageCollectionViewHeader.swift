//
//  HomePageCollectionViewHeader.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class HomePageCollectionViewHeader: UICollectionReusableView {
    //MAARK: - PUBLIC VARIABLES
    var label = UILabel()
    //MARK: -
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(25)
        }
        label.font = UIFont(name: "EncodeSans-Bold", size: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
}
