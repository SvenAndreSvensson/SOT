//
//  SOTManager.swift
//  SOTManager
//
//  Created by Sven Svensson on 27/08/2021.
//

import Foundation

class SOTManager: ObservableObject{
    @Published private(set)var parents: [Parent] = [Parent]()// Parent.data
    {
        didSet{
            print("SOTManager.parents - changed")
        }
    }
    
    func remove(atOffsets: IndexSet){
        parents.remove(atOffsets: atOffsets)
    }
    func remove(_ parent: Parent){
        guard let _pIndex = parents.firstIndex(where: {$0.id == parent.id}) else {
            print("SOTManager, remove - Parent Not found!")
            return
        }
        parents.remove(at: _pIndex)
    }
    
    func remove(atOffsets: IndexSet, toChildrenOf parent: Parent ){
        guard let _pIndex = parents.firstIndex(where: {$0.id == parent.id}) else {
            print("SOTManager, remove - Parent Not found!")
            return
        }
        parents[_pIndex].children.remove(atOffsets: atOffsets)
    }
    func remove(_ child: Child){
        guard let _pIndex = parents.firstIndex(where: {$0.children.contains(child) }),
        let _cIndex = parents[_pIndex].children.firstIndex(where: { $0.id == child.id }) else {
            print("SOTManager, remove - Parent Not found!")
            return
        }
        
        parents[_pIndex].children.remove(at: _cIndex)
    }
    
    func remove(atOffsets: IndexSet, toToysOf child: Child ){
        guard let _pIndex = parents.firstIndex(where: {$0.children.contains(child) }),
        let _cIndex = parents[_pIndex].children.firstIndex(where: { $0.id == child.id }) else {
            print("SOTManager, remove - Parent Not found!")
            return
        }
        parents[_pIndex].children[_cIndex].toys.remove(atOffsets: atOffsets)
    }
    
    func remove(_ toy: Toy){
        guard let _pIndex = parents.firstIndex(where: {$0.children.first (where: { $0.toys.contains(toy) }) != nil  }),
              let _cIndex = parents[_pIndex].children.firstIndex(where: { $0.toys.contains(toy) }),
              let _tIndex = parents[_pIndex].children[_cIndex].toys.firstIndex(where: { $0.id == toy.id }) else {
            print("SOTManager, remove - Parent Not found!")
            return
        }
        
        parents[_pIndex].children[_cIndex].toys.remove(at: _tIndex)
    }
    
    func append(_ data: Parent.Data){
        let newParent = Parent(
            id: UUID(),
            name: data.name,
            children: data.children)
        
        parents.append(newParent)
    }
    
    func append(_ data: Child.Data, toChildrenOf parent: Parent){
        guard let _pIndex = parents.firstIndex(where: {$0.id == parent.id}) else {
            print("SOTManager, append - Parent Not found!")
            return
        }
        let newChild = Child(
            id: UUID(),
            name: data.name,
            toys: data.toys)
        
        parents[_pIndex].children.append(newChild)
    }
    
    func append(_ data: Toy.Data, toToysOf child: Child){
        guard let _pIndex = parents.firstIndex(where: {$0.children.contains(where: { $0.id == child.id }) }),
              let _cIndex = parents[_pIndex].children.firstIndex(where: { $0.id == child.id }) else {
            print("SOTManager, append - Parent Not found!")
            return
        }
        let newToy = Toy(
            id: UUID(),
            name: data.name)
        
        parents[_pIndex].children[_cIndex].toys.append(newToy)
    }
    
    func update(_ parent: Parent, from data: Parent.Data){
        for pIndex in 0..<parents.count {
            if parents[pIndex].id == parent.id {
                parents[pIndex].update(from: data)
                break
            }
        }
    }
    
    func update(_ child: Child, from data: Child.Data){
        outerloop: for pIndex in 0..<parents.count {
            for cIndex in 0..<parents[pIndex].children.count {
                if parents[pIndex].children[cIndex].id == child.id {
                    parents[pIndex].children[cIndex].update(from: data)
                    break outerloop
                }
            }
        }
    }
    
