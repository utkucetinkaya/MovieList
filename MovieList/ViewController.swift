//
//  ViewController.swift
//  MovieList
//
//  Created by Utku on 22.01.2022.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let url = "https://api.themoviedb.org/3/tv/popular"
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getMovie { (movie, error) in
            self.movie = movie
            self.tableView.reloadData()
        }
    }
    
    func getMovie(completionHanler: @escaping(_ data: Movie?, _ error: Error?) -> Void) {
        let params: Parameters = ["api_key": "7c5cb5b002a2575bb2e3e5c345dbae35"]
        AF.request(url, method: .get, parameters: params).response { (response) in
            if let data = response.data {
                do {
                    let data = try JSONDecoder.init().decode(Movie.self, from: data)
                    completionHanler(data, nil)
                } catch {
                    completionHanler(nil, error)
                }
            }
            print(response)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movie?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.nameLabel.text = self.movie?.results[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.overView = self.movie?.results[indexPath.row].overview ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
