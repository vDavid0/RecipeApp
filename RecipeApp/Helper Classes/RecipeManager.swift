//
//  VideoManage.swift
//  RecipeApp
//
//  Created by Dávid Váradi on 2023. 04. 10..
//

import AVFoundation

class RecipeManager {
    var recipes = [Recipe]()
    
    private var playerLooper: AVPlayerLooper?
    private var activeVideoIndex = 0 {
        //az elozoleg megjelenitett video lejatszasanak visszaporgetese es leallitasa
        willSet {
            stopPlayingCurrentVideo()
        }
        //uj video megjelenitese utan valo elinditas
        didSet {
            startPlayingCurrentVideo()
        }
    }
    
    func stopPlayingCurrentVideo() {
        guard !recipes.isEmpty else {return}
       
        guard let currentPlayer = recipes[activeVideoIndex].video?.player else {return}
        currentPlayer.seek(to: .zero)
        currentPlayer.pause()

        playerLooper?.disableLooping()
    }
    
    func startPlayingCurrentVideo() {
        guard !recipes.isEmpty else {return}
        
        guard let currentPlayer = recipes[activeVideoIndex].video?.player else {return}
        playerLooper = AVPlayerLooper(player: currentPlayer, templateItem: currentPlayer.currentItem!)
        currentPlayer.play()
    }
    
    //  ha uj videora erkeztunk, akkor atallitjuk ra az aktiv indexet
    func checkIfNewVideo(newIndex index: Int) {
        if activeVideoIndex != index {
            activeVideoIndex = index
        }
    }
    
    func fetchData() {
        recipes = RecipeService.shared.fetchRecipes()
    }
}
