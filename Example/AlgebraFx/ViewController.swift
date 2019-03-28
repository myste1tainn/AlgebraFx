//
//  ViewController.swift
//  AlgebraFx
//
//  Created by myste1tainn on 02/26/2019.
//  Copyright (c) 2019 myste1tainn. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlgebraFx

class ViewController: UIViewController {
  
  let disposeBag = DisposeBag()
  
  var greetingsLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    greetingsLabel = UILabel()
    guard let greetingsLabel = greetingsLabel else { return }
    Observable.just(1) >>> { "\($0)" } --> greetingsLabel.rx.text | disposeBag
    Driver.just(2) >>> { "\($0)" } --> greetingsLabel.rx.text | disposeBag
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

