import UIKit
import RxSwift
import RxCocoa

protocol WireframeInterface: Progressable {
    var viewController: UIViewController { get }

    func open(url: URL)
    func open(stringUrl: String)
    func dismiss()
    func exit()
    func pop()
}

class BaseWireframe {

    let disposeBag = DisposeBag()

    private unowned var _viewController: UIViewController
    
    // To retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseWireframe: WireframeInterface {
    
    func open(url: URL) {
        UIApplication.shared.open(url)
    }
    
    func open(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        open(url: url)
    }
    
    func dismiss() {
        viewController.dismiss(animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func exit() {
        guard let navigationController = navigationController else {
            dismiss()
            return
        }
        
        if navigationController.viewControllers.count > 1 {
            pop()
        } else {
            dismiss()
        }
    }
}

extension BaseWireframe {
    
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
}

extension BaseWireframe {
    
    func subscribe<W: BaseWireframe, T>(to navigationOptionDriver: Driver<T>, unowning object: W, navigationBlock: @escaping (W) -> ((T) -> ())) {
        navigationOptionDriver
            .drive(onNext: { [unowned object] in navigationBlock(object)($0) })
            .disposed(by: disposeBag)
    }
}

extension UIViewController {
    
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }
    
    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }
}
