//
//  AnimationListViewController.swift
//  ios-gemini-demo
//
//  Created by OkuderaYuki on 2018/04/15.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import UIKit

final class AnimationListViewController: UIViewController {

    // MARK: - properties

    @IBOutlet private weak var tableView: UITableView!
    private let titles = ["Horizontal cube",
                          "Vertical cube",
                          "Horizontal clockwise rotation",
                          "Horizontal anticlockwise rotation",
                          "Vertical clockwise rotation",
                          "Vertical anticlockwise rotation",
                          "Horizontal roll up",
                          "Horizontal roll down",
                          "Horizontal sine wave",
                          "Horizontal reverse sine wave",
                          "Vertical roll up",
                          "Vertical roll down",
                          "Vertical sine wave",
                          "Vertical reverse sine wave",
                          "Horizontal pitch up",
                          "Horizontal pitch down",
                          "Horizontal sine wave",
                          "Horizontal reverse sine wave",
                          "Vertical pitch up",
                          "Vertical pitch down",
                          "Vertical sine wave",
                          "Vertical reverse sine wave",
                          "Horizontal yaw up",
                          "Horizontal yaw down",
                          "Horizontal sine wave",
                          "Horizontal reverse sine wave",
                          "Vertical yaw up",
                          "Vertical yaw down",
                          "Vertical sine wave",
                          "Vertical reverse sine wave",
                          "Horizontal scale up",
                          "Horizontal scale down",
                          "Vertical scale up",
                          "Vertical scale down",
                          "Custom animation1",
                          "Custom animation2"
                          ]

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "AnimationList"
    }
}

extension AnimationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
}

extension AnimationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let direction = UICollectionViewScrollDirection.horizontal
            let viewController = CubeViewController.make(scrollDirection: direction)
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let direction = UICollectionViewScrollDirection.vertical
            let viewController = CubeViewController.make(scrollDirection: direction)
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = CircleRotationViewController.make(scrollDirection: .horizontal,
                                                                   rotateDirection: .clockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = CircleRotationViewController.make(scrollDirection: .horizontal,
                                                                   rotateDirection: .anticlockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case 4:
            let viewController = CircleRotationViewController.make(scrollDirection: .vertical,
                                                                   rotateDirection: .clockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case 5:
            let viewController = CircleRotationViewController.make(scrollDirection: .vertical,
                                                                   rotateDirection: .anticlockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case 6:
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal,
                                                                 effect: .rollUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 7:
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal,
                                                                 effect: .rollDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 8:
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal,
                                                                 effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 9:
            let viewController = RollRotationViewController.make(scrollDirection: .horizontal,
                                                                 effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 10:
            let viewController = RollRotationViewController.make(scrollDirection: .vertical,
                                                                 effect: .rollUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 11:
            let viewController = RollRotationViewController.make(scrollDirection: .vertical,
                                                                 effect: .rollDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 12:
            let viewController = RollRotationViewController.make(scrollDirection: .vertical,
                                                                 effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 13:
            let viewController = RollRotationViewController.make(scrollDirection: .vertical,
                                                                 effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 14:
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal,
                                                                  effect: .pitchUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 15:
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal,
                                                                  effect: .pitchDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 16:
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal,
                                                                  effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 17:
            let viewController = PitchRotationViewController.make(scrollDirection: .horizontal,
                                                                  effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 18:
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical,
                                                                  effect: .pitchUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 19:
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical,
                                                                  effect: .pitchDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 20:
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical,
                                                                  effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 21:
            let viewController = PitchRotationViewController.make(scrollDirection: .vertical,
                                                                  effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 22:
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal,
                                                                effect: .yawUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 23:
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal,
                                                                effect: .yawDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 24:
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal,
                                                                effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 25:
            let viewController = YawRotationViewController.make(scrollDirection: .horizontal,
                                                                effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 26:
            let viewController = YawRotationViewController.make(scrollDirection: .vertical,
                                                                effect: .yawUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 27:
            let viewController = YawRotationViewController.make(scrollDirection: .vertical,
                                                                effect: .yawDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 28:
            let viewController = YawRotationViewController.make(scrollDirection: .vertical,
                                                                effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 29:
            let viewController = YawRotationViewController.make(scrollDirection: .vertical,
                                                                effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case 30:
            let viewController = ScaleAnimationViewController.make(scrollDirection: .horizontal,
                                                                   scaleEffect: .scaleUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 31:
            let viewController = ScaleAnimationViewController.make(scrollDirection: .horizontal,
                                                                   scaleEffect: .scaleDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 32:
            let viewController = ScaleAnimationViewController.make(scrollDirection: .vertical,
                                                                   scaleEffect: .scaleUp)
            navigationController?.pushViewController(viewController, animated: true)
        case 33:
            let viewController = ScaleAnimationViewController.make(scrollDirection: .vertical,
                                                                   scaleEffect: .scaleDown)
            navigationController?.pushViewController(viewController, animated: true)
        case 34:
            let viewController = CustomAnimationViewController.make(animationType: .custom1)
            navigationController?.pushViewController(viewController, animated: true)
        case 35:
            let viewController = CustomAnimationViewController.make(animationType: .custom2)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            print(titles[indexPath.row])
        }
    }
}
