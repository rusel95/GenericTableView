import Swinject
import SwinjectAutoregistration

final class MainFlowAssembly: Assembly {

    func assemble(container: Container) {
        
        container
            .register(MainContainerController.self) { (_, parent: EventNode) in
                let model = MainContainerModel(
                    parent: parent
                )
                let controller = MainContainerController()
                controller.viewModel = MainContainerViewModel(model: model)
                
                return controller
            }
            .inObjectScope(.transient)
        
        container
            .register(ExploreFlowCoordinator.self) { (_, parent: EventNode) in
                return ExploreFlowCoordinator(
                    parent: parent,
                    container: container
                )
            }
            .inObjectScope(.transient)
        
        container
            .register(MapFlowCoordinator.self) { (_, parent: EventNode) in
                return MapFlowCoordinator(
                    parent: parent,
                    container: container
                )
            }
            .inObjectScope(.transient)
        
        container
            .register(OrdersFlowCoordinator.self) { (_, parent: EventNode) in
                return OrdersFlowCoordinator(
                    parent: parent,
                    container: container
                )
            }
            .inObjectScope(.transient)
        
        container
            .register(ProfileFlowCoordinator.self) { (_, parent: EventNode) in
                return ProfileFlowCoordinator(
                    parent: parent,
                    container: container
                )
            }
            .inObjectScope(.transient)
    }
    
}
