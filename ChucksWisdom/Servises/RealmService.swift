//
//  RealmService.swift
//  ChucksWisdom
//
//  Created by Apple Mac Air on 15.03.2024.
//

import RealmSwift

final class RealmService {
    
    private (set) var list = [ValueModel]()
    private (set) var category = [Category]()
    
    init() {
        fetchCategory()
        fetchList()
    }
    
    func fetchList() {
        let realm = try! Realm()
        list = realm.objects(ValueModel.self).map{$0}
    }
    
    func fetchCategory() {
        let realm = try! Realm()
        category = realm.objects(Category.self).map{$0}
    }
    
    func addJokeToList(joke: String, category: String) {
        guard let realm = try? Realm() else { return }
            let newJoke = ValueModel()
            newJoke.value = joke
            let newCategory = Category()
            newCategory.category = category
            do {
                try realm .write({
                    
                    let objectCategory = realm.object(ofType: Category.self, forPrimaryKey: category)
                    let objectValue = realm.object(ofType: ValueModel.self, forPrimaryKey: joke)
                    let jokeService = JokeService(category: newCategory)
                    
                    if objectValue?.value != newJoke.value {
                        realm.add(newJoke)
                    }
            
                     if objectCategory?.category != newCategory.category {
                         realm.add(newCategory)
                         jokeService.addJokeToCategory(model: newJoke, at: newCategory)
                     } else {
                         jokeService.addJokeToCategory(model: newJoke, at: objectCategory!)
                     }
                    fetchList()
                    fetchCategory()
                })
            } catch {
                print (error)
            }
    }
    
    func deleteJoke(at index: Int) {
        guard list.count - 1 >= index else { return }
        guard let realm = try? Realm() else { return }
        do{
            try realm.write({
                realm.delete(list[index])
            })
        }catch{
            print (error)
        }
    }
    
    func deleteCategory(at index: Int) {
        guard category.count - 1 >= index else { return }
        guard let realm = try? Realm() else { return }
        do{
            try realm.write({
                realm.delete(category[index])
            })
        }catch{
            print (error)
        }
    }
}
    

