//
//  AppDelegate.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 10/29/22.
//

import UIKit

// TODO: Pt 1 - Import Parse Swift
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // TODO: Pt 1 - Initialize Parse SDK
        // https://github.com/parse-community/Parse-Swift/blob/main/ParseSwift.playground/Sources/Common.swift
        
        // load api keys from file ignored with .gitignore
        let path = Bundle.main.path(forResource: "api_keys", ofType: "plist")!
        let xml = FileManager.default.contents(atPath: path)!
        let apiKeys = try? PropertyListDecoder().decode(ApiKeys.self, from: xml)

        
        let appID = apiKeys!.appID
        let clientKey = apiKeys!.clientKey
        let serverURL = URL(string: "https://parseapi.back4app.com")
        
        ParseSwift.initialize(applicationId: appID, clientKey: clientKey, serverURL: serverURL!)
        
        
        // TODO: Pt 1: - Instantiate and save a test parse object to your server
        // https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/1%20-%20Your%20first%20Object.xcplaygroundpage/Contents.swift#L121
            
        let testParseBackend = false //Instead of commenting out the code I just made it condtional.
        if testParseBackend {
            var score = GameScore()
            score.playerName = "Kingsly"
            score.points = 13
            
            score.save {
                result in
                switch result {
                case . success(let savedScore):
                    print("Parse Obj saved: Player: \(String(describing: savedScore.playerName)), Score: \(String(describing: savedScore.points))")
                case .failure(let error):
                    assertionFailure("Error saving \(error)")
                }
            }
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
}

// TODO: Pt 1 - Create Test Parse Object
// https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/1%20-%20Your%20first%20Object.xcplaygroundpage/Contents.swift#L33

struct GameScore: ParseObject {
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    var playerName: String?
    var points: Int?
}

extension GameScore {
    init(playerName: String, points: Int) {
        self.playerName = playerName
        self.points = points
    }
}


struct ApiKeys: Codable {
    var appID:String
    var clientKey:String
}
