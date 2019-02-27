//
// Created by Arnon Keereena on 2019-02-14.
// Copyright (c) 2019 AMOS Thailand. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where E: OptionalType {
  public static postfix func ~~!(this: Self) -> Observable<E.Wrapped> {
    return this.ignoreNil()
  }
}

extension ObservableType {
  public static func >-><R: ObservableType>(left: Self, right: R) -> Observable<R.E> {
    return left.flatMap { _ in right }
  }
  
  public static func >-><R: ObservableType>(left: Self, right: @escaping (E) -> R) -> Observable<R.E> {
    return left.flatMap { l in right(l) }
  }
  
  public static func >-><R: ObservableType>(left: Self, right: @escaping (E) -> R) -> Observable<R.E> where E: OptionalType {
    return left.flatMap { l in right(l) }
  }
  
  public static func >--<R: ObservableType>(left: Self, right: R) -> Observable<R.E> {
    return left.flatMapLatest { _ in right.asObservable() }
  }
  
  public static func >--<R>(left: Self, right: @escaping (E) -> Observable<R>) -> Observable<R> {
    return left.flatMapLatest { right($0) }
  }
  
  public static func >-|<R: ObservableType>(left: Self, right: R) -> Observable<R.E> {
    return left.flatMapFirst { _ in right.asObservable() }
  }
  
  public static func >-|<R>(left: Self, right: @escaping (E) -> Observable<R>) -> Observable<R> {
    return left.flatMapFirst { right($0) }
  }
  
  public static func -->(left: Self, right: Void) -> Observable<Void> {
    return left.map { _ in }
  }
  
  public static func --><R>(left: Self, right: R) -> Observable<R> {
    return left.map { _ in right }
  }
  
  public static func --><R>(left: Self, right: @escaping (E) -> R) -> Observable<R> {
    return left.map { l -> R in right(l) }
  }
  
  public static func +>>(left: Self, right: @escaping (E) -> Void) -> Observable<E> {
    return left.do(onNext: right)
  }
  
  public static func |(left: Self, right: ActivityIndicator) -> Observable<E> {
    return left.trackActivity(right)
  }
  
  public static func |(left: Self, right: ErrorTracker) -> Observable<E> {
    return left.trackError(right)
  }
  
  public static func |(left: Self, right: (ActivityIndicator, ErrorTracker)) -> Observable<E> {
    return left.trackActivity(right.0)
               .trackError(right.1)
  }
  
  public static func |(left: Self, right: Int) -> Observable<E> {
    return left.take(right)
  }

  public static func ~~~(left: Self, right: @escaping (E) -> Bool) -> Observable<E> {
    return left.filter(right)
  }
  
  public static func --->(left: Self, right: Void) -> Disposable {
    return left.subscribe()
  }
  
  public static func --->(left: Self, right: @escaping (E) -> Void) -> Disposable {
    return left.subscribe(onNext: { right($0) })
  }
  
  public static func ---><R>(left: Self, right: R) -> Disposable where E == R.E, R: ObserverType {
    return left.subscribe(right)
  }
  
  public static func |>>(left: E, right: Self) -> Observable<E> {
    return right.startWith(left)
  }
  
  public static func |&&<R: ObservableType>(left: Self, right: R) -> Observable<R.E> {
    return left.withLatestFrom(right)
  }
  
  public static func +++<R: ObservableType>(left: Self, right: R) -> Observable<(E, R.E)> {
    return Observable.combineLatest(left, right)
  }
  
  public static func +++<A, B, R: ObservableType>(left: Self, right: R) -> Observable<(A, B, R.E)> where E == (A, B) {
    return Observable.combineLatest(left, right) { ($0.0, $0.1, $1) }
  }
  
  public static func +++<A, B, C, R: ObservableType>(left: Self, right: R) -> Observable<(A, B, C, R.E)> where E == (A, B, C) {
    return Observable.combineLatest(left, right) { ($0.0, $0.1, $0.2, $1) }
  }
  
  public static func +++<A, B, C, D, R: ObservableType>(left: Self, right: R) -> Observable<(A, B, C, D, R.E)> where E == (A, B, C, D) {
    return Observable.combineLatest(left, right) { ($0.0, $0.1, $0.2, $0.3, $1) }
  }
  
  public static func ===<R: ObservableType>(left: Self, right: R) -> Observable<Bool> where R.E == E, R.E: Equatable {
    return left +++ right --> { $0.0 == $0.1 }
  }
  
  public static func &&&<R: ObservableType>(left: Self, right: R) -> Observable<Bool> where R.E == E, R.E == Bool {
    return left +++ right --> { $0.0 && $0.1 }
  }
  
  public static func --/(left: Self, right: RxTimeInterval) -> Observable<E> {
    return left.debounce(right, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
  }
  
  public static func --/(left: Self, right: (RxTimeInterval, SchedulerType)) -> Observable<E> {
    return left.debounce(right.0, scheduler: right.1)
  }
  
  public static func /--(left: Self, right: RxTimeInterval) -> Observable<E> {
    return left.throttle(right, scheduler: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
  }
  
  public static func /--(left: Self, right: (RxTimeInterval, SchedulerType)) -> Observable<E> {
    return left.throttle(right.0, scheduler: right.1)
  }
  
}

public func ***<T>(left: Observable<T>, right: Observable<T>) -> Observable<T> {
  return Observable.merge([left, right])
}

extension ObservableType where E == Bool  {
  public static func ~~~(left: Self, right: E) -> Observable<E> {
    return left.filter { $0 == right }
  }
}

extension Array where Element: ObservableType {
  public static postfix func +++(this: Array<Element>) -> Observable<[Element.E]> {
    return Observable.combineLatest(this)
  }
}

public func |(left: Disposable, right: DisposeBag) {
  return left.disposed(by: right)
}

extension ObservableType where E: Hashable {
  public static prefix func ==(this: Self) -> Observable<E> {
    return this.distinctUntilChanged()
  }
}

extension ObservableType where E: Equatable {
  public static prefix func ==(this: Self) -> Observable<E> {
    return this.distinctUntilChanged()
  }
}

