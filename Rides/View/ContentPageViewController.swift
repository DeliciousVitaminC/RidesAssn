//
//  ContentPageViewController.swift
//  Rides
//
//  Created by zhaohe on 2023-01-30.
//

import UIKit

class ContentPageViewController: UIPageViewController {
    private var selectedVehicle : VehicleModel?
    var pages : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let vc1 = storyboard?.instantiateViewController(withIdentifier: Constants.page01Id) else{
            fatalError()
        }
        guard let vc2 = storyboard?.instantiateViewController(withIdentifier: Constants.page02Id) else {
            fatalError()
        }
        let vcc1 = vc1 as! Page01ViewController
        let vcc2 = vc2 as! Page02ViewController
        if vcc1.initData(with: selectedVehicle?.getVehicleInfo()) && vcc2.initData(with: selectedVehicle?.getCarbonEmission()){
            pages.append(vcc1)
            pages.append(vcc2)
        }
        dataSource = self
        setViewControllers([pages[0]], direction: .forward, animated: true)
    }
    
    func selectVehicle(for vehicle : VehicleModel){
        self.selectedVehicle = vehicle
    }
}

extension ContentPageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else{
            fatalError()
        }
        if currentIndex == 0{
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            fatalError()
        }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}
