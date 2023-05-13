import UIKit
import Flutter
import GoogleMaps
import MapKit



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCPfHHjL9-hpzEtZe3bFPcuSmCFD5feun0")
      
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let locationChannel = FlutterMethodChannel(name: "samples.flutter.dev/location",
                                                    binaryMessenger: controller.binaryMessenger)
     locationChannel.setMethodCallHandler({
         [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            // Handle battery messages.
        
         
         guard call.method == "getlocation" else {
            result(FlutterMethodNotImplemented)
            return
          }
            receiveLoca(result: result)
        
          })

      
      
    

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
private func receiveLoca(result: FlutterResult) {
    let pmobj = mylocationPM()
    if #available(iOS 14.0, *) {
        var loc = pmobj.checkIfLocationServicesEnabled()
        print("channnel called")
        
        result( loc )
        
    } else {
        // Fallback on earlier versions
        result(FlutterError(code: "UNAVAILABLE",
                                message: "location not available.",
                                details: nil))
    }
//
//  let device = UIDevice.current
//  device.isBatteryMonitoringEnabled = true
//  if device.batteryState == UIDevice.BatteryState.unknown {
//    result(FlutterError(code: "UNAVAILABLE",
//                        message: "Battery level not available.",
//                        details: nil))
//  } else {
//    result(Int(device.batteryLevel * 100))
//  }
}

 final class mylocationPM :NSObject , CLLocationManagerDelegate{
    
     var lat = ""
     var long = ""
    var locationManager = CLLocationManager()
    
    func checkIfLocationServicesEnabled() -> String{
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            if let lat =  locationManager.location?.coordinate.latitude {
              
                if let long =  locationManager.location?.coordinate.longitude {
                     
                    
                    return String( lat ) + ":"  + String(  long )
                }
                
            }
            
            
            
            
          
            
        }else {
            if #available(iOS 14.0, *) {
                checkLocAuthorisation()
            } else {
                // Fallback on earlier versions
                 
            }
            print("location services are off")
            return ""
        }
        return ""
        
    }
    
     @available(iOS 14.0, *)
     @available(iOS 14.0, *)
     func checkLocAuthorisation() {
   
        switch locationManager.authorizationStatus {
       
         
            
        case .notDetermined: //ask for permisson
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted ")
        case .denied:
            print("denied needs to be changed in app settings")
        case .authorizedAlways,
          .authorizedWhenInUse:
            print("Location permission are succesfull")
            break
        @unknown default:
            break
        }

        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            checkLocAuthorisation()
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
}


