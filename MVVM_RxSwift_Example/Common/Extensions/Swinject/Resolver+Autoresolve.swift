import Foundation
import Swinject
import SwinjectAutoregistration

extension Resolver {
    
    public func autoresolve<T, Arg1: EventNode>(argument: Arg1) -> T! {
        return resolve(T.self, argument: argument as EventNode)
    }
    
    public func autoresolve<T, Arg1: EventNode, Arg2>(arguments arg1: Arg1, _ arg2: Arg2) -> T! {
        return resolve(T.self, arguments: arg1 as EventNode, arg2)
    }
}
