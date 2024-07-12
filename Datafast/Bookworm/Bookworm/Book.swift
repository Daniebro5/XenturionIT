import Foundation
import SwiftData

@Model
final class Book {
  var titulo: String
  var autor: String
  var genero: String
  var review: String
  var rating: Int

  init(titulo: String, autor: String, genero: String, review: String, rating: Int) {
    self.titulo = titulo
    self.autor = autor
    self.genero = genero
    self.review = review
    self.rating = rating
  }
}
