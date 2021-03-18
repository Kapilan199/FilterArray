//
//  PhysicianController.swift
//  Got Pain
//
//  Created by Kapilan Ramasamy on 3/18/21.
//  Copyright © 2021 Health Attributes. All rights reserved.
//


//2. In viewcontroller can you import the “coreLocation framework”
import CoreLocation
import UIKit
import GoogleMaps
import Canvas
import GooglePlaces

class PhysicianController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    lazy var symbolHoldingView: UIView = {
         let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
           view.translatesAutoresizingMaskIntoConstraints = false
              return view
     }()
    
    
    var lblName1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)
       
        return label
    }()
    
    var lblAddress1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)
     
        return label
    }()
    
    
    var lblLatitude1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)
      
        return label
    }()
    
    
    var lblLongitude1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)

        return label
    }()
    
    
    var long:Double?
    
    var lat:Double?
    
    
    var _placesClient = GMSPlacesClient()

    
    let placesClient = GMSPlacesClient.shared()
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        getCurrentAddress()
        
        guard let lat = lat else {
            return
        }
        
        guard let long = long else {
            return
        }
        
  
        
        
        
 let fromLocation:CLLocation = CLLocation(latitude: 24.186965, longitude: 120.593158)
        
 var places:[Places] = [

Places( title: "Title1",
cllocation: CLLocation( latitude :24.181143, longitude: 120.593158), regionRadius: 300.0, location: "LocationTitle1",
type: "Food",distance : CLLocation( latitude :24.181143,
                                    longitude: 120.593158).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.181143,120.593158)),

Places( title: "Title2",
cllocation: CLLocation(latitude:24.14289,longitude:120.679901), regionRadius:150.0, location:"LocationTitle2",
type: "Food",distance : CLLocation(latitude:24.14289,
                                   longitude:120.679901).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.14289,120.679901)),
 
Places( title: "Title3",
cllocation: CLLocation(latitude : 24.180407, longitude:120.645086), regionRadius: 300.0, location:"LocationTitle3",
type: "Food",distance : CLLocation(latitude : 24.180407,
                                   longitude:120.645086).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.180407,120.645086)),
 
Places( title: "Title4",
cllocation: CLLocation(latitude: 24.149062,longitude:120.684891),
regionRadius: 300.0, location: "LocationTitle4",
type: "Food",distance : CLLocation(latitude: 24.149062,
                                   longitude:120.684891).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.149062,120.684891)),

    Places( title: "Title5", cllocation: CLLocation(latitude:24.138598,longitude:120.672096 ), regionRadius:150.0, location:"LocationTitle5",type: "Food",distance : CLLocation(latitude:24.138598,longitude:120.672096 ).distance(from: fromLocation),coordinate : CLLocationCoordinate2DMake(24.138598,120.672096)),

Places( title: "Title6",
cllocation: CLLocation(latitude :24.1333434,longitude:120.680744), regionRadius:100.0, location:"LocationtTitle6",
type: "Culture",distance : CLLocation(latitude :24.1333434,
                                      longitude:120.680744).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.1333434,120.680744))
            
        ]

        //Before sort the array
        for k in 0...(places.count-1) {
            print("\(String(describing: places[k].distance))")
        }
        