    func update(_ toy: Toy, from data: Toy.Data){
        // find parent containing child containing toy
        outerloop: for pIndex in 0..<parents.count {
            for cIndex in 0..<parents[pIndex].children.count {
                for tIndex in 0..<parents[pIndex].children[cIndex].toys.count {
                    if parents[pIndex].children[cIndex].toys[tIndex].id == toy.id {
                        parents[pIndex].children[cIndex].toys[tIndex].update(from: data)
                        break outerloop
                    }
                }
            }
        }
    }
    
    
    
    /*
    // creates a new Parent
    func add(data: Parent.Data) {
        let newParent = Parent(
            id: UUID(),
            name: data.name,
            children: data.children )
        
        parents.append(newParent)
    }
    
    func update(parent: Parent, from data: Parent.Data) {
        guard let index = parents.firstIndex(where: { $0.id == parent.id }) else {
            print("HumanManager: Trying to update a Parent that apparently does not exist?")
            return
        }
        parents[index].update(from: data)
    }
    
    func update( _ child: Child, of parent: Parent, from data: Child.Data) {
        guard let _pIndex = parents.firstIndex(where: {  $0.id == parent.id }),
              let _index = parents[_pIndex].children.firstIndex(where: { $0.id == child.id })
        else {
            
            print("HumanManager: Trying to update a Child, but can't find the parent or child?")
            return
        }
        parents[_pIndex].children[_index].update(from: data)
    }
    
    func delete(parent: Parent) -> Parent? {
        guard let _index = parents.firstIndex(where: { $0.id == parent.id }) else {
            print("HumanManager: Trying to delete a Parent that does not exist?")
            return nil
        }
        return parents.remove(at: _index)
    }
    
    func delete(_ indexSet: IndexSet) {
        // because what if it's sorted or ? - any reasonable sugestions :)
        var _itemsToRemove:[Parent] = [Parent]()
        indexSet.forEach { index in
            _itemsToRemove.append(parents[index])
        }
        _itemsToRemove.forEach { parent in
            let _ = delete(parent: parent)
        }
    }
    
    func delete(_ indexSet: IndexSet, from parent: Parent) {
        guard let _pIndex = parents.firstIndex(where: {  $0.id == parent.id })
        else {
            print("HumanManager: Trying to delete a Child(ren), but can't find the parent?")
            return
        }
        
        var childrenToDelete:[Child] = [Child]()
        
        indexSet.forEach { index in
            childrenToDelete.append(parents[_pIndex].children[index])
        }
        
        childrenToDelete.forEach { child in
            let _ = delete(child, from: parents[_pIndex])
        }
    }
    
    func delete(_ child: Child, from parent: Parent) -> Child? {
        
        guard let _pIndex = parents.firstIndex(where: {  $0.id == parent.id }),
              let _index = parents[_pIndex].children.firstIndex(where: { $0.id == child.id })
        else {
            
            print("HumanManager: Trying to delete a Child, but can't find the parent or this child?")
            return nil
        }
        
        return parents[_pIndex].children.remove(at: _index)
    }*/
    
    
    static var emptyState: SOTManager {
        
        let manager = SOTManager()
        manager.parents = []
        return manager
        
    }
    
    static var fullState: SOTManager {
        let manager = SOTManager()
        manager.parents = Parent.data
        return manager
    }
    
    /*
    func add(parent:Parent){
        parents.append(parent)
    }
    
    func removeParent(_ parent: Parent){
        
        let index = parents.firstIndex { item in
            item.id == parent.id
        }
        if let index = index {

            parents.remove(at: index)
        } else {
            print("HumanManager: removeParent: firstIndex not found")
        }
    }
    func removeParent(_ indexSet: IndexSet){
        
        var itemsToRemove:[Parent] = [Parent]()
        
        indexSet.forEach { index in
            itemsToRemove.append(parents[index])
        }
        
        itemsToRemove.forEach { parent in
            removeParent(parent)
        }
    }
    
    func removeChild( _ child: Child){
        if var _parent = parents.first(where: { parent in
            parent.children.contains { _child in
                _child.id == child.id
            }
        }){
            if let _index = _parent.children.firstIndex(where: {$0.id == child.id}) {
                _parent.children.remove(at: _index)
            }
        }
    }*/
}
