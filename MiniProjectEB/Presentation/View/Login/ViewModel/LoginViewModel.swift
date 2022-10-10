//
//  LoginViewModel.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation


protocol LoginViewModelProtocol: AnyObject {
    func loginSuccess()
    func loginFailure(err: String)
}

class LoginViewModel: ObservableObject {
    private var usecase: LoginInteractorProcol
    
    weak var delegate: LoginViewModelProtocol?

    private(set) var loginResponse = LoginResponse(token: "")
    private(set) var loginFail = ErrorLoginResponse(error: "")
    
    //error
    private(set) var errorSurah = ""
    
    init(usecase: LoginInteractorProcol) {
        self.usecase = usecase
    }
    
    
    func login(body: [String: String]) {
        usecase.login(body: body, completion: { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .success(let result):
                self.loginResponse = result
                DispatchQueue.main.async {
                    self.delegate?.loginSuccess()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.loginFailure(err: error.localizedDescription)
                }
            }
        })
    }
    
    
}
