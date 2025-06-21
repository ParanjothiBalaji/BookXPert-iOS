//
//  ReachabilityManager.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import Alamofire
import UIKit

final class ReachabilityManager {
    static let shared = ReachabilityManager()
    private let reachability = NetworkReachabilityManager()
    
    var isReachable: Bool { reachability?.isReachable == true }
    
    func startListening(onChange: @escaping (Bool) -> Void) {
        reachability?.startListening { status in
            let available = status == .reachable(.ethernetOrWiFi) ||
            status == .reachable(.cellular)
            DispatchQueue.main.async {
                onChange(available)
            }
        }
    }
}