//sort the array based on the current location to calculate the distance to compare the each and every array objects to sort the values
        for place in places {
            place.calculateDistance(fromLocation: fromLocation) // Replace YOUR_LOCATION with the location you want to calculate the distance to.
        }
        
        
        places.sortInPlace(by: { $0.distance! < $1.distance! })
         //after sort the array
        for n in 0...(places.count-1) {
            print("\(String(describing: places[n].distance))")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getCurrentAddress()
    {
        _placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
          //      self.viewContainer.isHidden = true
                return
            }
           // self.viewContainer.isHidden = false
            
            self.lblName1.text = "No current place"
            self.lblAddress1.text = "kkk"
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                 self.lblName1.text = place.name
                    self.lblAddress1.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                    self.lblLatitude1.text = String(place.coordinate.latitude)
                    self.lblLongitude1.text = String(place.coordinate.longitude)
                    self.lat = place.coordinate.latitude
                    self.long = place.coordinate.longitude
                }
            }
        })
    }
    
    func configureViewComponents() {
        
        view.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        
        view.addSubview(symbolHoldingView)
        symbolHoldingView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 50, paddingBottom: 100, paddingRight: 50, width: 180 * (UIScreen.main.bounds.size.width) / 414.0, height: 380 * (UIScreen.main.bounds.size.height) / 896.0)
        
        
        symbolHoldingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
              view.addSubview(lblName1)
              lblName1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 60, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
              
              view.addSubview(lblAddress1)
              lblAddress1.anchor(top: lblName1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
              
              view.addSubview(lblLatitude1)
              lblLatitude1.anchor(top: lblAddress1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
              
              view.addSubview(lblLongitude1)
              lblLongitude1.anchor(top: lblLatitude1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
              
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




import Foundation
import CoreLocation


final public class Places : NSObject  {
    var title: String?
    var cllocation: CLLocation
    var regionRadius: Double
    var location: String?
    var type: String?
    var distance : Double?
    var coordinate : CLLocationCoordinate2D
    
    init(title:String ,
    cllocation: CLLocation ,
    regionRadius: Double,
    location: String,
    type: String ,
    distance:Double!,
    coordinate: CLLocationCoordinate2D){
        self.title = title
        self.cllocation = cllocation
        self.coordinate = coordinate
        self.regionRadius = regionRadius
        self.location = location
        self.type = type
        self.distance = distance
    }
    
    
    // Function to calculate the distance from
    // given location (current Location).

    func calculateDistance(fromLocation: CLLocation?) {
        distance = cllocation.distance(from: fromLocation!)
    }// calculate the distance based on the current location
}







//
//  PhysicianController.swift
//  Got Pain
//
//  Created by Kapilan Ramasamy on 3/18/21.
//  Copyright © 2021 Health Attributes. All rights reserved.
//
/*

//2. In viewcontroller can you import the “coreLocation framework”
import CoreLocation
import UIKit
import GoogleMaps
import Canvas
import GooglePlaces

class PhysicianController: UIViewController {
    
    
    lazy var symbolHoldingView: UIView = {
         let view = UIView()
      //  view.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
           view.translatesAutoresizingMaskIntoConstraints = false
              return view
     }()
  
    
    var lblName1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)
       
        return label
    }()
    
    var lblAddress1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
     //   label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)
     
        return label
    }()
    
    
    var lblLatitude1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
     //   label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)
      
        return label
    }()
    
    
    var lblLongitude1: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
   //     label.backgroundColor = UIColor(red: 255, green: 255, blue: 0, alpha: 1)

        return label
    }()
    
    
    var long:Double?
    
    var lat:Double?
    
    
    var _placesClient = GMSPlacesClient()

    
    let placesClient = GMSPlacesClient.shared()
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()

        guard let lat = lat else {
            return
        }
        
        guard let long = long else {
            return
        }
        
        view.backgroundColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
        let fromLocation:CLLocation = CLLocation(latitude: lat, longitude: long)
        
 var places:[Places] = [

Places( title: "Title1",
cllocation: CLLocation( latitude :24.181143, longitude: 120.593158), regionRadius: 300.0, location: "LocationTitle1",
type: "Food",distance : CLLocation( latitude :24.181143,
                                    longitude: 120.593158).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.181143,120.593158)),

Places( title: "Title2",
cllocation: CLLocation(latitude:24.14289,longitude:120.679901), regionRadius:150.0, location:"LocationTitle2",
type: "Food",distance : CLLocation(latitude:24.14289,
                                   longitude:120.679901).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.14289,120.679901)),
 
Places( title: "Title3",
cllocation: CLLocation(latitude : 24.180407, longitude:120.645086), regionRadius: 300.0, location:"LocationTitle3",
type: "Food",distance : CLLocation(latitude : 24.180407,
                                   longitude:120.645086).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.180407,120.645086)),
 
Places( title: "Title4",
cllocation: CLLocation(latitude: 24.149062,longitude:120.684891),
regionRadius: 300.0, location: "LocationTitle4",
type: "Food",distance : CLLocation(latitude: 24.149062,
                                   longitude:120.684891).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.149062,120.684891)),

    Places( title: "Title5", cllocation: CLLocation(latitude:24.138598,longitude:120.672096 ), regionRadius:150.0, location:"LocationTitle5",type: "Food",distance : CLLocation(latitude:24.138598,longitude:120.672096 ).distance(from: fromLocation),coordinate : CLLocationCoordinate2DMake(24.138598,120.672096)),

Places( title: "Title6",
cllocation: CLLocation(latitude :24.1333434,longitude:120.680744), regionRadius:100.0, location:"LocationtTitle6",
type: "Culture",distance : CLLocation(latitude :24.1333434,
                                      longitude:120.680744).distance(from: fromLocation),
coordinate : CLLocationCoordinate2DMake(24.1333434,120.680744))
            
        ]

        //Before sort the array
        for k in 0...(places.count-1) {
            print("\(places[k].distance)")
        }
        
//sort the array based on the current location to calculate the distance to compare the each and every array objects to sort the values
        for place in places {
            place.calculateDistance(fromLocation: fromLocation) // Replace YOUR_LOCATION with the location you want to calculate the distance to.
        }
        
        
        places.sort(by: { $0.distance! < $1.distance! })
         //after sort the array
        for n in 0...(places.count-1) {
            print("\(places[n].distance)")
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func getCurrentAddress()
    {
        _placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
          //      self.viewContainer.isHidden = true
                return
            }
           // self.viewContainer.isHidden = false
            
            self.lblName1.text = "No current place"
            self.lblAddress1.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                 self.lblName1.text = String(place.name!)
                    self.lblAddress1.text = place.formattedAddress?.components(separatedBy: ", ")
                        .joined(separator: "\n")
                    self.lblLatitude1.text = String(place.coordinate.latitude)
                    self.lblLongitude1.text = String(place.coordinate.longitude)
                    self.lat = place.coordinate.latitude
                    self.long = place.coordinate.longitude
                }
            }
        })
    }
    
    
    
    
    
    
    func configureViewComponents() {
        
        view.addSubview(symbolHoldingView)
        symbolHoldingView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 50, paddingBottom: 100, paddingRight: 50, width: 180 * (UIScreen.main.bounds.size.width) / 414.0, height: 380 * (UIScreen.main.bounds.size.height) / 896.0)
        
        
        symbolHoldingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
        
  //      view.addSubview(lblName1)
        //lblName1.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
        
    //    view.addSubview(lblAddress1)
      //  lblAddress1.anchor(top: lblName1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
        
       // view.addSubview(lblLatitude1)
       // lblLatitude1.anchor(top: lblAddress1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
        
      //  view.addSubview(lblLongitude1)
       // lblLongitude1.anchor(top: lblLatitude1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 6, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50 * (UIScreen.main.bounds.size.height) / 896.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
import Foundation
import CoreLocation


final public class Places : NSObject  {
    var title: String?
    var cllocation: CLLocation
    var regionRadius: Double
    var location: String?
    var type: String?
    var distance : Double?
    var coordinate : CLLocationCoordinate2D
    
    init(title:String ,
    cllocation: CLLocation ,
    regionRadius: Double,
    location: String,
    type: String ,
    distance:Double!,
    coordinate: CLLocationCoordinate2D){
        self.title = title
        self.cllocation = cllocation
        self.coordinate = coordinate
        self.regionRadius = regionRadius
        self.location = location
        self.type = type
        self.distance = distance
    }
    
    
    // Function to calculate the distance from
    // given location (current Location).

    func calculateDistance(fromLocation: CLLocation?) {
        distance = cllocation.distance(from: fromLocation!)
    }// calculate the distance based on the current location
}
*/
