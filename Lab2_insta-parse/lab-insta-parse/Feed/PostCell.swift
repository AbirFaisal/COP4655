//
//  PostCell.swift
//  lab-insta-parse
//
//  Created by Charlie Hieger on 11/3/22.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!

    private var imageDataRequest: DataRequest?

    func configure(with post: Post) {
        // TODO: Pt 1 - Configure Post Cell
        
        if let user = post.user {
            usernameLabel.text = user.username
        }
        
        if let imageFile = post.imageFile, let imageUrl = imageFile.url {
            imageDataRequest = AF.request(imageUrl).responseImage {
                [weak self] response in
                switch response.result {
                case .success(let image):
                    self?.postImageView.image = image
                case .failure(let error):
                    print("Error fetching \(error.localizedDescription)")
                    break
                }
            }
        }
        
        captionLabel.text = post.caption
        
        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: P1 - Cancel image download
        
        postImageView.image = nil
        
        imageDataRequest?.cancel()
    }
}
