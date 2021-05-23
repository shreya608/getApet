/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

protocol PetDetailViewControllerDelegate: class {
  func petDetailViewController(_ petDetailViewController: PetDetailViewController, didAdoptPet pet: Pet)
}

class PetDetailViewController: UIViewController {
  // MARK: - Properties
  var pet: Pet
  var isAdopted = false
  weak var delegate: PetDetailViewControllerDelegate?

  // MARK: - IBOutlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var age: UILabel!
  @IBOutlet weak var adoptButton: UIButton!

  // MARK: - Life Cycle
  init?(coder: NSCoder, pet: Pet) {
    self.pet = pet
    super.init(coder: coder)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    adoptButton.setTitle("Adopt", for: .normal)
    adoptButton.isHidden = isAdopted
    imageView.image = UIImage(named: pet.imageName)
    name.text = isAdopted ? "Your pet: \(pet.name)" : pet.name
    age.text = "\(pet.age) years old"
  }
}

// MARK: - IBActions
extension PetDetailViewController {
  @IBAction func didTapAdoptButton(_ sender: UIButton) {
    delegate?.petDetailViewController(self, didAdoptPet: pet)
    navigationController?.popViewController(animated: true)
  }
}
