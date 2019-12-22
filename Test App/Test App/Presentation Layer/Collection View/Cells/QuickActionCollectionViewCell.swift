//
//  QuickActionCollectionViewCell.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class QuickActionCollectionViewCell: UICollectionViewCell {
    //MARK: - PUBLIC VARIABLES
    var icon = UIImageView()
    var label = UILabel()
    //MARK: -
    
    //MARK: - PRIVATE VARIABLES
    private var shadowLayer: CAShapeLayer!
    //MARK: -
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        configureIcon()
        configureLabel()
        
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 5, blur: 10, spread: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
    
    //MARK: - PUBLIC METHODS
    func configure(model: QuickActionViewModel) {
        icon.image = model.icon
        label.text = model.title
    }
    //MARK: -
    
    //MARK: - PRIVATE METHODS
    private func configureIcon() {
        addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().inset(128)
            make.top.equalToSuperview().inset(45)
            make.trailing.equalToSuperview().inset(10)
        }
        icon.contentMode = .bottom
    }
    
    private func configureLabel() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(icon.snp.trailing)
            make.bottom.equalToSuperview().inset(7)
            make.height.equalTo(22)
        }
        label.textAlignment = .right
        label.font = UIFont(name: "EncodeSans-Medium", size: 17)
    }
    //MARK: -
}


