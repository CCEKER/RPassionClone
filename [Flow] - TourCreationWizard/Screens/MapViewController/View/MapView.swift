//
//  MapView.swift
//  TourApp
//
//  Created by Cagatay Ceker on 16.03.2024.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIView, CLLocationManagerDelegate, MKMapViewDelegate {
    
    private let locationManager = CLLocationManager()
    private var previousLocation: CLLocation?
    
    private let pinIcon: UIImageView = {
        let view = UIImageView(image: UIImage(named: "location"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsUserLocation = true
        return view
    }()
    
    private let addressLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let checkAddressButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 3
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setupLocationManager()
        let istanbulCoordinate = CLLocationCoordinate2D(latitude: 41.035689, longitude: 28.9119)
        centerViewOnUserLocation(CLLocation(latitude: istanbulCoordinate.latitude, longitude: istanbulCoordinate.longitude))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .background
        addSubview(mapView)
        mapView.addSubview(pinIcon)
        addSubview(addressLabel)
        addSubview(checkAddressButton)
        mapView.delegate = self
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            pinIcon.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            pinIcon.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
            pinIcon.heightAnchor.constraint(equalToConstant: 52),
            pinIcon.widthAnchor.constraint(equalToConstant: 52),
            
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            
            checkAddressButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            checkAddressButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            checkAddressButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            checkAddressButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func centerViewOnUserLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 100
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            previousLocation = getCenterLocation(for: mapView)
        }
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation =  self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self else { return }
            if let _ = error {
                // show alert informing the user
                return
            }
            guard let placemark = placemarks?.first else {
                // show alert informing the user
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}
