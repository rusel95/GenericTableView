platform :ios, '11.0'

abstract_target 'Shared' do
    use_frameworks!
    inhibit_all_warnings!
    
    # DI
    pod 'Swinject'
    pod 'SwinjectAutoregistration'
    
    # FRP
    pod 'RxCocoa'
    pod 'RxSwift'
    pod 'RxOptional'
    pod 'NSObject+Rx'
    
    # DB client component
    pod 'RxRealm'
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'AlamofireNetworkActivityIndicator'
    
    target 'MVVM_RxSwift_Example' do
        # Controls
        pod 'SVProgressHUD'
        
        pod 'SnapKit'
        # Tools
        pod 'SwiftGen'
        pod 'KeychainAccess'
        
        # Firebase
        pod 'Firebase/Core'
        pod 'Firebase/Auth'
    end
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
