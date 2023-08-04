import SwiftUI
import Firebase

@main
struct Fight_Fitness_WorkoutsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        //configures firebase with app
        FirebaseApp.configure()
        
        return true
    }
    
}
