//
//  AirportTitleCollectionViewCell.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class AirportTitleCollectionViewCell: UICollectionViewCell {
    //MARK: - PUBLIC METHODS
    var mainLabel = UILabel()
    var secondaryLabel = UILabel()
    //MARK: -
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        configureMainLabel()
        configureSecondaryLaabel()
        
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 5, blur: 10, spread: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
    
    //MARK: - PUBLIC METHODS
    func configure(model: AirportTitleViewModel) {
        mainLabel.text = model.code
        secondaryLabel.text = model.title
    }
    //MARK: -
    
    //MARK: -PRIVATE METHODS
    private func configureMainLabel() {
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(22.5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(37)
        }
        mainLabel.font = UIFont(name: "EncodeSans-Bold", size: 34)
        mainLabel.textAlignment = .center
    }
    
    private func configureSecondaryLaabel() {
        addSubview(secondaryLabel)
        secondaryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(mainLabel.snp.bottom).offset(2.5)
            make.height.equalTo(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(21)
        }
        secondaryLabel.font = UIFont(name: "EncodeSans-Regular.ttf", size: 15)
        secondaryLabel.textAlignment = .center
    }
    //MARK: -
}
