//
//  ArticlesScreenPresenter.swift
//  TestApp
//
//  Created by Georges on 12/5/20.
//  Copyright (c) 2020 Xeronium. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Combine

final class ArticlesScreenPresenter {

    // MARK: - Private properties -

    private unowned let view: ArticlesScreenViewInterface
    private let interactor: ArticlesScreenInteractorInterface
    private let wireframe: ArticlesScreenWireframeInterface
    private var cancellableSet = Set<AnyCancellable>()
    private var previousResults: [Article] = []
    
    // MARK: - Lifecycle -

    init(view: ArticlesScreenViewInterface, interactor: ArticlesScreenInteractorInterface, wireframe: ArticlesScreenWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    private func registerToInteractor() {
        self.interactor.articlesResults.sink { (completion) in
            switch completion {
            case .failure(let error):
                self.view.error(error)
            case .finished: break
            }
        } receiveValue: { [weak self] (articles) in
            guard let self = self else { return }
            self.previousResults = self.previousResults + articles
            self.view.setArticles(articles: self.previousResults)
        }.store(in: &cancellableSet)
    }
}

// MARK: - Extensions -

extension ArticlesScreenPresenter: ArticlesScreenPresenterInterface {
    func viewLoaded() {
        self.view.loading()
        self.registerToInteractor()
        self.interactor.nextPage()
    }
    func didReachEnd() {
        self.interactor.nextPage()
    }
    func tapped(article: Article) {
        self.wireframe.routeToArticleDetails(article: article)
    }
}
