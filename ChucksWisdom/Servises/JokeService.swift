
import Foundation

class JokeService {
    
    private let category: Category
    private (set) var joke = [ValueModel]()
    
    init(category: Category) {
        self.category = category
        fetchJoke()
    }
    
    func fetchJoke() {
        joke = category.value.map{ $0 }
    }
    
    func addJokeToCategory(model: ValueModel, at category: Category) {
        category.value.append(model)
        fetchJoke()
    }
}
