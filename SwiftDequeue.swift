//
//  SwiftDequeue.swift
//  SwiftDequeue
//
//  Created by Cory Wilhite on 8/12/16.
//  Copyright © 2016 Cory Wilhite. All rights reserved.
//

import Foundation

// Object that provides a string to be used typically
// for registering and dequeueing from a tableview/collectionview
//
// Defaults to a string of the class name
public protocol Identifiable: class {
    static var identifier: String { get }
}

public extension Identifiable {
    static var identifier: String {
        return String(self)
    }
}


public protocol NibProvidable {
    static var nib: UINib { get }
    static var bundle: NSBundle { get }
}

public extension NibProvidable where Self: Identifiable {
    static var bundle: NSBundle {
        return NSBundle(forClass: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: Self.identifier, bundle: Self.bundle)
    }
}


public extension UITableView {
    func register<Cell where Cell: Identifiable, Cell: UITableViewCell>(type: Cell.Type) {
        registerClass(Cell.self, forCellReuseIdentifier: Cell.identifier)
    }
    
    func register<Cell where Cell: NibProvidable, Cell: Identifiable, Cell: UITableViewCell>(type: Cell.Type) {
        registerNib(Cell.nib, forCellReuseIdentifier: Cell.identifier)
    }
    
    func dequeue<Cell where Cell: Identifiable, Cell: UITableViewCell>(type: Cell.Type, at indexPath: NSIndexPath) -> Cell {
        return dequeueReusableCellWithIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell
    }
    
    func dequeue<Cell where Cell: NibProvidable, Cell: Identifiable, Cell: UITableViewCell>(type: Cell.Type, at indexPath: NSIndexPath) -> Cell {
        return dequeueReusableCellWithIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell
    }
}

public extension UICollectionView {
    func register<Cell where Cell: Identifiable, Cell: UICollectionReusableView>(type: Cell.Type) {
        registerClass(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
    }
    
    func register<Cell where Cell: NibProvidable, Cell: Identifiable, Cell: UICollectionReusableView>(type: Cell.Type) {
        registerNib(Cell.nib, forCellWithReuseIdentifier: Cell.identifier)
    }
    
    func dequeue<Cell where Cell: Identifiable, Cell: UICollectionReusableView>(type: Cell.Type, at indexPath: NSIndexPath) -> Cell {
        return dequeueReusableCellWithReuseIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell
    }
    
    func dequeue<Cell where Cell: NibProvidable, Cell: Identifiable, Cell: UICollectionReusableView>(type: Cell.Type, at indexPath: NSIndexPath) -> Cell {
        return dequeueReusableCellWithReuseIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell
    }
}