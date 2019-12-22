//
//  ViewController.swift
//  Test App
//
//  Created by Alex P on 22/12/2019.
//  Copyright © 2019 Alex Perov. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    //MARK: - PUBLIC VARIAABLES
    var coordinator: MainCoordinator
    //MARK: -
    
    //MARK: - PRIVATE VARIAABLES
    private lazy var homePageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(QuickActionCollectionViewCell.self,
                                forCellWithReuseIdentifier: "QuickAction")
        collectionView.register(AirportTitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: "AirportTitle")
        collectionView.register(BoardingPassCollectionViewCell.self,
                                forCellWithReuseIdentifier: "BoardingPass")
        collectionView.register(HomePageCollectionViewHeader.self,
                                forSupplementaryViewOfKind: "Header", withReuseIdentifier: "Header")
        return collectionView
    }()
    
    private var quickActions = [QuickActionViewModel(icon: #imageLiteral(resourceName: "car"),
                                                     title: "Plan Commute"),
                                QuickActionViewModel(icon: #imageLiteral(resourceName: "pickup"),
                                                     title: "Pickup"),
                                QuickActionViewModel(icon: #imageLiteral(resourceName: "luggage"),
                                                     title: "Luggage Tag")]
    
    private var boardingPasses = [BoardingPassViewModel(transportType: .airplane,
                                                        passStatus: .gateChanged,
                                                        passNumber: "AF1234",
                                                        initialDepartureTime: Date(),
                                                        initialArrivarlTime: Date(),
                                                        actualDepartureTime: Date(),
                                                        actualArrivalTime: Date(),
                                                        departureAirportCode: "AMS",
                                                        arrivalAirportCode: "PEK",
                                                        departureAirportTitle: "Amsterdam Schiphol",
                                                        arrivalAirportTitle: "Beijing Capital Int’",
                                                        pickupContact: PickupContactViewModel(name: "Mrs Maggie Eisenhower",
                                                                                              photo: #imageLiteral(resourceName: "person"),
                                                                                              phone: "+31 4728 4492")),
                                  BoardingPassViewModel(transportType: .airplane,
                                                        passStatus: .onTime, passNumber: "EK992",
                                                        initialDepartureTime: Date(),
                                                        initialArrivarlTime: Date(),
                                                        actualDepartureTime: Date(),
                                                        actualArrivalTime: Date(),
                                                        departureAirportCode: "PVG",
                                                        arrivalAirportCode: "LHR",
                                                        departureAirportTitle: "Shanghai Pudong",
                                                        arrivalAirportTitle: "London Heathrow",
                                                        pickupContact: nil),
                                  BoardingPassViewModel(transportType: .airplane,
                                                        passStatus: .gateChanged,
                                                        passNumber: "AF1234",
                                                        initialDepartureTime: Date(),
                                                        initialArrivarlTime: Date(),
                                                        actualDepartureTime: Date(),
                                                        actualArrivalTime: Date(),
                                                        departureAirportCode: "AMS",
                                                        arrivalAirportCode: "PEK",
                                                        departureAirportTitle: "Amsterdam Schiphol",
                                                        arrivalAirportTitle: "Beijing Capital Int’",
                                                        pickupContact: PickupContactViewModel(name: "Mrs Maggie Eisenhower",
                                                                                              photo: #imageLiteral(resourceName: "person"),
                                                                                              phone: "+31 4728 4492")),
                                  BoardingPassViewModel(transportType: .airplane,
                                                        passStatus: .onTime,
                                                        passNumber: "EK992",
                                                        initialDepartureTime: Date(),
                                                        initialArrivarlTime: Date(),
                                                        actualDepartureTime: Date(),
                                                        actualArrivalTime: Date(),
                                                        departureAirportCode: "PVG",
                                                        arrivalAirportCode: "LHR",
                                                        departureAirportTitle: "Shanghai Pudong",
                                                        arrivalAirportTitle: "London Heathrow",
                                                        pickupContact: nil)]
    
    private var airportsNearby = [AirportTitleViewModel(code: "TXL",
                                                        title: "Berlin-Tegel"),
                                  AirportTitleViewModel(code: "SXF",
                                                        title: "Schönefeld"),
                                  AirportTitleViewModel(code: "HAM",
                                                        title: "Hamburg"),
                                  AirportTitleViewModel(code: "HAJ",
                                                        title: "Hannover"),
                                  AirportTitleViewModel(code: "BRE",
                                                        title: "Bremen")]
    
    private var numberOfHomePageSections = 3
    private var searchController = UISearchController(searchResultsController: nil)
    //MARK: -
    
    //MARK: - INIT
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder init is not supported for ")
    }
    //MARK: -
    
    //MARK: - VC LIFECYCLE
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureNavigationBar()
        configureSearchController()
    }
    //MARK: -

    //MARK: - PRIVATE METHODS
    private func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    private func configureCollectionView() {
        view.addSubview(homePageCollectionView)
        homePageCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func configureNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationItem.title = "home"
        
        let gradient = CAGradientLayer()
        var bounds = navigationBar?.bounds
        bounds?.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds ?? .zero
        gradient.colors = [UIColor(red: 0, green: 90 / 255, blue: 246 / 255, alpha: 1).cgColor, UIColor(red: 1 / 255, green: 65 / 255, blue: 176 / 255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        if let image = getImageFrom(gradientLayer: gradient) {
            let app = UINavigationBarAppearance()
            app.backgroundImage = image // the gradient image
            app.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                       NSAttributedString.Key.font: UIFont(name: "EncodeSans-Black", size: 30)]
            self.navigationController?.navigationBar.scrollEdgeAppearance = app
            self.navigationController?.navigationBar.standardAppearance = app
        }
    }
    
    private func configureSearchController() {
        searchController.searchBar.placeholder = "Enter Flight Numbers or Airports"
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.searchTextField.layer.masksToBounds = false

        navigationItem.searchController = searchController
    }
    //MARK: -
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfHomePageSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return quickActions.count
        case 1:
            return boardingPasses.count
        case 2:
            return airportsNearby.count
        default:
            fatalError("Unexpected section in collection view")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HomePageCollectionViewHeader
        switch indexPath.section {
        case 0:
            view?.label.text = "Quick Actions"
        case 1:
            view?.label.text = "Following"
        case 2:
            view?.label.text = "Airports nearby"
        default:
            fatalError("Unexpected section in collection view")
        }
        
        return view ?? UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickAction", for: indexPath) as? QuickActionCollectionViewCell
            let model = quickActions[indexPath.row]
            cell?.configure(model: model)
            
            return cell ?? UICollectionViewCell()
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardingPass", for: indexPath) as? BoardingPassCollectionViewCell
            let model = boardingPasses[indexPath.row]
            cell?.configure(model: model)
            if let contactInfo = model.pickupContact {
                cell?.addPickupInfo(model: contactInfo)
            }
            
            return cell ?? UICollectionViewCell()
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirportTitle", for: indexPath) as? AirportTitleCollectionViewCell
            let model = airportsNearby[indexPath.row]
            cell?.configure(model: model)
            
            return cell ?? UICollectionViewCell()
        default:
            fatalError("Unxepected section in collection view")
        }
    }
}
//MARK: -
//MARK: - COLLECTIONVIEW LAYOUT
extension HomeViewController {
    private func createQuickEventsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(103))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5.5, bottom: 0, trailing: 5.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(173),
                                               heightDimension: .absolute(103))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: "Header", alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5.5, bottom: 0, trailing: 5.5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
        
        return section
    }
    
    private func createFollowingEventsScetion() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(193))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: "Header", alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5.5, bottom: 0, trailing: 5.5)
        
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createNearbyAirportsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(113))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5.5, bottom: 10, trailing: 5.5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(113))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitem: item, count: 2)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: "Header", alignment: .top)
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5.5, bottom: 0, trailing: 5.5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (section, environment) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                return self.createQuickEventsSection()
            case 1:
                return self.createFollowingEventsScetion()
            case 2:
                return self.createNearbyAirportsSection()
            default:
                fatalError("Unexpected section in collection view")
            }
        }
        
        return layout
    }
}
//MARK: -
