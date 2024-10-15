//
//  CommentCell.swift
//  project-bereal-clone-p2
//
//  Created by Administrator on 10/15/24.
//

import Foundation
import UIKit


class CommentCell: UITableViewCell {

    

    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentText: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


