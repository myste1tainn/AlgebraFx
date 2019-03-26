//
// Created by Arnon Keereena on 2019-02-14.
// Copyright (c) 2019 AMOS Thailand. All rights reserved.
//

import Foundation
import SwiftExpansion
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy, E: OptionalType {
  public static postfix func ~~!(this: Self) -> Driver<E.Wrapped> {
    return this.unwrap()
  }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
  
  public static func >-><R: DriverType>(left: Self, right: R) -> Driver<R.E> {
    return left.flatMap { _ in right.asDriver() }
  }
  
  public static func >-><R>(left: Self, right: @escaping (E) -> Driver<R>) -> Driver<R> {
    return left.flatMap { right($0) }
  }
  
  public static func >-><R>(left: Self, right: @escaping (E) -> Driver<R>) -> Driver<R> where E: OptionalType {
    return left.flatMap { right($0) }
  }
  
  public static func >--<R: DriverType>(left: Self, right: R) -> Driver<R.E> {
    return left.flatMapLatest { _ in right.asDriver() }
  }
  
  public static func >--<R>(left: Self, right: @escaping (E) -> Driver<R>) -> Driver<R> {
    return left.flatMapLatest { right($0) }
  }
  
  public static func >-|<R: DriverType>(left: Self, right: R) -> Driver<R.E> {
    return left.flatMapFirst { _ in right.asDriver() }
  }
  
  public static func >-|<R>(left: Self, right: @escaping (E) -> Driver<R>) -> Driver<R> {
    return left.flatMapFirst { right($0) }
  }
  
  public static func --><R>(left: Self, right: @escaping (E) -> R) -> Driver<R> {
    return left.map { l -> R in right(l) }
  }
  
  public static func -->(left: Self, right: Void) -> Driver<Void> {
    return left.map { _ in }
  }
  
  public static func +>>(left: Self, right: @escaping (E) -> Void) -> Driver<E> {
    return left.do(onNext: right)
  }
  
  public static func --->(left: Self, right: Void) -> Disposable {
    return left.drive()
  }
  
  public static func --->(left: Self, right: @escaping (E) -> Void) -> Disposable {
    return left.drive(onNext: { right($0) })
  }
  
  public static func ~~~(left: Self, right: @escaping (E) -> Bool) -> Driver<E> {
    return left.filter(right)
  }
  
  public static func ---><R>(left: Self, right: R) -> Disposable where E == R.E, R: ObserverType {
    return left.drive(right)
  }
  
  public static func |>>(left: E, right: Self) -> Driver<E> {
    return right.startWith(left)
  }
  
  public static func |&&<R: DriverType>(left: Self, right: R) -> Driver<R.E> {
    return left.withLatestFrom(right)
  }
  
  public static func +++<R: DriverType>(left: Self, right: R) -> Driver<(E, R.E)> {
    return Driver.combineLatest(left, right)
  }
  
  public static func +++<A, B, R: DriverType>(left: Self, right: R) -> Driver<(A, B, R.E)> where E == (A, B) {
    return Driver.combineLatest(left, right) { ($0.0, $0.1, $1) }
  }
  
  public static func +++<A, B, C, R: DriverType>(left: Self, right: R) -> Driver<(A, B, C, R.E)> where E == (A, B, C) {
    return Driver.combineLatest(left, right) { ($0.0, $0.1, $0.2, $1) }
  }
  
  public static func +++<A, B, C, D, R: DriverType>(left: Self, right: R) -> Driver<(A, B, C, D, R.E)> where E == (A, B, C, D) {
    return Driver.combineLatest(left, right) { ($0.0, $0.1, $0.2, $0.3, $1) }
  }
  
  public static func ===<R: DriverType>(left: Self, right: R) -> Driver<Bool> where R.E == E, R.E: Equatable {
    return left +++ right --> { $0.0 == $0.1 }
  }
  
  public static func &&&<R: DriverType>(left: Self, right: R) -> Driver<Bool> where R.E == E, R.E == Bool {
    return left +++ right --> { $0.0 && $0.1 }
  }
  
  public static func --/(left: Self, right: RxTimeInterval) -> Driver<E> {
    return left.debounce(right)
  }
  
  public static func /--(left: Self, right: RxTimeInterval) -> Driver<E> {
    return left.throttle(right)
  }
  
}

public func ***<T>(left: Driver<T>, right: Driver<T>) -> Driver<T> {
  return Driver.merge([left, right])
}

extension DriverType where E == Bool  {
  public static func ~~~(left: Self, right: E) -> Driver<E> {
    return left.filter { $0 == right }
  }
}
