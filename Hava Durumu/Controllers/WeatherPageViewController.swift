//
//  WeatherContainerViewController.swift
//  Hava Durumu
//
//  Created by Onur Sir on 14.02.2023.
//

import UIKit
import CoreLocation

class WeatherPageViewController: UIPageViewController {
    
    enum Appearance: Int {
        case daily
        case weekly
    }
    
    // MARK: - UI Elements
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var dailyViewController: DailyViewController = {
        return storyboard!.instantiateViewController(identifier: "DailyViewController")
    }()
    
    lazy var weeklyViewController: WeeklyViewController = {
        return storyboard!.instantiateViewController(identifier: "WeeklyViewController")
    }()
    
    var managedControllers: [UIViewController] {
        return [dailyViewController, weeklyViewController]
    }
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var currentAppearance: Appearance = .daily
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestLocation()
        
        updateCurrentController(animated: false)
    }
    
    // MARK: - Functions
    func updateCurrentController(animated: Bool) {
        switch currentAppearance {
        case .daily:
            setViewControllers([dailyViewController], direction: .reverse, animated: animated, completion: nil)
        case .weekly:
            setViewControllers([weeklyViewController], direction: .forward, animated: animated, completion: nil)
        }
    }
    
    // MARK: Actions
    @IBAction func segmentedControlValueChanged(_ segmentedControl: UISegmentedControl) {
        if let newAppearance = Appearance(rawValue: segmentedControl.selectedSegmentIndex) {
            currentAppearance = newAppearance
            updateCurrentController(animated: true)
        }
    }
}

extension WeatherPageViewController: CLLocationManagerDelegate {
    
    // MARK: - Functions
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Uygulaman??n konum servislerini kullanma yetkisi yok.")
        case .denied:
            print("Kullan??c??, uygulama i??in konum servislerinin kullan??m??n?? reddetti veya Ayarlar'da genel olarak devre d?????? b??rak??ld??.")
        case .authorizedAlways:
            print("Kullan??c??, istedi??i zaman konum hizmetini ba??latmas?? i??in uygulamaya izin verdi.")
        case .authorizedWhenInUse:
            print("Kullan??c??, uygulamadayken konum servislerini ba??latmas??na izi verdi.")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCoordinate = locations.first?.coordinate {
            let weatherProvider = WeatherProvider()
            
            weatherProvider.getWeather(for: myCoordinate) { (weather) in
                guard let weather = weather else { return }
                
                self.dailyViewController.updateUI(with: weather)
                self.weeklyViewController.weather = weather
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
