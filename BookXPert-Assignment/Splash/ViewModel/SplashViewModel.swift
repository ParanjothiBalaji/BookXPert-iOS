//
//  SplashViewModel.swift
//  BookXPert-Assignment
//
//  Created by Paranjothi Balaji on 20/06/25.
//

import Foundation

final class SplashViewModel {
    weak var delegate: SplashViewModelDelegate?

    func startSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.delegate?.didFinishSplash()
        }
    }
}

protocol SplashViewModelDelegate: AnyObject {
    func didFinishSplash()
}
