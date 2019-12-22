//
//  PickUpContactView.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class PickupContactView: UIView {
    //MARK: - PUBLIC VAARIABLES
    var pickUpPersonPhotoImageView = UIImageView()
    var pickUpPersonNameLabel = UILabel()
    var pickUpPersonPhoneLabel = UILabel()
    var messageButtonIcon = #imageLiteral(resourceName: "messageIcon")
    var messageButton = UIButton()
    //MARK: -
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        configurePhotoImaageView()
        configureNameLabel()
        configurePhoneLabel()
        configureMessageButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
    
    //MARK: - PUBLIC METHODS
    func configure(model: PickupContactViewModel) {
        pickUpPersonNameLabel.text = model.name
        pickUpPersonPhotoImageView.image = model.photo
        pickUpPersonPhoneLabel.text = model.phone
    }
    //MARK: -
    
    //MARK: - PRIVATE METHODS
    private func configurePhotoImaageView() {
        addSubview(pickUpPersonPhotoImageView)
        pickUpPersonPhotoImageView.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.height.width.equalTo(48)
        }
    }
    
    private func configureNameLabel() {
        addSubview(pickUpPersonNameLabel)
        pickUpPersonNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pickUpPersonPhotoImageView.snp.top)
            make.leading.equalTo(pickUpPersonPhotoImageView.snp.trailing).offset(10)
            make.height.equalTo(22)
        }
        pickUpPersonNameLabel.font = UIFont(name: "EncodeSans-Medium", size: 17)
    }
    
    private func configurePhoneLabel() {
        addSubview(pickUpPersonPhoneLabel)
        pickUpPersonPhoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pickUpPersonNameLabel.snp.bottom)
            make.leading.equalTo(pickUpPersonNameLabel.snp.leading)
            make.height.equalTo(20)
        }
        pickUpPersonPhoneLabel.font = UIFont(name: "EncodeSans-Regular", size: 15)
        pickUpPersonPhoneLabel.textColor = UIColor(red: 140 / 255, green: 140 / 255, blue: 140 / 255, alpha: 1)
    }
    
    private func configureMessageButton() {
        addSubview(messageButton)
        messageButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(pickUpPersonPhotoImageView.snp.centerY)
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.leading.greaterThanOrEqualTo(pickUpPersonNameLabel.snp.trailing).offset(5)
            make.width.equalTo(50)
        }
        messageButton.setTitle("Message", for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "EncodeSans-Light", size: 13)
        messageButton.setTitleColor(UIColor(red: 0, green: 90 / 255, blue: 246 / 255, alpha: 1), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "messageIcon"), for: .normal)
        messageButton.titleLabel?.textAlignment = .right
        messageButton.alignTextUnderImage(spacing: 0)
    }
    //MARK: -
}
