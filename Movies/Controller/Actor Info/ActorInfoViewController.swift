//
//  ActorInfoViewController.swift
//  Movies
//
//  Created by Данік on 21/09/2023.
//

import Foundation

class ActorInfoViewController: UIViewController {
    
    private var backButton: UIBarButtonItem!
    let actor = ActorScreen()
    var contents: [MovieOrTvInfo] = []
    var actorId: String?
    var actorFullInfo: ActorFullInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = actor
        fetchData {
            self.actor.knownForController.contents = self.contents
            if let actorInfo = self.actorFullInfo {
                self.actor.configure(withActorInfo: actorInfo, withMovies: actorInfo.credits)
            }
        }
        setupNavigationBar()
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        var trendingDay : [MovieOrTvInfo] = []

        let networkManager = HomeNetworkManager()
        let actorInfoNetworkManager = ActorInfoNetworkManager()
        
        group.enter()
        networkManager.fetchContent(from: "https://api.themoviedb.org/3/trending/all/day") { contents in
            trendingDay = contents
            group.leave()
        }
        
        group.enter()
        actorInfoNetworkManager.fetchAnActor(withPersonId: actorId ?? "666") { actorInfo in
            self.actorFullInfo = actorInfo
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.contents = trendingDay
            completion()
        }
    }
    
    func setupNavigationBar() {

        backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        backButton.accessibilityIdentifier = "backArrowButton"
        
        backButton.tintColor = K.seeAllColor

        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
}

