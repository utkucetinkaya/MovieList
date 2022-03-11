//
//  DetailViewController.swift
//  MovieList
//
//  Created by Utku on 22.01.2022.
//

import UIKit
import Alamofire
class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    var overView = ""
    let url = "https://api.themoviedb.org/3/tv"

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetails { (detail, error) in
        }
        if overView == "" {
            detailLabel.text = "overview bulunamadi"
        } else {
            detailLabel.text = overView
        }
    }
    
    func getDetails(completionHanler: @escaping(_ data: MovieDetail?, _ error: Error?) -> Void) {
        let params: Parameters = ["api_key": "7c5cb5b002a2575bb2e3e5c345dbae35" ,"tv_id": "550"]
        AF.request(url, method: .get, parameters: params).response { (response) in
            if let data = response.data {
                do {
                    let data = try JSONDecoder.init().decode(MovieDetail.self, from: data)
                    completionHanler(data, nil)
                } catch {
                    completionHanler(nil, error)
                }
            }
            print(response)
        }
    }
}
