//
//  HomeViewModel.swift
//  MiniProjectEB
//
//  Created by Putra on 10/10/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func getListUserSuccess()
    func getListUserFailed(err: String)
}


class HomeViewModel: ObservableObject {
    private var usecase: HomeInteractorProcol
    
    weak var delegate: HomeViewModelProtocol?
    
    init(usecase: HomeInteractorProcol) {
        self.usecase = usecase
    }
    
    private(set) var userRespnse = [UserResource]()
    
    
    func getList() {
        usecase.getListUser(completion: {[weak self] completion in
            guard let self = self else {return}
            switch completion {
            case .success(let result):
                print("masuk sukses = \(result.data)")
                self.userRespnse = result.data ?? []
                DispatchQueue.main.async {
                    self.delegate?.getListUserSuccess()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.getListUserFailed(err: error.localizedDescription)
                }
            }
        })
    }
    
}
