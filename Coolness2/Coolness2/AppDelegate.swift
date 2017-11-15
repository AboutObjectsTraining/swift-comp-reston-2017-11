import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CoolViewController(nibName: "CoolStuff", bundle: nil)
        window?.backgroundColor = UIColor.lightGray
        window?.makeKeyAndVisible()
    }
}
