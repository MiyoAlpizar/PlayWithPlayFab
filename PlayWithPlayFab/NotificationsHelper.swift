//
//  NotificationsHelper.swift
//  PlayWithPlayFab
//
//  Created by Miyo Alpízar on 16/10/20.
//

import Foundation
import UIKit

protocol NotificationsDelegate: class {
    func didSetNotification()
    func isNotificationsAvailable(available: Bool)
}

class NotificationsHelper: NSObject, UNUserNotificationCenterDelegate {
    
    public weak var delegate: NotificationsDelegate?
    private static let _shared = NotificationsHelper()
    public static var shared: NotificationsHelper {
        return _shared
    }
    
    private var _deviceToken: String = ""
    
    public var deviceToken: String {
        get {
            return _deviceToken
        }
    }
    
    ///Initialize push notifications
    func configPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
            if let error = error {
                print("Push Error: ",error.localizedDescription)
                self.sendDelegates(isGranted: false)
            }else {
                DispatchQueue.main.async { [unowned self] in
                    UIApplication.shared.registerForRemoteNotifications()
                    self.sendDelegates(isGranted: isGranted)
                    
                }
            }
        }
    }
    
    private func sendDelegates(isGranted: Bool) {
        guard let delegate = delegate else {
            return
        }
        delegate.didSetNotification()
        delegate.isNotificationsAvailable(available: isGranted)
    }
    
    public func clearBagde() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //let content = response.notification.request.content
        completionHandler()
    }
    
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.hexString
        let current_token = AppHelper.shared.getString(type: UserStrings.token)
        if current_token == token {
            //Token has been registered
            //return
        }
        PlayFabHelper.shared.Register(token: token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Register Remote Notification Failed ", error.localizedDescription)
    }
}


extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
