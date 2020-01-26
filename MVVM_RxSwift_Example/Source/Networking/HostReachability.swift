//
//  HostReachibility.swift
//  MVVM_RxSwift_Example
//
//  Created by Ruslan Popesku on 30.06.2019.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import RxSwift
import Alamofire

public final class HostReachability {
    
    public enum NetworkReachabilityStatus {
        case unknown
        case notReachable
        case reachable(ConnectionType)
    }
    
    public enum ConnectionType {
        case ethernetOrWiFi
        case wwan
    }
    
    public var hasConnectionObserver: Observable<Bool> {
        return statusEvent.map {
            guard case HostReachability.NetworkReachabilityStatus.reachable = $0 else { return false }
            return true
            }.asObservable()
    }
    public let statusEvent = PublishSubject<NetworkReachabilityStatus>()
    private var hostReachability: NetworkReachabilityManager
    
    public init() {
        self.hostReachability = NetworkReachabilityManager()!
        
        hostReachability.listener = { [weak statusEvent] status in
            
            switch status {
                
            case .notReachable:
                statusEvent?.onNext(.notReachable)
                debugPrint("The network is not reachable")
                
            case .unknown:
                statusEvent?.onNext(.unknown)
                debugPrint("It is unknown whether the network is reachable")
                
            case .reachable(.ethernetOrWiFi):
                statusEvent?.onNext(.reachable(.ethernetOrWiFi))
                debugPrint("The network is reachable over the WiFi connection")
                
            case .reachable(.wwan):
                statusEvent?.onNext(.reachable(.wwan))
                debugPrint("The network is reachable over the WWAN connection")
            }
            
        }
        
        hostReachability.startListening()
    }
    
}
