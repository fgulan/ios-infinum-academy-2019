platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

def reactive
    pod 'RxSwift'
    pod 'RxCocoa'
end

def networking
    pod 'Alamofire'
    pod 'AlamofireNetworkActivityIndicator'
    pod 'AlamofireNetworkActivityLogger'
    pod 'Kingfisher'
    pod 'Loggie'
    pod 'CodableAlamofire'
end

def ui
    pod 'SnapKit'
    pod 'SwiftI18n/I18n+Case'
    pod 'PKHUD'
    pod 'AHKNavigationController'
end

def other
    pod 'SwiftyBeaver'
end

def shared
    reactive
    networking
    ui
    other
end

target 'TVShows' do
    shared
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'AppStore_Debug' || config.name == 'Development_Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['$(inherited)', '-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end
