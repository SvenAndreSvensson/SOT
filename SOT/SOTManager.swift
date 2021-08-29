//
//  SOTManager.swift
//  SOTManager
//
//  Created by Sven Svensson on 27/08/2021.
//

import Foundation

class SOTManager: ObservableObject{
    @Published var parents: [Parent] = [Parent]()// Parent.data
    {
        didSet{
            print("SOTManager.parents - changed")
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
