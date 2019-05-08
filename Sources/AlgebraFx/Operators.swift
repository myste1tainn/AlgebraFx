//
//  Operators.swift
//  RxAlgebra
//
//  Created by Arnon Keereena on 14/2/2562 BE.
//  Copyright © 2562 AMOS Thailand. All rights reserved.
//

import Foundation

// MARK: - Transform operators

/// map
infix operator >>>: AdditionPrecedence

/// flatMap
infix operator >->: AdditionPrecedence

/// flatMapLatest
infix operator >--: AdditionPrecedence

/// flatMapFirst
infix operator >-|: AdditionPrecedence

// MARK: - Side effects

/// do onNext
infix operator +>>: AdditionPrecedence

/// do onError
infix operator +!>: AdditionPrecedence

/// do onCompleted
infix operator ++>: AdditionPrecedence

/// take || dispose
infix operator |: AdditionPrecedence

/// Tracking extraction
infix operator |>: AdditionPrecedence

// MARK: - Binding

/// Subscribe, one-way binding
infix operator -->: AdditionPrecedence

/// Two-way binding
infix operator <->: AdditionPrecedence

// MARK: - Filtration

/// filter
infix operator ~~~: AdditionPrecedence

/// unwrap
postfix operator ~~!

/// distinctUntilChanged
prefix operator ==

// MARK: - Merging

/// startWith
infix operator |>>: AdditionPrecedence

/// withLatestFrom (right)
infix operator ||&: AdditionPrecedence

/// withLatestFrom (left, right)
infix operator |&&: AdditionPrecedence

/// combineLatest
postfix operator +++
infix operator +++: AdditionPrecedence

/// zip
postfix operator +-+
infix operator +-+: AdditionPrecedence

/// merge
infix operator ***: MultiplicationPrecedence

// MARK: - Util

/// debounce
infix operator --/: AdditionPrecedence

/// throttle
infix operator /--: AdditionPrecedence

// MARK: - Special combination

///// combineLatest { == }, but this is declared by foundation
//infix operator ===: LogicalConjunctionPrecedence

/// combineLatest { && }
infix operator &&&: LogicalConjunctionPrecedence

/// reduce
prefix operator ∑

