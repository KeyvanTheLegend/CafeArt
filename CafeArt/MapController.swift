//
//  MapController.swift
//  CafeArt
//
//  Created by Apple on 6/6/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import GoogleMaps

class MapController: UIViewController, GMSMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var imageVw: UIImageView!
    
    
    var long : Double?
    var lat1 : Double?
    private let locationManager = CLLocationManager()
    let googlemapsearchkey = "AIzaSyCSWmjGM6gXpV5mwg_PlsP1SmcKHMksqu0"
    var sourcelat = 23.03
    var sourcelong = 72.55
    var rect = GMSPolyline()
    @IBOutlet fileprivate weak var mapView: GMSMapView!
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
       // print("HI")
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2D(latitude:  36.562315, longitude: 53.075982)
        marker.icon = self.imageWithImage(image: UIImage(named: "Group 211")!, scaledToSize: CGSize(width: 55, height:65))

        marker.title = "Cafe Honar"
        marker.snippet = "Sari"
        marker.map = mapView
        //print(location.coordinate)
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude:  36.562315, longitude: 53.075982), zoom: 15, bearing: 0, viewingAngle: 0)
        lat1 = location.coordinate.latitude
        long = location.coordinate.longitude
        locationManager.stopUpdatingLocation()
    }
    var x = false
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setting gradient
        if(!x){
            x = true
            let Colors = Coloros.init()
            
            imageVw.setGradientBackground(colorOne: Colors.title_start_color, colorTwo: Colors.title_end_color,colorThree: Colors.title_end_color)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        getPolylineRoute(from: CLLocationCoordinate2D(latitude:  36.555383387055763, longitude:  53.071229439278198),to: CLLocationCoordinate2D(latitude: 36.593693, longitude: 53.063637))

        
        
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    @IBAction func backp(_ sender: Any) {
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        /*
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary{
                        
                        //let routes = json["routes"] as! NSArray
                        //print(routes)
                       // let arryleg = (routes[0] as! NSDictionary).object(forKey: "legs") as! NSArray
                        //let arrysteps = arryleg[0] as! NSDictionary
                        print("HI334")
                        print(json)
                        DispatchQueue.global(qos: .background).async {
                            let array = json["routes"] as! NSArray
                            let dic = array[0] as! NSDictionary
                            let dic1 = dic["overview_polyline"] as! NSDictionary
                            let points = dic1["points"] as! String
                            print(array)
                            DispatchQueue.main.async {
                               let path = GMSPath(fromEncodedPath: points)
                                self.rect.map=nil
                                self.rect = GMSPolyline(path: path)
                                self.rect.strokeWidth = 4
                                self.rect.strokeColor = UIColor.red
                                self.rect.map = self.mapView
                            }
                        }
                        //Call this method to draw path on map
                      //  self.showPath(polyStr: polyString!)
                    }
                    
                }catch{
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()*/
    }
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView // Your map view
    }
}
