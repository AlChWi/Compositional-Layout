//
//  BoardingPassCollectionViewCell.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class BoardingPassCollectionViewCell: UICollectionViewCell {
    //MARK: - PUBLIC VARIAABLES
    var passStatusLabel = UILabel()
    var initialDepartureTimeLabel = UILabel()
    var initialArrivarlTimeLabel = UILabel()
    var actualDepartureTimeLabel = UILabel()
    var actualArrivalTimeLabel = UILabel()
    var departureAirportCodeLabel = UILabel()
    var arrivalAirportCodeLabel = UILabel()
    var departureAirportTitleLabel = UILabel()
    var arrivalAirportTitleLabel = UILabel()
    var transportTypeIcon = UIImageView()
    var passNumber = UILabel()
    var pickupView = UIView()
    var separatorLine = UIView()
    //MARK: -
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        configurePassStatusLaabel()
        configureInitialDepartureTimeLabel()
        configureInitialArrivalTimeLabel()
        configureActualDepartureTimeLabel()
        configureActualArrivaalTimeLabel()
        configureDepartureAirportCodeLabel()
        configureArrivalAirportCodeLabel()
        configureDepartureAirportTitleLaabel()
        configureArrivalAirportTitleLabel()
        configureTransportTypeIcon()
        configurePassNumber()
        configureSeparatorLine()
        configurePickupView()
        
        layer.cornerRadius = 5
        layer.masksToBounds = false
        layer.applyShadow(color: .black, alpha: 0.1, x: 0, y: 5, blur: 10, spread: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
    
    //MARK: - PUBLIC METHODS
    func configure(model: BoardingPassViewModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        initialArrivarlTimeLabel.text = dateFormatter.string(from: model.initialArrivarlTime)
        initialDepartureTimeLabel.text = dateFormatter.string(from: model.initialDepartureTime)
        actualArrivalTimeLabel.text = dateFormatter.string(from: model.actualArrivalTime)
        actualDepartureTimeLabel.text = dateFormatter.string(from: model.actualDepartureTime)
        
        setPassStatus(model.passStatus)
        
        switch model.transportType {
        case .airplane:
            transportTypeIcon.image = #imageLiteral(resourceName: "airplane")
        default:
            print("Unexpected transport type")
        }
        
        departureAirportCodeLabel.text = model.departureAirportCode
        arrivalAirportCodeLabel.text = model.arrivalAirportCode
        
        departureAirportTitleLabel.text = model.departureAirportTitle
        arrivalAirportTitleLabel.text = model.arrivalAirportTitle
        
        passNumber.text = model.passNumber
    }
    
    func setPassStatus(_ status: PassStatus) {
        switch status {
        case .gateChanged:
            passStatusLabel.text = "GATE CHANGED"
            passStatusLabel.backgroundColor = UIColor(red: 255 / 255, green: 195 / 255, blue: 18 / 255, alpha: 1)
            let attributedInitialArrivalString: NSMutableAttributedString =  NSMutableAttributedString(string: initialArrivarlTimeLabel.text ?? "")
            attributedInitialArrivalString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedInitialArrivalString.length))
            initialArrivarlTimeLabel.attributedText = attributedInitialArrivalString
            let attributedInitialDepartureString: NSMutableAttributedString =  NSMutableAttributedString(string: initialDepartureTimeLabel.text ?? "")
            attributedInitialDepartureString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedInitialDepartureString.length))
            initialDepartureTimeLabel.attributedText = attributedInitialDepartureString
            
            actualArrivalTimeLabel.textColor = UIColor(red: 234 / 255, green: 32 / 255, blue: 39 / 255, alpha: 1)
            actualDepartureTimeLabel.textColor = UIColor(red: 234 / 255, green: 32 / 255, blue: 39 / 255, alpha: 1)
        case .onTime:
            passStatusLabel.text = "ON TIME"
            passStatusLabel.textColor = .white
            passStatusLabel.backgroundColor = UIColor(red: 0 / 255, green: 148 / 255, blue: 50 / 255, alpha: 1)
        default:
            fatalError()
        }
    }
    
    func addPickupInfo(model: PickupContactViewModel) {
        pickupView.removeFromSuperview()
        pickupView = PickupContactView()
        addSubview(pickupView)
        pickupView.snp.remakeConstraints { (make) in
            make.top.equalTo(separatorLine).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        (pickupView as! PickupContactView).configure(model: model)
    }
    //MARK: -
    
    //MARK: - PRIVATE METHODS
    private func configurePassStatusLaabel() {
        addSubview(passStatusLabel)
        passStatusLabel.snp.makeConstraints { (make) in
            make.height.equalTo(25)
            make.leading.trailing.top.equalToSuperview()
        }
        passStatusLabel.font = UIFont(name: "EncodeSans-Bold", size: 10)
        passStatusLabel.textAlignment = .center
        passStatusLabel.layer.cornerRadius = 5
        passStatusLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        passStatusLabel.clipsToBounds = true
    }
    
    private func configureInitialDepartureTimeLabel() {
        addSubview(initialDepartureTimeLabel)
        initialDepartureTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passStatusLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(12)
        }
        initialDepartureTimeLabel.font = UIFont(name: "EncodeSans-Regular", size: 10)
        initialDepartureTimeLabel.textAlignment = .left
    }
    
    private func configureInitialArrivalTimeLabel() {
        addSubview(initialArrivarlTimeLabel)
        initialArrivarlTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(initialDepartureTimeLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(initialDepartureTimeLabel.snp.height)
        }
        initialArrivarlTimeLabel.textAlignment = .right
        initialArrivarlTimeLabel.font = UIFont(name: "EncodeSans-Regular", size: 10)
    }
    
    private func configureActualDepartureTimeLabel() {
        addSubview(actualDepartureTimeLabel)
        actualDepartureTimeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(initialDepartureTimeLabel.snp.leading)
            make.top.equalTo(initialDepartureTimeLabel.snp.bottom)
            make.height.equalTo(25)
        }
        actualDepartureTimeLabel.font = UIFont(name: "EncodeSans-Bold", size: 20)
        actualDepartureTimeLabel.textAlignment = .left
    }
    
    private func configureActualArrivaalTimeLabel() {
        addSubview(actualArrivalTimeLabel)
        actualArrivalTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(actualDepartureTimeLabel.snp.centerY)
            make.trailing.equalTo(initialArrivarlTimeLabel.snp.trailing)
            make.height.equalTo(actualDepartureTimeLabel.snp.height)
        }
        actualArrivalTimeLabel.font = UIFont(name: "EncodeSans-Bold", size: 20)
        actualArrivalTimeLabel.textAlignment = .right
    }
    
    private func configureDepartureAirportCodeLabel() {
        addSubview(departureAirportCodeLabel)
        departureAirportCodeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(actualDepartureTimeLabel.snp.leading)
            make.top.equalTo(actualDepartureTimeLabel.snp.bottom)
            make.height.equalTo(25)
        }
        departureAirportCodeLabel.font = UIFont(name: "EncodeSans-Light", size: 20)
        departureAirportCodeLabel.textAlignment = .left
    }
    
    private func configureArrivalAirportCodeLabel() {
        addSubview(arrivalAirportCodeLabel)
        arrivalAirportCodeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(actualArrivalTimeLabel.snp.trailing)
            make.centerY.equalTo(departureAirportCodeLabel.snp.centerY)
            make.height.equalTo(departureAirportCodeLabel.snp.height)
        }
        arrivalAirportCodeLabel.font = UIFont(name: "EncodeSans-Light", size: 20)
        arrivalAirportCodeLabel.textAlignment = .right
    }
    
    private func configureDepartureAirportTitleLaabel() {
        addSubview(departureAirportTitleLabel)
        departureAirportTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(departureAirportCodeLabel.snp.bottom)
            make.leading.equalTo(departureAirportCodeLabel.snp.leading)
            make.height.equalTo(16)
        }
        departureAirportTitleLabel.font = UIFont(name: "EncodeSans-Light", size: 13)
        departureAirportTitleLabel.textAlignment = .left
    }
    
    private func configureArrivalAirportTitleLabel() {
        addSubview(arrivalAirportTitleLabel)
        arrivalAirportTitleLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(arrivalAirportCodeLabel.snp.trailing)
            make.centerY.equalTo(departureAirportTitleLabel.snp.centerY)
            make.height.equalTo(departureAirportTitleLabel.snp.height)
            make.leading.greaterThanOrEqualTo(departureAirportTitleLabel.snp.trailing).inset(5)
        }
        arrivalAirportTitleLabel.font = UIFont(name: "EncodeSans-Light", size: 13)
        arrivalAirportTitleLabel.textAlignment = .right
    }
    
    private func configureTransportTypeIcon() {
        addSubview(transportTypeIcon)
        transportTypeIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.top.equalTo(passStatusLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        transportTypeIcon.contentMode = .scaleAspectFit
    }
    
    private func configurePassNumber() {
        addSubview(passNumber)
        passNumber.snp.makeConstraints { (make) in
            make.top.equalTo(transportTypeIcon.snp.bottom).offset(5)
            make.height.equalTo(12)
            make.centerX.equalToSuperview()
        }
        passNumber.font = UIFont(name: "EncodeSans-Regular", size: 10)
    }
    
    private func configureSeparatorLine() {
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(arrivalAirportTitleLabel.snp.bottom).offset(10)
            make.height.equalTo(2)
        }
        separatorLine.backgroundColor = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
    }
    
    private func configurePickupView() {
        pickupView = RequestPickUpView()
        addSubview(pickupView)
        pickupView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLine).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    //MARK: -
}
