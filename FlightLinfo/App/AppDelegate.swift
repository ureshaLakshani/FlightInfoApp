//
//  AppDelegate.swift
//  FlightLinfo
//
//  Created by Uresha Lakshani on 2022-04-23.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            let BackImage = UIImage(named: "backBtn")
           
            // background color
            appearance.backgroundColor = .white
            appearance.shadowColor = .clear
            
            // bar button styling
            let barButtonItemApperance = UIBarButtonItemAppearance()
            //remove back button title
            barButtonItemApperance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
            appearance.backButtonAppearance = barButtonItemApperance
            //set back button image
            appearance.setBackIndicatorImage(BackImage, transitionMaskImage: BackImage)
            
            // set the navigation bar appearance to the color we have set above
            UINavigationBar.appearance().standardAppearance = appearance
            
            // when the navigation bar has a neighbouring scroll view item (eg: scroll view, table view etc)
            // the "scrollEdgeAppearance" will be used
            // by default, scrollEdgeAppearance will have a transparent background
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            

        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func configureWindowAndMakeVisible(rootVC: UIViewController) {
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                window.rootViewController = rootVC
                window.makeKeyAndVisible()
          }
      }


}

