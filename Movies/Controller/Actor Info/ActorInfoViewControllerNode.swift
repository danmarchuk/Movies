//
//  ActorInfoViewControllerNode.swift
//  Movies
//
//  Created by Данік on 06/10/2023.
//

import Foundation
import AsyncDisplayKit

final class ActorInfoViewControllerNode: ASDKViewController<ActorScreenNode> {
    
    private var backButton: UIBarButtonItem!

    var knownFor: [MovieOrTvInfo] = []
    var actorId: String?
    var actorFullInfo: ActorFullInfo?
    
    override init() {
        super.init(node: ActorScreenNode())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData {
            self.node.knownForController.moviesOrTvs = self.knownFor
            if let actorInfo = self.actorFullInfo {
                self.node.configure(withActorInfo: actorInfo, withMovies: actorInfo.credits)
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
            self.knownFor = trendingDay
            completion()
        }
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white

        backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        
        backButton.accessibilityIdentifier = "backArrowButton"
        
        backButton.tintColor = K.seeAllColor

        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
}

